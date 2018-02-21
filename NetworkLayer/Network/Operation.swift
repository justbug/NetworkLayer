//
//  Operation.swift
//  NetworkLayer
//
//  Created by  SNT on 2018/2/21.
//  Copyright © 2018年 ezpay. All rights reserved.
//

import Foundation
import PromiseKit
import SwiftyJSON
import Reachability

protocol Operation {
    associatedtype Result
    
    var request: Request { get }
    func execute(in dispatcher: Dispatcher) -> Promise<Result>
    func checkInternet() -> Bool
}

extension Operation {
    func checkInternet() -> Bool{
        guard let reachability = Reachability() else { return false }
        if reachability.connection == .none { return false }
        return true
    }
}
