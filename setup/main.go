package main

import (
	"flag"
	"fmt"
	"os/exec"
	"setup/pkg"
	"setup/ui"
)

func excecuteSteps(steps []pkg.Step) {
	for _, step := range steps {
		path, _ := exec.LookPath(step.Bin)

		if path != "" {
			out := fmt.Sprintf("%s already installed. Skipping.", step.Bin)
			ui.Info(out)

			continue
		}

		ui.Info(fmt.Sprintf("Installing %s", step.Bin))

		err := step.Run()

		if err != nil {
			ui.Error(step.Name, err)
		}

		step.Cleanup()
	}
}

func main() {
	uiTest := flag.Bool("test-ui", false, "Run UI tests")
	flag.Parse()

	if *uiTest {
		err := fmt.Errorf("test error")
		ui.Error("This is a test error", err)
		ui.Info("This is a test info")

		return
	}

	steps := []pkg.Step{
		pkg.GetKitty(),
		pkg.InstallNixAndPackes(),
	}

	excecuteSteps(steps)

}
