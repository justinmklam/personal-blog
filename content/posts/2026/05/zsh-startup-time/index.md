---
title: Speeding up Zsh Startup Time
date: 2026-05-11T10:59:22-08:00
tagline:
image: placeholder.jpeg
image_source:
image_source_text:
tags:
draft: true
layout: single
type: blog
aliases:
---

A slow terminal is a death by a thousand cuts. Every new tab, every `tmux` split, every SSH session — you're waiting. I'd gotten used to the ~900ms startup time on my machine without really thinking about it, until it finally annoyed me enough to do something about it.

Turns out, a few targeted changes got it down to ~110ms. Here's what I did.

## Profiling First

Before changing anything, it helps to know where the time is actually going. Zsh has a built-in profiler called `zprof`:

```zsh
# Add to the very top of ~/.zshrc, before anything else
zmodload zsh/zprof

# Add to the very bottom
zprof
```

Open a new shell and you'll get a breakdown like this:

```
num  calls     time         self        name
------------------------------------------------------
 1)    1      224.26ms    71.11%      pyenv
 2)    4       35.03ms    11.11%      compaudit
 3)    1       32.07ms    10.17%      -antigen-load-source
 4)    2       53.20ms    16.87%      compinit
```

Three culprits: `pyenv`, `antigen`, and `compinit`. Together they accounted for nearly the entire 900ms.

## Fix 1: Lazy-load pyenv

`eval "$(pyenv init -)"` was the single biggest offender at ~224ms — 71% of total startup time. The fix is to defer initialization until `pyenv` is actually called, while still putting its shims on `PATH` immediately so scripts that rely on them don't break:

```zsh
# Before
export PATH="/Users/justinlam/.pyenv:$PATH"
eval "$(pyenv init -)"
pyenv virtualenvwrapper_lazy

# After
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/shims:$PYENV_ROOT/bin:$PATH"

pyenv() {
    unfunction pyenv
    eval "$(command pyenv init -)"
    pyenv virtualenvwrapper_lazy
    pyenv "$@"
}
```

The first time you run `pyenv`, it replaces the stub with the real thing. Every other shell that never calls `pyenv` gets its startup time back.

## Fix 2: Cache compinit

Zsh's completion system calls `compaudit` on every startup to check for insecure directories, which takes ~35ms and is mostly unnecessary on a personal machine where the completion dump hasn't changed. Skipping the audit if the dump is less than 24 hours old is an easy win:

```zsh
autoload -Uz compinit
if [[ -n ~/.zcompdump(#qN.mh+24) ]]; then
    compinit       # dump is stale, rebuild it
else
    compinit -C    # dump is fresh, skip the audit
fi
```

## Fix 3: Hardcode Homebrew's PATH

`eval "$(brew shellenv)"` spawns a subprocess every login shell, costing ~90ms. Since the output of that command never changes on your own machine, you can just hardcode it:

```zsh
# Before
eval "$(/opt/homebrew/bin/brew shellenv)"

# After
export HOMEBREW_PREFIX="/opt/homebrew"
export HOMEBREW_CELLAR="/opt/homebrew/Cellar"
export HOMEBREW_REPOSITORY="/opt/homebrew"
export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:$PATH"
export MANPATH="/opt/homebrew/share/man${MANPATH+:$MANPATH}:"
export INFOPATH="/opt/homebrew/share/info:${INFOPATH:-}"
```

The downside is that if Homebrew's prefix ever changes (e.g. moving between Intel and Apple Silicon), you'd need to update this manually. In practice, that almost never happens.

## Fix 4: Replace Antigen with Direct Plugin Sourcing

Antigen is convenient for managing plugins, but it carries real overhead: it calls `compinit` multiple times, runs its own bookkeeping, and prints noisy "already installed" messages to stderr. Since the plugins themselves are already cloned to disk in `~/.antigen/bundles`, antigen's job at runtime is mostly ceremony.

Replacing it with direct `source` calls:

```zsh
# Before
source /opt/homebrew/share/antigen/antigen.zsh
source ~/.antigenrc  # contained 8 antigen bundle calls + antigen apply

# After
ZPLUGINS=~/.antigen/bundles
source $ZPLUGINS/robbyrussell/oh-my-zsh/plugins/git/git.plugin.zsh
source $ZPLUGINS/robbyrussell/oh-my-zsh/plugins/pip/pip.plugin.zsh
source $ZPLUGINS/robbyrussell/oh-my-zsh/plugins/command-not-found/command-not-found.plugin.zsh
source $ZPLUGINS/zsh-users/zsh-history-substring-search/zsh-history-substring-search.plugin.zsh
source $ZPLUGINS/zsh-users/zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh
source $ZPLUGINS/zsh-users/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh
```

Note that the `fzf` and `unixorn/fzf-zsh-plugin` bundles were dropped entirely — they were redundant with `~/.fzf.zsh` which was already being sourced separately.

The tradeoff is that updating plugins now requires manually pulling the repos in `~/.antigen/bundles` rather than running `antigen update`. A small script handles this:

```zsh
for d in ~/.antigen/bundles/**/.git(N/); do
    echo "Updating ${d:h:t}..."
    git -C ${d:h} pull --ff-only
done
```

## Results

| State | Startup time |
|---|---|
| Baseline | ~900ms |
| After pyenv lazy-load | ~670ms |
| After compinit cache + brew hardcode | ~150ms |
| After removing antigen | ~110ms |

An 8× improvement without removing a single feature. The session still has git aliases, autosuggestions, syntax highlighting, and history substring search — everything just loads faster.

The main takeaway is to profile before optimizing. I'd assumed antigen was the main culprit, but `pyenv init` alone was responsible for 71% of the startup time. Without `zprof`, it would have been easy to waste time on the wrong things.
