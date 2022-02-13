//
//  MoviewDetailTopView.swift
//  MovieSearch
//
//  Created by 김믿음 on 2022/02/13.
//

import UIKit
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
    
    //MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: SetLayout
    func setLayout() {
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
        favoriteButton.imageView?.tintColor = .systemYellow
        favoriteButton.setImage(UIImage.init(systemName: "star.fill"), for: .normal)
        favoriteButton.snp.makeConstraints { make in
            make.top.equalTo(movieImage.snp.top).offset(5)
            make.trailing.equalTo(self.snp.trailing).inset(10)
            make.height.width.equalTo(16)
        }
        
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
    }
    
}
