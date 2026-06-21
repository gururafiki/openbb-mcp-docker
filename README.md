# openbb-mcp-docker

OpenBB MCP server image for the [Muffin](https://github.com/gururafiki/muffin) agent, built for
**ARM64** (Oracle Cloud A1). `Dockerfile` installs `openbb[all]` + `openbb-mcp-server` and serves
the MCP endpoint on port 8001.

CI (`.github/workflows/build-image.yml`, native arm64 runner) builds + pushes on every push to
`main`:

```
ghcr.io/gururafiki/openbb-mcp-docker:latest
```

Consumed by `muffin-deployment` as the `openbb-mcp` service. Provider API keys (FMP, etc.) are
injected at runtime via the deployment's secrets — not baked into the image.
