//
//  ViewController.swift
//  Coffee
//
//  Created by Sergey Razgulyaev on 19.11.2020.
//

import UIKit

class ViewController: UIViewController {
    //MARK: - @IBOutlets
    @IBOutlet private weak var simpleCoffeePriceLabel: UILabel!
    @IBOutlet private weak var milkPriceLabel: UILabel!
    @IBOutlet private weak var whipPriceLabel: UILabel!
    @IBOutlet private weak var sugarPriceLabel: UILabel!
    @IBOutlet private weak var quantityOfMilkInOrderLabel: UILabel!
    @IBOutlet private weak var quantityOfWhipInOrderLabel: UILabel!
    @IBOutlet private weak var quantityOfSugarInOrderLabel: UILabel!
    @IBOutlet private weak var totalAmountLabel: UILabel!
    
    //MARK: - Base properties
    private var milkCount: Int = 0
    private var whipCount: Int = 0
    private var sugarCount: Int = 0
    private var simpleCoffeePrice: Int = 50
    private var milkPrice: Int = 20
    private var whipPrice: Int = 30
    private var sugarPrice: Int = 10
    private var totalAmount: Int = 50
    private var totalAmountToDisplay: Int = 0
    lazy var coffee = SimpleCoffee(cost: simpleCoffeePrice)

    //MARK: - ViewController Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()

    }
    
    //MARK: - Configuration Methods
    func configure() {
//        let simpleCoffeWithMilk = Milk(base: simpleCoffee)
        simpleCoffeePriceLabel.text = String(simpleCoffeePrice) + " cent"
        milkPriceLabel.text = String(milkPrice) + " cent"
        whipPriceLabel.text = String(whipPrice) + " cent"
        sugarPriceLabel.text = String(sugarPrice) + " cent"
        totalAmountLabel.text = "= " + String(coffee.cost) + " cent"
    }

    //MARK: - @IBActions
    @IBAction func addToOrderMilkButtonPressed(_ sender: UIButton) {
        milkCount += 1
        quantityOfMilkInOrderLabel.text = String(milkCount)
        totalAmount = Sugar(base: Whip(base: Milk(base: coffee))).cost + (milkPrice * (milkCount - 1)) + (whipPrice * (whipCount - 1)) + (sugarPrice * (sugarCount - 1))
        totalAmountLabel.text = "= " + String(totalAmount) + " cent"
    }
    
    @IBAction func removeFromOrderMilkButtonPressed(_ sender: UIButton) {
        if milkCount > 0 {
            milkCount -= 1
            quantityOfMilkInOrderLabel.text = String(milkCount)
            totalAmount = Sugar(base: Whip(base: Milk(base: coffee))).cost + (milkPrice * (milkCount - 1)) + (whipPrice * (whipCount - 1)) + (sugarPrice * (sugarCount - 1))
            totalAmountLabel.text = "= " + String(totalAmount) + " cent"
        }
        if milkCount == 0 {
            totalAmountLabel.text = "= " + String(totalAmount) + " cent"
        }
    }
    
    @IBAction func addToOrderWhipButtonPressed(_ sender: UIButton) {
        whipCount += 1
        quantityOfWhipInOrderLabel.text = String(whipCount)
        totalAmount = Sugar(base: Whip(base: Milk(base: coffee))).cost + (milkPrice * (milkCount - 1)) + (whipPrice * (whipCount - 1)) + (sugarPrice * (sugarCount - 1))
        totalAmountLabel.text = "= " + String(totalAmount) + " cent"
    }
    
    @IBAction func removeFromOrderWhipButtonPressed(_ sender: UIButton) {
        if whipCount > 0 {
            whipCount -= 1
            quantityOfWhipInOrderLabel.text = String(whipCount)
            totalAmount = Sugar(base: Whip(base: Milk(base: coffee))).cost + (milkPrice * (milkCount - 1)) + (whipPrice * (whipCount - 1)) + (sugarPrice * (sugarCount - 1))
            totalAmountLabel.text = "= " + String(totalAmount) + " cent"
        }
        if whipCount == 0 {
            totalAmountLabel.text = "= " + String(totalAmount) + " cent"
        }
    }
    
    @IBAction func addToOrderSugarButtonPressed(_ sender: UIButton) {
        sugarCount += 1
        quantityOfSugarInOrderLabel.text = String(sugarCount)
        totalAmount = Sugar(base: Whip(base: Milk(base: coffee))).cost + (milkPrice * (milkCount - 1)) + (whipPrice * (whipCount - 1)) + (sugarPrice * (sugarCount - 1))
        totalAmountLabel.text = "= " + String(totalAmount) + " cent"
    }
    
    @IBAction func removeFromOrderSugarButtonPressed(_ sender: UIButton) {
        if sugarCount > 0 {
            sugarCount -= 1
            quantityOfSugarInOrderLabel.text = String(sugarCount)
            totalAmount = Sugar(base: Whip(base: Milk(base: coffee))).cost + (milkPrice * (milkCount - 1)) + (whipPrice * (whipCount - 1)) + (sugarPrice * (sugarCount - 1))
            totalAmountLabel.text = "= " + String(totalAmount) + " cent"
        }
        if sugarCount == 0 {
            totalAmountLabel.text = "= " + String(totalAmount) + " cent"
        }
    }
    
    @IBAction func buyButtonPressed(_ sender: UIButton) {
        totalAmountToDisplay = totalAmount
        print("You bought Coffee for \(totalAmountToDisplay) cent")
        totalAmountLabel.text = "= " + String(totalAmountToDisplay) + " cent"
    }
    
    @IBAction func resetButtonPressed(_ sender: UIButton) {
        totalAmount = 50
        milkCount = 0
        whipCount = 0
        sugarCount = 0
        totalAmountLabel.text = "= " + String(totalAmount) + " cent"
        quantityOfMilkInOrderLabel.text = String(milkCount)
        quantityOfWhipInOrderLabel.text = String(whipCount)
        quantityOfSugarInOrderLabel.text = String(sugarCount)

    }
}

