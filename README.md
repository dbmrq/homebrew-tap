# Homebrew Tap

This is a [Homebrew](https://brew.sh) tap for my personal tools.

## Installation

```bash
brew tap dbmrq/tap
```

## Available formulae

### poppy-ai

Turn coding-agent session history into reviewed skills, memories, and rules.

```bash
brew install dbmrq/tap/poppy-ai
```

### demoji

A fast CLI tool to remove or replace emoji characters from text files.

```bash
brew install dbmrq/tap/demoji
```

## Updating

```bash
brew update
brew upgrade
```

## Maintenance

`poppy-ai` updates itself from PyPI every day (and on demand with
`gh workflow run update-poppy-ai.yml --repo dbmrq/homebrew-tap`); the other
formulae are updated by hand.
