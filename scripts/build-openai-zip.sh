#!/usr/bin/env bash
# Пакет для каталога ChatGPT: plugin.json, mcp.json, skills, assets.
#
# Файлы Claude (.claude-plugin/, .mcp.json) в архив не попадают намеренно:
# площадка читает только свой манифест, а лишние файлы в пакете — лишний
# повод для вопросов на ревью.
set -Eeuo pipefail
cd "$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")/.."

out=dist/treeple-openai.zip
mkdir -p dist
rm -f "$out"

# Проверяем до упаковки: архив без иконки или без скилла ревью не пройдёт.
for f in plugin.json mcp.json skills/central-asia-trip-planner/SKILL.md \
  assets/logo.png assets/logo-dark.png assets/icon.png assets/icon-dark.png; do
  [[ -f $f ]] || { echo "build: нет файла $f" >&2; exit 1; }
done
python3 -c 'import json,sys; json.load(open("plugin.json")); json.load(open("mcp.json"))' \
  || { echo "build: plugin.json или mcp.json не разбирается" >&2; exit 1; }

zip -q -r "$out" plugin.json mcp.json skills assets -x '*/.*'
echo "build: $out"
unzip -l "$out"
