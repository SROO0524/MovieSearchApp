//
//  MoviewDetailViewController.swift
//  MovieSearch
//
//  Created by 김믿음 on 2022/02/12.
//

import UIKit
/*
 영화 상세 화면
 */
class MovieDetailViewController: UIViewController {

    //MARK: Properties
    
    //MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "언차티드"
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage.init(systemName: "chevron.backward"), style: .plain, target: self, action: #selector(backBTTap))
        navigationItem.leftBarButtonItem?.tintColor = .black
        view.backgroundColor = .systemBlue
    }
    
    @objc func backBTTap() {
        navigationController?.popViewController(animated: true)
    }
}
