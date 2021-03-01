//
//  BuilderPatternVC.swift
//  MovieApp
//
//  Created by 湛亚磊 on 2021/3/1.
//

import UIKit

class BuilderPatternVC: LZBaseVC {

    override func viewDidLoad() {
        super.viewDidLoad()
        let mealBuilder = MealBuilder()
        print("-------Veg Meal-------")
        let vegMeal = mealBuilder.prepareVegMeal()
        vegMeal.showItems()
        print("总价格是:\(vegMeal.getCost())")
        
        let nonVegMeal = mealBuilder.prepareNonVegMeal()
        print("-------Non-Veg Meal-------")
        print("Non-Veg Meal")
        nonVegMeal.showItems()
        print("总价格:\(nonVegMeal.getCost())")
    }
}
