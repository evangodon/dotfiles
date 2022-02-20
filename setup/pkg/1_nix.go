package pkg

import (
	"os"
	"os/exec"
	"path"
	"setup/util"
)

func InstallNix(cfg Config) Step {
	var installScript *os.File

	return Step{
		Name: "Install Nix",
		Bin:  "nix-env",
		Run: func() error {
			installScript, err := util.GetRemoteInstaller("https://nixos.org/nix/install")

			if err != nil {
				return err
			}

			cmd := exec.Command(installScript.Name(), "--no-daemon")
			cmd.Stdout = os.Stdout
			cmd.Stderr = os.Stderr

			err = cmd.Run()

			if err != nil {
				return err
			}

			return nil
		},
		Skip: func() bool {
			if cfg.OS == "linux" || cfg.OS == "darwin" {
				nixEnv := path.Join(cfg.HomeDir, ".nix-profile")
				if _, err := os.Stat(nixEnv); err == nil {
					return true
				}
			}

			return false
		},
		Cleanup: func() {
			if installScript != nil {
				os.Remove(installScript.Name())
			}
		},
	}
}
