package pkg

import (
	"os"
	"os/exec"
	"path"
	"setup/util"
)

func GetKitty(cfg Config) Step {
	var installScript *os.File

	return Step{
		Name: "Install Kitty Terminal",
		Bin:  "kitty",
		Run: func() error {
			installScript, err := util.GetRemoteInstaller("https://sw.kovidgoyal.net/kitty/installer.sh")

			if err != nil {
				return err
			}

			cmd := exec.Command(installScript.Name(), "launch=n")
			cmd.Stdout = os.Stdout
			cmd.Stderr = os.Stderr

			err = cmd.Run()

			if err != nil {
				return err
			}

			return nil
		},
		Skip: func() bool {
			if cfg.OS == "linux" {
				kittyApp := path.Join(cfg.HomeDir, ".local/kitty.app")
				if _, err := os.Stat(kittyApp); err == nil {
					return true
				}
			}

			if cfg.OS == "darwin" {
				kittyApp := path.Join(cfg.HomeDir, "Applications/kitty.app")
				if _, err := os.Stat(kittyApp); err == nil {
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
