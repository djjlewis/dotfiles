---
name: whats-next
description: Briefing for the course platform and courses (djjlewis/course-platform, djjlewis/learning-python) - the maintainer's decisions first, then local work, what's running, and what can go to the cloud. Use when the user asks "what's next", "what do I need to do", "where are we", or for a status or briefing on the course work.
---

# What's next

Gives the maintainer one short briefing so they never have to read old session threads to know what needs them.

## Gather

1. Run `bash ~/.claude/skills/whats-next/status.sh`. It is read-only.
2. List the sessions this session started (`list_sessions` with `linked: true`) for what is running, finished, or waiting on the user. A cloud session never reports back, so match it to its PR by issue number in the PR list.
3. Read an issue body only when you need it to state the decision in one line.

## Brief

Use exactly these four sections, in this order. Leave out a section that has nothing in it. Each item is one line with a link: `[repo#n](https://github.com/djjlewis/<repo>/issues/<n>)` or `/pull/<n>`, and sessions as `[title](#local_<id>)`. Aim for 25 lines or fewer.

**1. Your decisions.** Things only the maintainer can do in a minute or two, numbered so they can reply "1: option 2":
- `ready-for-human` issues that ask for a choice (titles starting "Decide", or bodies with "Options" or "Decision needed"): name the options in a few words each.
- Non-draft PRs with green checks: "merge?". If the PR touches `.github/`, say they must read that file first.
- Red PRs from agent sessions: say whether to re-run or send back.
- Any session waiting on the user's answer.

**2. Your hands-on work.** Work that needs the maintainer's time or machine: `ready-for-human` issues that are writing or rehearsal (such as lessons), draft PRs held for the maintainer's rehearsal (say "rehearse, then mark ready"), issues marked `local`, issues assigned to them, and checkout tidying (a branch already merged, uncommitted files).

**3. Running.** Sessions in flight and PRs waiting on CI or review. Nothing for the user to do; say so.

**4. Ready for the cloud.** Unassigned `ready-for-agent` issues marked `cloud`, frontier issues first, then ones that could be pulled forward. If two would change the same files, say so.

Then stop. Ask one question: which cloud items to start. Start them with `start_session` (`user_asked`, `target: "cloud"`) only when the user says yes. Build briefs begin with `/implement #<n>` if `.agents/skills/implement/` exists in course-platform, or with `/mattpocock-skills:implement #<n>` if it doesn't. Research and prototype briefs name the `/research` or `/prototype` skill. Each brief says to claim the issue, go through the review loop in `docs/agents/workflow.md`, and not merge.

## Rules

- The repos are private to the `djjlewis` account, and the active `gh` account may be a different one. Run every `gh` command with `GH_TOKEN=$(gh auth token --user djjlewis)`, and never switch the active account.

- Don't merge, comment, assign or label anything while briefing. Those happen only when the user answers.
- When the user answers a decision, record it where the repo's workflow says (an issue comment, or a new `ready-for-agent` issue), then show the briefing again.
