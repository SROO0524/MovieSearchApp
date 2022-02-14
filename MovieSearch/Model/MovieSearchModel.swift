//
//  MovieListModel.swift
//  MovieSearch
//
//  Created by 김믿음 on 2022/02/13.
//

import Foundation
/*
 영화 목록 Model
 */
struct MovieSearchModel: Codable {
    var lastBuildDate: String?
    var total: Int?
    var start: Int?
    var display: Int?
    var items: [Items]?
    
    struct Items: Codable {
        var title: String?
        var link: String?
        var image : String?
        var subtitle : String?
        var pubDate : String?
        var director : String?
        var actor : String?
        var userRating : String?
    }
}


