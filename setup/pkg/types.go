package pkg

type Step struct {
	Name    string
	Bin     string
	Run     func() error
	Cleanup func()
	Skip    func() bool
}

type Config struct {
	HomeDir string
	OS      string
}
