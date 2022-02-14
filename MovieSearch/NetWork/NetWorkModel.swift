//
//  NetWorkModel.swift
//  MovieSearch
//
//  Created by 김믿음 on 2022/02/13.
//

import UIKit
import Alamofire
/*
 네이버 API Header 및 URL
 */
class NetWorkModel {
    let baseURL = "https://openapi.naver.com/v1/search/movie.json"
    var headers : HTTPHeaders = [
        "X-Naver-Client-Id": "CL8FxWqGckBm4isPxeSE",
        "X-Naver-Client-Secret": "9_Q_ftV4oi"
    ]
}
