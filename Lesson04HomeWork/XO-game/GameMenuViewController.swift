//
//  GameMenuViewController.swift
//  XO-game
//
//  Created by Sergey Razgulyaev on 11.11.2020.
//  Copyright © 2020 plasmon. All rights reserved.
//

import UIKit

class GameMenuViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func playWithComputerButtonPressed(_ sender: UIButton) {
        GameModeSingleton.shared.gameMode = .playWithComputerGameMode
    }
    
    @IBAction func playWithFriendButtonPressed(_ sender: UIButton) {
        GameModeSingleton.shared.gameMode = .twoPlayersGameMode
    }
    
    @IBAction func playInFiveMovesGameButtonPressed(_ sender: UIButton) {
        GameModeSingleton.shared.gameMode = .fiveMovesGameMode
    }
}
