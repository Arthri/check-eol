# Test List
A list of steps for testing the workflow's features.

## Action successfully identifies non-compliant files

### Steps
1. Create the following files,
    - `lf.txt` - A file containing one LF.
    - `crlf.txt` - A file containing one CRLF.
    - `mixed.txt` - A file containing one LF and one CRLF.
1. Create or copy a binary file, such as an image or an archive.
1. Run the command `git config core.autocrlf false`
1. All other files created such as workflow files must be using the LF end-of-line sequence.
1. Commit and push to GitHub.

### Outputs
1. Workflow triggers.
1. Workflow fails.
1. The workflow should flag the following files,
    - `crlf.txt`.
    - `mixed.txt`.
1. The workflow should not flag the following files,
    - `lf.txt`.
    - The binary file.

## Action succeeds when non-compliant files are fixed

### Steps
1. Replace all non-LF end-of-line sequences with LF in flagged files.

### Outputs
1. Workflow triggers.
1. Workflow succeeds.
