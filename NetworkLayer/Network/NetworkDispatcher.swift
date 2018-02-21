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

enum NetworkErrors: String, Error {
    case noData = "連線失敗"
    case nilError = "連線失敗，請重新連線"
    case noInternet = "請確認網路，是否正常"
    case jsonInitFail = "連線失敗，初始化錯誤"
}

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
                resolver.resolve(Response((defaultDataResponse.response,defaultDataResponse.data,defaultDataResponse.error), for: request), defaultDataResponse.error)
            })
        }
    }

    
}
