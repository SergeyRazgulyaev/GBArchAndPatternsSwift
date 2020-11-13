//
//  FiveMovesState.swift
//  XO-game
//
//  Created by Sergey Razgulyaev on 13.11.2020.
//  Copyright © 2020 plasmon. All rights reserved.
//

import Foundation

class FiveMovesState: GameState {
    var isMoveCompleted: Bool = false
    
    public let player: Player
    private weak var gameViewController: XOGameViewController?
    private weak var gameboard: Gameboard?
    private weak var gameboardView: GameboardView?
    
    public let markViewPrototype: MarkView
    
    init(player: Player, gameViewController: XOGameViewController,
         gameBoard: Gameboard, gameBoardView: GameboardView, markViewPrototype: MarkView) {
        self.player = player
        self.gameViewController = gameViewController
        self.gameboard = gameBoard
        self.gameboardView = gameBoardView
        self.markViewPrototype = markViewPrototype
    }
    
    func begin() {
        switch player {
        case .first:
            gameViewController?.firstPlayerTurnLabel.isHidden = false
            gameViewController?.firstPlayerTurnLabel.text = "1st player"
            gameViewController?.secondPlayerTurnLabel.isHidden = true
        case .second:
            gameViewController?.firstPlayerTurnLabel.isHidden = true
            gameViewController?.secondPlayerTurnLabel.text = "2nd player"
            gameViewController?.secondPlayerTurnLabel.isHidden = false
        case .computer: break
        }
        gameViewController?.winnerLabel.isHidden = true
    }
    
    func addMark(at position: GameboardPosition) {
        guard let gameBoardView = gameboardView, gameBoardView.canPlaceMarkView(at: position) else { return }
        switch player {
        case .first:
            guard let gameBoard = gameboard else { return }
            addXMove(player: player, position: position, gameBoard: gameBoard, gameboardView: gameboardView!, markViewPrototype: markViewPrototype)
        case .second:
            guard let gameBoard = gameboard else { return }
            addOMove(player: player, position: position, gameBoard: gameBoard, gameboardView: gameboardView!, markViewPrototype: markViewPrototype)            
        case .computer: break
        }
        isMoveCompleted = true
    }
    
    func addAllMarks() { }

    func end() { }
}

