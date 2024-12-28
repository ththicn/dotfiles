SHELL=/bin/zsh

.PHONY: brew
brew:
	sh brew/install.sh
	brew tap Homebrew/bundle
	brew bundle --file "brew/Brewfile"

.PHONY: starship_conf
starship_conf:
	if [ ! -d ${HOME}/.config ]; then mkdir -p ${HOME}/.config; fi
	ln -s -f ${PWD}/starship/starship.toml ${HOME}/.config/starship.toml

.PHONY: zsh-conf
zsh-conf:
	ln -sf ${PWD}/zsh/.zshrc ${HOME}/.zshrc
	ln -sf ${PWD}/zsh/.zprofile ${HOME}/.zprofile

.PHONY: ghostty-conf
ghostty-conf:
	if [ ! -d ${HOME}/.config/ghostty ]; then mkdir -p ${HOME}/.config/ghostty; fi
	ln -sf ${PWD}/ghostty/config ${HOME}/.config/ghostty/config

.PHONY: all
all: brew starship_conf zsh-conf
