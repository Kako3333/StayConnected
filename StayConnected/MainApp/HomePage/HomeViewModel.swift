//
//  HomeViewModel.swift
//  StayConnected
//
//  Created by Tiko on 29.11.24.
//

import Foundation

enum HomeTab {
    case general
    case personal
}

struct Topic {
    let title: String
    let tags: [String]
    let replies: Int
    let isAnswered: Bool
}

class HomeViewModel {
    var topics: [Topic] = []
    private var allTopics: [Topic] = []
    var onTopicsChanged: (() -> Void)?
    
    var isEmptyState: Bool {
        return topics.isEmpty
    }
    
    func loadTopics(for tab: HomeTab) {
        allTopics = MockAPI.getTopics(for: tab)
        topics = allTopics
        onTopicsChanged?()
    }
    
    func filterTopics(query: String) {
        if query.isEmpty {
            topics = allTopics
        } else {
            topics = allTopics.filter { $0.title.lowercased().contains(query.lowercased()) }
        }
        onTopicsChanged?()
    }
}

class MockAPI {
    static func getTopics(for tab: HomeTab) -> [Topic] {
        switch tab {
        case .general:
            return [
                Topic(title: "How to implement the code", tags: ["Frontend", "iOS", "SwiftUI"], replies: 5, isAnswered: true),
                Topic(title: "Understanding Backend APIs", tags: ["Backend", "Swift"], replies: 3, isAnswered: false),
                Topic(title: "Mastering UIKit", tags: ["UIKit", "iOS"], replies: 7, isAnswered: true)
            ]
        case .personal:
            return []
        }
    }
}

