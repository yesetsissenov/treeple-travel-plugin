# Treeple Tours — plugin

Guided tours in Kazakhstan and the Kyrgyz part of one long itinerary, from the
catalogue of [Treeple](https://treeple.kz/en), a tour operator based in Almaty.
This package connects an assistant to the Treeple catalogue over a remote MCP
server: no account, no API key.

## What it can do

- **Search the catalogue** by place, region, theme, trip length, party size,
  budget, departure window and guide language.
- **Open one tour** in full: day-by-day itinerary, what the price includes and
  excludes, meeting point, cancellation terms, group size, guide languages,
  photos and verified reviews.
- **Price a tour exactly** for a given party and date, in USD. The per-person
  price falls as the party grows, so the total comes from the catalogue rather
  than from arithmetic; a quote carries the moment it holds until.
- **Show departure dates**, including the honest "on request" for the many
  tours that are arranged individually and confirmed by a manager.
- **Plan a set of tours** that fills a number of days, and compare two to four
  tours side by side.
- **Answer practical questions** — what to see, where to eat, when to go — from
  the places and articles Treeple publishes, with their source links.
- **Hand a tour request to a manager**, who replies by email, WhatsApp or
  Telegram.

## What it cannot do

- It takes no payment and holds no card details. Payment happens on treeple.kz,
  with a manager. In Claude the plugin can return a checkout link on treeple.kz;
  in ChatGPT it stops at the request and the tour page.
- A request reserves nothing: the departure, the hotels and the final price are
  confirmed by a manager.
- There is no status to poll. Once a request is sent, the manager contacts the
  traveller directly.
- It holds no structured visa data, and no flights or standalone hotels.
- It asks for no passport numbers, birth dates or payment details.

## Connect it

### ChatGPT

The plugin talks to `https://mcp.treeple.kz/apps/mcp` (`mcp.json`). Build the
submission package with:

```bash
bash scripts/build-openai-zip.sh      # → dist/treeple-openai.zip
```

The archive holds `plugin.json`, `mcp.json`, `skills/` and `assets/` — the
Claude-only files stay out of it.

### Claude

The plugin manifest is `.claude-plugin/plugin.json` and the server is
`https://mcp.treeple.kz/apps/claude/mcp` (`.mcp.json`). From a checkout of this
repository:

```bash
claude plugin validate .
```

Claude Code and the Claude apps install the plugin from the directory or from a
marketplace entry that points at this repository.

### Any MCP client

Point a Streamable HTTP MCP client at one of the two URLs above; no
authentication is required.

## Layout

```
plugin.json                 Agent Plugins manifest (ChatGPT listing and review)
mcp.json                    remote MCP server for ChatGPT
.claude-plugin/plugin.json  Claude plugin manifest
.mcp.json                   remote MCP server for Claude
skills/                     onboarding skill: how to plan a trip with the catalogue
assets/                     logo and composer icons, 512×512 PNG
scripts/build-openai-zip.sh builds dist/treeple-openai.zip
```

## Privacy, terms, support

- Privacy policy: https://treeple.kz/en/privacy
- Terms of service: https://treeple.kz/en/terms
- Support: https://treeple.kz/en/contacts
- Website: https://treeple.kz/en

A tour request carries only what a manager needs to answer: the tour, the
dates, the party, the traveller's name and citizenship when they are given, one
contact channel, and the traveller's own wishes. Nothing else is collected.

## Licence

MIT — see [LICENSE](LICENSE). The Treeple name, logo and catalogue content
remain the property of Keeyo, Inc.
