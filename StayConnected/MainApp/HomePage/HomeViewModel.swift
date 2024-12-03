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

struct Topic: Codable {
    let title: String
    let tags: [String]
    let replies: Int
    let isAnswered: Bool
    let question: String
    var id: String
}

class HomeViewModel {
    var topics: [Topic] = []
    private var allTopics: [Topic] = []
    var onTopicsChanged: (() -> Void)?
    
    var isEmptyState: Bool {
        return topics.isEmpty
    }
    
    private func getSavedTopics() -> [Topic] {
        if let savedData = UserDefaults.standard.array(forKey: "savedTopics") as? [Data] {
            let decoder = JSONDecoder()
            let topics = savedData.compactMap { try? decoder.decode(Topic.self, from: $0) }
            return topics
        }
        return []
    }
    
    func loadTopics(for tab: HomeTab) {
        allTopics = MockAPI.getTopics(for: tab)
        let savedTopics = getSavedTopics()
        topics = allTopics + savedTopics
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
                Topic(
                    title: "How to implement the code",
                    tags: ["Frontend", "iOS", "SwiftUI"],
                    replies: 5,
                    isAnswered: true,
                    question: """
                        What are the steps to implement a new feature in SwiftUI? 
                        Specifically, I am looking for advice on how to handle data binding, 
                        manage state effectively, and integrate with backend APIs. 
                        I am also interested in best practices for creating reusable components 
                        and ensuring smooth performance for complex UI elements.
                    """, id: "1"
                ),
                Topic(
                    title: "Understanding Backend APIs",
                    tags: ["Backend", "Swift"],
                    replies: 3,
                    isAnswered: false,
                    question: """
                        How do backend APIs communicate with iOS apps effectively? 
                        I am looking to understand the best practices for setting up a RESTful API, 
                        handling authentication, and managing network calls. 
                        Additionally, I am interested in how to deal with errors, 
                        retry failed requests, and ensure secure data transfer between the app and server.
                    """, id: "2"
                ),
                Topic(
                    title: "Mastering UIKit",
                    tags: ["UIKit", "iOS"],
                    replies: 7,
                    isAnswered: true,
                    question: """
                        What are the best practices for building user interfaces with UIKit in iOS? 
                        How do you ensure responsiveness and smooth animations in your app? 
                        What strategies do you recommend for organizing view controllers, 
                        handling layout constraints programmatically, and optimizing performance in complex apps?
                    """, id: "3"
                ),
                Topic(
                    title: "My First iOS App",
                    tags: ["Swift", "iOS"],
                    replies: 2,
                    isAnswered: false,
                    question: """
                        How should I structure my first iOS application in Swift? 
                        I would like to know about the different architectural patterns, 
                        how to handle data persistence, and the best way to organize view controllers 
                        and models for scalability and maintainability. 
                        What tools and techniques should I consider when starting my first app?
                    """, id: "4"
                )
            ]
        case .personal:
            
            return []
        }
    }
}



