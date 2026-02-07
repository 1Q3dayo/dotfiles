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

- **Static dotfiles**: Place in `roles/dotfiles/files/` and add to `dotfiles_list` in `roles/dotfiles/vars/main.yml`
- **Template dotfiles**: Place `.j2` files in `roles/dotfiles/templates/` and add (without .j2) to `dotfiles_templates` in vars

The playbook copies files to `$HOME` with backup enabled.

## Skills

`skills/` ディレクトリにClaude Code用のカスタムスキルを管理しています。

- **code-review** (`/code-review`): コードレビューを実施。品質・セキュリティ・パフォーマンス・テスタビリティの観点で分析する
- **codex** (`/codex`): OpenAI Codex CLIと連携し、別の視点からコードレビューや分析を依頼する
- **example-skill**: 新しいスキルを作成する際のテンプレート
