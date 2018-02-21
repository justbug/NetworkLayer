//
//  Request.swift
//  NetworkLayer
//
//  Created by  SNT on 2018/2/21.
//  Copyright © 2018年 ezpay. All rights reserved.
//

import Foundation
import Alamofire

protocol Request{
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: [String:String]? { get }
    var parameters: [String:Any]? { get }
}

extension Request {
    // init Request
    var method: HTTPMethod { return .post }
    var headers: [String:String]? { return ["Content-Type":"application/json", "AccessToken": ""] }
}
