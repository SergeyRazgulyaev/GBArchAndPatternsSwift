//
//  MoveInvoker.swift
//  XO-game
//
//  Created by Sergey Razgulyaev on 13.11.2020.
//  Copyright © 2020 plasmon. All rights reserved.
//

import Foundation

class MoveInvoker {
    public static let shared = MoveInvoker()
    
    private var moveXCommands: [MoveCommand] = []
    private var moveOCommands: [MoveCommand] = []
    private var moveCommands: [MoveCommand] = []
    
    func addMoveXCommand(moveCommand: MoveCommand) {
        moveXCommands.append(moveCommand)
        moveCommand.executePlaceMarkViewMoveCommand()
    }
    
    func addMoveOCommand(moveCommand: MoveCommand) {
        moveOCommands.append(moveCommand)
        moveCommand.executePlaceMarkViewMoveCommand()
    }
    
    func executeSaveAllXMovesCommands() {
        moveXCommands.forEach { $0.executeSetPlayerMoveCommand() }
    }
    
    func executeSaveAllOMovesCommands() {
        moveOCommands.forEach { $0.executeSetPlayerMoveCommand() }
    }
    
    func executeDrawAllMovesInFiveMoveGame() {
        moveXCommands.forEach {
            $0.executePlaceMarkViewMoveCommand()
        }
        moveOCommands.forEach {
            $0.executePlaceMarkViewMoveCommand()
        }
        moveXCommands = []
        moveOCommands = []
    }
}
