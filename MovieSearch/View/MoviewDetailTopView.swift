//
//  MoviewDetailTopView.swift
//  MovieSearch
//
//  Created by 김믿음 on 2022/02/13.
//

import UIKit
import RealmSwift
import CryptoKit

/*
 영화 상세 상단 정보 커스텀뷰
 */
class MoviewDetailTopView: UIView {
    
    //MARK: Properties
    let movieImage = UIImageView()
    let directorLabel = UILabel()
    let actorLabel = UILabel()
    let rateLabel = UILabel()
    let favoriteButton = UIButton()
    let favoriteViewModel = FavoriteViewModel.instance
    var movie: MovieDetailModel? = nil
        
    //MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: SetLayout
    func setLayout(_ movie: MovieDetailModel) {
        backgroundColor = .white
        addSubview(movieImage)
        movieImage.image = UIImage.init(named: "언차티드포스터")
        movieImage.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).offset(10)
            make.bottom.equalTo(self.snp.bottom).inset(10)
            make.leading.equalTo(self.snp.leading).offset(10)
            make.height.equalTo(65)
            make.width.equalTo(50)
        }
        
        addSubview(favoriteButton)
        favoriteButton.imageView?.tintColor = movie.isFavorite ? .systemYellow : .gray
        favoriteButton.isSelected = movie.isFavorite
        
        favoriteButton.setImage(UIImage.init(systemName: "star.fill"), for: .normal)
        favoriteButton.snp.makeConstraints { make in
            make.top.equalTo(movieImage.snp.top).offset(5)
            make.trailing.equalTo(self.snp.trailing).inset(10)
            make.height.width.equalTo(16)
        }
        
        favoriteButton.addTarget(self, action: #selector(favoriteBTClicked), for: .touchUpInside)
        
        addSubview(directorLabel)
        directorLabel.text = "감독: 루벤 플러셔"
        directorLabel.font = UIFont.systemFont(ofSize: 12)
        directorLabel.snp.makeConstraints { make in
            make.top.equalTo(movieImage.snp.top).offset(5)
            make.leading.equalTo(movieImage.snp.trailing).offset(10)
            make.trailing.equalTo(self.snp.trailing)
        }
        
        addSubview(actorLabel)
        actorLabel.text = "출연: 톰 홀랜드, 마크 윌버그, 소피아 테일러 알리, 소피아 테일러 알리, 소피아 테일러 알리"
        actorLabel.font = UIFont.systemFont(ofSize: 12)
        actorLabel.snp.makeConstraints { make in
            make.centerY.equalTo(movieImage.snp.centerY)
            make.leading.equalTo(directorLabel.snp.leading)
            make.trailing.equalTo(self.snp.trailing).inset(10)
        }
        
        addSubview(rateLabel)
        rateLabel.text = "평점: 8.8"
        rateLabel.font = UIFont.systemFont(ofSize: 12)
        rateLabel.snp.makeConstraints { make in
            make.leading.equalTo(actorLabel.snp.leading)
            make.trailing.equalTo(self.snp.trailing)
            make.bottom.equalTo(movieImage.snp.bottom).inset(5)
        }
        draw(movie)
    }
    
    func draw(_ movie: MovieDetailModel) {
        let url = URL(string: movie.image)
        self.movieImage.kf.setImage(with: url)
        self.actorLabel.text = "출연 : \(movie.actor)"
        self.rateLabel.text = "평점 : \(movie.userRating)"
        self.directorLabel.text = "감독 : \(movie.director)"
    }
    
    //MARK: 즐겨찾기 클릭
    @objc func favoriteBTClicked(_ sender: UIButton) {
        let id = self.favoriteViewModel.getHashedId(self.movie!.link)
        if movie!.isFavorite == false {
            let movieModel = MovieRealmModel()
            movieModel.title = self.movie!.title
            movieModel.actor = self.movie!.title
            movieModel.director = self.movie!.title
            movieModel.link = self.movie!.link
            movieModel.id = id
            movieModel.userRating = self.movie!.userRating
            movieModel.image = self.movie!.image
            self.favoriteViewModel.addFromFavorite(movieModel)
            favoriteButton.imageView?.tintColor = .systemYellow
        } else {
            
            let movieModel = self.favoriteViewModel.getFromFavorite(id)
            self.favoriteViewModel.deleteFromFavorite(movieModel!)
            favoriteButton.imageView?.tintColor = .gray
        }
        favoriteButton.isSelected = self.movie!.isFavorite
    }
}
