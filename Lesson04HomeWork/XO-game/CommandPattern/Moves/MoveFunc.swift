//
//  MoveFunc.swift
//  XO-game
//
//  Created by Sergey Razgulyaev on 13.11.2020.
//  Copyright © 2020 plasmon. All rights reserved.
//

import Foundation

public func addXMove(player: Player, position: GameboardPosition, gameBoard: Gameboard, gameboardView: GameboardView, markViewPrototype: MarkView) {
    let moveCommand = MoveCommand(player: player, position: position, gameBoard: gameBoard, gameboardView: gameboardView, markViewPrototype: markViewPrototype)
    MoveInvoker.shared.addMoveXCommand(moveCommand: moveCommand)
}

public func addOMove(player: Player, position: GameboardPosition, gameBoard: Gameboard, gameboardView: GameboardView, markViewPrototype: MarkView) {
    let moveCommand = MoveCommand(player: player, position: position, gameBoard: gameBoard, gameboardView: gameboardView, markViewPrototype: markViewPrototype)
    MoveInvoker.shared.addMoveOCommand(moveCommand: moveCommand)
}

public func saveAllXMoves() {
    MoveInvoker.shared.executeSaveAllXMovesCommands()
}

public func saveAllOMoves() {
    MoveInvoker.shared.executeSaveAllOMovesCommands()
}

public func drawAllMovesInFiveMoveGame() {
    MoveInvoker.shared.executeDrawAllMovesInFiveMoveGame()
}


