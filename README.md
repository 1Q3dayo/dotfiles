# dotfiles

Ansibleを使ってローカルマシンにdotfilesをデプロイするリポジトリです。

ツールごとにAnsibleロールとして分割管理しており、一括デプロイや個別デプロイが可能です。

## 管理対象ツール

| ツール | 説明 | デプロイ先 |
|--------|------|-----------|
| zsh | シェル設定 | `$HOME/` |
| starship | プロンプトテーマ | `$HOME/.config/starship/` |
| zellij | ターミナルマルチプレクサ | `$HOME/.config/zellij/` |
| yazi | ファイルマネージャー | `$HOME/.config/yazi/` |
| lazygit | Git TUI | `$HOME/.config/lazygit/` |
| claude | Claude Code | `$HOME/.claude/` |
| codex | OpenAI Codex CLI | `$HOME/.codex/` |
| gemini | Google Gemini CLI | `$HOME/.gemini/` |
| ghostty | ターミナルエミュレータ | `$HOME/Library/Application Support/com.mitchellh.ghostty/` |

## 前提条件

- [Ansible](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html) がインストールされていること

```bash
# macOS
brew install ansible

# pip
pip install ansible
```

## 使い方

### 全ツールのdotfilesを一括デプロイ

```bash
ansible-playbook playbooks/dotfiles.yml
```

### ドライラン（実際には変更せず、何が変更されるか確認）

```bash
ansible-playbook playbooks/dotfiles.yml --check
```

### 詳細な出力付きでデプロイ

```bash
ansible-playbook playbooks/dotfiles.yml -v
```

### 特定のツールのみデプロイ

`--tags` で対象を絞り込めます。

```bash
# zshのみ
ansible-playbook playbooks/dotfiles.yml --tags zsh

# 複数指定
ansible-playbook playbooks/dotfiles.yml --tags "zsh,starship"
```

### 変更内容の差分を確認

```bash
ansible-playbook playbooks/dotfiles.yml --check --diff
```

## ディレクトリ構成

```
.
├── ansible.cfg              # Ansible設定
├── inventory/localhost      # インベントリ（ローカル接続）
├── playbooks/
│   └── dotfiles.yml         # メインプレイブック
└── roles/
    └── <tool>/
        ├── files/           # dotfiles本体
        ├── tasks/main.yml   # デプロイタスク
        └── vars/main.yml    # デプロイ対象ファイルリスト
```

## dotfilesの追加方法

1. `roles/<tool>/files/` に設定ファイルを配置する
2. `roles/<tool>/vars/main.yml` の `<tool>_dotfiles` リストにファイル名を追加する

```yaml
# 例: roles/zsh/vars/main.yml
---
zsh_dotfiles:
  - .zshrc
```

3. ドライランで確認してからデプロイする

```bash
ansible-playbook playbooks/dotfiles.yml --tags zsh --check --diff
ansible-playbook playbooks/dotfiles.yml --tags zsh
```
