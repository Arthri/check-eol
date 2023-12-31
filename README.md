# check-eol
A reusable workflow for linting end-of-line sequences. This workflow is a wrapper for [check-eol-composite](https://github.com/Arthri/check-eol-composite).

## Installation
Add a new workflow under `.github/workflows/` with the following contents.
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
    uses: Arthri/check-eol/.github/workflows/check-eol.yml@v1
```

## Usage
Some configuration options are documented at https://github.com/Arthri/check-eol-composite#readme.

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
