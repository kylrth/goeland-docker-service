package main

import (
	_ "embed" //needed for embedding files
	"fmt"
	"math/rand"
	"os"
	"strconv"
	"time"

	"github.com/slurdge/goeland/cmd"
	"github.com/slurdge/goeland/version"
)

//go:embed CHANGELOG.md
var changeLog string

func main() {
	intervalStr := os.Getenv("INTERVAL")
	interval, err := strconv.Atoi(intervalStr)
	if err != nil {
		fmt.Fprintf(os.Stderr, "get interval: %v\n", err)
		os.Exit(1)
	}

	execute() // Run immediately the first time.
	c := time.Tick(time.Duration(interval) * time.Second)
	for _ = range c {
		execute()
	}
}

func execute() {
	fmt.Fprint(os.Stderr, "executing goeland run\n")
	version.ExtractVersionFromChangelog(changeLog)
	rand.Seed(time.Now().UnixNano())
	cmd.Execute()
	fmt.Fprint(os.Stderr, "finished executing goeland run\n")
}
