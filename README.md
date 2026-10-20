# CI Server Checks

Reusable GitHub Actions workflow for running ASSET A1 DNS and SSL scripts against a domain. **Build and test ASSET A1 first.** This component reuses A1 rather than duplicating its check logic.

## Required A1 scripts

The reusable workflow checks out the A1 repository (`iserver-support/serverchecks`) and runs `bin/dns-audit` and `bin/ssl-expiry`. DNS checks run with `CI_STRICT=true`. The SSL expiry threshold is configurable through `alert-days` (default 10 days).

## Same-repository use

For use in the same repository, call the workflow from a workflow file:

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
    uses: iserver-support/ci-server-checks/.github/workflows/server-checks.yml@main
    with:
      domain: example.com
      alert-days: 10
```

The workflow checks out A1 from its `main` branch. For reproducible production use, consider pinning the A1 checkout to an approved commit or release.

## DNS policy

Do not treat every absent record as a failure. A domain may intentionally have no AAAA or MX record. Configure A1 to check the records required for the target service.

## Security

Do not commit credentials or private keys. Test against a staging domain first, and review/pin GitHub Actions versions according to your policy.

## Related resource

For related cloud server administration and management services, visit [iServerSupport Cloud Server Management](https://iserversupport.com/cloud-server-management/).
