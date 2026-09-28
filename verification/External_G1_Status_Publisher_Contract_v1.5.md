# External G1 Status Publisher Contract

**Version:** 1.5  
**Boundary:** OUTSIDE FIFTY PROJECT NAMESPACE  
**Status context:** `fifty/external-verification`

The publisher receives a terminal verification receipt and publishes a commit-bound result for the receipt's target revision.

## Success criteria

Publish success only when:

- receipt result is `PASS`;
- receipt target and observed commit both equal `6f39aa53e9bb863b6c8fb5c719806f055646de49`;
- receipt target and observed tree both equal `c0153105eeea5b55d890cc0a7e83bbb586ecd890`;
- every required check is PASS;
- observed supply-map digest equals `f69369be68f079d0e0dcc367e4a8eb5c24626097414d1d909fe303cdc74a17ba`;
- observed denylist digest equals `10f941528bd53e8dd0ff2465c8b038a85f15f3c87248a098bf8ebfedd81a65d8`;
- both worktree-clean assertions are true;
- receipt is stored at the status target URL.

Any mismatch publishes failure or leaves the gate unsatisfied; it MUST NOT publish success.

## Required status fields

```yaml
context: fifty/external-verification
commit_sha: 6f39aa53e9bb863b6c8fb5c719806f055646de49
state: success | failure
description: bounded verification result
target_url: durable receipt location
```

Provider-specific credentials, API endpoints, service identity, and publication implementation remain outside the Fifty project namespace.
