---
layout: page
meta-description:The documentation page for the CI-Utils Common Lisp library.
---

## CI-Utils

[![Travis Build Status](https://img.shields.io/travis/neil-lindquist/ci-utils.svg?logo=Travis)](https://travis-ci.org/neil-lindquist/CI-Utils)
[![CircleCI Build Status](https://img.shields.io/circleci/build/github/neil-lindquist/CI-Utils.svg?logo=CircleCI)](https://circleci.com/gh/neil-lindquist/CI-Utils)
[![Appveyor Build status](https://ci.appveyor.com/api/projects/status/mm1swvm28hpp2oc5/branch/master?svg=true)](https://ci.appveyor.com/project/neil-lindquist/ci-utils/branch/master)
[![Gitlab pipeline status](https://img.shields.io/gitlab/pipeline/neil-lindquist/CI-Utils.svg?logo=Gitlab)](https://gitlab.com/neil-lindquist/CI-Utils/pipelines)

CI-Utils is a set of utilities for working on continuous integration platforms, including a run script for the Fiveam test library.

### Installation
If you are using Roswell, run `ros install neil-lindquist/ci-utils`.
This will download the code where ASDF can find it and place `run-fiveam` in the roswell bin directory.

If your are not using Roswell, copy the contents of this repository somewhere that ASDF can find it (such as `~/quicklisp/local-projects/ci-utils` for Quicklisp users).

### Usage

See [neil-lindquist.github.io/CI-Utils/API](neil-lindquist.github.io/CI-Utils/API) for documentation of the API.

#### run-fiveam

The `run-fiveam` Roswell script is designed to make running Fiveam tests simple.
It has the form `run-fiveam [options] <tests and suites>`.
The test and suite names are read as symbols after loading any requested systems.
The `--quicklisp <system>` and `-l <system>` options load a system using quicklisp.
Note that any root systems in the project directory are automatically loaded.
The `--exclude <path>` and `-e <path>` options mark a path for exclusion when measuring code coverage.
Additionally, there are two environmental variables that directly affect run-fiveam.
`COVERALLS` enables measuring code coverage using [cl-coveralls](https://github.com/fukamachi/cl-coveralls/).
`COVERAGE_EXCLUDE` is a colon separated list of paths to exclude from code coverage measurements, in addition to those passed as arguments.
See `run-fiveam --help` for more information.

#### Platform Features

CI-Utils adds a few values to `*FEATURES*` that describe the current platform.
First, either `:CI` or `:NOT-CI` is added, depending on the `CI` environmental variable (set by the major CI platforms).
Known CI platforms have their name added (listed in the table below).
If `CI` is set but the system is not a recognized CI platform, then `:UNKNOWN-CI` is added.
Finally, if the `COVERALLS` environmental variable is set, then `:COVERALLS` is added.

| Platform  |  Symbol Name |
|:---------:|:------------:|
| Travis CI | `:TRAVIS-CI` |
| Circle CI | `:CIRCLE-CI` |
| Appveyor  | `:APPVEYOR`  |
| GitLab CI | `:GITLAB-CI` |
