//
//  FavoriteListViewController.swift
//  MovieSearch
//
//  Created by 김믿음 on 2022/02/12.
//

import UIKit
import SnapKit

/*
 즐겨찾기 리스트
 */

class FavoriteListViewController: UIViewController {
    
    //MARK: Properties
    let tableView = MovieListTableView()

    //MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "즐겨찾기 목록"
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage.init(systemName: "xmark"), style: .plain, target: self, action: #selector(cancleBTTap))
        navigationItem.leftBarButtonItem?.tintColor = .black
        view.backgroundColor = .white
        setTableView()
    }
    
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
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let listCell = tableView.dequeueReusableCell(withIdentifier: "MovieListTableViewCell") else {
            return UITableViewCell()
        }
        
        return listCell
    }
}
