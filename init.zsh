# shellcheck shell=zsh

######################################################################
#<
#
# Function: p6df::modules::git::deps()
#
#>
######################################################################
p6df::modules::git::deps() {
  ModuleDeps=(
    sorin-ionescu/prezto:modules/git
    p6m7g8/p6git
  )
}

######################################################################
#<
#
# Function: p6df::modules::git::external::brew()
#
#>
######################################################################
p6df::modules::git::external::brew() {

  brew install git
  brew install git-extras
  brew install git-lfs
  brew install git-quick-stats
  brew install git-secret

  brew install tig

  brew install gitter-cli

  git lfs install
}

######################################################################
#<
#
# Function: p6df::modules::git::home::symlink()
#
#>
######################################################################
p6df::modules::git::home::symlink() {

  ln -fs $P6_DFZ_SRC_P6M7G8_DIR/p6df-git/share/.gitconfig .gitconfig
  ln -fs $P6_DFZ_SRC_P6M7G8_DIR/p6df-git/share/.gitignore_global .gitignore_global
}

######################################################################
#<
#
# Function: p6df::modules::git::init()
#
#>
######################################################################
p6df::modules::git::init() {

  p6df::modules::git::aliases::init
  p6df::modules::git::prompt
}

######################################################################
#<
#
# Function: p6df::modules::git::aliases::init()
#
#>
######################################################################
p6df::modules::git::aliases::init() {

  ## undo aliases from sorin-ionescu/prezto:modules/git
  ## keep the other stuff
  local a
  for a in $(alias | grep git | awk -F= '{ print $1 }'); do
    unalias $a
  done

  ## my aliases (finally!)
  alias g='p6_git_cmd'
  alias ga='p6_git_p6_add'
  alias gA='p6_git_p6_add_all'
  alias gb='p6_git_p6_branch'
  alias gC='p6_github_pr_submit'
  alias gCb='p6_github_pr_branch'
  alias gc='p6_git_p6_clone'
  alias gc='p6_git_p6_commit'
  alias gcb='p6_git_p6_branch_create'
  alias gcl='p6_git_p6_commit_last_edit'
  alias gco='p6_git_p6_checkout'
  alias gcom='p6_git_p6_checkout_master'
  alias gd='p6_git_p6_diff'
  alias gdm='p6_git_p6_diff_master'
  alias gdh='p6_git_p6_diff_head'
  alias gdp='p6_git_p6_diff_previous'
  alias gf='p6_git_p6_fetch'
  alias gg='p6_git_p6_grep'
  alias ggf='p6_git_p6_grep_files'
  alias gl='p6_git_p6_log'
  alias gm='p6_git_p6_merge'
  alias gp='p6_git_p6_pull'
  alias gP='p6_git_p6_push'
  alias gPt='p6_git_p6_push_tags'
  alias gR='p6_git_p6_restore'
  alias gra='p6_git_p6_rebase_abort'
  alias grc='p6_git_p6_rebase_continue'
  alias gs='p6_git_p6_status'
  alias gS='p6_git_p6_sync'
  alias gT='p6_git_p6_revert'
  alias grhh='p6_git_p6_reset_head_hard'
  alias gU='p6_git_p6_update'
}

######################################################################
#<
#
# Function: p6df::modules::git::prompt()
#
#>
######################################################################
p6df::modules::git::prompt() {

  add-zsh-hook precmd p6df::modules::git::prompt_precmd
}

######################################################################
#<
#
# Function: p6df::modules::git::prompt_precmd()
#
#>
######################################################################
p6df::modules::git::prompt_precmd() {
  p6df::modules::git::vcs_info
}

######################################################################
#<
#
# Function: p6df::modules::git::vcs_info()
#
#>
######################################################################
p6df::modules::git::vcs_info() {

  if p6_git_inside_tree; then
    g_org=$(p6_git_org_org_get)
    g_repo=$(p6_git_org_repo_get)
    g_shortsha=$(p6_git_sha_short_get)
    g_branch=$(p6_git_branch_get)
    g_status=$(p6_git_dirty_get)
  else
    unset g_org
    unset g_repo
    unset g_shortsha
    unset g_branch
    unset g_status
  fi
}

######################################################################
#<
#
# Function: p6df::modules::git::prompt::line()
#
#>
######################################################################
p6df::modules::git::prompt::line() {

  p6_git_prompt_info
}

######################################################################
#<
#
# Function: str str = p6_git_prompt_info()
#
#  Returns:
#	str - str
#
#>
######################################################################
p6_git_prompt_info() {

  local str
  if ! p6_string_blank "$g_org"; then
    str="git:\t  $g_org/$g_repo @ $g_shortsha ($g_branch) [$g_status]"
  fi

  p6_return_str "$str"
}
