//
//  FiveMovesFinishState.swift
//  XO-game
//
//  Created by Sergey Razgulyaev on 13.11.2020.
//  Copyright © 2020 plasmon. All rights reserved.
//

import Foundation


class FiveMovesFinishState: GameState {
    var isMoveCompleted = false
    
    public let winner: Player?
    private weak var gameboard: Gameboard?
    private weak var gameboardView: GameboardView?
    
    private weak var gameViewController: XOGameViewController?
    
    init(winner: Player?, gameViewController: XOGameViewController) {
        self.winner = winner
        self.gameViewController = gameViewController
    }
    
    func begin() { }
    
    func addMark(at position: GameboardPosition) { }
       
    func addAllMarks() {
        drawAllMovesInFiveMoveGame()
    }

    func getWinnerName(from: Player) -> String {
        switch winner {
        case .first:
            return "1st player"
        case .second:
            return "2nd player"
        case .computer:
            return "computer"
        case .none:
            return "there is no winner"
        }
    }
    
    func end() {
        log(action: .gameFinished(winner: winner))
        
        gameViewController?.winnerLabel.isHidden = false
        
        if let winner = winner {
            gameViewController?.winnerLabel.text = getWinnerName(from: winner) + " won"
        } else {
            gameViewController?.winnerLabel.text = "No winner"
        }
        gameViewController?.firstPlayerTurnLabel.isHidden = true
        gameViewController?.secondPlayerTurnLabel.isHidden = true
    }
}
