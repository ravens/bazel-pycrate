# bazel-based jupyter notebook with Pycrate support

A jupyter notebook that is run in a more hermetic manner using Bazel to work on 3GPP payloads.
I typically use this environment for 3GPP payloads analysis. 

Bazel (via bazelisk) is used to bootstrap a pseudo hermetic env (i.e. C, python of the system are used to bootstrap...) so works across system updates.

````
# bazelisk, some C and python should be enough to run this, i.e. brew install bazelisk on Mac with homebrew
bazel run //:notebook
````

Example is provided on demo.ipynb.
