load("//conftest/private:toolchain.bzl", "conftest_toolchain_alias")

load(
    "//conftest/private:rules.bzl",
    _conftest_test = "conftest_test",
    _conftest_report = "conftest_report"
)

def conftest(name):
    conftest_toolchain_alias(
        name = name,
        visibility = ["//visibility:public"],
    )

conftest_test = _conftest_test
conftest_report = _conftest_report