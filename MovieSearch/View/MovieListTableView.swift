//
//  MoviewListTableView.swift
//  MovieSearch
//
//  Created by 김믿음 on 2022/02/12.
//

import UIKit

/*
 TableView
  */

class MovieListTableView: UITableView {

    //MARK: Init
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        setTableView()

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: SetTableview
    func setTableView() {
        register(MovieListTableViewCell.self, forCellReuseIdentifier: "MovieListTableViewCell")
        separatorInset.left = 0
        estimatedRowHeight = UITableView.automaticDimension
        rowHeight = UITableView.automaticDimension
//        rowHeight = 100
    }
}
