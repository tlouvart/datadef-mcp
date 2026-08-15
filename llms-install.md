# Installing the Datadef MCP server (for AI agents)

Datadef is a REMOTE MCP server. There is nothing to build or run from this
repository; you connect to the hosted endpoint.

- Endpoint: `https://datadef.io/mcp` (Streamable HTTP)
- Auth: `Authorization: Bearer <API key>`; keys are created at
  https://datadef.io/settings/mcp (7-day free trial on signup, no card).
  OAuth is also supported for clients that prefer it (`https://datadef.io/mcp`
  advertises the authorization server via RFC 9728).
- Anonymous `initialize` and `tools/list` work without a key, so you can
  verify connectivity before the user provides credentials.

## Cline / Claude Desktop / any stdio-only client

Use the mcp-remote bridge:

```json
{
  "mcpServers": {
    "datadef": {
      "command": "npx",
      "args": [
        "-y", "mcp-remote", "https://datadef.io/mcp",
        "--header", "Authorization: Bearer ${DATADEF_API_KEY}"
      ],
      "env": { "DATADEF_API_KEY": "dd_live_..." }
    }
  }
}
```

## Clients with native Streamable HTTP support

```json
{
  "mcpServers": {
    "datadef": {
      "type": "http",
      "url": "https://datadef.io/mcp",
      "headers": { "Authorization": "Bearer dd_live_..." }
    }
  }
}
```

## Verify the install

Call `tools/list`: you should see `create_diagram`, `list_diagrams`,
`export_diagram`, `repo_status`, `repo_refresh` and the `canvas_*` suite.
A good first call is `get_design_guide` (no side effects), then
`create_diagram` with a short architecture description.
