# Bridge container for the hosted Datadef MCP server.
#
# Datadef is a remote Streamable HTTP server at https://datadef.io/mcp.
# This image bridges stdio to it via mcp-remote, for clients and checkers
# that expect a runnable container. Pass your API key at run time:
#
#   docker run -i -e DATADEF_API_KEY=dd_live_... datadef-mcp
#
# Keys: https://datadef.io/settings/mcp (7-day free trial includes MCP).
FROM node:20-alpine
RUN npm install -g mcp-remote@latest
ENV DATADEF_API_KEY=""
ENTRYPOINT ["sh", "-c", "mcp-remote https://datadef.io/mcp --header \"Authorization: Bearer ${DATADEF_API_KEY}\""]
