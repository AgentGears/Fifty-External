# External G1 Verification Contract

**Version:** 1.5  
**Date:** 28 September 2026  
**Boundary:** OUTSIDE FIFTY PROJECT NAMESPACE — DO NOT COMMIT TO THE FIFTY REPOSITORY  
**Target repository:** AgentGears/Fifty  
**Target commit:** `6f39aa53e9bb863b6c8fb5c719806f055646de49`  
**Expected source tree:** `c0153105eeea5b55d890cc0a7e83bbb586ecd890`  
**Supply snapshot:** `SUP-G1-001`

## Purpose

Produce commit-bound external verification evidence for the reviewed G1 bootstrap increment without placing external supply/provider identities inside the Fifty repository.

## Required checks

The verifier MUST fail closed unless all of the following pass against the exact target commit:

1. checked-out commit equals the target commit;
2. checked-out tree equals the expected tree;
3. worktree is clean before verification;
4. the approved runtime release token is exactly `go1.27.1`;
5. ordinary unit verification passes: `go test ./...`;
6. race/concurrency verification passes: `go test -race ./...`;
7. static analysis passes: `go vet ./...`;
8. race-enabled verification stress passes: `go test -race -count=100 ./verification`;
9. nil-valued panic compatibility regressions pass under both explicit compatibility settings;
10. the approved external supply-map file and terminology denylist match their recorded SHA-256 digests;
11. terminology-sovereignty scan passes using that exact denylist;
12. worktree remains clean after verification.

Every potentially non-terminating verification command, including terminology scanning, MUST run under a process-level wall-clock watchdog. A watchdog expiry is a verification failure, not an inconclusive success.

The verifier MUST NOT modify source files, generate committed artifacts, or fetch unapproved project dependencies.

## Durable receipt requirement

The runner MUST write a terminal receipt for both PASS and FAIL outcomes. The receipt MUST bind at least:

- contract version;
- target and observed commit/tree;
- result;
- terminal stage;
- runtime observation when available;
- approved and observed supply-map SHA-256;
- approved and observed terminology-denylist SHA-256;
- per-check result and output digest when available;
- worktree-clean observations;
- verification timestamp.

A process-level watchdog failure must still leave a failure receipt produced by the wrapper process.

## Commit-status requirement

A successful run is not sufficient by itself. A write-capable external publisher MUST attach a status/check to the exact target commit with:

- context/name: `fifty/external-verification`;
- terminal result: success or failure;
- target commit: exact target SHA above;
- target URL: immutable or durable verification receipt location;
- receipt digest: recorded in the durable receipt/target page where the status system supports it.

A missing status is a merge blocker even when the receipt itself says PASS.

## Head movement rule

If the pull-request HEAD changes after verification, the prior result is stale. The new HEAD requires the applicable maintainer-first review sequence plus a new external verification run and status.

## Claim ceiling

This contract verifies the bootstrap increment only. It does not qualify G1, CAP-101, or any production datastore/authentication implementation.
