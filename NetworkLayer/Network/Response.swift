//
//  Response.swift
//  NetworkLayer
//
//  Created by  SNT on 2018/2/21.
//  Copyright © 2018年 ezpay. All rights reserved.
//

import Foundation
import SwiftyJSON

enum NetworkErrors: String, Error {
    case noData = "連線失敗"
    case nilError = "連線失敗，請重新連線"
    case noInternet = "請確認網路，是否正常"
    case jsonInitFail = "連線失敗，回傳初始化錯誤"
}

enum Response {
    case json(_: JSON)
    case error( _: NetworkErrors)
    
    init(_ response: (urlResponse: HTTPURLResponse?, data: Data?, error: Error?)) {
        guard response.urlResponse?.statusCode == 200, response.error == nil else {
            self = .error(NetworkErrors.nilError)
            return
        }
        guard let data = response.data else {
            self = .error(NetworkErrors.noData)
            return
        }
        do {
            self = .json(try JSON(data: data))
        } catch {
            self = .error(NetworkErrors.jsonInitFail)
        }
    }
}
