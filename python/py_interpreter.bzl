OSX_OS_NAME = "mac os x"
LINUX_OS_NAME = "linux"

def _python_build_standalone_interpreter_impl(repository_ctx):
    os_name = repository_ctx.os.name.lower()
    arch = repository_ctx.execute(["uname","-m"])
    if os_name == OSX_OS_NAME:
        if "arm64" in arch.stdout:
            url = "https://github.com/indygreg/python-build-standalone/releases/download/20230507/cpython-3.10.11+20230507-aarch64-apple-darwin-install_only.tar.gz"
            integrity_shasum = "8348bc3c2311f94ec63751fb71bd0108174be1c4def002773cf519ee1506f96f"
        elif "x86_64" in arch.stdout:
            url = "https://github.com/indygreg/python-build-standalone/releases/download/20230507/cpython-3.10.11+20230507-x86_64-apple-darwin-install_only.tar.gz"
            integrity_shasum = "bd3fc6e4da6f4033ebf19d66704e73b0804c22641ddae10bbe347c48f82374ad"
        else:
            fail("arch '{}' is not supported.".format(arch.stdout))
    elif os_name == LINUX_OS_NAME:
        if "x86_64" in arch.stdout:
            url = "https://github.com/indygreg/python-build-standalone/releases/download/20230507/cpython-3.10.11+20230507-x86_64-unknown-linux-gnu-install_only.tar.gz"
            integrity_shasum = "c5bcaac91bc80bfc29cf510669ecad12d506035ecb3ad85ef213416d54aecd79"
        elif "aarch64" in arch.stdout:
            url = "https://github.com/indygreg/python-build-standalone/releases/download/20230507/cpython-3.10.11+20230507-aarch64-unknown-linux-gnu-install_only.tar.gz"
            integrity_shasum = "c7573fdb00239f86b22ea0e8e926ca881d24fde5e5890851339911d76110bc35"
        else:
            fail("arch '{}' is not supported.".format(arch.stdout))
    else:
        fail("OS '{}' is not supported.".format(os_name))

    repository_ctx.download(
        url = [url],
        sha256 = integrity_shasum,
        output = "python.tar.gz",
    )

    repository_ctx.execute(["tar", "xvf", "python.tar.gz"])

    if os_name == OSX_OS_NAME:
        sdkpath = "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk"
        
        xcodeexec = repository_ctx.execute(["xcode-select","-p"])
        xcodepath = xcodeexec.stdout.strip()
        if "Library" in xcodepath:
            sdkpath = "/Library/Developer/CommandLineTools/SDKs/MacOSX.sdk"      

        xcodesdkregexp = "s,/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX12.3.sdk," + sdkpath + ",g"      
        repository_ctx.execute(["sed", "-i", "-e", xcodesdkregexp,"python/lib/python3.10/_sysconfigdata__darwin_darwin.py"])


    repository_ctx.delete("python.tar.gz")

    BUILD_FILE_CONTENT = """
filegroup(
    name = "files",
    srcs = glob(["python/**/*"], exclude = ["**/* *"]),
    visibility = ["//visibility:public"],
)
exports_files(["python/bin/python3.10"])
"""

    repository_ctx.file("BUILD.bazel", BUILD_FILE_CONTENT)
    return None

python_build_standalone_interpreter = repository_rule(
    implementation = _python_build_standalone_interpreter_impl,
    attrs = {},
)
