// swift-tools-version: 6.2
//
//  Package.swift
//  Lyric
//
//  Created by Codex on 5/30/26.
//

import PackageDescription

let package = Package(
    name: "Lyric",
    platforms: [
        .iOS(.v26),
        .macOS(.v15),
    ],
    products: [
        .library(
            name: "Lyric",
            targets: ["Lyric"]
        ),
        .library(
            name: "LyricDemoUI",
            targets: ["LyricDemoUI"]
        ),
        .executable(
            name: "LyricDemo",
            targets: ["LyricDemo"]
        ),
    ],
    targets: [
        .target(
            name: "Lyric"
        ),
        .target(
            name: "LyricDemoUI",
            dependencies: ["Lyric"]
        ),
        .executableTarget(
            name: "LyricDemo",
            dependencies: ["LyricDemoUI"]
        ),
        .testTarget(
            name: "LyricTests",
            dependencies: ["Lyric"]
        ),
    ],
    swiftLanguageModes: [.v6]
)
