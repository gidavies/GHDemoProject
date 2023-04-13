#!/bin/zsh

# 
# Script to create a new demo GitHub project using gh CLI projects extension.
# https://github.com/github/gh-projects/
#
# Requirements:
# GitHub CLI installed: brew install gh
# jq installed: brew install jq
#
# Example usage:
# ./createproj.sh -o my-org -p "My Amazing Project" -d issues.csv
#

emulate -LR zsh

while getopts o:p:d: flag
do
    case "${flag}" in
        o) orgname=${OPTARG};;
        p) projectname=${OPTARG};;
        d) datafile=${OPTARG};;
    esac
done
echo "Org Name: $orgname"
echo "Project Name: $projectname"
echo "Data File: $datafile"

# Create a new project in the required org with the supplied name
gh projects create --org $orgname --title $projectname

# Need to get the number of the Project to use later
# Get all the projects
projects=$(gh projects list --org $orgname --format=json)
# Find the project number of the project we just created
projectnum=$(echo $projects | jq -r '.projects[] | select(.title == "'$projectname'") | .number')

echo "Project Name:$projectname Number: $projectnum"

username="@me"

# Read contents of CSV file extracting title and body into variables, ignoring header row
while IFS=, read -r title body
do
   if [[ $title != "title" ]]
   then
       echo "Title: $title"
       echo "Body: $body"
       gh projects item-create $projectnum --org $orgname --title "$title" --body "$body"
   fi
done < "$datafile"
# Note: the last row in the CSV file needs a new line character at the end or it will be ignored.
