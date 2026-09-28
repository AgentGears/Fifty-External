# CAP-101 Exhaustive First-Pass Review Freeze

**Version:** 1.0  
**State:** FROZEN — FIRST PASS COMPLETE  
**Gate:** G1  
**Capability:** CAP-101 — Durable Workspace and Principal Identity  
**Pull request:** `AgentGears/Fifty#2`  
**Reviewed HEAD:** `4b0a66ecb4fa1fb151241c4b20b7502725b66210`  
**Reviewed tree:** `a7ede2d1c1b5779305ddb92149d87f84a7c90257`  
**Authority:** `control/decisions/CAP-101-H1-Decision-v1.0.md`

## 1. Freeze rule

This file freezes the first-pass findings before independent secondary review. It must not be rewritten to match later secondary-review conclusions. Any source-tree change after the reviewed HEAD invalidates the source-dependent portion of this freeze and requires the affected first-pass checks to be repeated on the new exact HEAD/tree.

The independent secondary reviewer must initially receive the artifact/objective/authority and exact reviewed source, but not this findings register.

## 2. Review surface covered

The first pass covered:

- CAP-101 user outcome, H1 authority, forbidden scope, and canonical-object limits;
- Workspace and Principal identity/ownership/lifecycle representation;
- access and recovery credential semantics and custody boundary;
- durable canonical persistence, restart reconstruction, backup/restore, corruption and partial-publication behavior;
- transaction lifetime, serialized mutation, stale-version behavior, and multiple store handles inside the approved single-process boundary;
- commit-outcome truthfulness at the durable publication boundary;
- failure and recovery paths, malformed inputs, stale/revoked credentials, and unexpected store-lineage replacement;
- tests, race/concurrency checks, static analysis, terminology-denylist scan, assumptions, missing evidence, and later verification obligations;
- scope containment against CAP-102+, specialist/delegation, external effects, multi-workspace, external identity-provider, external database/service, distributed-service, queue/scheduler, and background-work activation.

## 3. Frozen findings register

| ID | Area | Finding | Severity | Confidence | Disposition at freeze |
|---|---|---|---|---|---|
| CAP101-FP-001 | persistence/concurrency | Separate store handles for the same directory originally held independent transaction gates and stale in-memory snapshots, allowing one handle to overwrite a newer accepted state from another handle. | BLOCKER | High | FIXED — all handles for one resolved directory share a process-local gate and refresh the accepted snapshot before transaction/backup/restore. Regression test added. |
| CAP101-FP-002 | restore/identity | A structurally valid higher-generation backup from an unrelated store lineage could originally replace canonical state. | BLOCKER | High | FIXED — durable lineage is integrity-bound to the snapshot; non-empty stores reject foreign-lineage restore; an empty recovery target may adopt the backup lineage. Regression test added. |
| CAP101-FP-003 | persistence/canonical decoding | Persistence and canonical payload decoding originally tolerated unknown JSON fields, weakening fail-closed schema interpretation. | MUST FIX | High | FIXED — strict decoding rejects unknown fields and trailing data for persistence envelopes/state and Workspace/Principal payloads. |
| CAP101-FP-004 | semantic identity | Enrollment originally did not fully defend against a faulty/colliding ID generator producing the same semantic identifier for distinct Workspace/Principal objects. | MUST FIX | High | FIXED — enrollment retries for distinct non-zero IDs; canonical validation rejects Workspace/Principal identifier sharing. Regression coverage added. |
| CAP101-FP-005 | recovery/versioning | Recovery could overflow access/recovery generation counters at the numeric boundary. | MUST FIX | High | FIXED — record and credential-generation exhaustion fail explicitly before increment. |
| CAP101-FP-006 | durable publication / truthful outcome | If the canonical snapshot rename succeeded but directory synchronization failed, the prior implementation could report a normal failure even though the new state might already be visible; for enrollment/recovery that could also discard the only newly issued credentials needed to use the possibly accepted state. | BLOCKER | High | FIXED — the canonical-store port now has `ErrCommitUncertain`; persistence distinguishes pre-publication failure from post-rename uncertainty, retains the published in-memory state, and enrollment/recovery return the issued credentials alongside an uncertainty result. Fault-injection regression tests added. |
| CAP101-FP-007 | continuity/lineage | A live store handle could originally accept an externally replaced, structurally valid snapshot belonging to another lineage on refresh. | BLOCKER | High | FIXED — once a handle has observed a lineage, unexpected lineage replacement fails closed. Regression test added. |
| CAP101-FP-008 | credential evidence | Initial tests proved raw access/recovery values were absent from the decoded Workspace payload but did not inspect the persisted canonical snapshot bytes. | MUST FIX | High | FIXED — regression coverage now checks the persisted snapshot does not contain either raw credential value and verifies recovery preserves primary-assistant identity. |

**Open first-pass blockers at freeze:** `0`.

## 4. Assumptions explicitly retained

### A-001 — single-process authoritative writer boundary

CAP-101 H1 explicitly selects a first-party single-process store. Serialization is enforced across store handles inside one process. Cross-process concurrent writers are not supported or claimed by this slice.

### A-002 — trusted filesystem custody boundary

The snapshot checksum detects accidental corruption. It is not an authenticated integrity mechanism against an attacker who already has write access to canonical persistence files. Filesystem access control remains part of the host trust boundary for this early M1 slice.

### A-003 — one-time enrollment composition

`workspace.Service.Initialize` is the one-time enrollment transaction for the initial personal Workspace. The reviewed source contains no user-facing product surface or composition root that exposes repeatable workspace creation. The eventual composition layer must preserve this one-time use; this slice does not introduce a new global canonical bootstrap object merely to encode that orchestration fact.

### A-004 — disaster-recovery claim ceiling

A recovery target that already contains newer same-lineage state rejects an older backup. An empty target can validate/adopt a backup lineage but cannot independently infer that a supplied backup was superseded after the entire source was lost. CAP-101 therefore proves deterministic backup/restore semantics but makes no production RPO/RTO or multi-region claim.

## 5. Potential failure modes retained as permanent review scenarios

- disk/write failure before canonical snapshot publication → no accepted mutation, unavailable/failure result;
- snapshot rename followed by synchronization failure → explicit commit-uncertain result, never false definite failure/success;
- unmatched prepared journal after interruption/restart → never promoted to accepted canonical truth;
- corrupt snapshot/envelope/payload → fail closed;
- stale record mutation → conflict;
- stale backup → reject;
- foreign backup or unexpected live lineage replacement → reject/fail closed;
- malformed, stale, or revoked access/recovery credential → deny;
- unavailable/corrupt canonical state → continuity cannot be claimed;
- raw bearer credential values → must remain outside canonical payload/snapshot, logs, receipts, and model-visible context.

## 6. Development evidence collected before freeze

On a reconstructed development module containing the merged kernel contracts plus the exact frozen CAP-101 source:

- `go test ./...` — PASS;
- `go test -race ./...` — PASS;
- `go vet ./...` — PASS;
- `go test -race -count=100 ./persistence ./workspace` — PASS;
- current external-namespace denylist literal scan of the reconstructed CAP-101 module — PASS.

The locally available runtime was not the pinned qualification runtime. These checks are development evidence only and do not replace external commit-bound qualification.

## 7. Missing evidence / obligations after freeze

The following are deliberately **not** claimed complete by the first pass:

1. independent secondary review of the exact frozen HEAD/tree;
2. reconciliation of secondary findings against this frozen first-pass state;
3. exact clean-checkout verification under the approved pinned runtime and external supply snapshot;
4. whole-checkout unit/race/static/terminology verification by the external verifier;
5. required resource measurements for CAP-101 continuity reconstruction latency and root identity/provenance storage overhead;
6. commit-bound `fifty/external-verification=success` on the final reconciled reviewed HEAD before merge.

## 8. Areas found clean in first pass

- only the approved Workspace and Principal canonical objects are activated;
- no external database/service or named third-party source dependency is introduced;
- no provider abstraction, distributed service, scheduler, queue, background execution, specialist/delegation, memory, Interaction, or external-effect scope is introduced;
- credential verification resolves durable semantic identity rather than redefining Principal identity from session/device/account identity;
- recovery preserves the same human Principal and Workspace and rotates both access and recovery credentials;
- stale/revoked credentials fail closed;
- persistence uses explicit record/store generations and serialized pre-G9 authoritative mutation;
- preparation and canonical acceptance are distinct;
- backup lineage, corruption detection, and stale-generation failure semantics are explicit;
- raw bearer credential values are not durably admitted by the reviewed implementation.

## 9. First-pass conclusion

The exact reviewed source at HEAD `4b0a66ecb4fa1fb151241c4b20b7502725b66210`, tree `a7ede2d1c1b5779305ddb92149d87f84a7c90257`, has **no unresolved first-pass source blocker** after the fixes recorded above.

This is not CAP-101 qualification and is not merge authority. The next required stage is independent secondary review without access to this findings register, followed by reconciliation and external commit-bound verification.
