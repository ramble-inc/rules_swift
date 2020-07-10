# Copyright 2018 The Bazel Authors. All rights reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

"""Definitions for handling Bazel repositories used by the Swift rules."""

load("@bazel_tools//tools/build_defs/repo:git.bzl", "git_repository")
load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
load(
    "@build_bazel_rules_swift//swift/internal:swift_autoconfiguration.bzl",
    "swift_autoconfiguration",
)

def _maybe(repo_rule, name, **kwargs):
    """Executes the given repository rule if it hasn't been executed already.

    Args:
      repo_rule: The repository rule to be executed (e.g., `http_archive`.)
      name: The name of the repository to be defined by the rule.
      **kwargs: Additional arguments passed directly to the repository rule.
    """
    if not native.existing_rule(name):
        repo_rule(name = name, **kwargs)

def swift_rules_dependencies():
    """Fetches repositories that are dependencies of `rules_swift`.

    Users should call this macro in their `WORKSPACE` to ensure that all of the
    dependencies of the Swift rules are downloaded and that they are isolated
    from changes to those dependencies.
    """
    _maybe(
        http_archive,
        name = "bazel_skylib",
        urls = [
            "https://github.com/bazelbuild/bazel-skylib/releases/download/1.0.2/bazel-skylib-1.0.2.tar.gz",
        ],
        sha256 = "97e70364e9249702246c0e9444bccdc4b847bed1eb03c5a3ece4f83dfe6abc44",
    )

    _maybe(
        git_repository,
        name = "build_bazel_apple_support",
        remote = "https://github.com/bazelbuild/apple_support.git",
        branch = "master",
    )

    _maybe(
        http_archive,
        name = "com_github_apple_swift_protobuf",
        urls = ["https://github.com/apple/swift-protobuf/archive/1.10.0.zip"],
        # sha256 = "a4546ee8e95e7f7d4cf46b5b667e824b58f3943a71c352bf1e0b91660afdf3c3",
        strip_prefix = "swift-protobuf-1.10.0/",
        type = "zip",
        build_file = "@build_bazel_rules_swift//third_party:com_github_apple_swift_protobuf/BUILD.overlay",
    )

    _maybe(
        http_archive,
        name = "com_github_grpc_grpc_swift",
        urls = ["https://github.com/grpc/grpc-swift/archive/1.0.0-alpha.14.zip"],
        # sha256 = "b9818134f497df073cb49e0df59bfeea801291230d6fc048fdc6aa76e453a3cb",
        strip_prefix = "grpc-swift-1.0.0-alpha.14/",
        type = "zip",
        build_file = "@build_bazel_rules_swift//third_party:com_github_grpc_grpc_swift/BUILD.overlay",
    )

    _maybe(
        http_archive,
        name = "com_github_apple_swift_nio",
        urls = ["https://github.com/apple/swift-nio/archive/2.19.0.zip"],
        # sha256 = "b9818134f497df073cb49e0df59bfeea801291230d6fc048fdc6aa76e453a3cb",
        strip_prefix="swift-nio-2.19.0/"
        type = "zip",
        build_file="@build_bazel_rules_swift//thirdparty:com_github_apple_swift_nio/BUILD.overlay",
    )

    _maybe(
        http_archive,
        name = "com_github_apple_swift_nio_http2",
        urls = ["https://github.com/apple/swift-nio-http2/archive/1.12.3.zip"],
        # sha256 = "b9818134f497df073cb49e0df59bfeea801291230d6fc048fdc6aa76e453a3cb",
        strip_prefix="swift-nio-http2-1.12.3/"
        type = "zip",
        build_file="@build_bazel_rules_swift//thirdparty:com_github_apple_swift_nio_http2/BUILD.overlay",
    )

    _maybe(
        http_archive,
        name = "com_github_apple_swift_nio_ssl",
        urls = ["https://github.com/apple/swift-nio-ssl/archive/2.8.0.zip"],
        # sha256 = "b9818134f497df073cb49e0df59bfeea801291230d6fc048fdc6aa76e453a3cb",
        strip_prefix="swift-nio-ssl-2.8.0/"
        type = "zip",
        build_file="@build_bazel_rules_swift//thirdparty:com_github_apple_swift_nio_ssl/BUILD.overlay",
    )

    _maybe(
        http_archive,
        name = "com_github_apple_swift_nio_transport_services",
        urls = ["https://github.com/apple/swift-nio-transport-services/archive/1.7.0.zip"],
        # sha256 = "b9818134f497df073cb49e0df59bfeea801291230d6fc048fdc6aa76e453a3cb",
        strip_prefix="swift-nio-transport-services-1.7.0/"
        type = "zip",
        build_file="@build_bazel_rules_swift//thirdparty:com_github_apple_swift_nio_transport_services/BUILD.overlay",
    )

    _maybe(
        http_archive,
        name = "com_github_apple_swift_log",
        urls = ["https://github.com/apple/swift-log/archive/1.3.0.zip"],
        # sha256 = "b9818134f497df073cb49e0df59bfeea801291230d6fc048fdc6aa76e453a3cb",
        strip_prefix="swift-log-1.3.0/"
        type = "zip",
        build_file="@build_bazel_rules_swift//thirdparty:com_github_apple_swift_log/BUILD.overlay",
    )

    _maybe(
        http_archive,
        name = "com_github_nlohmann_json",
        urls = [
            "https://github.com/nlohmann/json/releases/download/v3.6.1/include.zip",
        ],
        sha256 = "69cc88207ce91347ea530b227ff0776db82dcb8de6704e1a3d74f4841bc651cf",
        type = "zip",
        build_file = "@build_bazel_rules_swift//third_party:com_github_nlohmann_json/BUILD.overlay",
    )

    _maybe(
        http_archive,
        name = "com_google_protobuf",
        # v3.11.2, latest as of 2019-12-19
        urls = [
            "https://github.com/protocolbuffers/protobuf/archive/v3.11.2.zip",
        ],
        sha256 = "e4f8bedb19a93d0dccc359a126f51158282e0b24d92e0cad9c76a9699698268d",
        strip_prefix = "protobuf-3.11.2",
        type = "zip",
    )

    _maybe(
        swift_autoconfiguration,
        name = "build_bazel_rules_swift_local_config",
    )
