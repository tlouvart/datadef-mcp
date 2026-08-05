# Datadef MCP

Data-architecture diagrams your AI generates, edits, and exports — from Claude, Cursor, VS Code, Gemini CLI, or any MCP client. Typed tables with columns, pipelines, column-level lineage, 2,000+ real tool icons. Exported PNGs come back inline in the chat.

This repo is the public home of the **remote** MCP server at `https://datadef.io/mcp` (Streamable HTTP). There is nothing to install from here — it exists for directories, install links, and issues.

## Connect

Create an API key at [datadef.io/settings/mcp](https://datadef.io/settings/mcp) — the 7-day free trial includes MCP access.

**Claude Code**

```bash
claude mcp add --transport http datadef https://datadef.io/mcp \
  --header "Authorization: Bearer dd_live_YOUR_KEY"
```

**Cursor / Claude Desktop** (via the `mcp-remote` bridge)

```jsonc
{
  "mcpServers": {
    "datadef": {
      "command": "npx",
      "args": [
        "-y", "mcp-remote", "https://datadef.io/mcp",
        "--header", "Authorization: Bearer dd_live_YOUR_KEY"
      ]
    }
  }
}
```

**VS Code** (`.vscode/mcp.json`)

```jsonc
{
  "servers": {
    "datadef": {
      "type": "http",
      "url": "https://datadef.io/mcp",
      "headers": { "Authorization": "Bearer ${input:datadef-key}" }
    }
  }
}
```

**Gemini CLI** (`~/.gemini/settings.json`) — note `httpUrl`, not `url`; plain `url` is legacy SSE there and fails silently:

```json
{
  "mcpServers": {
    "datadef": {
      "httpUrl": "https://datadef.io/mcp",
      "headers": { "Authorization": "Bearer $DATADEF_API_KEY" }
    }
  }
}
```

One-click install buttons live at [datadef.io/settings/mcp](https://datadef.io/settings/mcp).

## Tools

Two layers. **Outcome-level** — describe an intent, Datadef's pipeline carries it out: `create_diagram`, `list_diagrams`, `get_diagram`, `edit_diagram`, `export_diagram`, `get_design_guide`. **Atomic** — 25 `canvas_*` tools your model drives directly (add/update/remove nodes, connect edges, set columns, add lineage, group, align, layout, validate), so the agent that already knows your repo can draw what it finds. The `datadef_design_guide` prompt teaches any model the design standard before it draws.

## Why a diagram tool wants an agent

The agent that just changed your dbt project still has the whole change in context. Telling it "update the architecture diagram too" costs one sentence — and an embedded diagram (`![arch](https://datadef.io/api/embed/your-diagram)`) updates everywhere the canvas does. Docs stop rotting.

## Run as a container

For clients or checkers that want a runnable image, the included Dockerfile
bridges stdio to the hosted server:

```bash
docker build -t datadef-mcp .
docker run -i -e DATADEF_API_KEY=dd_live_YOUR_KEY datadef-mcp
```

## Links

- Try without an account: [datadef.io/scratch](https://datadef.io/scratch)
- MCP guide: [datadef.io/guides/en/mcp-diagram-server](https://datadef.io/guides/en/mcp-diagram-server)
- Issues and feedback: right here.
