# Fifty Development Process Simplification Decision

**Version:** 1.0  
**Date:** 2026-10-01  
**State:** APPROVED BY PROJECT AUTHORITY

## Purpose

Fifty remains a persistent personal AI work system. This decision simplifies the development process for the current reality: one developer working with AI assistance.

The project should optimize for shipping correct product increments, not for maintaining ceremony designed for a larger team or independent assurance organization.

## Decision

Effective immediately:

1. External commit-bound verification is no longer a required merge gate.
2. The `fifty/external-verification` status is retired as a required project control.
3. Independent secondary review by an external service is no longer mandatory.
4. Exhaustive first-pass review / freeze / reconciliation artifacts are no longer mandatory for ordinary changes.
5. GitWire is optional advisory tooling only. Its availability, limits, or review state must not block Fifty development.
6. Routine capability work uses a lightweight solo-developer loop:
   - implement one coherent capability increment;
   - run relevant deterministic tests and static checks;
   - perform one focused AI-assisted code review for correctness, security, failure modes, and scope;
   - fix material issues found;
   - merge when the code is locally verified and no known material blocker remains.
7. Pull requests remain useful for diff visibility and history but are not themselves a governance ceremony. Draft state, multiple review stages, frozen-head evidence chains, and external receipts are not required unless a specific change justifies them.
8. Architecture/decision records are required only when a change materially alters product semantics, security/trust boundaries, canonical data ownership, irreversible data behavior, or a major implementation dependency.
9. Resource measurements are collected when they answer a real product or engineering question; they are not mandatory evidence for every capability increment.
10. Durable project state should remain compact: current capability, current branch/PR if any, known blockers, and next action.

## Quality floor retained

Streamlining does not remove engineering discipline. Fifty still requires:

- deterministic tests for deterministic behavior;
- fail-closed behavior for identity, authority, and durable-state corruption where applicable;
- no known material correctness or security blocker at merge;
- scope discipline against accidental expansion into later capabilities;
- explicit Project Authority decisions for genuine product-semantic changes.

## Scope

This decision changes development governance only. It does not change Fifty's product thesis, canonical domain semantics, human-control semantics, trust/data boundaries, or capability definitions.

Where older operational workflow text requires external verification, independent review, frozen review artifacts, or multi-stage reconciliation as universal gates, this decision supersedes those requirements.
