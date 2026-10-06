# CI Server Checks

Reusable GitHub Actions workflow for running ASSET A1 DNS and SSL scripts against a domain. **Build and test ASSET A1 first.** This component reuses A1 rather than duplicating its check logic.

## Required A1 scripts

Add these tested scripts to the caller repository:
- `scripts/check_dns.sh`
- `scripts/check_ssl.sh`

Both must accept the domain as `$1` or through `DOMAIN`, print useful diagnostics, and return exit code `0` only on success. The SSL script should read `ALERT_DAYS` (default 10) and return non-zero if the certificate cannot be checked or expires within that threshold. If A1 currently only prints warnings, update its exit status for CI use.

## Same-repository use

Copy `workflows/server-checks.yml` to `.github/workflows/server-checks.yml`, then call it from a workflow:

```yaml
jobs:
  server-checks:
    uses: ./.github/workflows/server-checks.yml
    with:
      domain: example.com
      alert-days: 10
```

## Cross-repository use

After publishing this component, call it with:

```yaml
jobs:
  server-checks:
    uses: iserversupport/ci-server-checks/.github/workflows/server-checks.yml@main
    with:
      domain: example.com
      alert-days: 10
```

Replace `iserversupport` with your actual GitHub owner. The reusable workflow checks out the caller repository, so the A1 scripts must be present in the caller repository. Alternatively, vendor the approved A1 scripts into the component repository or add a version-pinned checkout of A1 after confirming its real repository and file paths.

## DNS policy

Do not treat every absent record as a failure. A domain may intentionally have no AAAA or MX record. Configure A1 to check the records required for the target service.

## Security

Do not commit credentials or private keys. Test against a staging domain first, and review/pin GitHub Actions versions according to your policy.
