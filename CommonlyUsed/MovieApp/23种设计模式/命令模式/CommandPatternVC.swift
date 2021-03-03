//
//  CommandPatternVC.swift
//  MovieApp
//
//  Created by 湛亚磊 on 2021/3/3.
//

import UIKit

class CommandPatternVC: LZBaseVC {

    override func viewDidLoad() {
        super.viewDidLoad()

        let abcStock = Stock()
        
        let buyStockOrder = BuyStock(with: abcStock)
        let sellStockOrder = SellStock(with: abcStock)
        
        let broker = Broker()
        broker.takeOrder(with: buyStockOrder)
        broker.takeOrder(with: sellStockOrder)
        
        broker.placeOrders()
    }

}
