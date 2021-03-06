//
//  CompositePatternVC.swift
//  MovieApp
//
//  Created by 湛亚磊 on 2021/3/6.
//

import UIKit

class CompositePatternVC: LZBaseVC {

    override func viewDidLoad() {
        super.viewDidLoad()
        let CEO = Employee(with: "John", with: "CEO", with: 30000)
        let headSales = Employee(with: "Robert", with: "Head Sales", with: 20000)
        let headMarketing = Employee(with: "Michel", with: "Head Marketing", with: 20000)
        
        let clerk1 = Employee(with: "Laura", with: "Marketing", with: 10000)
        let clerk2 = Employee(with: "Bob", with: "Marketing", with: 10000)
        
        let salesExecutive1 = Employee(with: "Richard", with: "Sales", with: 10000)
        let salesExecutive2 = Employee(with: "Rob", with: "Sales", with: 10000)
        
        CEO.add(with: headSales)
        CEO.add(with: headMarketing)
        
        headSales.add(with: salesExecutive1)
        headSales.add(with: salesExecutive2)
        
        headMarketing.add(with: clerk1)
        headMarketing.add(with: clerk2)
        
        //打印该组织的所有员工
        print(CEO.toString())
        if let headList =  CEO.getSubordinates(){
            for headEmployee in headList {
                print(headEmployee.toString())
                if let employeeList = headEmployee.getSubordinates() {
                    for employee in employeeList {
                        print(employee.toString())
                    }
                }
            }
        }
    }

}
