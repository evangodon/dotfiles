package main

import (
	"flag"
	"fmt"
	"os"
	"runtime"
	"setup/pkg"
	"setup/ui"
)

func excecuteSteps(steps []pkg.Step) {
	for i, step := range steps {
		if skip := step.Skip(); skip {
			out := fmt.Sprintf("Skipping `%d. %s` step", i, step.Name)
			ui.Info(out)

			continue
		}

		ui.Info(fmt.Sprintf("Step %s", step.Name))

		err := step.Run()

		if err != nil {
			ui.Error(step.Name, err)
		}

		step.Cleanup()
	}
}

var homeDir, _ = os.UserHomeDir()

var cfg = pkg.Config{
	HomeDir: homeDir,
	OS:      runtime.GOOS,
}

// TODO: add install fish step
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
		pkg.GetKitty(cfg),
		pkg.InstallNix(cfg),
		pkg.InstallNixPackages(cfg),
	}

	excecuteSteps(steps)

}
