//
//  MoveCommand.swift
//  XO-game
//
//  Created by Sergey Razgulyaev on 13.11.2020.
//  Copyright © 2020 plasmon. All rights reserved.
//

import Foundation

class MoveCommand {
    let player: Player
    let position: GameboardPosition
    let gameBoard: Gameboard?
    let gameboardView: GameboardView?
    
    public let markViewPrototype: MarkView
    
    init(player: Player, position: GameboardPosition, gameBoard: Gameboard, gameboardView: GameboardView, markViewPrototype: MarkView) {
        self.player = player
        self.position = position
        self.gameBoard = gameBoard
        self.gameboardView = gameboardView
        self.markViewPrototype = markViewPrototype
    }
    
    func executeSetPlayerMoveCommand() {
        guard gameboardView != nil else { return }
        gameBoard?.setPlayer(player, at: position )
    }
    
    func executePlaceMarkViewMoveCommand() {
        guard let gameBoardView = gameboardView else { return }
        gameBoardView.placeMarkView(markViewPrototype.copy(), at: position)
    }
}
