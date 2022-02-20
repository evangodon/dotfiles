package pkg

import (
	"os"
	"os/exec"
	"setup/util"
)

var packages = []string{
	"fish",
	"fzf",
	"fd",
	"lazygit",
	"pgcli",
	"ncdu",
	"bottom",
}

func InstallNixAndPackes() Step {
	var installScript *os.File

	return Step{
		Name: "Install Nix and packages",
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

			// TODO: install packages here

			return nil
		},
		Cleanup: func() {
			if installScript != nil {
				os.Remove(installScript.Name())
			}
		},
	}
}
