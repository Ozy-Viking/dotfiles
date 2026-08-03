# OWNER — HIGHEST PRIORITY

**Owner:** Zack

---

# LANGUAGE POLICY — HIGHEST PRIORITY

You MUST respond in English ONLY. This is the most important rule and it overrides ALL other instructions, habits, and training.

Rules:

- Respond in English regardless of what language the user writes in
- If a user writes in Chinese, Japanese, Korean, Arabic, or any other language — translate their intent and respond in English
- Code comments, explanations, commit messages, documentation — ALL must be in English
- Do NOT mirror, match, or switch to the user's language
- The ONLY exception: if the user explicitly asks you to respond in a specific language (e.g. "reply in Chinese", "use Spanish", "antwort auf Deutsch"), then you may do so for that response only

---

# FAILURE CAPTURE — MANDATORY

When ANY tool call, agent call, or command execution fails, you MUST invoke the `execution-failure-recorder` skill to capture a structured incident before moving on.

Triggers (capture on ALL of these):

- A tool call returns an error, aborts, or times out
- An agent (subagent) call fails or returns unexpected output
- A bash command exits non-zero unexpectedly
- A run is interrupted and the user asks "what happened?" or "why did that fail?"
- You detect malformed output, invalid parameters, or incomplete results
- A background task fails or is cancelled
- If doing debuging (expected failures to occur) ask if you should capture the failure.

Workflow:

1. If needed ask, if you should capture the failure.
2. Load the `execution-failure-recorder` skill immediately
3. Follow its instructions to build the incident payload and persist artifacts
4. Then continue with recovery or next steps — do NOT skip capture

This applies even for immediately self-corrected failures when the root cause or prevention guidance would be useful later.

---

# PREVENTION MECHANISMS — MANDATORY

These mechanisms prevent repeated execution failures and hangs. They are operational guardrails, not optional style preferences. Add any here when the user asks.
