// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription
import CompilerPluginSupport

let package = Package(
    name: "SwiftUIDynamicColor",
    platforms: [.macOS(.v15), .iOS(.v17), .tvOS(.v13), .watchOS(.v6), .macCatalyst(.v13)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "SwiftUIDynamicColor",
            targets: ["SwiftUIDynamicColor"]
        ),
        .executable(
            name: "SwiftUIDynamicColorClient",
            targets: ["SwiftUIDynamicColorClient"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/swiftlang/swift-syntax.git", from: "601.0.1"),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        // Macro implementation that performs the source transformation of a macro.
        .macro(
            name: "SwiftUIDynamicColorMacros",
            dependencies: [
                .product(name: "SwiftSyntaxMacros", package: "swift-syntax"),
                .product(name: "SwiftCompilerPlugin", package: "swift-syntax")
            ]
        ),

        // Library that exposes a macro as part of its API, which is used in client programs.
        .target(name: "SwiftUIDynamicColor",
                dependencies: [
                    "SwiftUIDynamicColorMacros",
                    .product(name: "SwiftSyntaxMacros", package: "swift-syntax")
                ]),

        // A client of the library, which is able to use the macro in its own code.
        .executableTarget(name: "SwiftUIDynamicColorClient", dependencies: ["SwiftUIDynamicColor"]),

        // A test target used to develop the macro implementation.
        .testTarget(
            name: "SwiftUIDynamicColorTests",
            dependencies: [
                "SwiftUIDynamicColorMacros",
                .product(name: "SwiftSyntaxMacrosTestSupport", package: "swift-syntax"),
            ]
        ),
    ]
)
