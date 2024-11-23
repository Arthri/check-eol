# check-eol
A reusable workflow and composite action for linting end-of-line sequences.

## Installation

## Reusable Workflow
Add a new workflow under `.github/workflows/` with the following contents,
```yml
name: Check End-of-Line Sequences
run-name: Check End-of-Line Sequences

on:
  push:
    branches: [ master, dev ]
  pull_request:
    branches: [ master, dev ]

jobs:
  check-eol:
    uses: Arthri/check-eol/.github/workflows/check-eol.yml@v2
```

## Composite Action
Add the following step to the desired jobs.
```yml
jobs:
  job:
    - name: Check End-of-Line Sequences
      uses: Arthri/check-eol-composite@v2
```

## Usage

### Default End-of-Line Sequence
The workflow enforces `LF` for all files in the index. The workflow and action operate agnostic of `autocrlf=true`, as the config option modifies files in the working tree rather than the index.

The following example configures the reusable workflow to enforce `CRLF` instead.
```yml
jobs:
  check-eol:
    uses: Arthri/check-eol/.github/workflows/check-eol.yml@v2
    with:
      default-eol: crlf
```

And the following demonstrates the equivalent for composite actions.
```yml
jobs:
  job:
    - name: Check End-of-Line Sequences
      uses: Arthri/check-eol-composite@v2
      with:
        default-eol: crlf
```

### Checkout Ref
`$GITHUB_SHA` is used by [`actions/checkout@v4`](https://github.com/actions/checkout/tree/v4) as the default commitish to checkout. The following example sets `dev` as the ref to checkout.
```yml
jobs:
  check-eol:
    uses: Arthri/check-eol/.github/workflows/check-eol.yml@v2
    with:
      checkout-ref: dev
```

### Events Supported
The reusable workflow is not limited to pushes and pull requests, other types of events such as releases are also supported.
