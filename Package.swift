// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
	name: "FLFeatureRequest",
	defaultLocalization: "en",
	platforms: [.iOS(.v15), .macOS(.v12), .visionOS(.v1)],
	products: [
		.library(
			name: "FLFeatureRequest",
			targets: ["FLFeatureRequest"]),
	],
	dependencies: [
		.package(url: "https://github.com/firebase/firebase-ios-sdk.git", .upToNextMajor(from: "12.7.0"))
	],
	targets: [
		.target(
			name: "FLFeatureRequest",
			dependencies: [
				.product(name: "FirebaseDatabase", package: "firebase-ios-sdk")
			],
			resources: [.process("Resources")]
		),
		.testTarget(
			name: "FLFeatureRequestTests",
			dependencies: ["FLFeatureRequest"]
		),
	]
)
