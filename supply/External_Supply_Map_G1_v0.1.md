# External Supply Map — G1 H1

**Boundary:** OUTSIDE FIFTY PROJECT NAMESPACE — DO NOT COMMIT TO THE FIFTY REPOSITORY  
**Version:** 0.1  
**Date:** 27 September 2026  
**Supply snapshot:** `SUP-G1-001`  
**Purpose:** Resolve the real external implementation identities referenced opaquely by the G1 H1 architecture.

This file intentionally contains external technology identities and therefore belongs only in the externally governed supply/mapping custody boundary.

## Selected identities

| Opaque ID | External identity | Selected version / state | Role |
|---|---|---|---|
| RUNTIME-001 | Go | 1.27.1 | Compiled server runtime/toolchain |
| STORE-001 | PostgreSQL | 18.6 | Transactional relational canonical datastore |
| DEP-0001 | pgx | 5.11.0 | Runtime datastore adapter |
| DEP-0002 | go-oidc | 3.20.0 | OpenID Connect token/discovery validation |
| DEP-0003 | x/oauth2 | 0.37.0 | Authorization-code and PKCE client flow |
| TEST-001 | Go standard testing/fuzzing facilities | supplied by RUNTIME-001 | Base deterministic verification framework |

## Production-selection notes

- PostgreSQL 19 is still a beta release as of 27 September 2026 and is not selected for production use in this snapshot.
- Runtime and library versions must be pinned in the immutable supply snapshot used for a build.
- Integrity hashes/checksums must be captured by the supply acquisition process before the first reproducible build.
- External authentication provider identity is intentionally not selected here; production provider qualification must satisfy the generic `AUTH-001` contract before real user authentication is enabled.
- Secret-custody service identity is also unresolved until deployment-environment selection; the Fifty-side contract remains `CUSTODY-001`.

## Evidence sources

- Go release history: https://go.dev/doc/devel/release
- PostgreSQL release archive: https://www.postgresql.org/docs/release/
- PostgreSQL beta warning/current beta information: https://www.postgresql.org/developer/beta/
- pgx changelog: https://github.com/jackc/pgx/blob/master/CHANGELOG.md
- go-oidc releases: https://github.com/coreos/go-oidc/releases
- OAuth2 package documentation/version: https://pkg.go.dev/golang.org/x/oauth2

## Custody rule

The mapping from opaque IDs to these real identities must not be copied into:

- Fifty source comments;
- Fifty architecture/governance documents;
- Fifty schemas;
- Fifty configuration templates;
- Fifty tests;
- Fifty operational runbooks.

The build/supply boundary may use the real identities where machines, license compliance, vulnerability management, and reproducibility require them.
