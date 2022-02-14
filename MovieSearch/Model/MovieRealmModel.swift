//
//  MovieRealmModel.swift
//  MovieSearch
//
//  Created by 김믿음 on 2022/02/14.
//

import Foundation
import RealmSwift

class MovieRealmModel: Object {
    @objc dynamic var title  = ""
    @objc dynamic var director = ""
    @objc dynamic var actor = ""
    @objc dynamic var link = ""
    @objc dynamic var favorite = false
    
    override static func primaryKey() -> String? {
        return "title"
    }
}
