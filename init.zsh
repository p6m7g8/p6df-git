p6df::modules::git::version() { echo "0.0.1" }
p6df::modules::git::deps()    {
	ModuleDeps=(
		sorin-ionescu/prezto:modules/git
		p6m7g8/p6git
	)
}

p6df::modules::git::external::brew() {

  brew install git
  brew install git-extras
  brew install git-lfs
  brew install git-quick-stats
  brew install git-secret

  brew install tig

  git lfs install
}

p6df::modules::git::home::symlink() {

    ln -fs $P6_DFZ_SRC_P6M7G8_DIR/p6df-git/share/.gitconfig .gitconfig
    ln -fs $P6_DFZ_SRC_P6M7G8_DIR/p6df-git/share/.gitignore_global .gitignore_global
}

p6df::modules::git::init() {

  p6df::modules::git::prompt
}

p6df::modules::git::prompt() {

  add-zsh-hook precmd p6df::modules::git::prompt_precmd
}

p6df::modules::git::prompt_precmd() {
  p6df::modules::git::vcs_info
}

p6df::modules::git::vcs_info() {

    if p6_git_inside_tree; then
	g_org=$(p6_git_org_org_get)
	g_repo=$(p6_git_org_repo_get)
	g_shortsha=$(p6_git_sha_short_get)
	g_branch=$(p6_git_branch_get)
	g_status=$(p6_git_dirty_get)
    fi
}

p6df::prompt::git::line() {

    if p6_git_inside_tree; then
	echo "git:\t$g_org/$g_repo @ $g_shortsha ($g_branch) $g_status"
    fi
}
