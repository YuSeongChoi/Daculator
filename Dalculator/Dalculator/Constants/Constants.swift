//
//  Constants.swift
//  Dalculator
//
//  Created by YuSeongChoi on 2023/03/14.
//

import Foundation

enum Constants {
    
    enum HomeTabItem: String, Hashable {
        case home
        case setting
        
        var title: String {
            switch self {
            case .home:
                return "홈"
            case .setting:
                return "설정"
            }
        }
    }
    
    enum MainTabItem: String, Hashable, CaseIterable {
        /// 장비
        case equipment
        /// 대장간
        case blacksmith
        /// 아바타
        case avatar
        /// 성안의봉인
        case seal
        /// 기타
        case etc
        
        var title: String {
            switch self {
            case .equipment:
                return "장비"
            case .blacksmith:
                return "대장간"
            case .avatar:
                return "아바타"
            case .seal:
                return "성안의봉인"
            case .etc:
                return "기타"
            }
        }
    }
    
}
