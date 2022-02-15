//
//  FavoriteListViewController.swift
//  MovieSearch
//
//  Created by 김믿음 on 2022/02/12.
//

import UIKit
import SnapKit
import RealmSwift
import CoreAudio

/*
 즐겨찾기 리스트
 */

class FavoriteListViewController: UIViewController {
    
    //MARK: Properties
    let tableView = MovieListTableView()
    let favoriteViewModel = FavoriteViewModel.instance
    var movie: [MovieRealmModel] = []

    //MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.movie = Array(favoriteViewModel.getFavorites())
        navigationItem.title = "즐겨찾기 목록"
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage.init(systemName: "xmark"), style: .plain, target: self, action: #selector(cancleBTTap))
        navigationItem.leftBarButtonItem?.tintColor = .black
        view.backgroundColor = .white
        setTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.movie = Array(favoriteViewModel.getFavorites())
        tableView.reloadData()
    }
    
    //MARK: @objc
    @objc func cancleBTTap() {
        navigationController?.popViewController(animated: true)
    }
    
    //MARK: TableView Set
    func setTableView() {
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(8)
            make.trailing.equalTo(view.safeAreaLayoutGuide).inset(8)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

//MARK: Extension
extension FavoriteListViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movie.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let listCell = tableView.dequeueReusableCell(withIdentifier: "MovieListTableViewCell") as! MovieListTableViewCell
        
        let movieData = movie[indexPath.row]
        listCell.movieTitle.text =  movieData.title
        listCell.directorLabel.text = movieData.director
        listCell.actorLabel.text = movieData.actor
        listCell.rateLabel.text = movieData.userRating
        listCell.link.text = movieData.link
        let url = URL(string: movieData.image)
        listCell.movieImage.kf.setImage(with: url)
        listCell.favoriteButton.imageView?.tintColor = .systemYellow
    
        return listCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movieDetailVC = MovieDetailViewController()
        let cell = tableView.cellForRow(at: indexPath) as! MovieListTableViewCell
        
        /// 클릭시 셀의 정보를 다음 VC 에 전달
        let movieModel = self.movie[indexPath.row]
        let detailModel = MovieDetailModel(
            id : movieModel.id,
            title : movieModel.title,
            director: movieModel.director,
            actor: movieModel.actor,
            userRating: movieModel.userRating,
            image: movieModel.image,
            link: movieModel.link,
            isFavorite: self.favoriteViewModel.isFavoriteMovie(movieFromDb: movieModel))
        movieDetailVC.movie = detailModel
        
        
        navigationController?.pushViewController(movieDetailVC, animated: true)
    }
}
