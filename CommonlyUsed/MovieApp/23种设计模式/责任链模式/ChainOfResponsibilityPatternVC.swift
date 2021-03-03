//
//  ChainOfResponsibilityPatternVC.swift
//  MovieApp
//
//  Created by 湛亚磊 on 2021/3/3.
//

import UIKit

class ChainOfResponsibilityPatternVC: LZBaseVC {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let loggerChan = getChainOfLoggers()
        loggerChan.logMessage(with: .INFO, with: "This is an information.")
        
        loggerChan.logMessage(with: .DEBUG, with: "This is a debug level information.")
        
        loggerChan.logMessage(with: .ERROR, with: "This is an error information.")

    }
    
    func getChainOfLoggers() -> AbstractLogger {
        let errorLogger = ErrorLogger(with: .ERROR)
        let debugLogger = DebugLogger(with: .DEBUG)
        let consoleLogger = ConsoleLogger(with: .INFO)
        
        errorLogger.nextLogger=debugLogger
        debugLogger.nextLogger = consoleLogger
        return errorLogger
    }

}
