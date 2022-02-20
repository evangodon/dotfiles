package ui

import (
	"fmt"

	"github.com/charmbracelet/lipgloss"
)

var red = lipgloss.Color("#F02E6E")
var redLight = lipgloss.Color("#F48FB1")
var white = lipgloss.Color("#FFFFFF")
var purple = lipgloss.Color("#A37ACC")
var purpleLight = lipgloss.Color("#D4BFFF")

func renderTitle(color lipgloss.Color, title string) string {
	return lipgloss.NewStyle().
		Background(color).
		Foreground(white).
		Padding(0, 1).
		Render(title)
}

func withBorder(color lipgloss.Color, msg string) string {
	return lipgloss.NewStyle().
		Padding(0, 1).
		BorderStyle(lipgloss.RoundedBorder()).
		BorderForeground(color).
		Width(100).
		Render(msg)
}

func Error(step string, err error) {
	if err != nil {
		title := renderTitle(red, "Error")
		formatted := fmt.Sprintf("%s Step: %s\n\n%s", title, step, err)
		out := withBorder(redLight, formatted)

		fmt.Println(out)
	}
}

func Info(msg string) {
	title := renderTitle(purple, "ⓘ Info")
	out := withBorder(purpleLight, fmt.Sprintf("%s\n\n%s", title, msg))

	fmt.Println(out)
}
