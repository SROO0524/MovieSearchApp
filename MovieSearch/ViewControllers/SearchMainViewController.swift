//
//  ViewController.swift
//  MovieSearch
//
//  Created by 김믿음 on 2022/02/10.
//

import UIKit
import SnapKit

/*
 영화 검색 메인 VC
 */

class SearchMainViewController: UIViewController,UISearchBarDelegate {
    
    //MARK: Properties
    let searchLabel = UILabel()
    let searchBar = UISearchBar()
    let tableView = MovieListTableView()
    let searchViewModel = SearchViewModel()
    let favoriteViewModel = FavoriteViewModel.instance

    var movie: MovieRealmModel?
    
    //MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setNav()
        setSearchBar()
        setTableView()
        setBinding()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }

    
    // MARK: Navigation 세팅
    func setNav() {
        navigationController?.navigationBar.backgroundColor = .systemBackground
        
        let leftButton = UIBarButtonItem(title: "네이버 영화검색", style: .plain, target: self, action: .none)
        leftButton.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20)], for: .normal)
        navigationItem.leftBarButtonItem = leftButton
        navigationItem.leftBarButtonItem?.tintColor = .black
        
        let rightButton = UIButton()
        rightButton.layer.borderColor = UIColor.lightGray.cgColor
        rightButton.layer.borderWidth = 1
        
        rightButton.setImage(UIImage.init(systemName: "star.fill"), for: .normal)
        rightButton.imageView?.tintColor = .systemYellow
        
        rightButton.setTitle("즐겨찾기", for: .normal)
        rightButton.setTitleColor(.black, for: .normal)
        rightButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        rightButton.titleLabel?.font = .systemFont(ofSize: 15)
        rightButton.addTarget(self, action: #selector(favoriteBTTap), for: .touchUpInside)
        
        rightButton.snp.makeConstraints { make in
            make.height.equalTo(30)
            make.width.equalTo(100)
        }
        
        let barButton = UIBarButtonItem(customView: rightButton)
        navigationItem.rightBarButtonItem = barButton
    }
    
    @objc func favoriteBTTap() {
        let favoriteListVC = FavoriteListViewController()
        navigationController?.pushViewController(favoriteListVC, animated: true)
    }
    
    //MARK: SearchBar Set
    func setSearchBar() {
        searchBar.delegate = self
        
        view.addSubview(searchBar)
        searchBar.layer.cornerRadius = 2
        searchBar.layer.borderColor = UIColor.white.cgColor
        searchBar.layer.borderWidth = 1
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    // 텍스트가 변경되기 시작하면 테이블 리로드
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
//        tableView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchBar.becomeFirstResponder()
//        tableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        guard let searchText = searchBar.text else { return }
        searchViewModel.getSearchList(query: searchText)
    }

    func setBinding() {
        searchViewModel.apiResponse.bind(onNext: { [weak self]  in
            // 데이터를 가져온 후에 테이블 리로드
            self?.tableView.reloadData()
        }).disposed(by: searchViewModel.disposeBag)
    }
    
    
    //MARK: TableView Set
    func setTableView() {
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(55)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(8)
            make.trailing.equalTo(view.safeAreaLayoutGuide).inset(8)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

//MARK: Extension
extension SearchMainViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchViewModel.getSearchListCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let listCell = tableView.dequeueReusableCell(withIdentifier: "MovieListTableViewCell") as! MovieListTableViewCell
        let movieModel = searchViewModel.getDetailsData(index: indexPath.row)
        
        listCell.bindingCellData(movieModel: movieModel, isFavorite: self.favoriteViewModel.isFavoriteMovie(movieFromHttp: movieModel))
        return listCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movieDetailVC = MovieDetailViewController()
        let cell = tableView.cellForRow(at: indexPath) as! MovieListTableViewCell
        
        print("🌴 클릭 영화 데이터", cell.directorLabel.text ?? "")
    
        let movieModel = searchViewModel.getDetailsData(index: indexPath.row)
        let detailModel = MovieDetailModel(
            title : movieModel.title ?? "",
            director: movieModel.director ?? "",
            actor: movieModel.actor ?? "",
            userRating: movieModel.userRating ?? "",
            image: movieModel.image ?? "",
            link: movieModel.link ?? "",
            isFavorite: self.favoriteViewModel.isFavoriteMovie(movieFromHttp: movieModel))
        movieDetailVC.movie = detailModel
        navigationController?.pushViewController(movieDetailVC, animated: true)
    }
}

