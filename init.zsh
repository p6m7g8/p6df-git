######################################################################
#<
#
# Function: p6df::modules::git::version()
#
#>
######################################################################
p6df::modules::git::version() { echo "0.0.1" }
######################################################################
#<
#
# Function: p6df::modules::git::deps()
#
#>
######################################################################
p6df::modules::git::deps()    {
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
  alias gs='p6_git_p6_status'
  alias gd='p6_git_p6_diff'
  alias gl='p6_git_p6_log'
  alias gco='p6_git_p6_checkout'
  alias gcb='p6_git_p6_branch_create'
  alias gb='p6_git_p6_branch'
  alias gp='p6_git_p6_pull'
  alias gP='p6_git_p6_push'
  alias gPt='p6_git_p6_push_tags'
  alias gS='p6_git_p6_sync'
  alias gm='p6_git_p6_merge'
  alias gc='p6_git_p6_commit'
  alias gcl='p6_git_p6_commit_last_edit'
  alias gf='p6_git_p6_fetch'
  alias gc='p6_git_p6_clone'
  alias gr='p6_git_p6_revert'
  alias ggf='p6_git_p6_grep_files'
  alias gg='p6_git_p6_grep'
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
    fi
}

######################################################################
#<
#
# Function: p6df::prompt::git::line()
#
#>
######################################################################
p6df::prompt::git::line() {

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
    if p6_git_inside_tree; then
	str="git:\t$g_org/$g_repo @ $g_shortsha ($g_branch) $g_status"
    fi

    p6_return_str "$str"
}