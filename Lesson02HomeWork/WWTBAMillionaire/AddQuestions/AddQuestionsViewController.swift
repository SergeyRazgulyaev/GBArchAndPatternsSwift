//
//  AddQuestionsViewController.swift
//  WWTBAMillionaire
//
//  Created by Sergey Razgulyaev on 04.11.2020.
//

import UIKit

class AddQuestionsViewController: UIViewController {
    @IBOutlet private weak var userMadeQuestionTextView: UITextView!
    @IBOutlet private weak var userMadeFirstAnswerTextField: UITextField!
    @IBOutlet private weak var userMadeSecondAnswerTextField: UITextField!
    @IBOutlet private weak var userMadeThirdAnswerTextField: UITextField!
    @IBOutlet private weak var userMadeFourthAnswerTextField: UITextField!
    @IBOutlet private weak var userMadeCorrectAnswerTextField: UITextField!
    
    //MARK: - Base properties
    var userMadeQuestion = Question()
    let initialQuestionText = "Enter the Text of the User made (new) Question"
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    //MARK: - Configuration Methods
    func configure() {
        userMadeQuestionTextView.text = initialQuestionText
    }
    
    func configureUserMadeQuestion() {
        userMadeQuestion.question = userMadeQuestionTextView.text
        userMadeQuestion.firstAnswer = userMadeFirstAnswerTextField.text ?? ""
        userMadeQuestion.secondAnswer = userMadeSecondAnswerTextField.text ?? ""
        userMadeQuestion.thirdAnswer = userMadeThirdAnswerTextField.text ?? ""
        userMadeQuestion.fourthAnswer = userMadeFourthAnswerTextField.text ?? ""
        userMadeQuestion.correctAnswer = userMadeCorrectAnswerTextField.text ?? ""
    }
    
    func checkingTheCorrectnessOfTheQuestion() -> Bool {
        if userMadeQuestionTextView.text != "", userMadeQuestionTextView.text != " ", userMadeQuestionTextView.text != initialQuestionText,
           userMadeFirstAnswerTextField.text != "",
           userMadeFirstAnswerTextField.text != " ",
           userMadeSecondAnswerTextField.text != "",
           userMadeSecondAnswerTextField.text != " ",
           userMadeThirdAnswerTextField.text != "",
           userMadeThirdAnswerTextField.text != " ",
           userMadeFourthAnswerTextField.text != "",
           userMadeFourthAnswerTextField.text != " ",
           userMadeCorrectAnswerTextField.text != "",
           userMadeFirstAnswerTextField.text != userMadeSecondAnswerTextField.text,
           userMadeFirstAnswerTextField.text != userMadeThirdAnswerTextField.text,
           userMadeFirstAnswerTextField.text != userMadeFourthAnswerTextField.text,
           userMadeSecondAnswerTextField.text != userMadeThirdAnswerTextField.text,
           userMadeSecondAnswerTextField.text != userMadeFourthAnswerTextField.text,
           userMadeThirdAnswerTextField.text != userMadeFourthAnswerTextField.text,
           (userMadeCorrectAnswerTextField.text == userMadeFirstAnswerTextField.text || userMadeCorrectAnswerTextField.text == userMadeSecondAnswerTextField.text || userMadeCorrectAnswerTextField.text == userMadeThirdAnswerTextField.text || userMadeCorrectAnswerTextField.text == userMadeFourthAnswerTextField.text) {
            return true
        } else {
            return false
        }
    }
    
    //MARK: - @IBActions
    @IBAction func returnToTheGameMenuButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveAndExitButtonPressed(_ sender: UIButton) {
        configureUserMadeQuestion()
        if checkingTheCorrectnessOfTheQuestion() {
            Game.shared.addUserMadeQuestion(userMadeQuestion: userMadeQuestion)
            self.dismiss(animated: true, completion: nil)
        } else {
            print("The Question is incorrectly written")
        }
    }
    
    @IBAction func deleteAllUserMadeQuestionsButtonPressed(_ sender: UIButton) {
        Game.shared.clearAllUserMadeQuestions()
        self.dismiss(animated: true, completion: nil)
    }
}
