# Exhaustive First-Pass Review Before Independent Secondary Review

**Version:** 1.0  
**State:** Project review procedure

## Purpose

Ensure that our own reasoning performs the primary discovery, analysis, and synthesis before invoking the independent secondary reviewer.

The governing sequence is:

**Our exhaustive review → explicit findings and hypotheses → independent secondary review → reconciliation → final judgment**

The independent secondary reviewer must not become the mechanism that tells us what to look for.

---


## Terminology sovereignty

The review workflow must not introduce or preserve external product/project names or distinctive external vocabulary in Fifty artifacts. Tool/reviewer identity remains operational metadata outside the project namespace. Project-facing findings use generic role labels such as “secondary reviewer” and Fifty-native terminology only.

---

## Core Principle

> Perform the deepest review we can ourselves before asking the independent secondary reviewer to inspect the work.

The independent secondary reviewer is the **second reviewer**, not the discovery engine.

The first-pass analysis must independently establish:

- what the artifact is trying to do;
- how it is structured;
- what assumptions it makes;
- where its important boundaries are;
- what can fail;
- what evidence supports or contradicts it;
- what is missing;
- what appears correct;
- what remains uncertain;
- what should be tested or challenged.

Only after this review is documented should independent secondary reviewer be invoked.

---

## Why This Skill Exists

Starting with the independent secondary reviewer creates several risks:

1. **Anchoring**
   - Subsequent reasoning becomes biased toward issues the independent secondary reviewer happened to notice.

2. **Coverage blindness**
   - Areas the independent secondary reviewer does not inspect may receive insufficient attention.

3. **False independence**
   - A later review is not truly independent if it merely elaborates on independent secondary reviewer's findings.

4. **Reasoning atrophy**
   - The primary reviewer gradually becomes an orchestrator rather than an analyst.

5. **Tool authority bias**
   - secondary-review findings can be accepted because they came from the independent secondary reviewer rather than because the evidence supports them.

6. **Discovery collapse**
   - The process degenerates into:
     `Ask independent secondary reviewer → explain independent secondary reviewer → accept/reject`
     instead of:
     `Understand → investigate → hypothesize → verify`.

---

# Required Workflow

## Phase 1 — Establish the Review Surface

Before analysis, determine what is actually being reviewed.

Identify:

- objectives;
- requirements;
- architecture;
- implementation;
- interfaces;
- dependencies;
- data flows;
- trust boundaries;
- failure boundaries;
- tests;
- operational assumptions;
- security assumptions;
- performance assumptions;
- deployment model;
- unresolved decisions.

Produce a review map before forming conclusions.

---

## Phase 2 — Independent Exhaustive Review

Review the artifact without relying on secondary-review findings.

Use multiple analytical passes.

### Pass A — Intent and Requirement Review

Determine:

- What problem is being solved?
- What requirements are explicit?
- What requirements are implicit?
- What would make the solution unsuccessful even if technically functional?
- Are requirements internally consistent?
- Are important requirements missing?

### Pass B — Structural Review

Inspect:

- major components;
- module boundaries;
- ownership boundaries;
- state;
- lifecycle;
- control flow;
- data flow;
- dependency direction;
- coupling;
- hidden assumptions.

### Pass C — Correctness Review

Look for:

- incorrect logic;
- impossible states;
- race conditions;
- inconsistent contracts;
- invalid assumptions;
- incomplete state transitions;
- unsafe defaults;
- error-handling gaps;
- unhandled edge cases.

### Pass D — Failure Analysis

Ask:

- What happens when each dependency fails?
- What happens when input is malformed?
- What happens under partial completion?
- What happens after interruption?
- Can state become inconsistent?
- Can operations be safely retried?
- What happens under concurrency?
- What happens at resource exhaustion?

### Pass E — Security and Trust Review

Inspect:

- authentication;
- authorization;
- privilege boundaries;
- input validation;
- secret handling;
- command execution;
- external integrations;
- data exposure;
- unsafe deserialization;
- injection surfaces;
- escalation paths.

### Pass F — Operability Review

Inspect:

- logging;
- observability;
- diagnostics;
- recovery;
- rollback;
- configuration;
- deployment;
- upgrade paths;
- backup;
- reproducibility.

### Pass G — Maintainability Review

Look for:

- unnecessary complexity;
- duplication;
- hidden coupling;
- unclear contracts;
- abstraction leakage;
- brittle implementation;
- unclear ownership;
- poor testability.

### Pass H — Evidence Review

Separate findings into:

- directly observed;
- strongly inferred;
- plausible but unverified;
- unknown.

Do not silently convert an inference into a fact.

---

# Phase 3 — Build the First-Pass Findings Register

Before invoking independent secondary reviewer, create a findings register.

Each material finding should contain:

```text
ID:
Area:
Finding:
Evidence:
Why it matters:
Severity:
Confidence:
Recommended verification:
```

Also maintain:

```text
Open Questions
Assumptions
Potential Failure Modes
Missing Evidence
Areas Reviewed With No Issue Found
```

Recording clean areas is important because it demonstrates actual review coverage rather than only issue collection.

---

# Phase 4 — Freeze the First-Pass View

Before independent secondary reviewer is used, preserve the first review state.

The review should explicitly record:

```text
FIRST-PASS REVIEW COMPLETE

Known findings:
...

Suspected findings:
...

Open questions:
...

Areas considered sound:
...

Areas requiring deeper verification:
...
```

Do not retroactively rewrite this baseline after seeing secondary-review results.

This makes independent-review quality measurable.

---

# Phase 5 — independent secondary reviewer as Independent Second Reviewer

Now invoke the independent secondary reviewer.

The independent secondary reviewer should receive the artifact and review objective, but it should **not initially receive our findings** unless needed for a targeted verification pass.

Preferred instruction:

```text
Independently review this artifact.

Do not assume the existing design is correct.

Identify correctness defects, architectural weaknesses,
missing edge cases, security issues, operational risks,
unhandled failure modes, inconsistent contracts, and
missing tests.

Provide concrete evidence for each finding.

Do not optimize for agreement with another reviewer.
```

This preserves reviewer independence.

---

# Phase 6 — Compare Reviews

After the secondary reviewer completes its independent review, compare findings.

Classify every significant result as:

### A — Found by both

Strong corroboration.

```text
OURS: detected
SECONDARY REVIEWER: detected
STATUS: corroborated
```

### B — Found by us only

Requires investigation.

Possibilities include:

- we discovered something independent secondary reviewer missed;
- our finding is invalid;
- independent secondary reviewer lacked sufficient context.

### C — Found by the independent secondary reviewer only

Treat this as a new hypothesis, not automatically as truth.

Verify it independently.

```text
SECONDARY REVIEWER CLAIM:
...

OUR VERIFICATION:
...

RESULT:
CONFIRMED / PARTIALLY CONFIRMED / REJECTED / UNRESOLVED
```

### D — Disagreement

Re-open the evidence.

Never resolve disagreement based on reviewer identity.

Use:

```text
Claim
Evidence supporting our interpretation
Evidence supporting secondary-review interpretation
Relevant implementation/contracts/tests
Resolution
Remaining uncertainty
```

---

# Phase 7 — Targeted independent secondary reviewer Verification

Only after the independent comparison may independent secondary reviewer receive our findings.

Use it to challenge specific conclusions.

Examples:

```text
Try to falsify Finding F-07.

We believe X can produce Y under condition Z.
Inspect the implementation and determine whether that claim is valid.
Provide a concrete execution path or explain why the path is impossible.
```

or:

```text
We found no correctness issue in this subsystem.

Attempt to invalidate that conclusion.
Focus on concurrency, retries, state recovery, and malformed input.
```

At this stage the independent secondary reviewer acts as an **adversarial verifier**.

---

# Phase 8 — Synthesis

The final review must distinguish provenance.

Example:

```text
F-01 — Independently discovered, secondary reviewer corroborated
F-02 — Independently discovered, secondary reviewer did not identify
F-03 — secondary reviewer discovered, independently verified
F-04 — secondary reviewer suggested, verification rejected
F-05 — Reviewer disagreement remains unresolved
```

The final result is produced from evidence, not by merging opinions.

---

# Mandatory Rule

Do not use this workflow:

```text
secondary review
    ↓
Read secondary-review findings
    ↓
Investigate those findings
    ↓
Call that an exhaustive review
```

That is **tool-directed investigation**, not independent review.

Use:

```text
Artifact
   ↓
Our review surface
   ↓
Our exhaustive analysis
   ↓
Our findings + uncertainties
   ↓
Freeze first-pass state
   ↓
independent secondary review
   ↓
Difference analysis
   ↓
Targeted adversarial verification
   ↓
Evidence reconciliation
   ↓
Final assessment
```

---

# When to Use

Use this skill for:

- repository reviews;
- architecture reviews;
- implementation assessments;
- technical specifications;
- project build plans;
- design documents;
- security reviews;
- migration plans;
- AI-generated implementations;
- PR reviews;
- milestone acceptance;
- engineering handoffs;
- code audits;
- debugging complex systems;
- validating agent-generated work.

It is especially important when the secondary reviewer has access to the entire repository and could easily become the dominant source of discovery.

---

# When Not to Use

A full exhaustive-first workflow may be unnecessary for:

- trivial syntax corrections;
- obvious isolated compiler errors;
- simple formatting changes;
- mechanical refactoring;
- narrowly scoped questions where independent discovery provides little value.

Even in these cases, do not present secondary-review output as independently verified unless it actually was verified.

---

# Review Depth Rule

The first pass must be deep enough that the independent secondary reviewer can genuinely surprise us.

If nearly every substantive issue in the final report originates from the independent secondary reviewer, the first-pass review was probably insufficient.

This is a process-quality signal, not proof of failure.

---

# Discovery vs Verification

Maintain a strict distinction:

| Activity | Primary Owner |
|---|---|
| Understand the problem | Us |
| Establish review surface | Us |
| Discover obvious defects | Us |
| Discover architectural risks | Us |
| Develop hypotheses | Us |
| Identify unknowns | Us |
| First-pass evidence gathering | Us |
| Independent second review | independent secondary reviewer |
| Adversarial challenge | independent secondary reviewer |
| Repository-scale cross-check | independent secondary reviewer |
| Mechanical code tracing | independent secondary reviewer |
| Final evidence evaluation | Us |
| Final judgment | Us |

independent secondary reviewer increases review strength without replacing primary reasoning.

---

# Anti-Patterns

## independent secondary reviewer-First Anchoring

```text
"What does independent secondary reviewer think is wrong?"
```

Avoid.

Prefer:

```text
"What do we believe is wrong after independently examining the system?"
```

---

## Finding Laundering

Bad:

```text
independent secondary reviewer says there is a race condition.
Therefore there is a race condition.
```

Required:

```text
independent secondary reviewer reports a possible race condition.

Trace:
...

Shared state:
...

Interleaving:
...

Result:
CONFIRMED
```

---

## Artificial Agreement

Do not reshape our earlier interpretation merely to match independent secondary reviewer.

Disagreement is useful evidence.

---

## Exhaustiveness by Tool Invocation

Multiple independent secondary reviewer calls do not make a review exhaustive.

Exhaustiveness comes from deliberate coverage of the review surface.

---

## Delegated Understanding

Never allow:

```text
"I don't yet understand this subsystem, so I will ask independent secondary reviewer what it does."
```

as the default review method.

First build our own model.

independent secondary reviewer may then validate or challenge it.

---

# Evidence Standard

A material technical finding should ideally have at least one of:

- source-code path;
- execution trace;
- violated contract;
- failing test;
- reproducible scenario;
- architecture contradiction;
- configuration evidence;
- specification conflict;
- observable runtime behavior.

Reviewer confidence alone is not evidence.

---

# Completion Criteria

The review is complete only when:

- the review surface has been mapped;
- an independent first pass has been completed;
- major assumptions have been documented;
- important failure modes have been examined;
- findings have supporting evidence;
- uncertainties are explicit;
- the first-pass state has been preserved;
- independent secondary reviewer has performed an independent second review;
- independent secondary reviewer-only findings have been independently evaluated;
- disagreements have been investigated;
- the final report identifies evidence and provenance.

---

# Compact Operational Version

For routine use:

```text
1. Understand the artifact ourselves.
2. Map the complete review surface.
3. Perform multiple independent review passes.
4. Document findings, assumptions, unknowns, and clean areas.
5. Freeze the first-pass assessment.
6. Ask independent secondary reviewer for an independent review without revealing our findings.
7. Diff our findings against independent secondary reviewer.
8. Independently verify independent secondary reviewer-only findings.
9. Use independent secondary reviewer adversarially against disputed/high-risk conclusions.
10. Produce an evidence-based final assessment.
```

---

# Governing Statement

**Our reasoning owns discovery.  
independent secondary reviewer supplies independent scrutiny.  
Evidence resolves disagreement.**

The right sequence is:

**our own exhaustive review first, independent secondary reviewer second.**