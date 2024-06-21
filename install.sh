#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

source scripts/utils.sh
source scripts/packages.sh
source scripts/mac-apps.sh

cleanup() {
	err "Last command failed"
	info "Finishing..."
}

wait_input() {
	read -p "Press enter to continue: "
}

main() {
	info "Installing ..."

	info "################################################################################"
	info "Homebrew Packages and Applications"
	info "################################################################################"
	wait_input

	install_packages
	success "Finished installing applications"

	info "################################################################################"
	info "Configuration"
	info "################################################################################"
	wait_input

	setup_osx
	success "Finished configuring MacOS defaults. NOTE: A restart is needed"

	stow_dotfiles
	success "Finished stowing dotfiles"

	info "System needs to restart. Restart?"

	select yn in "y" "n"; do
		case $yn in
		y)
			sudo shutdown -r now
			break
			;;
		n) exit ;;
		esac
	done
}

trap cleanup SIGINT SIGTERM ERR EXIT

main
