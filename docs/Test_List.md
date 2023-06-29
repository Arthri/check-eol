# Test List
A list of steps for testing the workflow's features.

## Action successfully identifies non-compliant files

### Steps
1. Create the following files,
    - `lf-lf.txt` - A file containing one LF.
    - `lf-crlf.txt` - A file containing one CRLF.
    - `lf-mixed.txt` - A file containing one LF and one CRLF.
    - `crlf-lf.txt` - A file containing one LF.
    - `crlf-crlf.txt` - A file containing one CRLF.
    - `crlf-mixed.txt` - A file containing one LF and one CRLF.
1. Create or copy a binary file, such as an image or an archive.
1. Ensure that `autocrlf` and other git mechanisms aren't interfering with the end-of-line sequences.
1. Push to GitHub.

### Outputs
1. Workflow triggers.
1. Workflow fails.
1. The workflow should flag the following files,
    - `lf-crlf.txt`.
    - `lf-mixed.txt`.
    - `crlf-lf.txt`.
    - `crlf-mixed.txt`.
1. The workflow should not flag the following files,
    - `lf-lf.txt`.
    - `crlf-crlf.txt`.

## Action respects `.gitattributes`

### Steps
1. Create a file named `.gitattributes` with the following contents,
    ```ini
    lf-lf.txt text eol=lf
    lf-crlf.txt text eol=crlf
    crlf-lf.txt text eol=lf
    crlf-crlf.txt text eol=crlf
    ```
1. Remove the files ending in `mixed`.
1. Push to GitHub.

### Outputs
1. Workflow triggers.
1. Workflow succeeds.

## Action succeeds when non-compliant files are fixed

### Steps
1. Remove the `.gitattributes` file.
1. Restore the files ending in `mixed`.
1. Replace all non-LF end-of-line sequences with LF in files starting with `lf-*`.
1. Replace all non-CRLF end-of-line sequences with CRLF in files starting with `crlf-*`.

### Outputs
1. Workflow triggers.
1. Workflow succeeds.
