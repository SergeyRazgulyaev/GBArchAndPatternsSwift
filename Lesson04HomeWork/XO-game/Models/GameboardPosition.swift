//
//  GameBoardPosition.swift
//  XO-game
//
//  Created by Evgeny Kireev on 26/02/2019.
//  Copyright © 2019 plasmon. All rights reserved.
//

import Foundation

public struct GameboardPosition: Hashable {
    public var column: Int
    public var row: Int
    
    mutating func setRandomPosition() {
        column = Int.random(in: 0..<3)
        row = Int.random(in: 0..<3)
    }
}
