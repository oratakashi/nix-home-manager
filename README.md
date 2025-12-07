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

## 🚨 First-Time User Notice

> **This configuration is currently set up for the username `oratakashi`.**
> 
> If you want to use this configuration, you **MUST** customize it for your own username **BEFORE** applying it to your system. Applying it as-is may cause issues or unexpected behavior.
>
> 👉 **Please read the [Adjusting Configuration for Your Username](#adjusting-configuration-for-your-username) section carefully before proceeding with the installation.**

---

## 📋 Table of Contents

- [First-Time User Notice](#-first-time-user-notice)
- [Features](#-features)
- [Prerequisites](#-prerequisites)
- [Supported Platforms](#-supported-platforms)
- [Installation](#-installation)
- [Project Structure](#-project-structure)
- [Configuration Overview](#-configuration-overview)
- [Usage](#-usage)
- [Customization](#-customization)
  - [Adjusting Configuration for Your Username](#adjusting-configuration-for-your-username)
  - [Adding New Packages](#adding-new-packages)
  - [Adding Shell Aliases](#adding-shell-aliases)
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
| macOS | Intel (x86_64) | `darwinConfigurations.<username>` (default: `oratakashi`) |
| macOS | Apple Silicon (aarch64) | `darwinConfigurations.<username>-arm64` (default: `oratakashi-arm64`) |
| Linux | x86_64 | `homeConfigurations.linux` |
| Windows | WSL (x86_64) | `homeConfigurations.windows` |

> **Note:** `<username>` should be replaced with your actual username after customization. See [Adjusting Configuration for Your Username](#adjusting-configuration-for-your-username).

---

## 🚀 Installation

> ⚠️ **IMPORTANT:** This configuration is set up for the user `oratakashi`. Before following the installation steps, you **MUST** customize it for your username. See the [Adjusting Configuration for Your Username](#adjusting-configuration-for-your-username) section in Customization for detailed instructions.

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

> **Note:** You can also fork this repository to your own GitHub account and clone from your fork if you want to maintain your own customizations.

### Step 3: Apply Configuration

> ⚠️ **Remember:** Before running these commands, make sure you've customized the configuration with your username. The commands below assume you've already updated the configuration files. Replace `<username>` with the username you configured in the customization step.

Choose the appropriate commands for your platform:

<details>
<summary><strong>🍎 macOS (Intel)</strong></summary>

1. **Build the initial configuration:**

   ```bash
   nix build ~/.config/home-manager#darwinConfigurations.<username>.system
   ```
   
   Example: If you customized with username "john", use:
   ```bash
   nix build ~/.config/home-manager#darwinConfigurations.john.system
   ```

2. **Apply the configuration:**

   ```bash
   cd ~/.config/home-manager
   ./result/sw/bin/darwin-rebuild switch --flake .#<username>
   ```
   
   Example: If your username is "john":
   ```bash
   ./result/sw/bin/darwin-rebuild switch --flake .#john
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
   nix build ~/.config/home-manager#darwinConfigurations.<username>-arm64.system
   ```
   
   Example: If you customized with username "john", use:
   ```bash
   nix build ~/.config/home-manager#darwinConfigurations.john-arm64.system
   ```

2. **Apply the configuration:**

   ```bash
   cd ~/.config/home-manager
   ./result/sw/bin/darwin-rebuild switch --flake .#<username>-arm64
   ```
   
   Example: If your username is "john":
   ```bash
   ./result/sw/bin/darwin-rebuild switch --flake .#john-arm64
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
├── README.md                 # Main documentation
└── CUSTOMIZATION_GUIDE.md    # Detailed guide for username customization
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

### Adjusting Configuration for Your Username

> ⚠️ **Important:** This configuration is currently set up for the user `oratakashi`. Before using it for your own system, you **must** customize it with your username.
>
> 📖 **For a detailed standalone guide, see [CUSTOMIZATION_GUIDE.md](CUSTOMIZATION_GUIDE.md)**

#### Quick Reference: Files to Modify

The following table shows all files that need to be updated and what to change:

| File | What to Change | Example |
|------|----------------|---------|
| `flake.nix` | Configuration names (`darwinConfigurations`), `users.oratakashi` section, username and homeDirectory fields | `"oratakashi"` → `"yourusername"` |
| `home-shared.nix` | `home.username`, PATH variables in Fish config | `"oratakashi"` → `"yourusername"` |
| `darwin-configuration.nix` | `system.primaryUser`, `users.users.oratakashi` section | `oratakashi` → `yourusername` |
| `home-darwin.nix` | `home.homeDirectory`, shell aliases for `home-update` | `/Users/oratakashi` → `/Users/yourusername` |
| `home-linux.nix` | `home.homeDirectory` | `/home/oratakashi` → `/home/yourusername` |
| `home-windows.nix` | `home.homeDirectory` | `/mnt/c/Users/oratakashi` → `/mnt/c/Users/yourusername` |

#### Step-by-Step Customization Guide

Follow these steps carefully to customize the configuration for your username:

##### 1. Update `flake.nix`

Replace all instances of `oratakashi` with your username:

**Darwin Configurations (macOS):**
```nix
# For Intel Macs - Change the configuration name and user settings
darwinConfigurations."yourusername" = darwin.lib.darwinSystem {
  system = "x86_64-darwin";
  modules = [
    ./darwin-configuration.nix
    home-manager.darwinModules.home-manager
    {
      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        users.yourusername = { pkgs, ... }: {  # Change here
          home = {
            username = "yourusername";        # Change here
            homeDirectory = "/Users/yourusername";  # Change here
            stateVersion = "23.11";
          };
          imports = [ 
            ./home-shared.nix
            ./home-darwin.nix 
          ];
        };
      };
    }
  ];
};

# For Apple Silicon Macs - Same changes as above
darwinConfigurations."yourusername-arm64" = darwin.lib.darwinSystem {
  system = "aarch64-darwin";
  # ... make the same username changes ...
};
```

##### 2. Update `home-shared.nix`

Change the username and PATH variables:

```nix
home.username = "yourusername";  # Change this line

# In programs.fish.interactiveShellInit, update the PATH:
set -l nix_paths \
  /Users/yourusername/.nix-profile/bin \           # Change here
  /etc/profiles/per-user/yourusername/bin          # Change here
```

Also update the session path if needed (note: adjust the path format for your platform):
```nix
home.sessionPath = [
  "/home/yourusername/Documents/Tools/kobweb/bin"  # For Linux/WSL
  # Or for macOS: "/Users/yourusername/Documents/Tools/kobweb/bin"
];
```

##### 3. Update `darwin-configuration.nix` (macOS only)

Change the primary user and user definition:

```nix
system.primaryUser = "yourusername";  # Change here

users.users.yourusername = {          # Change here
  name = "yourusername";              # Change here
  home = "/Users/yourusername";       # Change here
};
```

##### 4. Update `home-darwin.nix` (macOS only)

Change the home directory and shell aliases:

```nix
home.homeDirectory = "/Users/yourusername";  # Change here

# Update the home-update alias:
programs.zsh.shellAliases = {
  home-update = "sudo darwin-rebuild switch --flake ~/.config/home-manager#yourusername";  # Change here
};

programs.fish.shellAliases = {
  home-update = "sudo darwin-rebuild switch --flake ~/.config/home-manager#yourusername";  # Change here
};
```

##### 5. Update `home-linux.nix` (Linux only)

Change the home directory:

```nix
home.homeDirectory = "/home/yourusername";  # Change here
```

##### 6. Update `home-windows.nix` (WSL only)

Change the Windows home directory:

```nix
home.homeDirectory = "/mnt/c/Users/yourusername";  # Change here
```

#### Verification Steps

After making all the changes, verify your configuration before applying:

1. **Check syntax:**
   ```bash
   cd ~/.config/home-manager
   nix flake check
   ```

2. **Verify your changes:**
   ```bash
   # Search for any remaining references to the old username in Nix files only
   grep -r "oratakashi" ~/.config/home-manager --include="*.nix"
   ```
   This should return no results if all changes were made correctly (documentation files may still contain "oratakashi" as examples, which is fine).

3. **Show available configurations:**
   ```bash
   nix flake show ~/.config/home-manager
   ```
   You should see your new username in the configuration names.

#### Platform-Specific Application

Once you've customized all files, apply the configuration for your platform:

**macOS (Intel):**
```bash
nix build ~/.config/home-manager#darwinConfigurations.yourusername.system
./result/sw/bin/darwin-rebuild switch --flake ~/.config/home-manager#yourusername
```

**macOS (Apple Silicon):**
```bash
nix build ~/.config/home-manager#darwinConfigurations.yourusername-arm64.system
./result/sw/bin/darwin-rebuild switch --flake ~/.config/home-manager#yourusername-arm64
```

**Linux:**
```bash
nix run github:nix-community/home-manager -- switch --flake ~/.config/home-manager#linux
```

**Windows (WSL):**
```bash
nix run github:nix-community/home-manager -- switch --flake ~/.config/home-manager#windows
```

#### Troubleshooting Username Changes

<details>
<summary><strong>Configuration not found error</strong></summary>

If you get an error like `configuration 'yourusername' not found`, double-check that you:
- Changed the configuration name in `flake.nix`
- Used the correct name in the build/switch command
- Saved all files before running the command

</details>

<details>
<summary><strong>Permission denied on home directory</strong></summary>

Ensure the home directory path matches your actual system username. Check with:
```bash
echo $HOME
```

</details>

<details>
<summary><strong>Still seeing references to old username</strong></summary>

Use this command to find any remaining references in Nix configuration files:
```bash
grep -r "oratakashi" ~/.config/home-manager --include="*.nix"
```

Note: Documentation files (README.md, CUSTOMIZATION_GUIDE.md) may contain "oratakashi" as examples, which is expected and fine.

</details>

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
sudo darwin-rebuild switch --flake ~/.config/home-manager#<username>
```

Replace `<username>` with your actual username (or `<username>-arm64` for Apple Silicon).

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