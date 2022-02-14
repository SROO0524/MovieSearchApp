//
//  MovieListTableViewCell.swift
//  MovieSearch
//
//  Created by 김믿음 on 2022/02/12.
//

import UIKit
import Kingfisher
/*
 TablaView CustomCell
 */
class MovieListTableViewCell: UITableViewCell {

    //MARK: Properties
    let movieImage = UIImageView()
    let movieTitle = UILabel()
    let directorLabel = UILabel()
    let actorLabel = UILabel()
    let rateLabel = UILabel()
    let favoriteButton = UIButton()
    
    //MARK: Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setLaytout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: SetLayout
    func setLaytout() {
        addSubview(movieImage)
        movieImage.image = UIImage.init(named: "언차티드포스터")
        movieImage.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).offset(10)
            make.bottom.equalTo(self.snp.bottom).inset(10)
            make.leading.equalTo(self.snp.leading)
            make.height.equalTo(65)
            make.width.equalTo(50)
        }
        
        addSubview(favoriteButton)
        favoriteButton.imageView?.tintColor = .systemYellow
        favoriteButton.setImage(UIImage.init(systemName: "star.fill"), for: .normal)
        favoriteButton.snp.makeConstraints { make in
            make.top.equalTo(movieImage.snp.top)
            make.trailing.equalTo(self.snp.trailing)
            make.height.width.equalTo(16)
        }
        
        favoriteButton.addTarget(self, action: <#T##Selector#>, for: <#T##UIControl.Event#>)
        
        addSubview(movieTitle)
        movieTitle.text = "언차티드"
        movieTitle.textColor = .black
        movieTitle.font = UIFont.boldSystemFont(ofSize: 14)
        movieTitle.snp.makeConstraints { make in
            make.top.equalTo(movieImage.snp.top)
            make.leading.equalTo(movieImage.snp.trailing).offset(10)
            make.trailing.equalTo(favoriteButton.snp.leading).inset(10)
        }

        addSubview(directorLabel)
        directorLabel.text = "감독: 루벤 플러셔"
        directorLabel.font = UIFont.systemFont(ofSize: 12)
        directorLabel.snp.makeConstraints { make in
            make.top.equalTo(movieTitle.snp.bottom).offset(2)
            make.leading.equalTo(movieTitle.snp.leading)
            make.trailing.equalTo(self.snp.trailing)
        }
        
        addSubview(actorLabel)
        actorLabel.text = "출연: 톰 홀랜드, 마크 윌버그, 소피아 테일러 알리, 소피아 테일러 알리, 소피아 테일러 알리"
        actorLabel.font = UIFont.systemFont(ofSize: 12)
        actorLabel.snp.makeConstraints { make in
            make.top.equalTo(directorLabel.snp.bottom).offset(2)
            make.leading.equalTo(directorLabel.snp.leading)
            make.trailing.equalTo(self.snp.trailing)
        }
        
        addSubview(rateLabel)
        rateLabel.text = "평점: 8.8"
        rateLabel.font = UIFont.systemFont(ofSize: 12)
        rateLabel.snp.makeConstraints { make in
            make.top.equalTo(actorLabel.snp.bottom).offset(2)
            make.leading.equalTo(actorLabel.snp.leading)
            make.trailing.equalTo(self.snp.trailing)
            make.bottom.equalTo(movieImage.snp.bottom)
        }
    }
    
    //MARK: Cell 데이터 바인딩
    func bindingCellData(movieModel: MovieSearchModel.Items) {
        let url = URL(string: movieModel.image ?? "")
        movieImage.kf.setImage(with: url)
        
        movieTitle.text = movieModel.title
        movieTitle.text = CommonFunc.formateStringData(string: movieModel.title ?? "")
//        favoriteButton
        directorLabel.text = "감독: \(movieModel.director ?? "")"
        actorLabel.text = "출연: \(movieModel.actor ?? "")"
        rateLabel.text = "평점: \(movieModel.userRating ?? "")"
    }
}
