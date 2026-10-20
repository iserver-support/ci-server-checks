#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
WORKFLOW="$ROOT/.github/workflows/server-checks.yml"

test -f "$WORKFLOW"
grep -q 'iserver-support/serverchecks' "$WORKFLOW"
grep -q 'bin/dns-audit' "$WORKFLOW"
grep -q 'bin/ssl-expiry' "$WORKFLOW"
grep -q 'CI_STRICT' "$WORKFLOW"
grep -q 'alert-days' "$WORKFLOW"

echo "PASS: reusable workflow exists in .github/workflows"
echo "PASS: workflow checks out A1 and invokes its existing scripts"
echo "PASS: strict DNS mode and configurable SSL threshold are present"
