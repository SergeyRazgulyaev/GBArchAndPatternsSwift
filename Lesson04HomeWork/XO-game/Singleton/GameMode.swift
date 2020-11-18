//
//  GameModeSingleton.swift
//  XO-game
//
//  Created by Sergey Razgulyaev on 11.11.2020.
//  Copyright © 2020 plasmon. All rights reserved.
//

import Foundation

enum GameModeSettings {
    case twoPlayersMode
    case playWithComputerMode
}

class GameModeSingleton {
    var gameMode: GameModeSettings = .twoPlayersMode
    
    static let shared = GameModeSingleton()
    private init(){}
}
