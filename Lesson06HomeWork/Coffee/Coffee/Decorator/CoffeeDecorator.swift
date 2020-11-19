//
//  CoffeeDecorator.swift
//  Coffee
//
//  Created by Sergey Razgulyaev on 19.11.2020.
//

import Foundation

protocol Coffee {
    var cost: Int { get }
}

protocol CoffeeDecorator: Coffee {
    var base: Coffee { get }
    init(base: Coffee)
}

class SimpleCoffee: Coffee {
    var cost: Int
    init(cost: Int) {
        self.cost = cost
    }
}

class Milk: CoffeeDecorator {
    var base: Coffee
    required init(base: Coffee) {
        self.base = base
    }
    lazy var cost: Int = base.cost + 200
}

class Whip: CoffeeDecorator {
    var base: Coffee
    required init(base: Coffee) {
        self.base = base
    }
    lazy var cost: Int = base.cost + 300
}

class Sugar: CoffeeDecorator {
    var base: Coffee
    required init(base: Coffee) {
        self.base = base
    }
    lazy var cost: Int = base.cost + 100
}


