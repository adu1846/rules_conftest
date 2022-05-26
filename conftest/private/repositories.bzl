"""Repository macros for conftest"""

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

load(":platforms.bzl", "OS_ARCH")

CONFTEST_VERSION = "0.32.0"

_BUILD_FILE_CONTENT = """
exports_files(["conftest"])
"""

SHA256S = {
    "conftest_0.32.0_Darwin_x86_64.tar.gz": "a692cd676cbcdc318d16f261c353c69e0ef69aff5fb0442f3cb909df13beb895",
    "conftest_0.32.0_Linux_x86_64.tar.gz": "e368ef4fcb49885e9c89052ec0c29cf4d4587707a589fefcaa3dc9cc72065055",
    "conftest_0.32.0_Linux_arm64.tar.gz": "30d446688422ffe46bb6520bb1ae816cc45cf0575d364d77b55d5c6561255046",
    "conftest_0.32.0_Windows_x86_64.zip": "2dcb9f62d811707eedec46dddc75dc773c956b1efce659506a2291ce5520a1f8",
}

def conftest_rules_dependencies():
    for os, arch in OS_ARCH:
        archive_format = "zip" if os == "windows" else "tar.gz"
        archive_name = "conftest_{v}_{os}_{arch}.{format}".format(
            v = CONFTEST_VERSION,
            os = os.capitalize(),
            arch = arch,
            format = archive_format,
        )

        http_archive(
            name = "conftest_{os}_{arch}".format(os = os, arch = arch),
            sha256 = SHA256S[archive_name],
            urls = [
                "https://github.com/open-policy-agent/conftest/releases/download/v{}/{}".format(CONFTEST_VERSION, archive_name),
            ],
            build_file_content = _BUILD_FILE_CONTENT,
        )
