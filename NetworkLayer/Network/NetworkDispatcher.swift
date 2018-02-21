//
//  NetworkDispatcher.swift
//  NetworkLayer
//
//  Created by  SNT on 2018/2/21.
//  Copyright © 2018年 ezpay. All rights reserved.
//

import Foundation
import PromiseKit
import Alamofire
import SwiftyJSON



protocol Dispatcher {
    //base url
    init(host: String)
    func execute(request: Request) -> Promise<Response>
}

class NetworkDispatcher: Dispatcher {
    private let baseUrl: String
    
    required init(host: String) {
        self.baseUrl = host
    }
    
    public func execute(request: Request) -> Promise<Response> {
        return Promise<Response> { resolver in
            Alamofire.request("\(baseUrl)\(request.path)", method: request.method, parameters: request.parameters, encoding: JSONEncoding.default, headers: request.headers).response(completionHandler: { (defaultDataResponse) in
                resolver.fulfill(Response((defaultDataResponse.response,defaultDataResponse.data,defaultDataResponse.error)))
            })
        }
    }

    
}
