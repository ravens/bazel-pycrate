load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

http_archive(
    name = "rules_python",
    sha256 = "0a8003b044294d7840ac7d9d73eef05d6ceb682d7516781a4ec62eeb34702578",
    strip_prefix = "rules_python-0.24.0",
    url = "https://github.com/bazelbuild/rules_python/releases/download/0.24.0/rules_python-0.24.0.tar.gz",
)

load("@rules_python//python:repositories.bzl", "py_repositories")

py_repositories()

load("//3rdparty/python:py_interpreter.bzl", "python_build_standalone_interpreter")

python_build_standalone_interpreter(
    name = "python_interpreter",
)


load("@rules_python//python:pip.bzl", "pip_parse")

 
pip_parse(
   name = "pip",
   python_interpreter_target = "@python_interpreter//:python/bin/python3.10",
   requirements_lock = "//3rdparty:requirements_lock.txt",
)

load("@pip//:requirements.bzl", "install_deps")
install_deps()


http_archive(
    name = "cryptomobile",
    build_file = "@//:3rdparty/cryptomobile.build",
    sha256 = "18b9fae86f8872ab27f8f41eff81dc716d82541e538c6ca6da0b8f65fd628cbe",
    strip_prefix = "CryptoMobile-5bcd996a1c0fc41d4d1c3b8fb69db15eb88ba810",
    urls = ["https://github.com/mitshell/CryptoMobile/archive/5bcd996a1c0fc41d4d1c3b8fb69db15eb88ba810.tar.gz"],
)

http_archive(
    name = "pycrate",
    build_file = "@//:3rdparty/pycrate.build",
    sha256 = "06073e0d3694bb490c78487baec9adfa61bdc0768335309189444dc4844b28ae",
    strip_prefix = "pycrate-0.6.0",
    urls = ["https://github.com/P1sec/pycrate/archive/refs/tags/0.6.0.tar.gz"],
)

register_toolchains("//3rdparty/python:py_toolchain")
