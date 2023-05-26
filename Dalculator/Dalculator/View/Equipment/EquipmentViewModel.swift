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
    @Published var alertItem: AlertProvider?
    
    var taskStorage: Set<Task<Void,Never>> = []
    
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
            saveUserItem(itemType: .weapon)
        }
        if item.itype == .shoulder {
            selectedShoulder = item
            saveUserItem(itemType: .shoulder)
        }
        if item.itype == .coat {
            selectedCoat = item
            saveUserItem(itemType: .coat)
        }
        if item.itype == .pants {
            selectedPants = item
            saveUserItem(itemType: .pants)
        }
        if item.itype == .belt {
            selectedBelt = item
            saveUserItem(itemType: .belt)
        }
        if item.itype == .shoes {
            selectedShoes = item
            saveUserItem(itemType: .shoes)
        }
        if item.itype == .necklace {
            selectedNecklace = item
            saveUserItem(itemType: .necklace)
        }
        if item.itype == .bracelet {
            selectedBracelet = item
            saveUserItem(itemType: .bracelet)
        }
        if item.itype == .ring {
            selectedRing = item
            saveUserItem(itemType: .ring)
        }
        if item.itype == .supequip {
            selectedSupEquip = item
            saveUserItem(itemType: .supequip)
        }
    }
    
}

// MARK: - 데이터 불러오기 및 Default 파싱
extension EquipmentViewModel {
    
    // MARK: 직업 리스트 불러오기
    func loadChampionList() {
        guard let data = FileLoader.load(file: R.file.dfclassJson.name) else { return }
        let result = FileLoader.decode(ChampionVO.self, data: data)
        switch result {
        case .success(let result):
            championList = result
            initDefaultJob()
        case .failure(let failure):
            print(failure)
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
            print(failure)
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
            print(failure)
        }
    }
    
    // MARK: 세트 아이템 리스트 딕셔너리 넣기
    func injectItemList() {
        itemList.forEach { item in
            guard let setName = item.setOf.first else { return }
            if item.rarity != .epic || item.content?.first == .illusion || item.itype == .sealstone || item.itype == .essence || item.itype == .creature {
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
    
    // MARK: 초기 직업 설정
    func initDefaultJob() {
        let decoder: JSONDecoder = JSONDecoder()
        if let data = UserDefaults.standard.object(forKey: "job") as? Data,
           let decoded = try? decoder.decode(ChampionVOElement.self, from: data) {
            selectedJob = decoded
        }
        if selectedJob.name.isEmpty {
            guard let job = championList.filter({ $0.name == "rangerM" }).first else { return }
            selectedJob = job
            let encoder: JSONEncoder = JSONEncoder()
            guard let encoded = try? encoder.encode(selectedJob) else { return }
            UserDefaults.standard.set(encoded, forKey: "job")
        }
    }
    
    // MARK: 초기장비 설정
    func initDefaultItem() {
        if let _ = UserDefaults.standard.object(forKey: UserItemType.shoulder.rawValue) as? Data {
            UserItemType.allCases.forEach { loadUserItem(name: $0.rawValue) }
        } else {
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
            UserItemType.allCases.forEach{ saveUserItem(itemType: $0) }
        }
    }
    
}

// MARK: - UserDefault 저장 및 불러오기
extension EquipmentViewModel {
    
    // MARK: 유저 Item 저장
    func saveUserItem(itemType: UserItemType) {
        let encoder: JSONEncoder = JSONEncoder()
        var encodedData = Data()
        switch itemType {
        case .shoulder:
            guard let encoded = try? encoder.encode(selectedShoulder) else { return }
            encodedData = encoded
        case .coat:
            guard let encoded = try? encoder.encode(selectedCoat) else { return }
            encodedData = encoded
        case .pants:
            guard let encoded = try? encoder.encode(selectedPants) else { return }
            encodedData = encoded
        case .belt:
            guard let encoded = try? encoder.encode(selectedBelt) else { return }
            encodedData = encoded
        case .shoes:
            guard let encoded = try? encoder.encode(selectedShoes) else { return }
            encodedData = encoded
        case .weapon:
            guard let encoded = try? encoder.encode(selectedWeapon) else { return }
            encodedData = encoded
        case .bracelet:
            guard let encoded = try? encoder.encode(selectedBracelet) else { return  }
            encodedData = encoded
        case .necklace:
            guard let encoded = try? encoder.encode(selectedNecklace) else { return }
            encodedData = encoded
        case .ring:
            guard let encoded = try? encoder.encode(selectedRing) else { return }
            encodedData = encoded
        case .supequip:
            guard let encoded = try? encoder.encode(selectedSupEquip) else { return }
            encodedData = encoded
        }
        UserDefaults.standard.set(encodedData, forKey: itemType.rawValue)
    }
    
    // MARK: 유저 아이템 불러오기
    func loadUserItem(name: String) {
        let decoder: JSONDecoder = JSONDecoder()
        if let data = UserDefaults.standard.object(forKey: name) as? Data,
           let decodedItem = try? decoder.decode(ItemVOElement.self, from: data) {
            equipItem(item: decodedItem)
        }
    }
    
}

extension EquipmentViewModel {
    
    enum UserItemType: String, CaseIterable {
        case shoulder
        case coat
        case pants
        case belt
        case shoes
        case weapon
        case bracelet
        case necklace
        case ring
        case supequip
    }
    
}
