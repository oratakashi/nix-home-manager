# User Customization Guide

> ⚠️ **Important:** This configuration is currently set up for the user `oratakashi`. Before using it for your own system, you **must** customize it with your username.

This guide provides detailed instructions on how to adjust this Nix Home Manager configuration for your own username.

## Quick Reference: Files to Modify

| File | What to Change | Example |
|------|----------------|---------|
| `flake.nix` | Darwin configuration names, `users.oratakashi`, username and homeDirectory | `"oratakashi"` → `"yourusername"` |
| `home-shared.nix` | `home.username`, PATH variables | `"oratakashi"` → `"yourusername"` |
| `darwin-configuration.nix` | `system.primaryUser`, `users.users` section | `oratakashi` → `yourusername` |
| `home-darwin.nix` | `home.homeDirectory`, shell aliases | `/Users/oratakashi` → `/Users/yourusername` |
| `home-linux.nix` | `home.homeDirectory` | `/home/oratakashi` → `/home/yourusername` |
| `home-windows.nix` | `home.homeDirectory` | `/mnt/c/Users/oratakashi` → `/mnt/c/Users/yourusername` |

## Step-by-Step Customization

### 1. Update `flake.nix`

Replace all instances of `oratakashi` with your username:

**For Darwin Configurations (macOS):**

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
```

### 2. Update `home-shared.nix`

Change the username:

```nix
home.username = "yourusername";  # Change this
```

Update PATH variables in the Fish shell configuration:

```nix
# In programs.fish.interactiveShellInit:
set -l nix_paths \
  /Users/yourusername/.nix-profile/bin \           # Change here
  /etc/profiles/per-user/yourusername/bin          # Change here
```

Update session path (if you use it):

```nix
home.sessionPath = [
  "/home/yourusername/Documents/Tools/kobweb/bin"  # Change here
];
```

### 3. Update `darwin-configuration.nix` (macOS only)

Change the primary user:

```nix
system.primaryUser = "yourusername";  # Change here
```

Update user definition:

```nix
users.users.yourusername = {          # Change here
  name = "yourusername";              # Change here
  home = "/Users/yourusername";       # Change here
};
```

### 4. Update `home-darwin.nix` (macOS only)

Change the home directory:

```nix
home.homeDirectory = "/Users/yourusername";  # Change here
```

Update shell aliases:

```nix
programs.zsh.shellAliases = {
  home-update = "sudo darwin-rebuild switch --flake ~/.config/home-manager#yourusername";  # Change here
};

programs.fish.shellAliases = {
  home-update = "sudo darwin-rebuild switch --flake ~/.config/home-manager#yourusername";  # Change here
};
```

### 5. Update `home-linux.nix` (Linux only)

Change the home directory:

```nix
home.homeDirectory = "/home/yourusername";  # Change here
```

### 6. Update `home-windows.nix` (WSL only)

Change the Windows home directory:

```nix
home.homeDirectory = "/mnt/c/Users/yourusername";  # Change here
```

## Verification

After making all changes, verify your configuration:

### 1. Check Syntax

```bash
cd ~/.config/home-manager
nix flake check
```

This command will check if your Nix configuration has any syntax errors.

### 2. Search for Old Username References

```bash
grep -r "oratakashi" ~/.config/home-manager --include="*.nix"
```

This should return **no results** if all changes were made correctly. If you still see results, review the files and update any remaining references.

**Note:** Documentation files (README.md, CUSTOMIZATION_GUIDE.md) may contain "oratakashi" as examples, which is expected and fine. The command above only searches `.nix` files.

### 3. Show Available Configurations

```bash
nix flake show ~/.config/home-manager
```

Expected output should show your new username:
```
├───darwinConfigurations
│   ├───yourusername: Darwin configuration
│   └───yourusername-arm64: Darwin configuration
└───homeConfigurations
    ├───darwin: Home Manager configuration
    ├───darwin-aarch64: Home Manager configuration
    ├───linux: Home Manager configuration
    └───windows: Home Manager configuration
```

## Applying the Configuration

Once verified, apply the configuration for your platform:

### macOS (Intel)

```bash
nix build ~/.config/home-manager#darwinConfigurations.yourusername.system
./result/sw/bin/darwin-rebuild switch --flake ~/.config/home-manager#yourusername
```

### macOS (Apple Silicon)

```bash
nix build ~/.config/home-manager#darwinConfigurations.yourusername-arm64.system
./result/sw/bin/darwin-rebuild switch --flake ~/.config/home-manager#yourusername-arm64
```

### Linux

```bash
nix run github:nix-community/home-manager -- switch --flake ~/.config/home-manager#linux
```

### Windows (WSL)

```bash
nix run github:nix-community/home-manager -- switch --flake ~/.config/home-manager#windows
```

## Troubleshooting

### Configuration not found

**Error:** `error: configuration 'yourusername' not found`

**Solution:** Verify that you:
- Changed the configuration name in `flake.nix` (e.g., `darwinConfigurations."yourusername"`)
- Used the correct configuration name in the build/switch command
- Saved all files before running the command

### Permission denied on home directory

**Error:** Permission errors related to home directory

**Solution:** Ensure the home directory path matches your actual system username:

```bash
echo $HOME
```

Compare this with what you set in the configuration files.

### Still seeing references to old username

**Solution:** Run a search to find remaining references in configuration files:

```bash
grep -r "oratakashi" ~/.config/home-manager --include="*.nix"
```

Review and update any remaining files that still reference the old username.

**Note:** Documentation files may contain "oratakashi" as examples, which is expected and fine.

### Nix flake check fails

**Solution:** Read the error message carefully. Common issues:
- Missing quotes around strings
- Incorrect syntax in Nix expressions
- Typos in attribute names

Review your changes in the affected file and fix any syntax errors.

---

## Need Help?

If you encounter issues not covered in this guide:

1. Check the [main README](README.md) for general troubleshooting tips
2. Run `nix flake check` to identify configuration errors
3. Use `nix flake show` to verify configuration structure
4. Review [Home Manager documentation](https://nix-community.github.io/home-manager/)
5. Check [nix-darwin documentation](https://github.com/LnL7/nix-darwin) for macOS-specific issues

---

**Happy Nix-ing! 🎉**
