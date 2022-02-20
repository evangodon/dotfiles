package pkg

import (
	"os"
	"os/exec"
	"path"
	"strings"
)

var packages = []string{
	"bat",
	"bottom",
	"brave",
	"fd",
	"fish",
	"fzf",
	"lazygit",
	"ncdu",
	"neovim",
	"pgcli",
	// "vscode",
}

func InstallNixPackages(cfg Config) Step {

	nixEnv := path.Join(cfg.HomeDir, ".nix-profile/bin/nix-env")

	return Step{
		Name: "Install Nix packages",
		Bin:  "",
		Run: func() error {

			withNixPrefix := []string{"-iA"}

			for _, pkg := range packages {
				p := "nixpkgs" + "." + pkg
				withNixPrefix = append(withNixPrefix, p)
			}

			// Allow unfree packages
			os.Setenv("NIXPKGS_ALLOW_UNFREE", "1")

			cmd := exec.Command(nixEnv, withNixPrefix...)
			cmd.Stdout = os.Stdout
			cmd.Stderr = os.Stderr

			err := cmd.Run()

			if err != nil {
				return err
			}

			return nil
		},
		Skip: func() bool {
			out, _ := exec.Command(nixEnv, "-q").Output()
			installedPacakges := string(out)

			for _, pkg := range packages {
				if !strings.Contains(installedPacakges, pkg) {
					return false
				}
			}

			return true
		},
		Cleanup: func() {},
	}
}
