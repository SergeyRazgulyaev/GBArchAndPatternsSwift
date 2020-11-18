//
//  PlayerState.swift
//  XO-game
//
//  Created by Veaceslav Chirita on 11/6/20.
//  Copyright © 2020 plasmon. All rights reserved.
//

import Foundation

class PlayerState: GameState {
    
    var isMoveCompleted: Bool = false
    
    public let player: Player
    private weak var gameViewController: XOGameViewController?
    private weak var gameBoard: Gameboard?
    private weak var gameBoardView: GameboardView?
    
    public let markViewPrototype: MarkView
    
    init(player: Player, gameViewController: XOGameViewController,
         gameBoard: Gameboard, gameBoardView: GameboardView, markViewPrototype: MarkView) {
        self.player = player
        self.gameViewController = gameViewController
        self.gameBoard = gameBoard
        self.gameBoardView = gameBoardView
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
        log(action: .playerSetMark(player: player, position: position))
        
        guard let gameBoardView = gameBoardView, gameBoardView.canPlaceMarkView(at: position) else {
            return
        }
        gameBoard?.setPlayer(player, at: position)
        gameBoardView.placeMarkView(markViewPrototype.copy(), at: position)
        isMoveCompleted = true
    }
    
    func addAllMarks() { }

    func end() { }
}
