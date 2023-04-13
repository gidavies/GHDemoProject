# GHDemoProject

A script to create a new demo GitHub project using the gh CLI projects extension [https://github.com/github/gh-projects/](https://github.com/github/gh-projects/)

## Requirements

The script is designed for zsh and requires the following dependencies to be installed:
- GitHub CLI: brew install gh
- jq: brew install jq

## Usage

Add draft Issue titles and body text to a CSV file, such as the example issues.csv file in this repo. The script will create a new project with the specified name and add the issues to the project.

Example usage:
./createproj.sh -o my-org -p "My Project" -d issues.csv

where:
- -o is the GitHub organisation name
- -p is the name of the project to create
- -d is the CSV file containing the issue titles and body text