# Alpha Theme (Minimalist with colored text and simple separators)
setopt PROMPT_SUBST

# Color reset
RESET="%f%k"

# Simple separator
SEP="%F{white} ❯ %{$RESET%}"

# Time segment (no icon, just clean time)
time_segment() {
  echo "%F{magenta}%D{%H:%M:%S}%{$RESET%}"
}

# User segment (colored text based on privileges)
user_segment() {
  if [[ $EUID -eq 0 ]]; then
    echo "%F{red}%n@%m%{$RESET%}"
  else
    echo "%F{yellow}%n@%m%{$RESET%}"
  fi
}

# Path segment (colored text, no background)
path_segment() {
  echo "%F{cyan}%2~%{$RESET%}"
}

# Git segment with GitHub-style info (only shows if in git repo)
git_segment() {
  if git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
    local branch=$(git symbolic-ref --short HEAD 2>/dev/null || git rev-parse --short HEAD 2>/dev/null)
    local git_status=""
    local extras=""

    # Status indicators
    if [[ -n $(git status --porcelain 2>/dev/null) ]]; then
      git_status="%F{yellow}●%{$RESET%}"  # Dirty - yellow
    else
      git_status="%F{green}✓%{$RESET%}"   # Clean - green
    fi

    # Stashed changes
    if git rev-parse --verify refs/stash >/dev/null 2>&1; then
      extras+="%F{blue}⚑%{$RESET%}"
    fi

    # Ahead/behind with counts (GitHub style)
    local upstream=$(git rev-list --count --left-right @{upstream}...HEAD 2>/dev/null)
    if [[ $? -eq 0 ]]; then
      local behind=$(echo $upstream | cut -f1)
      local ahead=$(echo $upstream | cut -f2)

      if [[ $ahead -gt 0 ]] && [[ $behind -gt 0 ]]; then
        extras+="%F{yellow}⇕${ahead}↑${behind}↓%{$RESET%}"
      elif [[ $ahead -gt 0 ]]; then
        extras+="%F{green}↑${ahead}%{$RESET%}"
      elif [[ $behind -gt 0 ]]; then
        extras+="%F{red}↓${behind}%{$RESET%}"
      fi
    fi

    echo "${SEP}%F{blue}${branch}%{$RESET%} ${git_status}${extras}"
  fi
}

# Alpha segment (final status)
alpha_segment() {
  if [[ $? -eq 0 ]]; then
    echo "%F{green}⍺%{$RESET%}"
  else
    echo "%F{red}⍺%{$RESET%}"
  fi
}

# Smart prompt that only shows git section when in git repo
PROMPT='$(time_segment)${SEP}$(user_segment)${SEP}$(path_segment)$(git_segment)${SEP}$(alpha_segment) '

# Clean right prompt
RPROMPT=''

# Alternative separators (uncomment to try):
# SEP="%F{black} • %{$RESET%}"     # Bullet separator
# SEP="%F{white} / %{$RESET%}"     # Slash separator
# SEP="%F{black} → %{$RESET%}"     # Arrow separator
# SEP="%F{white} ▸ %{$RESET%}"     # Triangle separator

# Alternative: Even more minimal (no separators)
# PROMPT='$(time_segment) $(user_segment) $(path_segment)$(git_segment) $(alpha_segment) '