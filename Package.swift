// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Apollo",
    products: [
    .library(
      name: "ApolloCore",
      targets: ["ApolloCore"]),
    .library(
      name: "Apollo",
      targets: ["Apollo"]),
    .library(
        name: "Apollo-Dynamic",
        type: .dynamic,
        targets: ["Apollo"]),
    .library(
      name: "ApolloCodegenLib",
      targets: ["ApolloCodegenLib"]),
    .library(
        name: "ApolloSQLite",
        targets: ["ApolloSQLite"]),
    .library(
        name: "ApolloWebSocket",
        targets: ["ApolloWebSocket"]),
    ],
    dependencies: [
    .package(
      url: "https://github.com/stephencelis/SQLite.swift.git",
      .upToNextMinor(from: "0.12.2")),
    .package(
      url: "https://github.com/daltoniam/Starscream",
      .upToNextMinor(from: "3.1.1")),
    .package(
      url: "https://github.com/stencilproject/Stencil.git",
      .upToNextMinor(from: "0.14.0")),
    .package(
      url: "https://github.com/apple/swift-crypto.git",
      .upToNextMinor(from: "1.1.2")),
    .package(
      url: "https://github.com/apollographql/InflectorKit",
      .upToNextMinor(from: "0.0.2")),
    ],
    targets: [
      .target(
        name: "ApolloCore",
        dependencies: [
          .product(name: "Crypto",
                   package: "swift-crypto",
                   condition: .when(platforms: [.linux]))
        ]),
    .target(
      name: "Apollo",
      dependencies: [
        "ApolloCore",
      ]),
    .target(
      name: "ApolloCodegenLib",
      dependencies: [
        "ApolloCore",
        .product(name: "InflectorKit",
                 package: "InflectorKit",
                 condition: .when(platforms: [.macOS])),
        .product(name: "Stencil",
                 package: "Stencil",
                 condition: .when(platforms: [.macOS])),
      ]),
    .target(
      name: "ApolloSQLite",
      dependencies: [
        "Apollo",
        .product(name: "SQLite", package: "SQLite.swift"),
      ]),
    .target(
      name: "ApolloSQLiteTestSupport",
      dependencies: [
        "ApolloSQLite",
        "ApolloTestSupport"
      ]),
    .target(
      name: "ApolloWebSocket",
      dependencies: [
        "Apollo",
        "ApolloCore",
        .product(name: "Starscream", package: "Starscream"),
      ]),
    .target(
      name: "ApolloTestSupport",
      dependencies: [
        "Apollo",
      ]),
    .target(
      name: "GitHubAPI",
      dependencies: [
        "Apollo",
      ]),
    .target(
      name: "StarWarsAPI",
      dependencies: [
        "Apollo",
      ]),
    .target(
      name: "UploadAPI",
      dependencies: [
        "Apollo",
      ]),
    .testTarget(
      name: "ApolloTests",
      dependencies: [
        "ApolloTestSupport",
        "StarWarsAPI",
        "UploadAPI"
      ]),
    .testTarget(
      name: "ApolloCacheDependentTests",
      dependencies: [
        "ApolloSQLiteTestSupport",
        "StarWarsAPI",
      ]),
    .testTarget(
      name: "ApolloCodegenTests",
      dependencies: [
        "ApolloTestSupport",
        "ApolloCodegenLib"
      ]),
    .testTarget(
      name: "ApolloSQLiteTests",
      dependencies: [
        "ApolloSQLiteTestSupport",
        "StarWarsAPI"
      ]),
    .testTarget(
      name: "ApolloWebsocketTests",
      dependencies: [
        "ApolloWebSocket",
        "ApolloTestSupport",
        "StarWarsAPI",
      ]),
    ]
)
