// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "MyAppName",
    platforms: [
        .iOS(.v17)
    ],
    products: [
        .library(
            name: "MyAppName",
            targets: ["MyAppName"]
        ),
    ],
    dependencies: [
        // Add external dependencies here if needed
    ],
    targets: [
        .target(
            name: "MyAppName",
            dependencies: [],
            path: "Sources"
        ),
        .testTarget(
            name: "MyAppNameTests",
            dependencies: ["MyAppName"],
            path: "Tests"
        ),
    ]
)
