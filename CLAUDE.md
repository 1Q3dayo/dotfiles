# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## 言語

ユーザーとのやり取りはすべて日本語で行ってください。コード内のコメントやコミットメッセージも日本語を使用してください。

## Overview

This repository manages dotfiles using Ansible for deployment to the local machine.

## Commands

```bash
# Deploy all dotfiles
ansible-playbook playbooks/dotfiles.yml

# Dry-run (check mode)
ansible-playbook playbooks/dotfiles.yml --check

# Deploy with verbose output
ansible-playbook playbooks/dotfiles.yml -v
```

## Architecture

ツール別にAnsibleロールを分割して管理しています。各ロールは以下の構造を持ちます：

```
roles/<tool>/
  files/          ← dotfilesを配置
  tasks/main.yml  ← copy タスク
  vars/main.yml   ← ファイルリストの定義（<tool>_dotfiles 変数）
```

### 対象ロール

| ロール | デプロイ先 | タグ |
|--------|-----------|------|
| zsh | `$HOME/` | `zsh` |
| starship | `$HOME/.config/starship/` | `starship` |
| zellij | `$HOME/.config/zellij/` | `zellij` |
| yazi | `$HOME/.config/yazi/` | `yazi` |
| lazygit | `$HOME/.config/lazygit/` | `lazygit` |
| claude | `$HOME/.claude/` | `claude` |
| codex | `$HOME/.codex/` | `codex` |
| gemini | `$HOME/.gemini/` | `gemini` |
| ghostty | `$HOME/Library/Application Support/com.mitchellh.ghostty/` | `ghostty` |

### dotfilesの追加方法

1. `roles/<tool>/files/` にファイルを配置
2. `roles/<tool>/vars/main.yml` の `<tool>_dotfiles` リストにファイル名を追加

特定のツールのみデプロイする場合は `--tags` を使用：
```bash
ansible-playbook playbooks/dotfiles.yml --tags zsh
```

## Skills

`skills/` ディレクトリにClaude Code用のカスタムスキルを管理しています。

- **code-review** (`/code-review`): コードレビューを実施。品質・セキュリティ・パフォーマンス・テスタビリティの観点で分析する
- **codex** (`/codex`): OpenAI Codex CLIと連携し、別の視点からコードレビューや分析を依頼する
- **create-pr** (`/create-pr`): ghコマンドでプルリクエストを作成。`.github/PULL_REQUEST_TEMPLATE.md` に沿った本文を自動生成する
- **example-skill**: 新しいスキルを作成する際のテンプレート
