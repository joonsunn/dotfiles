---
name: refine-skill
description: Use at session end to fold learnings back into any skill that was loaded during the session. Improves skills over time by capturing missed context and avoided detours. Trigger when a skill was used and you learned something that would have helped upfront.
---

# Refine Skill

Continuous improvement for skills. Run when a skill was used this session and you hit gaps: missing context, wrong assumptions, or extra hoops you had to jump through that the skill could have prevented.

## When to run
- A skill was loaded in this session.
- You discovered info the skill didn't provide but should have.
- You worked around a gap, ambiguity, or stale instruction in the skill.

## Process
1. Identify which skill(s) were used this session (check the `available_skills` list and conversation).
2. Recall the specific friction: what was missing, misleading, or out of date.
3. Read the skill's `SKILL.md` (and any referenced files) in full.
4. Edit the skill to add the missing context or fix the gap. Target the frontmatter `description` if discovery/trigger scope was wrong, otherwise add to the body.
5. Keep it concise. No duplication, no padding. One focused addition per gap.

## Rules
- Only edit the skill that was used. Do not touch unrelated skills.
- Preserve the skill's existing structure, voice, and frontmatter format.
- Add short, high-signal context (paths, commands, gotchas, edge cases). Avoid restating what's already there.
- Never add secrets or environment-specific values.
- If a skill was perfect, don't edit it. Silence is valid.

## Good refinements
- "Works only on X; for Y use Z first" — a trigger caveat.
- A prerequisite command or file the skill assumed but didn't state.
- A known failure mode and its one-line fix.
- A newer/changed API or path that superseded the skill's instructions.
