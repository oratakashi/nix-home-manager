<div align="center">

# 🏠 Nix Home Manager Configuration

[![Nix](https://img.shields.io/badge/Nix-5277C3?style=for-the-badge&logo=nixos&logoColor=white)](https://nixos.org/)
[![Home Manager](https://img.shields.io/badge/Home%20Manager-41BDF5?style=for-the-badge&logo=nixos&logoColor=white)](https://github.com/nix-community/home-manager)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg?style=for-the-badge)](https://opensource.org/licenses/MIT)

**A cross-platform, declarative, and reproducible home environment configuration using Nix Flakes and Home Manager.**

[Features](#-features) •
[Prerequisites](#-prerequisites) •
[Installation](#-installation) •
[Usage](#-usage) •
[Customization](#-customization) •
[Troubleshooting](#-troubleshooting)

</div>

---

## 📋 Table of Contents

- [Features](#-features)
- [Prerequisites](#-prerequisites)
- [Supported Platforms](#-supported-platforms)
- [Installation](#-installation)
- [Project Structure](#-project-structure)
- [Configuration Overview](#-configuration-overview)
- [Usage](#-usage)
- [Customization](#-customization)
- [Troubleshooting](#-troubleshooting)
- [Contributing](#-contributing)
- [License](#-license)

---

## ✨ Features

- 🔄 **Cross-Platform Support** - Works seamlessly on macOS (Intel & Apple Silicon), Linux, and Windows (WSL)
- 📦 **Declarative Configuration** - Define your entire development environment in code
- 🔁 **Reproducible Builds** - Same configuration yields identical results across machines
- ⚡ **Nix Flakes** - Modern Nix with lockfile support for reproducibility
- 🍎 **nix-darwin Integration** - Full macOS system configuration support
- 🍺 **Homebrew Management** - Automated Homebrew package management on macOS
- 🐚 **Shell Configuration** - Pre-configured Fish and Zsh with aliases and plugins
- 🛠️ **Development Tools** - Ready-to-use development environment with common tools

---

## 📋 Prerequisites

Before you begin, ensure you have the following:

- A supported operating system (macOS, Linux, or Windows with WSL)
- Administrator/sudo access on your machine
- Internet connection for downloading packages

---

## 💻 Supported Platforms

| Platform | Architecture | Configuration |
|----------|--------------|---------------|
| macOS | Intel (x86_64) | `darwinConfigurations.oratakashi` |
| macOS | Apple Silicon (aarch64) | `darwinConfigurations.oratakashi-arm64` |
| Linux | x86_64 | `homeConfigurations.linux` |
| Windows | WSL (x86_64) | `homeConfigurations.windows` |

---

## 🚀 Installation

### Step 1: Install Nix Package Manager

Install the Nix package manager using the Determinate Systems installer:

```bash
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
```

> **Note:** After installation, restart your terminal or source your shell configuration.

### Step 2: Clone This Repository

Clone this repository to `~/.config/home-manager`:

**Using SSH (recommended):**

```bash
nix-shell -p git --command "git clone git@github.com:oratakashi/nix-home-manager.git $HOME/.config/home-manager"
```

**Using HTTPS:**

```bash
nix-shell -p git --command "git clone https://github.com/oratakashi/nix-home-manager.git $HOME/.config/home-manager"
```

### Step 3: Apply Configuration

Choose the appropriate commands for your platform:

<details>
<summary><strong>🍎 macOS (Intel)</strong></summary>

1. **Build the initial configuration:**

   ```bash
   nix build ~/.config/home-manager#darwinConfigurations.oratakashi.system
   ```

2. **Apply the configuration:**

   ```bash
   cd ~/.config/home-manager
   ./result/sw/bin/darwin-rebuild switch --flake .#oratakashi
   ```

3. **For subsequent updates, simply run:**

   ```bash
   home-update
   ```

</details>

<details>
<summary><strong>🍎 macOS (Apple Silicon / ARM64)</strong></summary>

1. **Build the initial configuration:**

   ```bash
   nix build ~/.config/home-manager#darwinConfigurations.oratakashi-arm64.system
   ```

2. **Apply the configuration:**

   ```bash
   cd ~/.config/home-manager
   ./result/sw/bin/darwin-rebuild switch --flake .#oratakashi-arm64
   ```

3. **For subsequent updates, simply run:**

   ```bash
   home-update
   ```

</details>

<details>
<summary><strong>🐧 Linux</strong></summary>

1. **Apply the Home Manager configuration:**

   ```bash
   nix run github:nix-community/home-manager -- switch --flake ~/.config/home-manager#linux
   ```

2. **(Optional) Change default shell to Fish or Zsh:**

   ```bash
   # For Fish (recommended - primary shell in this config)
   sudo usermod -s $(which fish) $(whoami)
   
   # For Zsh (alternative)
   sudo usermod -s $(which zsh) $(whoami)
   ```

3. **For subsequent updates, simply run:**

   ```bash
   home-update
   ```

</details>

<details>
<summary><strong>🪟 Windows (WSL)</strong></summary>

1. **Apply the Home Manager configuration:**

   ```bash
   nix run github:nix-community/home-manager -- switch --flake ~/.config/home-manager#windows
   ```

2. **For subsequent updates, simply run:**

   ```bash
   home-update
   ```

</details>

---

## 📁 Project Structure

```
~/.config/home-manager/
├── flake.nix                 # Main flake configuration (entry point)
├── flake.lock                # Locked dependencies for reproducibility
├── darwin-configuration.nix  # macOS-specific system configuration
├── home-shared.nix           # Shared configuration across all platforms
├── home-darwin.nix           # macOS-specific home configuration
├── home-linux.nix            # Linux-specific home configuration
├── home-windows.nix          # Windows/WSL-specific home configuration
├── emulator-fix-hackintosh/  # Android emulator fix for Hackintosh
│   └── emulatorfix.plist
└── README.md                 # This documentation
```

---

## ⚙️ Configuration Overview

### Shared Packages (`home-shared.nix`)

The following packages are installed across all platforms:

| Category | Packages |
|----------|----------|
| **Terminal Tools** | git, eza, fastfetch, btop, htop |
| **Development** | scrcpy, PHP 8.4, Composer |
| **Build Tools** | cmake, ninja, clang, Python 3.11, Node.js 20, Yarn |
| **Editors** | Neovim, Helix |
| **Shell** | Fish (with Starship prompt), Zsh (with Oh My Zsh) |

### macOS-Specific (`home-darwin.nix` & `darwin-configuration.nix`)

| Category | Packages/Settings |
|----------|-------------------|
| **Homebrew Casks** | Google Chrome, Firefox, Arc, 1Password, Warp Terminal, TeamViewer |
| **Homebrew Brews** | cloudflared, jmeter |
| **System Settings** | Auto-hide dock, Finder show extensions |
| **Development** | CocoaPods, wget, kdoctor, Kobweb CLI |

### Shell Aliases

The configuration includes helpful aliases:

| Alias | Command | Description |
|-------|---------|-------------|
| `home-update` | Platform-specific | Update Home Manager configuration |
| `home-edit` | `code ~/.config/home-manager` | Open config in VS Code |
| `ls` | `eza --icons` | Enhanced directory listing |
| `cat` | `bat` | Syntax-highlighted file viewer |
| `neofetch` | `fastfetch` | System information display |
| `nix-clear` | `nix-collect-garbage -d` | Clean up Nix store |

---

## 📖 Usage

### Daily Commands

| Command | Description |
|---------|-------------|
| `home-update` | Apply latest configuration changes |
| `home-edit` | Open configuration in VS Code |
| `nix-clear` | Clean up unused Nix packages |

### Updating Flake Inputs

To update all flake inputs to their latest versions:

```bash
cd ~/.config/home-manager
nix flake update
home-update
```

---

## 🎨 Customization

### Adding New Packages

1. **For all platforms:** Edit `home-shared.nix` and add packages to `home.packages`:

   ```nix
   home.packages = with pkgs; [
     # Add your packages here
     ripgrep
     fd
   ];
   ```

2. **For platform-specific packages:** Edit the corresponding file:
   - macOS: `home-darwin.nix`
   - Linux: `home-linux.nix`
   - Windows/WSL: `home-windows.nix`

### Adding Shell Aliases

Edit the `shellAliases` section in `home-shared.nix`:

```nix
programs.fish.shellAliases = {
  # Add your aliases here
  myalias = "my-command --with-flags";
};
```

### Changing Username

To use this configuration with a different username, update the following files:

1. `flake.nix` - Change `oratakashi` to your username
2. `home-shared.nix` - Update `home.username`
3. `darwin-configuration.nix` - Update `users.users` section
4. Platform-specific files - Update `home.homeDirectory` paths

---

## 🔧 Troubleshooting

### Common Issues

<details>
<summary><strong>Nix command not found after installation</strong></summary>

Restart your terminal or run:

```bash
source /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
```

</details>

<details>
<summary><strong>Flakes not enabled</strong></summary>

Ensure flakes are enabled in your Nix configuration. The installer from Determinate Systems enables this by default.

</details>

<details>
<summary><strong>Permission denied during darwin-rebuild</strong></summary>

Some darwin-rebuild operations may require elevated permissions. Try running with sudo:

```bash
sudo darwin-rebuild switch --flake ~/.config/home-manager#oratakashi
```

> **Note:** The initial installation typically doesn't require sudo, but subsequent system-level changes might.

</details>

<details>
<summary><strong>Android Emulator not working on Hackintosh</strong></summary>

Apply the emulator fix:

```bash
cp ~/.config/home-manager/emulator-fix-hackintosh/emulatorfix.plist ~/Library/LaunchAgents/
launchctl load ~/Library/LaunchAgents/emulatorfix.plist
```

</details>

### Useful Debug Commands

```bash
# Check Nix version
nix --version

# Verify flake configuration
nix flake check ~/.config/home-manager

# Show flake outputs
nix flake show ~/.config/home-manager

# Dry-run to see what would change
home-manager switch --flake ~/.config/home-manager#linux --dry-run
```

---

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

---

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

<div align="center">

**Made with ❤️ using [Nix](https://nixos.org/) and [Home Manager](https://github.com/nix-community/home-manager)**

</div>