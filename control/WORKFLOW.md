# Fifty Continuous Delivery Control

This file defines the operational workflow used to advance Fifty without unnecessary pauses while preserving the project's semantic, review, and verification gates.

## Operating principle

Keep one active implementation lane. Advance it continuously until a genuine authority boundary, credential boundary, semantic blocker, or failed verification requires intervention.

Routine repository operations, evidence collection, review reconciliation, status checks, branch/PR maintenance, and transition to the next already-authorized slice should not require repeated confirmation.

## Continuous execution loop

1. Select the next already-authorized capability slice or implementation increment.
2. Create or continue one focused branch and pull request.
3. Implement only the current slice; do not pre-build later optional scope.
4. Run local/deterministic verification during implementation.
5. Perform the exhaustive first-pass review and freeze its findings before independent secondary review.
6. Resolve first-pass defects, then freeze the reviewed source HEAD.
7. Invoke independent secondary review on that frozen HEAD; treat new findings as hypotheses and reconcile them against evidence.
8. Run the external commit-bound verifier against the exact frozen HEAD/tree.
9. Persist the external receipt and publish `fifty/external-verification` against that exact commit.
10. When all required gates are satisfied, move the pull request out of draft and merge it.
11. Re-read the authoritative capability backlog/roadmap, select the next eligible slice, and immediately begin the next lane.

A source-tree change after review or external verification invalidates only the evidence that depended on the previous source tree. Re-run the minimum affected stages rather than restarting unrelated completed work.

## Interruption policy

The execution loop should stop and request human action only when one of the following is true:

- an explicit Project Authority decision is required;
- a secret, credential, permission, or account setting must be created through a surface unavailable to the connected tools;
- an irreversible or externally consequential action requires explicit authority;
- authoritative project artifacts conflict and the conflict cannot be resolved without changing product semantics;
- verification returns FAIL or INCONCLUSIVE and the next correction is not mechanically determined;
- the next capability is not already authorized by the governing gate/backlog.

Everything else is treated as normal project execution and should continue without a confirmation round-trip.

## Repository boundary

`AgentGears/Fifty` remains the Fifty project namespace and contains only project-native implementation artifacts.

`AgentGears/Fifty-External` is the operational/external boundary for provider-specific CI configuration, concrete external identities, supply mappings, verification machinery, receipts, and this execution-control state.

Do not copy external identity or provider-specific operational material into the Fifty project namespace.

## Durable project state

`control/project-state.json` is the compact rehydration record for continuing work across sessions. Update it whenever the active PR, reviewed HEAD, gate state, blocker, or next action changes.

The state record is operational metadata. It is not product authority and cannot supersede the Product Constitution, approved decision records, Canonical Domain Model, capability backlog, or verification evidence.

## Communication cadence

Report at meaningful milestones rather than after every mechanical step:

- blocker requiring human action;
- review/reconciliation complete;
- external verification PASS/FAIL;
- merge completed;
- next capability lane started;
- gate or phase closed.

This keeps the project observable without turning routine execution into an approval queue.
