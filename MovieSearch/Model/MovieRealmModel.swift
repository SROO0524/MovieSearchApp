//
//  MovieRealmModel.swift
//  MovieSearch
//
//  Created by 김믿음 on 2022/02/14.
//

import Foundation
import RealmSwift

class MovieRealmModel: Object {
    @objc dynamic var id = ""
    @objc dynamic var title  = ""
    @objc dynamic var director = ""
    @objc dynamic var actor = ""
    @objc dynamic var userRating = ""
    @objc dynamic var image = ""
    @objc dynamic var link = ""
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
