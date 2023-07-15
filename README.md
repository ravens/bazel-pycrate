# bazel-based jupyter notebook with Pycrate support

A jupyter notebook that is run in a more hermetic manner using Bazel to work on 3GPP payloads.
I typically use this environment for 3GPP payloads analysis. 

Bazel (via bazelisk) is used to bootstrap a pseudo hermetic env (i.e. C, python of the system are used to bootstrap...) so works across system updates.

````
# bazelisk, some C and python should be enough to run this, i.e. brew install bazelisk on Mac with homebrew
bazelisk run //:notebook
````

Example is provided on demo.ipynb.

## setup example

Bazel makes it very easy to run notebook with specific dependencies every where. Example on Debian 12
````
apt-get update
apt-get install build-essential git
git clone https://github.com/ravens/bazel-pycrate.git && cd bazel-pycrate
# get bazelisk from https://github.com/bazelbuild/bazelisk/releases
wget https://github.com/bazelbuild/bazelisk/releases/download/v1.17.0/bazelisk-linux-arm64 && chmod ugo+x bazelisk-linux-arm64 && mv bazelisk-linux-arm64 bazelisk
./bazelisk run //:notebook
./bazelisk shutdown # to close bazel server
````
