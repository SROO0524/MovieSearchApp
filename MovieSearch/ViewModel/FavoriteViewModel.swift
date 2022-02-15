//
//  Favorite.swift
//  즐겨찾기 처리
//
//  Created by 김믿음 on 2022/02/14.
//

import Foundation
import RealmSwift
import CryptoKit

/*
 영화 검색 ViewModel
 */
class FavoriteViewModel {
    static let instance = FavoriteViewModel()
    
    //MARK: Properties
    private let realm = try! Realm()
    private var favoriteIds: [String] = []
    
    private init() {
        print("😀realmURL\(Realm.Configuration.defaultConfiguration.fileURL)")
        self.favoriteIds = self.getFavoriteIds()
    }
    
    //MARK: id를 통해 즐겨찾기 가져오기
    func getFromFavorite(_ id: String) -> MovieRealmModel? {
        return self.realm.object(ofType: MovieRealmModel.self, forPrimaryKey: id)
    }
    
    //MARK: 영화를 즐겨찾기에 추가
    func addFromFavorite(_ movie: MovieRealmModel) {
        try! self.realm.write {
            self.realm.add(movie)
            self.favoriteIds.append(movie.id)
        }
    }
    //MARK: 영화를 즐겨찾기에서 제거
    func deleteFromFavorite(_ movie: MovieRealmModel) {
        try! self.realm.write {
            if let index = self.favoriteIds.firstIndex(of: movie.id) {
                self.favoriteIds.remove(at: index)
            }
            self.realm.delete(movie)
            
            
        }
    }
    
    //MARK: realm data를 구분할수 있도록 고유값인 Hash를 ID 값으로 설정
    func getHashedId(_ link: String) -> String {
        let data = link.data(using: .utf8)
        let sha256 = SHA256.hash(data: data!)
        return sha256.compactMap{String(format: "%02x", $0)}.joined()
    }
    
    //MARK: 즐겨찾기 영화인지 확인 by id
    func isFavoriteMovie(id: String) -> Bool {
        return self.favoriteIds.contains(id)
    }
    
    //MARK: 즐겨찾기 영화인지 확인 by 네이버 api 모델
    func isFavoriteMovie(movieFromHttp movie: MovieSearchModel.Items) -> Bool {
        return self.favoriteIds.contains(self.getHashedId(movie.link!))
    }
    
    //MARK: 즐겨찾기 영화인지 확인 by DB model
    func isFavoriteMovie(movieFromDb movie: MovieRealmModel) -> Bool {
        return self.favoriteIds.contains(movie.id)
    }
    
    //MARK: 즐겨찾기 된 영화들 가져오기
    func getFavorites() -> Results<MovieRealmModel> {
        return self.realm.objects(MovieRealmModel.self)
    }
    
    func getFavoriteIds() -> [String] {
        let favorites = self.getFavorites()
        var favIds: [String] = []
        for fav in favorites {
            favIds.append(fav.id)
        }
        return favIds
    }
}
