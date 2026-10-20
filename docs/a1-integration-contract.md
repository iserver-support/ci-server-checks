# A1 Integration Contract

ASSET A6 calls the ASSET A1 scripts; it does not duplicate DNS or SSL logic.

Required files:
- `bin/dns-audit`
- `bin/ssl-expiry`

Each script must:
1. Accept the domain as the first positional argument (`$1`); A6 passes the domain this way.
2. Exit `0` only when the check passes.
3. Exit non-zero on DNS failure, certificate retrieval/parse failure, or expiry at/below `ALERT_DAYS`.
4. Print concise diagnostics and avoid interactive prompts.
5. Avoid email notifications in CI mode (`CI=true`).

If the existing A1 script uses only an environment variable, adapt its input handling without replacing its tested logic. If it only prints a warning but returns zero, update its exit-code behavior. Prefer explicit exit codes over parsing human-readable output.

Test cases:
- Healthy DNS and certificate outside threshold: pass.
- Required DNS records missing: fail.
- Expired certificate or certificate within threshold: fail.
- Missing A1 script or invalid input: fail early.
- Optional DNS record absent by design: pass unless that record is required for the service.
