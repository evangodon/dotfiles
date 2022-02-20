package util

import (
	"io"
	"io/ioutil"
	"net/http"
	"os"
)

func GetRemoteInstaller(path string) (*os.File, error) {
	resp, err := http.Get(path)

	if err != nil {
		return nil, err
	}

	defer resp.Body.Close()

	body, err := io.ReadAll(resp.Body)

	if err != nil {
		return nil, err
	}

	file, err := ioutil.TempFile("", "kitty-installer-")
	if err != nil {
		return nil, err
	}

	_, err = file.Write(body)

	if err != nil {
		return nil, err
	}

	err = os.Chmod(file.Name(), 0755)

	if err != nil {
		return nil, err
	}

	file.Close()

	return file, err
}
