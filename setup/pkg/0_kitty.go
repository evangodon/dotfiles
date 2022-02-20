package pkg

import (
	"os"
	"os/exec"
	"setup/util"
)

func GetKitty() Step {

	var installScript *os.File

	return Step{
		Name: "Install Kitty Terminal",
		Bin:  "kitty",
		Run: func() error {
			installScript, err := util.GetRemoteInstaller("https://sw.kovidgoyal.net/kitty/installer.sh")

			if err != nil {
				return err
			}

			cmd := exec.Command(installScript.Name())
			cmd.Stdout = os.Stdout
			cmd.Stderr = os.Stderr

			err = cmd.Run()

			if err != nil {
				return err
			}

			return nil
		},
		Cleanup: func() {
			if installScript != nil {
				os.Remove(installScript.Name())
			}
		},
	}
}
