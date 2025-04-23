//
//  MockData.swift
//  FLFeatureReequest
//
//  Created by Francesco Leoni on 3/5/23.
//  Copyright © 2025 Francesco Leoni. All rights reserved.
//

import Foundation

struct MockData {
    static var features: [FeatureResponse] {
        let features = [
            createFeature("📸 Transformation Challenge", "It would be awesome to be able to take a picture after every workout and after 30 days it creates a video out of them."),
						createFeature("🎥 Exercise Video Example.", "When doing an exercise it would be great if I could see a video example that shows me how to do it properly"),
						createFeature("Health App Connection.", "If this app would also let Health App know about your exercises then this would be awesome!"),
						createFeature("Browser exercise list", "I would like to see exercises in a list and be able to chose from then when creating my workouts instead of coming up with them myself."),
						createFeature("📈 Statistics of my workout", "Seeing a chart that displays how disciplined I was this week and also how many calories I have burned would be great."),
						createFeature("⌚️ Apple Watch App", "Having the app also on the Apple Watch would be super convenient. Especially when I want to pause a workout or so.")
        ]

        var votes = 123
        return features.map({ feature in
            let shadowFeature = feature
					var ul = [UserResponse(uuid: UUID().uuidString)]
            for _ in 1...votes {
							ul.append(UserResponse(uuid: UUID().uuidString))
            }

            votes -= Int.random(in: 1...7)
            return FeatureResponse(
                id: shadowFeature.id,
                userUUID: shadowFeature.userUUID,
                title: shadowFeature.title,
                description: shadowFeature.description,
                state: .approved,
                votingUsers: ul,
                commentList: []
            )
        })
    }

    static func createFeature(_ title: String, _ description: String) -> FeatureResponse {
        FeatureResponse(
            id: UUID(),
						userUUID: UUIDManager.getUUID(),
            title: title,
            description: description,
            state: .pending,
            votingUsers: [],
            commentList: []
        )
    }
}
