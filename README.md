# Fifty External Boundary

This repository is deliberately outside the Fifty project namespace. It contains concrete external supply identities, CI-provider configuration, verification machinery, and receipts that must not be copied into `AgentGears/Fifty`.

## G1 bootstrap verification

The current boundary verifies the reviewed G1 bootstrap revision:

- target repository: `AgentGears/Fifty`
- target commit: `6f39aa53e9bb863b6c8fb5c719806f055646de49`
- target tree: `c0153105eeea5b55d890cc0a7e83bbb586ecd890`
- verification contract: v1.5
- status context: `fifty/external-verification`

The workflow acquires the exact approved runtime archive, verifies its published SHA-256, checks out the exact Fifty commit, runs the fail-closed verifier, persists the terminal receipt in this repository, and then publishes a commit status back to the exact Fifty commit.

## Required secret

The workflow requires repository secret `FIFTY_STATUS_TOKEN` to publish the cross-repository commit status. Use a fine-grained credential limited to `AgentGears/Fifty` with **Commit statuses: Read and write** (plus the platform-required repository metadata read permission). Do not grant source-write permission to Fifty for this credential.

If the secret is missing or cannot publish the status, the workflow fails and the Fifty merge gate remains unsatisfied even when verification itself passes.

## Custody

External identities and supply mappings may live here. They must not be copied into Fifty source, schemas, tests, project-facing governance documents, configuration templates, or operational runbooks.
