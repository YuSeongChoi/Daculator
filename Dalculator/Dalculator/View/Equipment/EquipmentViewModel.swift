//
//  EquipmentViewModel.swift
//  Dalculator
//
//  Created by YuSeongChoi on 2023/03/14.
//

import SwiftUI

import DalculatorResources

@MainActor
final class EquipmentViewModel: ObservableObject, Identifiable {
    
    @Published var championList: ChampionVO = []
    @Published var itemList: ItemVO = []
    @Published var itemSetList: ItemSetVO = []
    
    /// 직업
    @Published var selectedJob: ChampionVOElement = .init()
    /// 머리어깨
    @Published var selectedShoulder: ItemVOElement = .init(attrs: .init())
    /// 상의
    @Published var selectedCoat: ItemVOElement = .init(attrs: .init())
    /// 하의
    @Published var selectedPants: ItemVOElement = .init(attrs: .init())
    /// 벨트
    @Published var selectedBelt: ItemVOElement = .init(attrs: .init())
    /// 신발
    @Published var selectedShoes: ItemVOElement = .init(attrs: .init())
    /// 무기
    @Published var selectedWeapon: ItemVOElement = .init(attrs: .init())
    /// 목걸이
    @Published var selectedNecklace: ItemVOElement = .init(attrs: .init())
    /// 팔찌
    @Published var selectedBracelet: ItemVOElement = .init(attrs: .init())
    /// 반지
    @Published var selectedRing: ItemVOElement = .init(attrs: .init())
    /// 보조장비
    @Published var selectedSupEquip: ItemVOElement = .init(attrs: .init())
    
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
            if selectedJob.name.isEmpty {
                guard let job = championList.filter({ $0.name == "rangerM" }).first else { return }
                selectedJob = job
            }
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
                injectItemList()
                
                itemList.forEach { item in
                    if itemDict[item.name] == nil {
                        itemDict[item.name] = []
                        itemDict[item.name]?.append(item)
                    } else {
                        itemDict[item.name]?.append(item)
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
    
    // MARK: 세트 아이템 리스트 딕셔너리 넣기
    func injectItemList() {
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
        itemSetDict.sorted { (first, second) in
            return first.key < second.key
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
                if item.name.contains("브왕가") || item.name.contains("미완성") {
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
        
        if type.bigType == .weapon {
            let weapons = selectedJob.weapons
            itemDict.forEach{ (name, item) in
                item.forEach { element in
                    guard let elementType = element.itype?.rawValue else { return }
                    if weapons.contains(elementType) {
                        selectedItem.append(element)
                    }
                }
            }
        } else {
            itemDict.forEach { (name, item) in
                guard let selected = item.filter({ $0.itype == type }).first else { return }
                selectedItem.append(selected)
            }
        }
    }
    
    // MARK: 세트 아이템 설정하기
    func settingSetItemType(type: ItemType) {
        itemSetDict.removeAll()
        injectItemList()
        
        itemSetDict.forEach { (name, item) in
            let selected = item.filter{ $0.itype?.bigType == type.bigType }
            
            itemSetDict[name] = selected
        }
        
        for (key, value) in itemSetDict where value.isEmpty {
            itemSetDict.removeValue(forKey: key)
        }
    }
    
    // MARK: 장비 장착하기
    func equipItem(item: ItemVOElement) {
        if item.itype?.bigType == .weapon {
            selectedWeapon = item
        }
        if item.itype == .shoulder {
            selectedShoulder = item
        }
        if item.itype == .coat {
            selectedCoat = item
        }
        if item.itype == .pants {
            selectedPants = item
        }
        if item.itype == .belt {
            selectedBelt = item
        }
        if item.itype == .shoes {
            selectedShoes = item
        }
        if item.itype == .necklace {
            selectedNecklace = item
        }
        if item.itype == .bracelet {
            selectedBracelet = item
        }
        if item.itype == .ring {
            selectedRing = item
        }
        if item.itype == .supequip {
            selectedSupEquip = item
        }
    }
    
}