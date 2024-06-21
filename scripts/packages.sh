#!/usr/bin/env bash

install_packages() {
	brew bundle --file Brewfile
}

post_install_packages() {
	info "Installing fzf bindings"
	# shellcheck disable=SC2046
	$(brew --prefix)/opt/fzf/install
}
