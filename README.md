# check-eol
A reusable workflow and composite action for linting line endings.

## Installation

## Reusable Workflow
Add a new workflow under `.github/workflows/` with the following contents,
```yml
name: Check Line Endings

on:
  push:
    branches: [ master, dev ]
  pull_request:
    branches: [ master, dev ]

jobs:
  check-eol:
    uses: Arthri/check-eol/.github/workflows/i.yml@v2
    permissions:
      contents: read
```

## Composite Action
Add the following step to the desired jobs.
```yml
jobs:
  job:
    - name: Check Line Endings
      uses: Arthri/check-eol-composite@v2
```

## Usage

### Default Line Ending
The workflow enforces `LF` for all files in the index. The workflow and action operate agnostic of `autocrlf=true`, as the config option modifies files in the working tree rather than the index.

The following example configures the reusable workflow to enforce `CRLF` instead.
```yml
jobs:
  check-eol:
    uses: Arthri/check-eol/.github/workflows/i.yml@v2
    with:
      default-eol: crlf
```

And the following demonstrates the equivalent for composite actions.
```yml
jobs:
  job:
    - name: Check Line Endings
      uses: Arthri/check-eol-composite@v2
      with:
        default-eol: crlf
```

### Checkout Reference
The reusable workflow, by default, checkouts the ref of the branch or tag that triggered the workflow. An example is provided below demonstrating how to change the checkout `dev` instead. For more information about the default ref, see `github.ref` in [Accessing contextual information about workflow runs](https://docs.github.com/en/actions/writing-workflows/choosing-what-your-workflow-does/accessing-contextual-information-about-workflow-runs#github-context).
```yml
jobs:
  check-eol:
    uses: Arthri/check-eol/.github/workflows/i.yml@v2
    with:
      ref: dev
```

### Events Supported
The reusable workflow is not limited to pushes and pull requests, other types of events such as releases are also supported.
