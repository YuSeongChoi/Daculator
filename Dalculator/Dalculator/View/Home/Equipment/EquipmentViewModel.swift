//
//  EquipmentViewModel.swift
//  Dalculator
//
//  Created by YuSeongChoi on 2023/03/14.
//

import Foundation

import RswiftResources

@MainActor
final class EquipmentViewModel: ObservableObject, Identifiable {
    
    @Published var championList: ChampionVO = []
    @Published var itemList: ItemVO = []
    
    /// 직업
    @Published var selectedJob: String = ""
    /// 머리어깨
    @Published var selectedShoulder: String = ""
    /// 상의
    @Published var selectedCoat: String = ""
    /// 하의
    @Published var selectedPants: String = ""
    /// 벨트
    @Published var selectedBelt: String = ""
    /// 신발
    @Published var selectedShoes: String = ""
    /// 무기
    @Published var selectedWeapon: String = ""
    /// 목걸이
    @Published var selectedNecklace: String = ""
    /// 팔찌
    @Published var selectedBracelet: String = ""
    /// 반지
    @Published var selectedRing: String = ""
    /// 보조장비
    @Published var selectedSupEquip: String = ""
    
    func loadChampionList() {
        guard let data = FileLoader.load(file: R.file.dfclassJson.name) else { return }
        let result = FileLoader.decode(ChampionVO.self, data: data)
        switch result {
        case .success(let result):
            championList = result
            guard let job = championList.filter{ $0.name == "소드마스터" }.first else { return }
            selectedJob = job.name
        case .failure(let failure):
            print(failure.localizedDescription)
        }
    }
    
    func loadItemList() {
        guard let data = FileLoader.load(file: R.file.itemsJson.name) else { return }
        let result = FileLoader.decode(ItemVO.self, data: data)
        switch result {
        case .success(let result):
            itemList = result
            var equipment: [ItemVOElement] = []
            itemList.forEach { item in
                if let setName = item.setOf.first {
                    if setName.contains("예언자") || setName.contains("새벽") {
                        equipment.append(item)
                    }
                } else {
                    if item.name.contains("브왕가") || item.name.contains("혼철") {
                        equipment.append(item)
                    }
                }
            }
            equipment.forEach { item in
                if item.itype == "머리어깨" {
                    selectedShoulder = item.image
                }
                if item.itype == "상의" {
                    selectedCoat = item.image
                }
                if item.itype == "하의" {
                    selectedPants = item.image
                }
                if item.itype == "벨트" {
                    selectedBelt = item.image
                }
                if item.itype == "신발" {
                    selectedShoes = item.image
                }
                if item.itype == "도" {
                    selectedWeapon = item.image
                }
                if item.itype == "목걸이" {
                    selectedNecklace = item.image
                }
                if item.itype == "팔찌" {
                    selectedBracelet = item.image
                }
                if item.itype == "반지" {
                    selectedRing = item.image
                }
                if item.itype == "보조장비" {
                    selectedSupEquip = item.image
                }
            }
        case .failure(let failure):
            print(failure.localizedDescription)
        }
    }
    
}
