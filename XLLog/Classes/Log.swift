//
//  Log.swift
//  XLTongHuaCaculateSwift
//
//  Created by Liang Xiang on 29/09/2022.
//

import UIKit


public enum kModuleName : String {
    case VC = "ViewController"
    case NW = "NetWork";
    case DB = "DataBase";
}

public protocol logProtocol {
    func log(_ message: String)
}

public class Log: NSObject {
    static var loggerS : Array< logProtocol > = []
    
    public static func add(_ logger: logProtocol) {
        loggerS.append(logger)
    }
    
    public static func startWith(_ loggers:[logProtocol]) {
        loggerS.append(contentsOf: loggers)
    }
    
    public static func verbose<T>(_ moduleName: kModuleName, _ message: T, file: String = #file, function: String = #function, line: Int = #line) {
        let fileName = (file as NSString).lastPathComponent
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS"
        let dateStr = formatter.string(from: Date())
        let logStr = "------> \(moduleName) [V] \(dateStr) [\(fileName):\(line) \(function)] || \(message)"
        for logger in loggerS {
            logger.log(logStr)
        }
    }
    public static func debug<T>(_ moduleName: kModuleName, _ message: T, file: String = #file, function: String = #function, line: Int = #line) {
        let fileName = (file as NSString).lastPathComponent
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS"
        let dateStr = formatter.string(from: Date())
        let logStr = "------> \(moduleName) [D] \(dateStr) [\(fileName):\(line) \(function)] || \(message)"
        for logger in loggerS {
            logger.log(logStr)
        }
    }
    public static func info<T>(_ moduleName: kModuleName, _ message: T, file: String = #file, function: String = #function, line: Int = #line) {
        let fileName = (file as NSString).lastPathComponent
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS"
        let dateStr = formatter.string(from: Date())
        let logStr = "------> \(moduleName) [I] \(dateStr) [\(fileName):\(line) \(function)] || \(message)"
        for logger in loggerS {
            logger.log(logStr)
        }
    }
    public static func warn<T>(_ moduleName: kModuleName, _ message: T, file: String = #file, function: String = #function, line: Int = #line) {
        let fileName = (file as NSString).lastPathComponent
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS"
        let dateStr = formatter.string(from: Date())
        let logStr = "------> \(moduleName) [W] \(dateStr) [\(fileName):\(line) \(function)] || \(message)"
        for logger in loggerS {
            logger.log(logStr)
        }
    }
    public static func error<T>(_ moduleName: kModuleName, _ message: T, file: String = #file, function: String = #function, line: Int = #line) {
        let fileName = (file as NSString).lastPathComponent
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS"
        let dateStr = formatter.string(from: Date())
        let logStr = "------> \(moduleName) [E] \(dateStr) [\(fileName):\(line) \(function)] || \(message)"
        for logger in loggerS {
            logger.log(logStr)
        }
    }
}

public class ConsoleLogger: NSObject, logProtocol {
    public static let shared = ConsoleLogger()
    public func log(_ message: String) {
        print(message)
    }
}
