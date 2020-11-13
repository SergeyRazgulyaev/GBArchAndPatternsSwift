//
//  XOGameViewController.swift
//  XO-game
//
//  Created by Evgeny Kireev on 25/02/2019.
//  Copyright © 2019 plasmon. All rights reserved.
//

import UIKit

class XOGameViewController: UIViewController {
    @IBOutlet var gameboardView: GameboardView!
    @IBOutlet var firstPlayerTurnLabel: UILabel!
    @IBOutlet var secondPlayerTurnLabel: UILabel!
    @IBOutlet var winnerLabel: UILabel!
    @IBOutlet var restartButton: UIButton!
    
    private let gameBoard = Gameboard()
    private lazy var referee = Referee(gameboard: gameBoard)
    private var currentState: GameState! {
        didSet {
            currentState.begin()
        }
    }
    
    private var counter: Int = 0
    private var computerPosition = GameboardPosition(column: 0, row: 0)
    private let numberOfMoves: Int = 5
    private var madeMove: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setFirstState()
        
        gameboardView.onSelectPosition = { [weak self] position in
            switch GameModeSingleton.shared.gameMode {
            case .twoPlayersGameMode, .playWithComputerGameMode:
                guard let self = self else { return }
                self.currentState.addMark(at: position)
                if self.currentState.isMoveCompleted {
                    self.counter += 1
                    self.setNextState()
                }
            case .fiveMovesGameMode:
                guard let self = self else { return }
                if self.madeMove < self.numberOfMoves {
                    self.currentState.addMark(at: position)
                    if self.currentState.isMoveCompleted {
                        self.counter += 1
                        self.madeMove += 1
                    }
                    if self.madeMove == self.numberOfMoves {
                        self.setNextState()
                        self.madeMove = 0
                        if self.counter != 10 {
                            self.gameboardView.clear()
                        }
                    }
                }
            }
        }
    }
    
    private func setFirstState() {
        let player = Player.first
        switch GameModeSingleton.shared.gameMode {
        case .twoPlayersGameMode, .playWithComputerGameMode:
            currentState = PlayerState(player: player,
                                       gameViewController: self,
                                       gameBoard: gameBoard,
                                       gameBoardView: gameboardView,
                                       markViewPrototype: player.markViewPrototype)
        case .fiveMovesGameMode:
            currentState = FiveMovesState(player: player,
                                          gameViewController: self,
                                          gameBoard: gameBoard,
                                          gameBoardView: gameboardView,
                                          markViewPrototype: player.markViewPrototype)
        }
    }
    
    private func setNextState() {
        switch GameModeSingleton.shared.gameMode {
        case .twoPlayersGameMode:
            configureTwoPlayersGameMode()
        case .playWithComputerGameMode:
            configurePlayWithComputerGameMode()
        case .fiveMovesGameMode:
            configureFiveMovesGameMode()
        }
    }
    
    func checkWithTheReferee() {
        if let winner = referee.determineWinner() {
            currentState = GameOverState(winner: winner, gameViewController: self)
            return
        }
    }
    
    func endGameCheck() {
        switch GameModeSingleton.shared.gameMode {
        case .twoPlayersGameMode:
            if counter >= 9 {
                currentState = GameOverState(winner: nil, gameViewController: self)
                return
            }
        case .playWithComputerGameMode:
            if counter >= 10 {
                currentState = GameOverState(winner: nil, gameViewController: self)
                return
            }
        case .fiveMovesGameMode:
            if counter >= 9 {
                currentState = FiveMovesFinishState(winner: nil, gameViewController: self)
                saveAllXMoves()
                saveAllOMoves()
                currentState.addAllMarks()
                checkWithTheReferee()
                currentState.end()
                return
            }
        }
    }
    
    func configureTwoPlayersGameMode() {
        checkWithTheReferee()
        endGameCheck()
        if let playerInputState = currentState as? PlayerState {
            let player = playerInputState.player.next
            currentState = PlayerState(player: player,
                                       gameViewController: self,
                                       gameBoard: gameBoard,
                                       gameBoardView: gameboardView,
                                       markViewPrototype: player.markViewPrototype)
        }
    }
    
    func configurePlayWithComputerGameMode() {
        checkWithTheReferee()
        endGameCheck()
        if let playerInputState = currentState as? PlayerState {
            let player = playerInputState.player.next
            counter += 1
            currentState = ComputerState(computer: player,
                                         gameViewController: self, gameBoard: gameBoard, gameBoardView: gameboardView, markViewPrototype: player.markViewPrototype, fieldFillingCounter: counter)
            computerPosition.setRandomPosition()
            currentState.addMark(at: computerPosition)
            self.setNextState()
        } else {
            if let playerInputState = currentState as? ComputerState {
                let player = playerInputState.player.next
                currentState = PlayerState(player: player,
                                           gameViewController: self,
                                           gameBoard: gameBoard,
                                           gameBoardView: gameboardView,
                                           markViewPrototype: player.markViewPrototype)
            }
        }
    }
    
    func configureFiveMovesGameMode() {
        endGameCheck()
        if let playerInputState = currentState as? FiveMovesState {
            let player = playerInputState.player.next
            currentState = FiveMovesState(player: player,
                                          gameViewController: self,
                                          gameBoard: gameBoard,
                                          gameBoardView: gameboardView,
                                          markViewPrototype: player.markViewPrototype)
        }
    }
    
    @IBAction func restartButtonTapped(_ sender: UIButton) {
        log(action: .restartGame)
        
        gameboardView.clear()
        gameBoard.clear()
        setFirstState()
        counter = 0
    }
}

