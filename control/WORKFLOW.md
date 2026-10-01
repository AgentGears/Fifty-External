# Fifty Solo-Developer Delivery Control

This file defines the lightweight operational workflow for advancing Fifty as a single-developer project with AI assistance.

## Operating principle

Optimize for shipping correct product increments with minimal ceremony. Keep one active capability lane, preserve product semantics and trust boundaries, and stop only for a genuine product decision or a material engineering blocker.

Routine repository work, test execution, AI-assisted review, branch/PR maintenance, and transition to the next already-authorized slice do not require repeated confirmation.

## Delivery loop

1. Select the next already-authorized capability slice or coherent implementation increment.
2. Create or continue a focused branch/PR when useful for visibility.
3. Implement only the current slice; do not pre-build later optional scope.
4. Run the relevant deterministic tests, race/static checks, and targeted fault tests for the changed behavior.
5. Perform one focused AI-assisted review of the actual diff/source for correctness, security, failure modes, contract consistency, and missing tests.
6. Fix material issues found and rerun the affected checks.
7. Merge when the implementation is locally verified and no known material blocker remains.
8. Update compact durable project state and immediately begin the next eligible lane.

No universal external verifier, independent secondary reviewer, frozen-head evidence chain, reconciliation ceremony, or external status receipt is required.

GitWire and similar services are optional advisory tools. Their availability, limits, or review state must not block project progress.

## When extra rigor is justified

Use additional review, measurements, or explicit decision records when a change materially affects one or more of:

- product semantics or canonical domain ownership;
- identity, authority, credentials, or trust boundaries;
- irreversible or destructive data behavior;
- persistence/recovery guarantees;
- a major external dependency or runtime choice;
- a known high-risk migration;
- a real performance/resource question.

The extra rigor should answer a concrete risk or product question, not exist as ceremony.

## Interruption policy

Stop and request human action only when one of the following is true:

- an explicit Project Authority decision is required;
- a secret, credential, permission, or account action is unavailable to the connected tools and is genuinely needed for the product;
- an irreversible or externally consequential action requires explicit authority;
- authoritative project semantics conflict and cannot be resolved mechanically;
- tests or review reveal a material blocker whose correction is not mechanically determined;
- the next capability is not already authorized.

Everything else is normal project execution.

## Repository boundary

`AgentGears/Fifty` is the Fifty product repository.

`AgentGears/Fifty-External` holds operational control state, external/provider-specific notes where still useful, and development-process records. External machinery is not a required correctness authority for Fifty.

## Durable project state

`control/project-state.json` is a compact rehydration record. Keep only what is useful to resume work: active capability, branch/PR if any, current implementation state, material blockers, and next action.

The state record is operational metadata. Product authority remains in explicit Project Authority decisions and the applicable Fifty product/domain artifacts.

## Communication cadence

Report only meaningful milestones:

- material blocker requiring human action;
- capability implementation complete;
- material review/test issue found or resolved;
- merge completed;
- next capability lane started;
- gate or phase closed.

Avoid turning routine development into an approval queue.
