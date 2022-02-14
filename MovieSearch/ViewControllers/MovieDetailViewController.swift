//
//  MoviewDetailViewController.swift
//  MovieSearch
//
//  Created by 김믿음 on 2022/02/12.
//

import UIKit
import WebKit
/*
 영화 상세 화면
 */
class MovieDetailViewController: UIViewController {

    //MARK: Properties
    let movieInfoHeaderView = MoviewDetailTopView()
    let moviewWebView = MovieWebView()
    
    //MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setNav()
        setLayout()
    }
    
    @objc func backBTTap() {
        navigationController?.popViewController(animated: true)
    }
    
    //MARK: SetNav
    func setNav() {
        navigationItem.title = "언차티드"
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage.init(systemName: "chevron.backward"), style: .plain, target: self, action: #selector(backBTTap))
        navigationItem.leftBarButtonItem?.tintColor = .black
        navigationController?.navigationBar.barTintColor = .white
    }
    
    //MARK: SetLayout
    func setLayout() {
        view.addSubview(movieInfoHeaderView)
        movieInfoHeaderView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp
                                .top)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp
                                    .leading)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp
                                    .trailing)
            make.height.equalTo(100)
        }
        
        view.addSubview(moviewWebView)
        moviewWebView.snp.makeConstraints { make in
            make.top.equalTo(movieInfoHeaderView.snp.bottom)
            make.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
}
