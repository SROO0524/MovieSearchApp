//
//  SearchAPI.swift
//  MovieSearch
//
//  Created by 김믿음 on 2022/02/13.
//

import UIKit
import Alamofire
/*
 영화검색 API
 */
class SearchAPI: NetWorkModel {
    func search(query: String, completion: @escaping (Bool, Codable?) -> Void) {
        var param: [String:Any] = [:]
        param["query"] = query
        AF.request(baseURL, method: .get, parameters:param, encoding: URLEncoding.default, headers: headers).responseString { response in
            switch response.result {
            case .success:
//                print("getResult : ",String(decoding: response.data!, as: UTF8.self))
                guard let decodeData = try? JSONDecoder().decode(MovieSearchModel.self, from: response.data!) else { return }
//                print("decodeData: \(String(describing: decodeData))")
                completion(true,decodeData)
                print("성공")
            case .failure:
                completion(false,nil)
                print("실패", response.error as Any)
            }
        }
    }
}

