
#!/usr/bin/env bash

mas_apps=(
	"1474276998"  # HP Smart for Desktop
	"1003160018"  # Quip
)

install_masApps() {
	info "Installing App Store apps..."
	for app in "${mas_apps[@]}"; do
		mas install "$app"
	done
}
