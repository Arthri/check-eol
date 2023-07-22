# reusable-workflow
A linter for end-of-line sequences based on .gitattributes. 

## Installation
Add a new workflow under `.github/workflows/` with the following contents.
```yml
name: Check End-of-Line Sequence
run-name: Check End-of-Line Sequence

on:
  push:
    branches: [ master, dev ]
  pull_request:
    branches: [ master, dev ]

jobs:
  check-eol:
    uses: Arthri/check-eol/.github/workflows/check-eol.yml@v1
```

## Usage

### Default End-of-Line Sequence
The workflow enforces `LF` for all files in the index. `autocrlf=true` modifies files in the working tree rather than the index and thus does not affect the workflow. The following example configures the workflow to enforce `CRLF` instead.
```yml
jobs:
  check-eol:
    uses: Arthri/check-eol/.github/workflows/check-eol.yml@v1
    with:
      default-eol: crlf
```

### Checkout Ref
`$GITHUB_SHA` is used by [`actions/checkout@v3`](https://github.com/actions/checkout/tree/v3) as the default commitish to checkout. The following example sets `dev` as the ref to checkout.
```yml
jobs:
  check-eol:
    uses: Arthri/check-eol/.github/workflows/check-eol.yml@v1
    with:
      checkout-ref: dev
```

### More Events
The reusable workflow is not limited to pushes and pull requests, other types of events such as releases are also supported.
