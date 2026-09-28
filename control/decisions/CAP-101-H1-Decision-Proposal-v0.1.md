# CAP-101 H1 Decision Proposal

**Version:** 0.1  
**State:** PROPOSED — NOT PROJECT AUTHORITY  
**Gate:** G1  
**Capability:** CAP-101 — Durable Workspace and Principal Identity  
**Forcing function:** PR #1 merged the verified kernel seams. CAP-101 is the next eligible G1 slice, but the approved backlog requires its affected H1 implementation decisions before implementation begins.

## 1. Decision scope

This proposal closes only the H1 choices needed to implement and qualify CAP-101. It does not authorize CAP-102+, specialist delegation, memory, consequential effects, background work, multi-workspace scope, or later-gate infrastructure.

## 2. Recommended H1 package

### H1-101-A — Implementation language/runtime

Retain the implementation language/runtime already exercised by the merged kernel and external verifier: the current pinned runtime supply (`go1.27.1`) under the existing external-supply verification boundary.

Rationale: changing toolchains now would add no CAP-101 user value and would invalidate verified bootstrap assumptions.

### H1-101-B — Durable canonical persistence

Implement one first-party, single-process durable canonical-store adapter behind the existing `CanonicalStore` port using only the selected runtime's standard facilities. Use a filesystem-backed journal/snapshot design with explicit versioning, atomic publication, integrity checks, restart reconstruction, and serialized authoritative mutation.

No external database or named third-party persistence dependency is admitted for CAP-101.

Rationale: CAP-101 needs process-independent canonical Workspace/Principal durability, but the roadmap forbids infrastructure expansion without a forcing function and keeps the initial architecture modular-before-distributed.

### H1-101-C — Initial authentication mechanism

Use a first-party high-entropy opaque access credential. The server stores only a one-way digest and credential metadata; raw credential values are never admitted to ordinary Workspace/context state. Successful credential verification resolves to the existing durable human `Principal` and its single `Workspace`.

This mechanism is intentionally single-user and is not a general identity-provider abstraction.

### H1-101-D — Account recovery

Issue a separate high-entropy recovery credential at enrollment. Store only its digest. A successful recovery rotates/revokes access credentials while preserving the same human `Principal` and Workspace identity. Recovery must not create a new Principal merely because a device/session was replaced.

### H1-101-E — Secret-value custody for this slice

CAP-101 stores no reusable external-provider secrets. Access/recovery credential plaintext exists only at issuance/use boundaries; durable server state stores digests, not raw credential values. Therefore no separate long-lived secret-store technology is activated by CAP-101.

A later capability that introduces long-lived secret values must make its own H1/H3 custody decision before implementation.

### H1-101-F — Build, harness, test isolation, and terminology verification

Retain the merged bootstrap approach:

- deterministic semantic tests through the current verification seams;
- verification-only in-memory store for isolated unit/fault scenarios;
- external commit-bound verifier for pinned-runtime, race/concurrency, static-analysis, stress, panic-compatibility, terminology, clean-worktree, and receipt evidence;
- no additional testing framework or build orchestrator unless a measured forcing function appears.

### H1-101-G — Recovery objective for early M1 identity state

For CAP-101 qualification, require:

- committed canonical state must survive process restart without accepted-state loss;
- corruption or incomplete publication must fail closed rather than fabricate continuity;
- deterministic backup/restore qualification must demonstrate restoration of the same Workspace/Principal identities and rejection of stale superseded generations;
- no production-availability or multi-region claim is made at this gate.

Quantitative service-level disaster-recovery promises remain outside CAP-101 qualification until there is a real production deployment/launch cohort. CAP-101 must nevertheless prove restart and backup/restore semantics before claiming durable continuity.

## 3. Canonical and authority impact

CAP-101 activates only the already-approved canonical objects:

- `Workspace` — owned by Workspace Core;
- `Principal` — durable semantic actor identity within Workspace Core.

No new canonical object is admitted by this H1 package.

Authenticated access is evidence for Principal resolution; it is not itself Principal identity. Model/session identity is not Workspace identity. Device replacement and account recovery do not create a new human Principal when continuity is successfully re-established.

## 4. Verification scenarios required before CAP-101 qualification

1. create Workspace + human Principal + primary-assistant Principal and persist them;
2. restart/reconstruct from durable state with identical canonical identities;
3. model/session replacement preserves semantic assistant identity;
4. access credential resolves to the same human Principal after session replacement;
5. recovery credential rotates access while preserving the same human Principal;
6. stale/revoked credential fails closed;
7. stale canonical generation cannot overwrite newer Workspace/Principal state;
8. interrupted/partial durable publication does not become accepted canonical truth;
9. backup/restore reconstructs the same canonical identities;
10. corrupted/unavailable canonical state yields blocked/recovery-required semantics rather than false continuity;
11. no raw credential value appears in canonical Workspace/Principal payloads, ordinary logs, receipts, or model-visible context;
12. terminology-sovereignty and clean-worktree checks remain PASS.

## 5. Forbidden scope

This decision does not authorize:

- CAP-102 Interaction/context persistence;
- CAP-103 data-rights/export/deletion implementation beyond the minimum hooks required not to contradict approved semantics;
- CAP-104 expansion beyond the existing verification kernel needed for CAP-101 scenarios;
- specialist/delegation objects;
- external effects;
- multi-user or multi-workspace isolation;
- external identity-provider integration;
- external database/service dependencies;
- distributed services;
- queue/scheduler/background execution;
- provider abstraction for its own sake.

## 6. Approval transaction

Project Authority may approve this proposal as the CAP-101 H1 implementation decision package, modify it, or reject it.

Approval authorizes implementation of CAP-101 only within the boundaries above. Implementation must still use the normal PR governance, exhaustive first-pass review, independent secondary review, reconciliation, and external commit-bound verification sequence.
