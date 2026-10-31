#!/usr/bin/env bash
# Gathers the raw state behind the /whats-next briefing for the course platform
# and the courses. Read-only: it never changes an issue, PR or checkout.
set -uo pipefail

OWNER=djjlewis
PROJECT=2
REPOS=(course-platform learning-python)
CHECKOUTS=("$HOME/projects/personal/course-platform" "$HOME/projects/personal/learning-python")

# The repos are private to this account; don't depend on which gh account is active.
GH_TOKEN="${GH_TOKEN:-$(gh auth token --user "$OWNER" 2>/dev/null)}"
export GH_TOKEN

echo "## FRONTIER (Now phase, ready-for-*, unblocked, unassigned)"
echo "# repo#number | label | where | title"
frontier=$(gh project item-list "$PROJECT" --owner "$OWNER" --limit 200 --format json \
  --jq '.items[] | select(.phase=="Now" and .status!="Done" and .content.type=="Issue" and ((.labels // []) | any(startswith("ready-for-")))) | "\(.content.repository) \(.content.number)"' |
while read -r repo number; do
  gh api "repos/$repo/issues/$number" --jq '
    select(.state=="open" and (.assignees|length)==0 and (.issue_dependencies_summary.blocked_by // 0)==0)
    | "\(.repository_url|split("/")|last)#\(.number) | \(.labels|map(.name|select(startswith("ready-for-")))|join(",")) | \(if ((.body // "")|test("[Rr]uns in a local session")) then "local" else "cloud" end) | \(.title)"'
done)
echo "$frontier"

echo
echo "## READY-FOR-AGENT NOT ON THE FRONTIER (later phase, or blocked)"
for r in "${REPOS[@]}"; do
  gh issue list -R "$OWNER/$r" --state open --label ready-for-agent --json number,title,assignees,body \
    --jq ".[] | select((.assignees|length)==0) | \"$r#\(.number) | \(if ((.body // \"\")|test(\"[Rr]uns in a local session\")) then \"local\" else \"cloud\" end) | \(.title)\""
done | while read -r line; do
  ref=${line%% |*}
  grep -qF "$ref |" <<<"$frontier" && continue
  blockers=$(gh api "repos/$OWNER/${ref%#*}/issues/${ref#*#}/dependencies/blocked_by" --jq '[.[]|select(.state=="open")|"#\(.number)"]|join(",")' 2>/dev/null)
  echo "$line${blockers:+ | blocked by $blockers}"
done

echo
echo "## IN PROGRESS (assigned, open)"
for r in "${REPOS[@]}"; do
  gh issue list -R "$OWNER/$r" --state open --json number,title,assignees \
    --jq ".[] | select((.assignees|length)>0) | \"$r#\(.number) | \(.assignees|map(.login)|join(\",\")) | \(.title)\""
done

echo
echo "## OPEN PRS"
echo "# repo#number | draft | checks | touches .github | author | branch | title"
for r in "${REPOS[@]}"; do
  gh pr list -R "$OWNER/$r" --state open --json number,title,isDraft,author,headRefName,statusCheckRollup,files --jq "
    .[] | \"$r#\(.number) | draft=\(.isDraft) | \(
      [.statusCheckRollup[]? | (.conclusion // .state // \"PENDING\")] as \$c
      | if (\$c|length)==0 then \"none\"
        elif (\$c|any(.==\"FAILURE\" or .==\"ERROR\" or .==\"CANCELLED\" or .==\"TIMED_OUT\")) then \"red\"
        elif (\$c|all(.==\"SUCCESS\" or .==\"NEUTRAL\" or .==\"SKIPPED\")) then \"green\"
        else \"pending\" end) | github=\([.files[]?.path|startswith(\".github/\")]|any) | \(.author.login) | \(.headRefName) | \(.title)\""
done

echo
echo "## LOCAL CHECKOUTS"
for d in "${CHECKOUTS[@]}"; do
  [ -d "$d/.git" ] || continue
  git -C "$d" fetch -q origin 2>/dev/null
  branch=$(git -C "$d" branch --show-current)
  dirty=$(git -C "$d" status --porcelain | wc -l | tr -d ' ')
  merged=$(gh pr list -R "$OWNER/$(basename "$d")" --state merged --head "$branch" --json number --jq '.[0].number // empty' 2>/dev/null)
  echo "$(basename "$d") | branch=$branch | uncommitted=$dirty | ${merged:+branch already merged as PR #$merged}"
done
