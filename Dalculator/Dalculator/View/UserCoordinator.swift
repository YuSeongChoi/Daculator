//
//  UserCoordinator.swift
//  Dalculator
//
//  Created by YuSeongChoi on 2023/05/23.
//

import SwiftUI

@MainActor
final class UserCoordinator: ObservableObject, Identifiable {
    
    // MARK: - 재화 정보
    /// 전체 골드
    @Published var totalGold: Int64 = 0
    /// 전체 라이언코크스
    @Published var totalRyanCokes: Int64 = 0
    /// 전체 상급 라이언코크스
    @Published var totalHighRyanCockes: Int64 = 0
    /// 전체 촉매제
    @Published var totalCatalyst: Int64 = 0
    
    // MARK: - 유저 정보
    /// 직업
    @Published var userJob: ChampionVOElement = .init()
    /// 머리어깨
    @Published var userShoulder: UserItemVO = .init()
    /// 상의
    @Published var userCoat: UserItemVO = .init()
    /// 하의
    @Published var userPants: UserItemVO = .init()
    /// 벨트
    @Published var userBelt: UserItemVO = .init()
    /// 신발
    @Published var userShoes: UserItemVO = .init()
    /// 무기
    @Published var userWeapon: UserItemVO = .init()
    /// 목걸이
    @Published var userNecklace: UserItemVO = .init()
    /// 팔찌
    @Published var userBracelet: UserItemVO = .init()
    /// 반지
    @Published var userRing: UserItemVO = .init()
    /// 보조장비
    @Published var userSupEquip: UserItemVO = .init()
    
}
