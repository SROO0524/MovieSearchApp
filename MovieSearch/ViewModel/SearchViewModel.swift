//
//  SearchViewModel.swift
//  MovieSearch
//
//  Created by 김믿음 on 2022/02/14.
//

import Foundation
import RxCocoa
import RxSwift

/*
 영화 검색 ViewModel
 */
class SearchViewModel {
    
    //MARK: Properties
    var searchModel : MovieSearchModel?
    var searchList = [MovieSearchModel.Items]()
    var totalElements : Int?
    let apiResponse = PublishSubject<Void>()
    let disposeBag = DisposeBag()
    
    //MARK: API 통신
    func getSearchList(query: String) {
        let searchAPI = SearchAPI()
        searchAPI.search(query: query) { isSuccess, model in
            if isSuccess {
                self.searchList = []
                self.searchModel = model as? MovieSearchModel
                print("검색 모델",self.searchModel)
                self.searchList.append(contentsOf: self.searchModel?.items ?? [])
                self.totalElements = self.searchModel?.total
                self.apiResponse.onNext(())
            }
        }
    }
    
    //MARK: 검색 갯수
    func getSearchListCount() -> Int {
        searchList.count
    }
    
    //MARK: 인덱스별 데이터 불러오기
    func getDetailsData(index: Int) -> MovieSearchModel.Items {
        return searchList[index]
    }
}
