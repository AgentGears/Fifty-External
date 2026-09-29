# CAP-101 GitWire Same-SHA Re-Review Runbook v1.0

## Purpose

Recover the CAP-101 independent secondary-review gate without changing the frozen Fifty source head or rewriting the frozen first-pass review artifact.

## Frozen target

- Repository: `AgentGears/Fifty`
- Pull request: `#2`
- Frozen head: `4b0a66ecb4fa1fb151241c4b20b7502725b66210`
- Frozen tree: `a7ede2d1c1b5779305ddb92149d87f84a7c90257`
- First-pass artifact: `control/reviews/CAP-101-First-Pass-Review-Freeze-v1.0.md`
- First-pass findings remain withheld from the independent reviewer until the independent review is complete.

## Confirmed failure mode

GitWire completed an independent review on the exact frozen head but published `Evidence: INCOMPLETE` because the configured cumulative `max_lines_to_review` budget was 2000 lines.

The six changed files, in GitHub/GitWire review order, are:

| File | Added | Deleted | Cumulative changed lines |
| --- | ---: | ---: | ---: |
| `persistence/store.go` | 714 | 0 | 714 |
| `persistence/store_test.go` | 381 | 0 | 1095 |
| `ports/store.go` | 1 | 0 | 1096 |
| `workspace/model.go` | 301 | 0 | 1397 |
| `workspace/service.go` | 390 | 0 | 1787 |
| `workspace/service_test.go` | 248 | 0 | 2035 |

GitWire's coverage algorithm applies the line budget cumulatively in file order. The first five files fit at 1787 lines; admitting `workspace/service_test.go` would raise the total to 2035, so that file is marked partial and the review cannot constitute complete approval evidence.

A repository comment command `/gitwire run review` was issued on the unchanged frozen head. GitWire accepted the command but recovered the already-published exact-SHA review instead of recomputing it, and reported the existing outcome `INCOMPLETE`.

## GitWire behavior that matters

The currently inspected GitWire implementation has these relevant semantics:

1. `ai_review_config.max_lines_to_review` defaults to 2000 and is a GitWire service-side repository configuration field.
2. `ai_reviews` has a uniqueness constraint on `(repo_id, pr_number, commit_sha)`.
3. Review startup performs an upsert on that key.
4. When the resulting row is already in publication state `published` with a GitHub review id, the review service recovers that publication and returns without running the model again.
5. The GitHub comment command `/gitwire run review` clears the queue idempotency marker, but it does not invalidate or create a new same-SHA publication receipt. It therefore cannot repair this case by itself.
6. The inspected GitHub comment command surface exposes no dedicated same-SHA review-reset command.

## Required operator action

This is an external-service operator action, not a Fifty source change.

1. In the GitWire operator surface, raise `max_lines_to_review` for `AgentGears/Fifty` to at least `2035`; `5000` is the recommended bounded value for this lane.
2. Enable an **evidence-preserving fresh review attempt** for PR `#2` at the exact frozen head `4b0a66ecb4fa1fb151241c4b20b7502725b66210`.
3. Preserve the already-published incomplete review as historical evidence. Do not delete or silently overwrite it merely to bypass the uniqueness/recovery behavior.
4. Trigger the fresh independent review without changing the PR head or tree.
5. Accept the review gate only if the resulting evidence explicitly accounts for all 6 changed files and reports complete evidence on the exact frozen head.

If the deployed GitWire operator surface does not provide an evidence-preserving same-SHA attempt/reset control, the safe remedy is to add or deploy such a control in GitWire (for example, an explicit review-attempt identity that preserves prior receipts) rather than pushing a dummy Fifty commit or destructively rewriting the prior review receipt.

## Prohibited shortcuts

Do not:

- push a no-op or dummy commit to PR #2 merely to obtain a different SHA;
- change the CAP-101 source tree to fit the reviewer budget;
- rewrite or expose the frozen first-pass findings to the independent reviewer;
- treat the existing incomplete review as a completed independent review;
- merge, leave draft, or start external qualification while this gate is incomplete;
- delete prior review evidence solely to force a rerun.

## Resume condition

Mechanical Fifty continuation may resume when a fresh GitWire review on exact head `4b0a66ecb4fa1fb151241c4b20b7502725b66210` reports complete evidence for all 6 changed files. At that point:

1. capture the exact-head secondary-review evidence;
2. reconcile every material secondary finding against the frozen first-pass record, independently verifying secondary-only claims;
3. if no source change is required, create a separate reconciliation record without rewriting the first-pass freeze;
4. if a source fix is required, make only the authorized CAP-101 correction and restart the affected first-pass/independent-review sequence on the new exact head/tree;
5. after reconciliation, run the exact-head external qualification including CAP-101 continuity-reconstruction latency and root identity/provenance storage-overhead measurements;
6. require `fifty/external-verification=success` on the exact reviewed head before PR #2 leaves draft or merges.
