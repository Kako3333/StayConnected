//
//  Untitled.swift
//  StayConnected
//
//  Created by Gio Kakaladze on 02.12.24.
//

import Foundation

struct AnsweredQuestion {
    let title: String
    let replies: Int
    let tags: [String]
    let isAnswered: Bool
}

class AnsweredQuestionsViewModel {

    private var allQuestions: [AnsweredQuestion] = []
    var questions: [AnsweredQuestion] = []

    var onQuestionsUpdated: (() -> Void)?

    func loadQuestions() {

        allQuestions = [
            AnsweredQuestion(title: "How to implement the code", replies: 5, tags: ["Frontend", "iOS", "SwiftUI"], isAnswered: true),
            AnsweredQuestion(title: "Understanding APIs", replies: 3, tags: ["Backend", "API"], isAnswered: true),
            AnsweredQuestion(title: "Mastering UIKit", replies: 7, tags: ["UIKit", "Swift"], isAnswered: true)
        ]
        questions = allQuestions
        onQuestionsUpdated?()
    }

    func filterQuestions(query: String) {
        if query.isEmpty {
            questions = allQuestions
        } else {
            questions = allQuestions.filter { $0.title.lowercased().contains(query.lowercased()) }
        }
        onQuestionsUpdated?()
    }
}
