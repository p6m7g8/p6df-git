p6df::modules::git::version() { echo "0.0.1" }
p6df::modules::git::deps()    { 
	ModuleDeps=(
		sorin-ionescu/prezto:modules/git
		p6m7g8/p6git
	)
}

p6df::modules::git::external::brew() { 

  brew install git --without-completions
  brew install git-extras
  brew install git-lfs
  brew install git-quick-stats
  brew install git-secret

  git lfs install
}

p6df::modules::git::init() {
}

p6df::modules::git::init
