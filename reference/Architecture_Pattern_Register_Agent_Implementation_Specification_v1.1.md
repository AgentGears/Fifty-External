# Architecture Pattern Register Agent Implementation Specification

**Revision:** 1.1 — terminology-sovereign edition

*Portable mechanism for controlled architectural learning, adoption, implementation, and verification*

# Purpose

This document is an executable governance specification for an AI or software-engineering agent tasked with establishing and operating an Architecture Pattern Register (APR) in a new project. It distills the recurring mechanism and philosophy found across the Architecture Pattern Register corpus into a project-portable implementation contract.

## Core doctrine

Learn broadly, commit narrowly.

Research may expand what the project understands. It must not silently expand what the project is committed to build. External mechanisms are evidence; local invariants define architecture. Observation, adoption, implementation, verification, and qualification are distinct states.

## How to use this document

Provide this document to the implementing agent together with the new project's source repository, current architecture material, plans, requirements, and relevant research. The agent SHALL use this specification as the governance contract for creating or maintaining the APR. Where project facts are missing, the agent SHALL record the gap explicitly rather than inventing a policy, authority boundary, invariant, or claim.

## Authority statement

This specification authorizes the agent to create the APR governance structure and to characterize evidence. It does not, by itself, authorize product implementation, schema migration, infrastructure change, roadmap expansion, or adoption of any particular pattern.

## Source basis

This specification is a cross-register synthesis of a supplied architecture-governance corpus. External source identities and vocabulary are intentionally excluded from the project-facing specification. The corpus contributes recurring distinctions: research versus authority; observation versus adoption; implementation versus verification; claim scope; project-native semantics; explicit forcing functions; durable negative evidence; and explicit promotion records.

# 1. Agent Mission and Boundaries

The agent's mission is to construct a durable architecture-learning system that allows the project to absorb research and experience without converting research directly into scope. The APR SHALL preserve provenance, extract reusable invariants, translate them into project-native semantics, and make promotion into architecture an explicit decision.

## 1.1 Required outcomes

- A clear project boundary and a compact set of project-specific constitutional invariants.

- A normalized Architecture Pattern Register with explicit pattern status, implementation status, and planning disposition.

- Traceability from source evidence to observation, interpretation, decision, implementation linkage, and verification evidence.

- A forcing-function mechanism that prevents speculative patterns from becoming roadmap commitments.

- A durable record of rejected, deferred, superseded, and negative-result knowledge.

- A validation procedure that detects semantic drift, authority drift, evidence inflation, vocabulary contamination, and status collapse.

## 1.2 Prohibited shortcuts

- Do not copy another project's nouns, lifecycle, object model, or component topology merely because they appear successful.

- Do not create work because a pattern is interesting, fashionable, externally validated, or already implemented elsewhere.

- Do not treat ACCEPTED as IMPLEMENTED, IMPLEMENTED as VERIFIED, or VERIFIED as universal qualification.

- Do not treat an external source as project authority.

- Do not hide missing evidence by filling gaps with inference presented as fact.

- Do not silently delete rejected or failed approaches when normalizing the register.

- Do not permit external product/project names, branded terms, distinctive source vocabulary, or source-derived identifiers in project artifacts. Normalize external research before it crosses the project boundary.

## 1.3 Default behavior under uncertainty

When an architectural fact, authority boundary, evidence scope, source revision, or implementation linkage cannot be established from project material, the agent SHALL mark it UNKNOWN, UNRESOLVED, or NOT-LINKED as appropriate. Unknown is a valid state; fabricated certainty is not.

# 2. Non-Negotiable Governance Laws

| **Law**                              | **Required interpretation**                                                                                              |
|--------------------------------------|--------------------------------------------------------------------------------------------------------------------------|
| Observation ≠ Adoption               | Evidence that a mechanism exists or works somewhere does not make it part of this project.                               |
| Adoption ≠ Implementation            | A project may accept a pattern while having no authorized or existing implementation.                                    |
| Implementation ≠ Verification        | Code or configuration may exist without evidence that it satisfies the intended contract.                                |
| Verification ≠ Generalization        | A verified result is bounded by its environment, workload, language, evidence class, and claim scope.                    |
| Evidence ≠ Claim                     | Evidence supports a bounded claim; it does not automatically establish policy or authority.                              |
| Cognition ≠ Authority                | An agent, model, analysis component, or suggestion system may propose; it does not automatically author canonical truth. |
| Visibility ≠ Permission              | Discoverability or access does not imply authorization to mutate, publish, execute, or expose.                           |
| Execution ≠ External Effect          | A successful dispatch or local execution does not necessarily establish that an external effect occurred.                |
| Storage identity ≠ Semantic identity | Path, row ID, cache key, or byte identity may not establish provenance or domain identity.                               |
| External success ≠ Local requirement | A mechanism used successfully elsewhere must still satisfy a local forcing function and transfer test.                   |

The agent SHALL preserve these distinctions even if the target project uses different names. Project-specific invariants may extend them; they SHALL NOT collapse them without an explicit, justified architectural decision.

# 3. Logical Architecture of the Governance System

The portable model has four governance layers plus an evidence lifecycle. The layers may live in one document or several project-native artifacts, but their semantics SHALL remain distinct.

| **Layer**            | **Purpose**                                                                            | **Primary question**                        |
|----------------------|----------------------------------------------------------------------------------------|---------------------------------------------|
| Project Constitution | Defines project truth, authority, scope, and non-negotiable invariants.                | What must remain true here?                 |
| Pattern Register     | Retains reusable architectural knowledge and negative knowledge.                       | What have we learned?                       |
| Decision Layer       | Records explicit adoption, rejection, deferment, trial authorization, or supersession. | What has this project decided?              |
| Execution Layer      | Links decisions to current authorized work and implementation evidence.                | What is actually authorized or implemented? |
| Evidence Lifecycle   | Bounds what implementation or experiments prove.                                       | What is justified by the evidence?          |

## 3.1 Canonical flow

```text
SOURCE / PROJECT EVIDENCE
  -> OBSERVATION
  -> REUSABLE PATTERN / INVARIANT
  -> PROJECT-SPECIFIC INTERPRETATION
  -> EXPLICIT DECISION
  -> AUTHORIZED IMPLEMENTATION LINKAGE
  -> INDEPENDENT VERIFICATION / QUALIFICATION
```

Every arrow is a governance boundary. The agent SHALL retain enough information to show why a transition was valid rather than treating the sequence as an automatic pipeline.

# 4. Project Initialization Procedure

When applying the APR concept to a new project, the agent SHALL initialize governance before importing patterns.

## 4.1 Establish the product and system boundary

1. State the project's primary product or system purpose.
2. State the user/operator/scientific outcome the architecture exists to support.
3. State what is explicitly outside scope.
4. Identify canonical state or truth objects, if already defined.
5. Identify existing authority owners: host process, human approver, control plane, repository, database, policy service, experiment record, or other project-native authority.
6. Identify current planning and implementation authorities. The APR SHALL not replace them.

## 4.2 Derive the project constitution

The agent SHALL derive 5–15 concise invariants from current project evidence. Invariants should be written as durable relationships rather than implementation details. Examples are illustrative only and SHALL NOT be copied unless supported by the new project:

```text
Canonical State > Conversation
Evidence ≠ Claim
Execution ≠ Effect
Visibility ≠ Authority
Byte Identity ≠ Provenance Identity
Configured ≠ Observed ≠ Inferred
Current State ≠ Historical Captured State
```

If the project does not yet have enough evidence to establish an invariant, the agent MAY record a PROVISIONAL invariant, but SHALL label it as provisional and request project authority before treating it as binding.

## 4.3 Identify the claim ceiling

The agent SHALL identify how evidence can be overgeneralized in this project. Examples include benchmark result ≠ general architecture claim; verification ≠ scientific validity; verification ≠ calibration; verification ≠ product qualification; upstream parity ≠ product quality. The project-specific claim ceiling SHALL become part of the constitution or evidence policy.

# 5. Required Data Model

The APR SHALL use a structured record even if rendered as Markdown. The following schema is the normative logical model. Field names may be adapted to project conventions if their meanings remain intact.

```yaml
id: APR-XXX
name: <project-native or vendor-neutral pattern name>

pattern:
  problem: <recurring project-relevant problem class>
  invariant: <what must remain true>
  mechanism: <implementation-neutral mechanism, if known>
  benefits: []
  liabilities: []
  failure_modes: []

provenance:
  kind: project-native | external | synthesis | negative-result
  source: <opaque project source identifier>
  snapshot_ref: <opaque frozen-evidence reference>
  evidence_boundary: <what was actually inspected or demonstrated>

observation:
  demonstrated: <source facts only>
  not_demonstrated: []
  uncertainty: []

project_interpretation:
  adaptation: <what the pattern means in this project>
  must_preserve: []
  conflicts: []
  forcing_function: <observable condition that creates local need>
  required_evidence: []

claim_scope:
  supported_claim: <strongest currently justified claim>
  exclusions: []
  environment: <where the claim applies>

decision:
  pattern_status: OBSERVED | CHARACTERIZED | CANDIDATE | ACCEPTED | TRIAL-AUTHORIZED | DEFERRED | REJECTED | SUPERSEDED
  implementation_status: NOT-LINKED | LINKED | IN-TRIAL | IMPLEMENTED | VERIFIED | ROLLED-BACK
  planning_disposition: current-plan-authorized | future-plan-candidate | research-only | do-not-promote
  authority: <decision / plan / ADR / issue / null>
  rationale: <bounded project rationale>

implementation:
  links: []
  verification_links: []
  known_gaps: []
```

## 5.1 Required semantics

| **Field**        | **Rule**                                                                                       |
|------------------|------------------------------------------------------------------------------------------------|
| problem          | Must describe a problem class, not advertise a mechanism.                                      |
| invariant        | Must state what must remain true independent of the current implementation.                    |
| mechanism        | May be omitted if the invariant is useful without a preferred mechanism.                       |
| provenance       | Must identify an opaque research-source and frozen evidence boundary; external identity resolution remains outside the project namespace.           |
| observation      | Must contain source/project facts, not local adoption language.                                |
| adaptation       | Must use project-native semantics and explain translation from source mechanism.               |
| forcing_function | Must be observable/testable enough to know whether promotion is justified.                     |
| claim_scope      | Must prevent evidence from supporting a stronger claim than it actually establishes.           |
| statuses         | Must remain independent axes.                                                                  |
| authority        | Must identify the project artifact or actor that actually authorizes promotion/implementation. |

# 6. Status Model

The agent SHALL maintain independent status axes. A single status such as APPROVED or DONE is insufficient because it collapses architectural judgment, implementation existence, verification, and planning authority.

## 6.1 Pattern status

| **Status**       | **Meaning**                                                                                              |
|------------------|----------------------------------------------------------------------------------------------------------|
| OBSERVED         | A relevant mechanism, behavior, result, or failure has been recorded.                                    |
| CHARACTERIZED    | The pattern, invariant, boundaries, and evidence limitations are understood well enough to reason about. |
| CANDIDATE        | There is plausible project relevance, but no adoption decision.                                          |
| ACCEPTED         | The project has explicitly adopted the pattern as architectural guidance.                                |
| TRIAL-AUTHORIZED | A bounded trial is explicitly permitted without full adoption.                                           |
| DEFERRED         | Potentially useful, but a present forcing function or prerequisite is absent.                            |
| REJECTED         | The project explicitly rejects the pattern for the recorded reason.                                      |
| SUPERSEDED       | Another decision or pattern now governs the same architectural concern.                                  |

## 6.2 Implementation status

| **Status**  | **Meaning**                                                                    |
|-------------|--------------------------------------------------------------------------------|
| NOT-LINKED  | No implementation work is linked to the pattern.                               |
| LINKED      | Authorized implementation work or existing implementation has been identified. |
| IN-TRIAL    | A bounded experiment or implementation trial is active.                        |
| IMPLEMENTED | The mechanism exists in the project, but verification is a separate question.  |
| VERIFIED    | Defined verification evidence supports the intended local contract.            |
| ROLLED-BACK | An implementation was intentionally reversed; retain evidence and rationale.   |

## 6.3 Planning disposition

| **Disposition**         | **Meaning**                                                                |
|-------------------------|----------------------------------------------------------------------------|
| current-plan-authorized | The current authoritative plan permits work.                               |
| future-plan-candidate   | The idea may be considered in a future plan; it is not current scope.      |
| research-only           | Retained for knowledge; no planning implication.                           |
| do-not-promote          | The current decision explicitly prevents promotion without a new decision. |

Valid combinations are intentionally non-linear. ACCEPTED + NOT-LINKED + future-plan-candidate is valid. CANDIDATE + IN-TRIAL may be valid when a trial is separately authorized. IMPLEMENTED does not imply ACCEPTED if legacy behavior exists without current architectural endorsement.

# 7. Forcing Functions and Transfer Tests

A forcing function is the observable project condition that makes a pattern worth promoting. It is the primary defense against research-to-roadmap collapse.

## 7.1 Forcing-function quality test

| **Weak / invalid**             | **Strong / actionable**                                                                                                  |
|--------------------------------|--------------------------------------------------------------------------------------------------------------------------|
| “Other systems use it.”        | “The second provider cannot satisfy the canonical capability contract without provider-specific branching.”              |
| “It may scale better.”         | “Measured memory growth prevents the current architecture from satisfying the target workload.”                          |
| “It would be cleaner.”         | “Three independent implementations now duplicate the same authority decision and have diverged.”                         |
| “This benchmark is promising.” | “The current product requirement cannot be met within the measured latency/resource budget using the accepted baseline.” |
| “We may need this later.”      | “A current requirement or recurring defect is blocked by the absence of this invariant/mechanism.”                       |

## 7.2 Transfer test

Before moving a pattern beyond CANDIDATE, the agent SHALL answer all of the following:

1.  What existing requirement, defect, risk, cost, evidence gap, or operational failure creates the need?

2.  Does the pattern improve reliability, control, safety, cost, performance, preservation, recovery, replaceability, or another explicit project objective?

3.  Is the proposed mechanism simpler than the problem it introduces?

4.  Can the invariant be expressed in project-native semantics?

5.  Can the result be tested independently?

6.  What transitive complexity, new authority, infrastructure, state, or operational burden would adoption create?

7.  Which parts are reusable primitives, and which are source-specific domain assumptions that must not transfer?

# 8. Promotion Protocol

Promotion SHALL be a discrete recorded transaction. Repetition, popularity, external success, implementation convenience, or informal consensus SHALL NOT cause semantic promotion.

## 8.1 Mandatory promotion gate

| **Gate**            | **Pass condition**                                                                                |
|---------------------|---------------------------------------------------------------------------------------------------|
| Problem match       | A concrete local forcing function is present and evidenced.                                       |
| Invariant match     | The pattern preserves the project constitution or explicitly changes it through proper authority. |
| Semantic adaptation | The pattern is expressed in project-native terms rather than source vocabulary.                   |
| Scope boundary      | The adoption scope and explicit non-scope are recorded.                                           |
| Failure model       | Known failure modes, ambiguity, rollback, and uncertainty handling are documented.                |
| Evidence plan       | The evidence needed to verify the local contract is specified before implementation.              |
| Claim ceiling       | The strongest legitimate post-verification claim is stated.                                       |
| Authorization       | A project authority explicitly approves adoption, trial, or current-plan implementation.          |

## 8.2 Promotion record

```yaml
promotion:
  from_status: CANDIDATE
  to_status: ACCEPTED | TRIAL-AUTHORIZED
  forcing_function: <evidence-backed local trigger>
  adopted_invariant: <project-native statement>
  adaptation: <what changes from source/reference pattern>
  scope: <where it applies>
  non_scope: <where it does not apply>
  failure_model: <known failures and uncertainty>
  verification_plan: <how local correctness will be shown>
  claim_ceiling: <maximum claim after successful verification>
  authority_reference: <canonical decision or planning authority>
  decision_date: <date>
  decision_rationale: <why now / why this scope>
```

If any mandatory gate is unresolved, the agent SHALL retain the pattern at CANDIDATE, DEFERRED, or research-only rather than manufacturing completion.

# 9. Evidence, Verification, and Claim Discipline

Verification is a relationship between a claim and evidence, not a ceremonial final state. The agent SHALL define evidence in terms of the project's actual risk and product/scientific contract.

## 9.1 Evidence chain

```text
source evidence
  -> source observation
  -> project interpretation
  -> adoption decision
  -> implementation evidence
  -> verification evidence
  -> bounded claim
```

## 9.2 Claim ceiling rules

- Benchmark success applies only to the benchmark conditions unless broader evidence exists.

- A component-level result does not automatically qualify end-to-end product behavior.

- A synthetic result does not automatically establish behavior on real production data.

- A successful dispatch does not establish an external mutation when receipts are incomplete or ambiguous.

- A byte/content identity result does not automatically establish provenance identity.

- A model, evaluator, teacher, reward function, or AI-generated corpus does not become independent evidence merely because it is stored separately.

- Negative, failed, and ambiguous results SHALL be retained because they constrain future claims.

## 9.3 Verification record

```yaml
verification:
  contract: <what local property is being verified>
  evidence: []
  environment: <hardware / workload / language / dataset / topology / version>
  result: pass | fail | partial | inconclusive
  limitations: []
  independent_from_training_or_generation: <yes/no/partial/not-applicable>
  verified_claim: <bounded claim supported by evidence>
  prohibited_generalizations: []
```

# 10. Provenance and Terminology Sovereignty

The agent SHALL preserve research provenance without allowing external naming to cross into project artifacts. External research is admitted only after semantic normalization.

## 10.1 Five-layer traceability

| **Layer**                  | **Content** |
|----------------------------|-------------|
| 1. Pattern definition | Project-native or generic invariant/mechanism. |
| 2. Opaque provenance | Project-safe source ID, snapshot reference, date, evidence class, and inspection boundary. |
| 3. Source observation | What the source demonstrates, expressed without external names or distinctive vocabulary. |
| 4. Project interpretation | What the observation means under local invariants, terminology, authority, and constraints. |
| 5. Decision log | Accepted, deferred, rejected, trial-authorized, superseded, plus rationale and authority. |

## 10.2 Terminology rule

External product/project names, branded component names, distinctive lifecycle/object labels, protocol names, source acronyms, and source-derived identifier prefixes SHALL NOT appear in project product, architecture, domain, implementation, schema, API, UI, test, planning, or operational artifacts. There is no project-side naming exception for provenance.

The research process MAY inspect named external material outside the project namespace. Before evidence enters the project, it SHALL be translated into implementation-neutral semantics and assigned opaque identifiers. Exact external identity/revision mapping SHALL remain in the external research environment.

## 10.3 Project-safe source ledger

```yaml
source_id: SRC-XXX
snapshot_ref: SNAP-XXX
kind: repository | paper | experiment | incident | benchmark | project-code | interview
observed_at: <date>
inspection_scope: <normalized description of what was inspected>
reliability_notes: []
linked_patterns: [APR-...]
claim_limitations: []
external_identity_in_project: prohibited
```

## 10.4 Terminology admission test

A new term may enter canonical project vocabulary only when it is either ordinary domain language or deliberately coined/selected for this project. A term fails admission if understanding it depends on knowledge of an external source or if it is a copied/distinctive source label.

# 11. Anti-Pattern and Negative-Knowledge Register

A mature APR records failure knowledge alongside positive patterns. The agent SHOULD use an APX namespace or equivalent when a recurring architectural mistake is worth preserving.

```yaml
id: APX-XXX
name: <anti-pattern>
trigger: <conditions under which this mistake appears>
mechanism_of_failure: <why it fails>
evidence: []
protected_invariant: <what project rule it violates>
corrective_pattern: <APR-XXX or guidance>
status: ACTIVE | HISTORICAL | SUPERSEDED
```

Common cross-project anti-pattern classes include:

- Research-to-roadmap collapse: treating study as authorization.

- Vocabulary contamination: importing source ontology into canonical architecture.

- Evidence inflation: claiming more than evidence establishes.

- Status collapse: treating acceptance, implementation, and verification as one state.

- Authority drift: allowing a worker/model/observer/executor to author canonical truth.

- Negative-result amnesia: deleting failed approaches so the project repeats them.

- Premature mechanism fixation: choosing a mechanism before the local problem and invariant are understood.

- Infrastructure inflation: introducing systems because they are available rather than because a forcing function exists.

- Historical reconstruction from current state: using today's topology/configuration to infer past execution without captured provenance.

- Ambiguous-effect retry: blindly repeating external mutations when effect state is unknown.

# 12. Agent Operating Procedures

The following procedures define how the agent SHALL operate the register.

## 12.1 Ingest a research observation

1. Capture exact provenance and revision.
2. Describe only what the source demonstrates.
3. List what the source does not demonstrate or what remains uncertain.
4. Extract the reusable problem/invariant without importing source vocabulary unnecessarily.
5. Map the observation against project invariants and current architecture.
6. If no local forcing function exists, stop at OBSERVED or CHARACTERIZED and mark research-only.
7. If a forcing function may exist, create a CANDIDATE and record the missing evidence required for promotion.

## 12.2 Evaluate an existing project mechanism

1. Do not assume existing code equals accepted architecture.
2. Identify the mechanism's actual authority, state, failure, and evidence semantics.
3. Create or link an APR entry if the mechanism embodies a reusable invariant.
4. Set implementation_status to IMPLEMENTED only when the mechanism actually exists.
5. Set VERIFIED only when evidence supports the defined contract.
6. Record legacy mismatches explicitly instead of rewriting history.

## 12.3 Process a request to “use pattern X”

1. Identify the local problem the requester expects X to solve.
2. Extract X's invariant and source-specific assumptions.
3. Run the transfer test.
4. Define the forcing function and evidence gap.
5. If the request includes valid implementation authority, link it; otherwise keep planning disposition separate.
6. Do not treat the user's mention of a pattern as evidence that the project has adopted it.

## 12.4 Normalize the register

1. Deduplicate by invariant/problem semantics, not by similar titles alone.
2. Preserve supersession and historical decisions.
3. Preserve source provenance through merges.
4. Do not upgrade status to make entries look consistent.
5. Do not lower the detail of failure modes, uncertainty, or negative evidence merely for brevity.
6. Flag conflicts between accepted patterns and constitutional invariants for human/project-authority review.

# 13. Validation Rules the Agent Must Enforce

The agent SHALL run a validation pass after material APR changes. A register with unresolved validation failures SHALL be reported as such rather than presented as clean.

| **Validation**              | **Failure condition**                                                                                    |
|-----------------------------|----------------------------------------------------------------------------------------------------------|
| V-01 Provenance             | A source-derived entry lacks source identity, revision/evidence boundary, or observation.                |
| V-02 Status separation      | One status field is being used to encode architecture, implementation, and planning together.            |
| V-03 Forcing function       | A CANDIDATE/ACCEPTED pattern has no concrete local problem trigger unless explicitly foundational.       |
| V-04 Authority              | Promotion or current-plan authorization lacks an authority reference.                                    |
| V-05 Claim ceiling          | Verification language exceeds evidence/environment scope.                                                |
| V-06 Terminology sovereignty | Any external name, branded term, distinctive source vocabulary, external identity mapping, or source-derived identifier appears in a project artifact. |
| V-07 Negative evidence      | Known failed/rejected approaches were removed or overwritten without supersession history.               |
| V-08 Unknown handling       | Missing facts are presented as established facts.                                                        |
| V-09 Implementation proof   | VERIFIED is asserted without verification evidence.                                                      |
| V-10 Historical integrity   | Historical execution/decisions are reconstructed from current mutable state without captured provenance. |
| V-11 Effect uncertainty     | Ambiguous external effects are collapsed to success/failure without supporting evidence.                 |
| V-12 Scope creep            | Register content creates new roadmap work without a separate planning authority.                         |

Validation severity SHOULD be ERROR when the defect would create false authority, false verification, or false provenance; WARNING when the defect reduces clarity but does not yet misstate authority or evidence.

# 14. Default Repository / Document Structure

The logical model is more important than file layout. When the project has no established convention, the agent MAY use the following default:

```text
/architecture/
  ARCHITECTURE_PATTERN_REGISTER.md
  APR_DECISION_LOG.md
  APR_SOURCE_LEDGER.md
  APR_VALIDATION_REPORT.md
```

For small projects, these may be sections of one file. For large research-heavy projects, separate ledgers reduce churn and make provenance easier to audit. The APR SHALL remain readable without requiring a specialized database.

## 14.1 Required register sections

- Purpose and non-authority statement.

- Project boundary and constitutional invariants.

- Status vocabulary and promotion rules.

- Source / provenance policy.

- Pattern index.

- Pattern records.

- Anti-pattern / negative-knowledge records.

- Decision history or links to the decision ledger.

- Validation summary and known unresolved governance gaps.

# 15. Initial Agent Execution Plan

When first introduced to an existing project, the agent SHALL execute the following sequence. It SHALL not begin by importing patterns from other projects.

| **Phase**      | **Agent action**                                                                                                          | **Output**                     |
|----------------|---------------------------------------------------------------------------------------------------------------------------|--------------------------------|
| 1. Inspect    | Read authoritative project sources, architecture, requirements, plans, schemas, runtime boundaries, and relevant history. | Evidence inventory             |
| 2. Bound      | Write project purpose, explicit non-scope, canonical truth objects, and authority owners.                                 | Project boundary draft         |
| 3. Constitute | Derive 5–15 supported invariants and claim ceilings.                                                                      | Constitution draft             |
| 4. Baseline   | Identify existing architectural mechanisms and map them without assuming endorsement.                                     | Baseline pattern set           |
| 5. Research   | Ingest external/internal observations through the five-layer traceability model.                                          | Observed/characterized entries |
| 6. Govern     | Assign independent status axes and forcing functions.                                                                     | Normalized register            |
| 7. Decide     | Promote only where explicit local gates and authority are satisfied.                                                      | Decision records               |
| 8. Verify     | Link implementation and evidence; bound claims.                                                                           | Verification records           |
| 9. Validate   | Run governance validation rules and surface unresolved issues.                                                            | Validation report              |

# 16. Acceptance Criteria for the APR Implementation

The APR implementation is complete enough to operate when all of the following are true:

- A reader can tell what the project is and is not trying to build.

- Canonical truth and authority owners are explicit or explicitly unresolved.

- Project constitutional invariants are present and evidence-based.

- Every source-derived pattern separates provenance, observation, interpretation, and decision.

- Every pattern has independent architecture, implementation, and planning states.

- Candidates have concrete forcing functions or are explicitly marked research-only.

- Promotion requires an explicit decision and authority reference.

- Verification records state environment, evidence, result, limitations, and claim ceiling.

- Rejected, deferred, superseded, failed, and ambiguous knowledge is retained.

- External names, branded terms, distinctive source vocabulary, and source-derived identifiers do not appear in project artifacts.

- The APR does not create new roadmap scope merely by containing a pattern.

- The validation report can identify false authority, false verification, missing provenance, and claim inflation.

## 16.1 Definition of done for an individual pattern

A pattern record is governance-complete when:

- its problem and invariant are clear;

- provenance and observation are distinguishable from interpretation;

- uncertainty and non-demonstrated claims are visible;

- the project adaptation is stated in native semantics;

- the forcing function is concrete or the entry is research-only;

- status axes are independently assigned;

- any promotion has an authority reference;

- any implementation has traceable links;

- any VERIFIED claim has evidence and a bounded claim ceiling;

- historical rejection/supersession is not erased.

# 17. Copy-Paste Agent Directive

The following directive may be supplied directly to an implementing agent together with this specification and the target project materials.

```text
IMPLEMENT AN ARCHITECTURE PATTERN REGISTER FOR THIS PROJECT.

Treat the accompanying Architecture Pattern Register Agent Implementation Specification as the governance contract.

Your task is to build a controlled architectural-learning system, not a catalog of interesting ideas and not a new roadmap.

You must:

1. Inspect project-authoritative sources before importing patterns.
2. Establish product/system boundary, truth objects, authority owners, and evidence-backed constitutional invariants.
3. Preserve these separations:
   Observation != Adoption
   Adoption != Implementation
   Implementation != Verification
   Verification != Generalization / Qualification
4. For each source-derived pattern, preserve:
   pattern definition -> provenance -> source observation -> project interpretation -> explicit decision.
5. Use independent axes for pattern status, implementation status, and planning disposition.
6. Require a concrete local forcing function before promotion, except for explicitly identified foundational invariants.
7. Express all project artifacts in project-native or generic terminology. External names and distinctive source vocabulary remain outside the project namespace; use opaque provenance identifiers only.
8. Define failure semantics, evidence plan, claim ceiling, and authority before promoting a pattern into project architecture.
9. Preserve negative, rejected, deferred, superseded, and ambiguous results.
10. Mark missing facts as UNKNOWN/UNRESOLVED. Do not invent authority, evidence, requirements, or implementation state.
11. Do not create product implementation, schema changes, infrastructure, or roadmap scope unless separately authorized by the project's planning/execution authority.
12. Produce a validation report showing unresolved provenance, authority, forcing-function, status, verification, vocabulary, or claim-scope defects.

Start with the project itself. Reuse the governance mechanism; do not assume architecture from any other project transfers unchanged.
```

# 18. Design Rationale: What Is Portable and What Is Not

The mechanism is portable because the corpus converges on a common governance problem: research and implementation move faster than architectural judgment unless explicit boundaries are maintained. What transfers is the control system around learning. What does not automatically transfer is the project's truth model, domain ontology, authority topology, evidence standard, product boundary, or preferred mechanisms.

| **Portable governance shell**                               | **Must be re-derived per project**                  |
|-------------------------------------------------------------|-----------------------------------------------------|
| Observation/adoption/implementation/verification separation | Canonical state and truth objects                   |
| Five-layer traceability                                     | Authority owners and mutation rights                |
| Independent status axes                                     | Product boundary and non-scope                      |
| Forcing-function promotion                                  | Evidence classes and claim ceilings                 |
| Explicit promotion record                                   | Domain ontology and canonical vocabulary            |
| Negative-result retention                                   | Failure semantics and recovery contract             |
| Vocabulary sovereignty                                      | Performance/resource/product qualification criteria |
| Validation against authority/evidence drift                 | Specific implementation mechanisms                  |

## The governing principle is therefore:

Reuse the learning mechanism across projects; never assume the learned architecture itself transfers unchanged.

# Appendix A — Corpus-Derived Principles

The following principles were distilled from the external research corpus. Source identities are intentionally excluded from the project namespace.

| **Principle** | **Statement retained in this specification** |
|---|---|
| CP-01 | Observation is not adoption; adoption is not implementation; implementation is not verification. Study does not authorize execution. |
| CP-02 | Optimization is not equivalence; benchmark evidence does not automatically become a general architecture claim. |
| CP-03 | Verification is not scientific or product validity; evidence layers and lineage must remain explicit. |
| CP-04 | Persistent semantic layers must remain distinct where their authority/lifecycle differs. |
| CP-05 | Forcing functions and independent qualification protect against evidence inflation and premature mechanism fixation. |
| CP-06 | Configured, observed, and inferred truth must remain distinguishable; observation does not imply control authority. |
| CP-07 | Evidence, claim, policy, and authority are distinct; cognition does not own program authority. |
| CP-08 | Product boundaries govern transfer; approvals bind to exact effects; ambiguous external effects remain explicit and are reconciled rather than blindly retried. |
| CP-09 | Historical truth requires captured provenance; current state must not reconstruct past execution; storage identity is not provenance identity. |
| CP-10 | Verification is bounded by workload/environment and does not automatically establish broad product qualification. |

# Appendix B — Compact Checklist

| **Question**     | **Required answer before architectural promotion**                         |
|------------------|----------------------------------------------------------------------------|
| Problem          | What real project problem exists now?                                      |
| Invariant        | What must remain true?                                                     |
| Authority        | Who/what is allowed to decide and mutate canonical state?                  |
| Provenance       | What evidence/source produced this observation?                            |
| Adaptation       | What does the pattern mean in project-native semantics?                    |
| Forcing function | What observable condition makes it necessary now?                          |
| Scope            | Where does it apply, and where explicitly not?                             |
| Failure          | How does it fail, become ambiguous, or require rollback/reconciliation?    |
| Evidence         | What will independently verify the intended local contract?                |
| Claim ceiling    | What is the strongest legitimate claim after successful verification?      |
| Authorization    | Which canonical decision/plan authorizes adoption and/or implementation?   |
| History          | What rejected, deferred, failed, or superseded knowledge must be retained? |

End of specification.
