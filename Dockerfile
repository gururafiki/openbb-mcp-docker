FROM python:3.15-slim

# THE PACKAGE SET IS PINNED, because `openbb[all]` resolved on the day of a build is not the image
# that was tested. constraints.txt is the deployed image's own `pip freeze`, so a rebuild changes
# only what is named here.
#
# finvizfinance>=1.5.0: 1.3.0 sends a 2020 Chrome/81 User-Agent, which finviz began refusing with
# 403 around 2026-09-30. Every finviz call through this image failed from then on: openbb-api's
# price targets and sector groups, and the agent's finviz tools. muffin-ingest, on 1.5.0, kept
# getting answers from the same node, which is what located the fault in the client rather than
# the address. The assertion fails the build if a resolver ever picks an older one.
COPY constraints.txt /tmp/constraints.txt
RUN pip install --no-cache-dir -c /tmp/constraints.txt "openbb[all]" openbb-mcp-server "finvizfinance>=1.5.0" \
 && python -c "import importlib.metadata as m; v = m.version('finvizfinance'); assert tuple(int(p) for p in v.split('.')[:2]) >= (1, 5), v"

EXPOSE 8001

CMD ["openbb-mcp", "--host", "0.0.0.0", "--port", "8001"]
