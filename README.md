# openbb-mcp-docker

OpenBB MCP server image for the [Muffin](https://github.com/gururafiki/muffin) agent, built for
**ARM64** (Oracle Cloud A1). `Dockerfile` installs `openbb[all]` + `openbb-mcp-server` and serves
the MCP endpoint on port 8001.

**The package set is pinned by `constraints.txt`**, the deployed image's own `pip freeze`. An unpinned
`openbb[all]` resolves differently on every build day, so a rebuild for one fix would otherwise move
every package under the agent's MCP server. To change a package, edit its line there; to re-snapshot,
run `pip freeze --all` in the deployed container. `finvizfinance` is named in the Dockerfile instead
(>=1.5.0): 1.3.0's User-Agent has been refused by finviz with 403 since about 2026-09-30.

CI (`.github/workflows/build-image.yml`, native arm64 runner) builds + pushes on every push to
`main`:

```
ghcr.io/gururafiki/openbb-mcp-docker:latest
```

Consumed by `muffin-deployment` as the `openbb-mcp` service. Provider API keys (FMP, etc.) are
injected at runtime via the deployment's secrets — not baked into the image.
