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
    private var simpleCoffeePrice: Int = 500
    private var milkPrice: Int = 200
    private var whipPrice: Int = 300
    private var sugarPrice: Int = 100
    private var totalAmount: Int = 500
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
        simpleCoffeePriceLabel.text = String(simpleCoffeePrice)
        milkPriceLabel.text = String(milkPrice)
        whipPriceLabel.text = String(whipPrice)
        sugarPriceLabel.text = String(sugarPrice)
        totalAmountLabel.text = String(coffee.cost)
    }

    //MARK: - @IBActions
    @IBAction func addToOrderMilkButtonPressed(_ sender: UIButton) {
        milkCount += 1
        quantityOfMilkInOrderLabel.text = String(milkCount)
//        totalAmount = Milk(base: coffee).cost + (milkPrice * (milkCount - 1))
        totalAmount = Sugar(base: Whip(base: Milk(base: coffee))).cost + (milkPrice * (milkCount - 1)) + (whipPrice * (whipCount - 1)) + (sugarPrice * (sugarCount - 1))
        totalAmountLabel.text = String(totalAmount)
    }
    
    @IBAction func removeFromOrderMilkButtonPressed(_ sender: UIButton) {
        if milkCount > 0 {
            milkCount -= 1
            quantityOfMilkInOrderLabel.text = String(milkCount)
//            totalAmount = Milk(base: coffee).cost + (milkPrice * (milkCount - 1))
            totalAmount = Sugar(base: Whip(base: Milk(base: coffee))).cost + (milkPrice * (milkCount - 1)) + (whipPrice * (whipCount - 1)) + (sugarPrice * (sugarCount - 1))
            totalAmountLabel.text = String(totalAmount)
        }
        if milkCount == 0 {
            totalAmountLabel.text = String(totalAmount)
        }
    }
    
    @IBAction func addToOrderWhipButtonPressed(_ sender: UIButton) {
        whipCount += 1
        quantityOfWhipInOrderLabel.text = String(whipCount)
//        totalAmount = Whip(base: coffee).cost + (whipPrice * (whipCount - 1))
        totalAmount = Sugar(base: Whip(base: Milk(base: coffee))).cost + (milkPrice * (milkCount - 1)) + (whipPrice * (whipCount - 1)) + (sugarPrice * (sugarCount - 1))
        totalAmountLabel.text = String(totalAmount)
    }
    
    @IBAction func removeFromOrderWhipButtonPressed(_ sender: UIButton) {
        if whipCount > 0 {
            whipCount -= 1
            quantityOfWhipInOrderLabel.text = String(whipCount)
            totalAmount = Sugar(base: Whip(base: Milk(base: coffee))).cost + (milkPrice * (milkCount - 1)) + (whipPrice * (whipCount - 1)) + (sugarPrice * (sugarCount - 1))
            totalAmountLabel.text = String(totalAmount)
        }
        if whipCount == 0 {
            totalAmountLabel.text = String(totalAmount)
        }
    }
    
    @IBAction func addToOrderSugarButtonPressed(_ sender: UIButton) {
        sugarCount += 1
        quantityOfSugarInOrderLabel.text = String(sugarCount)
//        totalAmount = Sugar(base: coffee).cost + (sugarPrice * (sugarCount - 1))
        totalAmount = Sugar(base: Whip(base: Milk(base: coffee))).cost + (milkPrice * (milkCount - 1)) + (whipPrice * (whipCount - 1)) + (sugarPrice * (sugarCount - 1))
        totalAmountLabel.text = String(totalAmount)
    }
    
    @IBAction func removeFromOrderSugarButtonPressed(_ sender: UIButton) {
        if sugarCount > 0 {
            sugarCount -= 1
            quantityOfSugarInOrderLabel.text = String(sugarCount)
            totalAmount = Sugar(base: Whip(base: Milk(base: coffee))).cost + (milkPrice * (milkCount - 1)) + (whipPrice * (whipCount - 1)) + (sugarPrice * (sugarCount - 1))
            totalAmountLabel.text = String(totalAmount)
        }
        if sugarCount == 0 {
            totalAmountLabel.text = String(totalAmount)
        }
    }
    
    @IBAction func buyButtonPressed(_ sender: UIButton) {
        totalAmountToDisplay = totalAmount
        print("You bought Coffee for \(totalAmountToDisplay)")
        totalAmountLabel.text = String(totalAmountToDisplay)
    }
    
    @IBAction func resetButtonPressed(_ sender: UIButton) {
        totalAmount = 500
        milkCount = 0
        whipCount = 0
        sugarCount = 0
        totalAmountLabel.text = String(totalAmount)
        quantityOfMilkInOrderLabel.text = String(milkCount)
        quantityOfWhipInOrderLabel.text = String(whipCount)
        quantityOfSugarInOrderLabel.text = String(sugarCount)

    }
}

