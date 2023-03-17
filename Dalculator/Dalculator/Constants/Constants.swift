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

extension Constants {
    
    enum EquipmentType: String {
        /// 머리어깨
        case shoulder
        /// 상의
        case coat
        /// 하의
        case pants
        /// 벨트
        case belt
        /// 신발
        case shoes
        /// 무기
        case weapon
        /// 목걸이
        case necklace
        /// 팔찌
        case bracelet
        /// 반지
        case ring
        /// 보조장비
        case supequip
        
        var title: String {
            switch self {
            case .shoulder:
                return "머리어깨"
            case .coat:
                return "상의"
            case .pants:
                return "하의"
            case .belt:
                return "벨트"
            case .shoes:
                return "신발"
            case .weapon:
                return "무기"
            case .necklace:
                return "목걸이"
            case .bracelet:
                return "팔찌"
            case .ring:
                return "반지"
            case .supequip:
                return "보조장비"
            }
        }
    }
    
}
