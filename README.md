# Test Trac

Configure and run a local test instance of [Trac](https://trac.edgewall.org/).
To use this repo make sure you have `make`, `python` and `virtualenv` in your
path, then:

    $ make run

This will create a virtualenv, install Trac into it, configure it by creating
a couple of test accounts and some test components and milestones, then run
it on port 8000.
