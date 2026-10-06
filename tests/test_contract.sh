#!/usr/bin/env bash
set -euo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
grep -q 'scripts/check_dns.sh' "$ROOT/workflows/server-checks.yml"
grep -q 'scripts/check_ssl.sh' "$ROOT/workflows/server-checks.yml"
grep -q 'alert-days' "$ROOT/workflows/server-checks.yml"
grep -q 'Build and test ASSET A1 first' "$ROOT/README.md"
grep -q 'Exit non-zero' "$ROOT/docs/a1-integration-contract.md"
echo "PASS: workflow references both A1 scripts"
echo "PASS: expiry threshold and A1 dependency are documented"
echo "PASS: non-zero exit-code contract is documented"
