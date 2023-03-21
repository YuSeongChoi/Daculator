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
    @Published var itemSetList: ItemSetVO = []
    
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
    
    var itemDict = Dictionary<String, [ItemVOElement]>()
    var itemSetDict = Dictionary<String, [ItemVOElement]>()
    var selectedItem: [ItemVOElement] = []
    
    // MARK: 직업 리스트 불러오기
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
    
    // MARK: 아이템 리스트 불러오기
    func loadItemList() {
        guard let data = FileLoader.load(file: R.file.itemsJson.name) else { return }
        let result = FileLoader.decode(ItemVO.self, data: data)
        switch result {
        case .success(let result):
            if itemList.isEmpty {
                itemList = result
                initDefaultItem()
                
                itemList.forEach { item in
                    if itemDict[item.name] == nil {
                        itemDict[item.name] = []
                        itemDict[item.name]?.append(item)
                    } else {
                        itemDict[item.name]?.append(item)
                    }
                }
                
                itemList.forEach { item in
                    guard let setName = item.setOf.first else { return }
                    if item.rarity != .epic || item.content == .illusion || item.itype == .sealstone || item.itype == .essence || item.itype == .creature {
                        return
                    }
                    if itemSetDict[setName] == nil {
                        itemSetDict[setName] = []
                        itemSetDict[setName]?.append(item)
                    } else {
                        itemSetDict[setName]?.append(item)
                    }
                }
            } else {
                return
            }
        case .failure(let failure):
            print(failure.localizedDescription)
        }
    }
    
    // MARK: 세트 아이템 리스트 불러오기
    func loadItemSetList() {
        guard let data = FileLoader.load(file: R.file.itemsetsJson.name) else { return }
        let result = FileLoader.decode(ItemSetVO.self, data: data)
        switch result {
        case .success(let result):
            itemSetList = result
        case .failure(let failure):
            print(failure.localizedDescription)
        }
    }
    
    // MARK: 초기장비 설정
    func initDefaultItem() {
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
            equipItem(item: item)
        }
    }
    
    // MARK: 아이템 종류 설정하기
    func settingItemType(type: ItemType) {
        selectedItem.removeAll()
        
        itemDict.forEach { (name, item) in
            guard let selected = item.filter({ $0.itype == type }).first else { return }
            selectedItem.append(selected)
        }
    }
    
    // MARK: 세트 아이템 설정하기
    func settingSetItemType(type: ItemType) {
        itemSetDict.forEach { (name, item) in
            let selected = item.filter({ $0.itype == type })
            
        }
    }
    
    // MARK: 장비 장착하기
    func equipItem(item: ItemVOElement) {
        guard let type = item.itype else { return }
        if type.bigType == .weapon {
            selectedWeapon = item.image
        }
        if item.itype == .shoulder {
            selectedShoulder = item.image
        }
        if item.itype == .coat {
            selectedCoat = item.image
        }
        if item.itype == .pants {
            selectedPants = item.image
        }
        if item.itype == .belt {
            selectedBelt = item.image
        }
        if item.itype == .shoes {
            selectedShoes = item.image
        }
        if item.itype == .necklace {
            selectedNecklace = item.image
        }
        if item.itype == .bracelet {
            selectedBracelet = item.image
        }
        if item.itype == .ring {
            selectedRing = item.image
        }
        if item.itype == .supequip {
            selectedSupEquip = item.image
        }
    }
    
}
