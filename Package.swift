
// swift-tools-version:5.5
import PackageDescription

let package = Package(
    name: "BMQuadtree",
    platforms: [
        .iOS(.v10)
    ],
    products: [
        .library(
            name: "BMQuadtree",
            targets: ["BMQuadtree"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "BMQuadtree",
            dependencies: [],
            path: "Sources"
        ),
        // Uncomment and add tests if necessary
        // .testTarget(
        //     name: "BMQuadtreeTests",
        //     dependencies: ["BMQuadtree"],
        //     path: "Tests"
        // ),
    ]
)
