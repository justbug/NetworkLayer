//
//  Response.swift
//  NetworkLayer
//
//  Created by  SNT on 2018/2/21.
//  Copyright © 2018年 ezpay. All rights reserved.
//

import Foundation
import SwiftyJSON

enum Response {
    case json(_: JSON)
    case error( _: NetworkErrors)
    
    init(_ response: (urlResponse: HTTPURLResponse?, data: Data?, error: Error?), for request: Request) {
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
