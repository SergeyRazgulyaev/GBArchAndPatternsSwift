//
//  ComputerState.swift
//  XO-game
//
//  Created by Sergey Razgulyaev on 11.11.2020.
//  Copyright © 2020 plasmon. All rights reserved.
//

import Foundation

class ComputerState: GameState {
    var isMoveCompleted: Bool = false
    
    public let player: Player
    private weak var gameViewController: XOGameViewController?
    private weak var gameBoard: Gameboard?
    private weak var gameBoardView: GameboardView?
    private var fieldFillingCounter: Int
    
    public let markViewPrototype: MarkView

    init(computer: Player, gameViewController: XOGameViewController, gameBoard: Gameboard, gameBoardView: GameboardView, markViewPrototype: MarkView, fieldFillingCounter: Int) {
        self.player = computer
        self.gameViewController = gameViewController
        self.gameBoard = gameBoard
        self.gameBoardView = gameBoardView
        self.markViewPrototype = markViewPrototype
        self.fieldFillingCounter = fieldFillingCounter
    }
    
    func begin() {
        switch player {
        case .first:
            gameViewController?.firstPlayerTurnLabel.isHidden = false
            gameViewController?.firstPlayerTurnLabel.text = "player"
            gameViewController?.secondPlayerTurnLabel.isHidden = true
        case .second: break
        case .computer:
            gameViewController?.firstPlayerTurnLabel.isHidden = true
            gameViewController?.secondPlayerTurnLabel.text = "computer"
            gameViewController?.secondPlayerTurnLabel.isHidden = false
        }
        gameViewController?.winnerLabel.isHidden = true
    }
    
    
    func addMark(at position: GameboardPosition) {
        var computerPosition = position
        guard let gameBoardView = gameBoardView else {
            return
        }
        while !gameBoardView.canPlaceMarkView(at: computerPosition), fieldFillingCounter < 9 {
            computerPosition.setRandomPosition()
        }
        log(action: .playerSetMark(player: player, position: computerPosition))
        gameBoard?.setPlayer(player, at: computerPosition)
        gameBoardView.placeMarkView(markViewPrototype.copy(), at: computerPosition)
        isMoveCompleted = true
    }
    
    func addAllMarks() { }
    
    func end() { }
}
