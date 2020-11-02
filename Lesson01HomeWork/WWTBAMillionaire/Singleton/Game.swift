//
//  Game.swift
//  WWTBAMillionaire
//
//  Created by Sergey Razgulyaev on 29.10.2020.
//

import Foundation

class Game {
    var gameSession: GameSession?
    private(set) var gameResults: [GameResult] {
        didSet {
            gameResultsCaretaker.saveGameResults(results: gameResults)
        }
    }
    private var percentageOfAnsweredQuestions = 0.0
    private let gameResultsCaretaker = GameResultsCaretaker()
    
    static let shared = Game()
    private init(){
        gameResults = gameResultsCaretaker.loadGameResults() ?? []
    }
    
    func addGameResult(result: GameResult) {
        gameResults.insert(result, at: 0)
        gameSession = GameSession()
    }
    
    func clearAllGameResults() {
        gameResults.removeAll()
    }
}
