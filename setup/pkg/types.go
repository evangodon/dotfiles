package pkg

type Step struct {
	Name    string
	Bin     string
	Run     func() error
	Cleanup func()
}
