//
//  MoviewWebView.swift
//  MovieSearch
//
//  Created by 김믿음 on 2022/02/13.
//

import UIKit
import WebKit
/*
 영화 정보 웹뷰
 */
class MovieWebView: UIView {

    //MARK: Properties
    var webView = WKWebView()
    
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
        addSubview(webView)
        webView.snp.makeConstraints { make in
            make.edges.equalTo(self)
        }
    }
    
    //MARK: LoadView
    func loadWeb(link: String?) {
        guard let webLink = link else { return }
        let request = URLRequest(url: URL(string: webLink)!)
        webView.load(request)
    }
}
