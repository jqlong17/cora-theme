#!/bin/bash

# Cora Theme - Universal Installer
# One-command installation for macOS and Linux
# Usage: curl -fsSL https://raw.githubusercontent.com/jqlong17/cora-theme/main/install.sh | bash

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Configuration
REPO_URL="https://github.com/jqlong17/cora-theme"
RAW_URL="https://raw.githubusercontent.com/jqlong17/cora-theme/main"
INSTALL_DIR="$HOME/.local/share/cora-theme"

# Functions
print_success() {
    echo -e "${GREEN}✓${NC} $1"
}

print_error() {
    echo -e "${RED}✗${NC} $1"
}

print_info() {
    echo -e "${BLUE}ℹ${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}⚠${NC} $1"
}

# Detect OS
detect_os() {
    if [[ "$OSTYPE" == "darwin"* ]]; then
        OS="macos"
        GHOSTTY_CONFIG_DIR="$HOME/Library/Application Support/com.mitchellh.ghostty"
    elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
        OS="linux"
        GHOSTTY_CONFIG_DIR="$HOME/.config/ghostty"
    else
        print_error "Unsupported operating system: $OSTYPE"
        print_info "Currently supported: macOS and Linux"
        exit 1
    fi
    print_success "Detected OS: $OS"
}

# Check dependencies
check_dependencies() {
    print_info "Checking dependencies..."
    
    local missing_deps=()
    
    # Check for curl or wget
    if ! command -v curl &> /dev/null && ! command -v wget &> /dev/null; then
        missing_deps+=("curl or wget")
    fi
    
    # Check for git
    if ! command -v git &> /dev/null; then
        missing_deps+=("git")
    fi
    
    if [ ${#missing_deps[@]} -ne 0 ]; then
        print_error "Missing required dependencies: ${missing_deps[*]}"
        print_info "Please install them first:"
        
        if [[ "$OS" == "macos" ]]; then
            echo "  brew install curl git"
        else
            echo "  sudo apt-get install curl git    # Debian/Ubuntu"
            echo "  sudo yum install curl git        # RHEL/CentOS"
            echo "  sudo pacman -S curl git          # Arch"
        fi
        exit 1
    fi
    
    print_success "All dependencies satisfied"
}

# Download file
download_file() {
    local url="$1"
    local output="$2"
    
    if command -v curl &> /dev/null; then
        curl -fsSL "$url" -o "$output"
    else
        wget -q "$url" -O "$output"
    fi
}

# Create backup
create_backup() {
    local file="$1"
    if [[ -f "$file" ]]; then
        local backup_name="${file}.backup.$(date +%Y%m%d_%H%M%S)"
        cp "$file" "$backup_name"
        print_warning "Backed up: $file → $backup_name"
    fi
}

# Install Ghostty configuration
install_ghostty_config() {
    print_info "Installing Ghostty configuration..."
    
    mkdir -p "$GHOSTTY_CONFIG_DIR"
    
    # Backup existing config
    create_backup "$GHOSTTY_CONFIG_DIR/config"
    
    # Download config
    download_file "$RAW_URL/configs/ghostty.config" "$GHOSTTY_CONFIG_DIR/config"
    
    print_success "Ghostty configuration installed"
}

# Install OpenCode configuration
install_opencode_config() {
    print_info "Installing OpenCode configuration..."
    
    local opencode_dir="$HOME/.config/opencode"
    mkdir -p "$opencode_dir/themes"
    
    # Backup existing configs
    create_backup "$opencode_dir/tui.json"
    if [[ -d "$opencode_dir/themes" ]]; then
        local backup_dir="$opencode_dir/themes.backup.$(date +%Y%m%d_%H%M%S)"
        cp -r "$opencode_dir/themes" "$backup_dir"
        print_warning "Backed up themes directory"
    fi
    
    # Download configs
    download_file "$RAW_URL/configs/tui.json" "$opencode_dir/tui.json"
    download_file "$RAW_URL/configs/catppuccin-mocha.json" "$opencode_dir/themes/catppuccin-mocha.json"
    
    print_success "OpenCode configuration installed"
}

# Install fonts
install_fonts() {
    print_info "Installing fonts..."
    
    if [[ "$OS" == "macos" ]]; then
        # Check if Maple Mono is installed
        if ! fc-list | grep -qi "maple"; then
            print_warning "Maple Mono font not detected"
            print_info "Installing via Homebrew..."
            
            if command -v brew &> /dev/null; then
                brew tap subframe7536/maple-font
                brew install --cask maple-mono
                print_success "Maple Mono installed via Homebrew"
            else
                print_warning "Homebrew not found"
                print_info "Please manually install Maple Mono from:"
                print_info "https://github.com/subframe7536/maple-font/releases"
            fi
        else
            print_success "Maple Mono font already installed"
        fi
    else
        # Linux - download and install manually
        print_info "Downloading Maple Mono for Linux..."
        
        local font_dir="$HOME/.local/share/fonts"
        mkdir -p "$font_dir"
        
        # Download latest release
        local temp_dir=$(mktemp -d)
        cd "$temp_dir"
        
        curl -fsSL "https://github.com/subframe7536/maple-font/releases/latest/download/MapleMono-NF-CN.zip" -o maple-mono.zip
        unzip -q maple-mono.zip -d maple-mono
        cp maple-mono/*.ttf "$font_dir/" 2>/dev/null || cp maple-mono/*/*.ttf "$font_dir/"
        
        # Refresh font cache
        fc-cache -f
        
        cd - > /dev/null
        rm -rf "$temp_dir"
        
        print_success "Maple Mono installed to $font_dir"
    fi
}

# Verify installation
verify_installation() {
    print_info "Verifying installation..."
    
    local all_good=true
    
    if [[ -f "$GHOSTTY_CONFIG_DIR/config" ]]; then
        print_success "Ghostty config: OK"
    else
        print_error "Ghostty config: Missing"
        all_good=false
    fi
    
    if [[ -f "$HOME/.config/opencode/tui.json" ]]; then
        print_success "OpenCode TUI config: OK"
    else
        print_error "OpenCode TUI config: Missing"
        all_good=false
    fi
    
    if [[ -f "$HOME/.config/opencode/themes/catppuccin-mocha.json" ]]; then
        print_success "OpenCode theme: OK"
    else
        print_error "OpenCode theme: Missing"
        all_good=false
    fi
    
    if [[ "$all_good" == true ]]; then
        return 0
    else
        return 1
    fi
}

# Print next steps
print_next_steps() {
    echo ""
    echo -e "${GREEN}🎉 Cora Theme installed successfully!${NC}"
    echo ""
    echo -e "${BLUE}📋 Next steps:${NC}"
    
    if [[ "$OS" == "macos" ]]; then
        echo "  1. Restart Ghostty (or press Cmd+Shift+, to reload config)"
    else
        echo "  1. Restart Ghostty (or press Ctrl+Shift+, to reload config)"
    fi
    
    echo "  2. Launch OpenCode: opencode"
    echo "  3. Enjoy your aesthetic terminal setup!"
    echo ""
    echo -e "${BLUE}✨ Features enabled:${NC}"
    echo "  • Catppuccin Mocha color scheme"
    echo "  • Frosted glass transparency effect"
    echo "  • Maple Mono programming font"
    echo "  • Unified theme across Ghostty and OpenCode"
    echo ""
    echo -e "${BLUE}📖 Documentation:${NC} https://github.com/jqlong17/cora-theme"
    echo ""
}

# Main function
main() {
    echo -e "${BLUE}🎨 Installing Cora Theme...${NC}"
    echo ""
    
    detect_os
    check_dependencies
    install_ghostty_config
    install_opencode_config
    install_fonts
    
    if verify_installation; then
        print_next_steps
    else
        print_error "Installation verification failed"
        exit 1
    fi
}

# Run main function
main
