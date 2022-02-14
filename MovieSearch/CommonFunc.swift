//
//  CommonFunc.swift
//  MovieSearch
//
//  Created by 김믿음 on 2022/02/14.
//

import UIKit
/*
 파일 내 공통함수
 */
class CommonFunc: NSObject {
    //MARK:  영화 이름 스트링 값 치환
    static func formateStringData(string: String) -> String {
        let titleResult = string.replacingOccurrences(of: "</b>", with: "").replacingOccurrences(of: "<b>", with: "")
        return titleResult
    }

}
