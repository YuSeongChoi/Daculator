//
//  ItemSetVO.swift
//  Dalculator
//
//  Created by YuSeongChoi on 2023/03/17.
//

import Foundation

typealias ItemSetVO = [ItemSetVOElement]

// MARK: - ItemSetVOElement
struct ItemSetVOElement: Codable, Hashable {
    let name: String
    let set2: Set2?
    let set3: Set3?
    let set4: Set4?
    let set5: Set5?
    let set8: Set8?

    enum CodingKeys: String, CodingKey {
        case name
        case set2 = "2"
        case set3 = "3"
        case set4 = "4"
        case set5 = "5"
        case set8 = "8"
    }
}

// MARK: - Set2
struct Set2: Codable, Hashable {
    let attrs: Set2_Attrs
    let name: String
}

// MARK: - Set2_Attrs
struct Set2_Attrs: Codable, Hashable {
    let skInc: Int
    let skLV: [String: Int]?
    let hpmax, mpmax, defPh, defMg: Int?
    let resFire: Int?
    let eltype: String?
    let speedMove, targetDef: Int?
    let misc: [String]?
    let speedAtk, speedCast: Int?

    enum CodingKeys: String, CodingKey {
        case skInc = "sk_inc"
        case skLV = "sk_lv"
        case hpmax, mpmax
        case defPh = "def_ph"
        case defMg = "def_mg"
        case resFire = "res_fire"
        case eltype
        case speedMove = "speed_move"
        case targetDef = "target_def"
        case misc
        case speedAtk = "speed_atk"
        case speedCast = "speed_cast"
    }
}

// MARK: - Set3
struct Set3: Codable, Hashable {
    let attrs: Set3_Attrs?
    let name: String
    let exclusive: [Set3_Exclusive]?
    let branch: [Set3_Branch]?
}

// MARK: - Set3_Attrs
struct Set3_Attrs: Codable, Hashable {
    let elFire, elIce, elLght, elDark: Int?
    let skInc, intl, atkMg, speedMove: Int?
    let accu: Int?
    let speedCast: Double?
    let strn, speedAtk, atkPh, dmgAdd: Int?
    let skCool, skVal: [String: Int]?
    let misc: [String]?
    let skHit: [String: Int]?
    let targetDef: Int?

    enum CodingKeys: String, CodingKey {
        case elFire = "el_fire"
        case elIce = "el_ice"
        case elLght = "el_lght"
        case elDark = "el_dark"
        case skInc = "sk_inc"
        case intl
        case atkMg = "atk_mg"
        case speedMove = "speed_move"
        case accu = "Accu"
        case speedCast = "speed_cast"
        case strn
        case speedAtk = "speed_atk"
        case atkPh = "atk_ph"
        case dmgAdd = "dmg_add"
        case skCool = "sk_cool"
        case skVal = "sk_val"
        case misc
        case skHit = "sk_hit"
        case targetDef = "target_def"
    }
}

// MARK: - Set3_Branch
struct Set3_Branch: Codable, Hashable {
    let when: String
    let attrs: PurpleAttrs
}

// MARK: - PurpleAttrs
struct PurpleAttrs: Codable, Hashable {
    let speedAtk, speedCast, speedMove: Int

    enum CodingKeys: String, CodingKey {
        case speedAtk = "speed_atk"
        case speedCast = "speed_cast"
        case speedMove = "speed_move"
    }
}

// MARK: - The3_Exclusive
struct Set3_Exclusive: Codable, Hashable {
    let name, label: String
    let children: [PurpleChild]
}

// MARK: - PurpleChild
struct PurpleChild: Codable, Hashable {
    let name: String
    let attrs: FluffyAttrs
}

// MARK: - FluffyAttrs
struct FluffyAttrs: Codable, Hashable {
    let eldmgFire, eldmgIce, eldmgLght, eldmgDark: Int?

    enum CodingKeys: String, CodingKey {
        case eldmgFire = "eldmg_fire"
        case eldmgIce = "eldmg_ice"
        case eldmgLght = "eldmg_lght"
        case eldmgDark = "eldmg_dark"
    }
}

// MARK: - Set4
struct Set4: Codable, Hashable {
    let name: String
    let attrs: Set4_Attrs
    let branch: [Set4_Branch]
}

// MARK: - Set4_Attrs
struct Set4_Attrs: Codable, Hashable {
    let elFire, elIce, elLght, elDark: Int

    enum CodingKeys: String, CodingKey {
        case elFire = "el_fire"
        case elIce = "el_ice"
        case elLght = "el_lght"
        case elDark = "el_dark"
    }
}

// MARK: - Set4_Branch
struct Set4_Branch: Codable, Hashable {
    let when: String
    let attrs: TentacledAttrs
}

// MARK: - TentacledAttrs
struct TentacledAttrs: Codable, Hashable {
    let dmgAdd: Int

    enum CodingKeys: String, CodingKey {
        case dmgAdd = "dmg_add"
    }
}

// MARK: - Set5
struct Set5: Codable, Hashable {
    let name: String
    let branch: [Set5_Branch]?
    let attrs: Set5_Attrs
    let gives: [SetOptions]?
    let exclusive: [Set5_Exclusive]?
}

// MARK: - Set5_Attrs
struct Set5_Attrs: Codable, Hashable {
    let atkPh, atkMg, dmgInc: Int?
    let misc: [String]?
    let strInc, intInc, skInc, elFire: Int?
    let elIce, elDark, eldmgLght, targetRes: Int?
    let eldmgFire, intl, speedMove, accu: Int?
    let speedCast: Double?
    let strn, speedAtk, cdmgInc: Int?
    let skLV: SkLV?
    let dmgAdd, targetDef, hpmax, mpmax: Int?
    let elLght: Int?
    let skVal, skHit, skCool, skDur: [String: Int]?

    enum CodingKeys: String, CodingKey {
        case atkPh = "atk_ph"
        case atkMg = "atk_mg"
        case dmgInc = "dmg_inc"
        case misc
        case strInc = "str_inc"
        case intInc = "int_inc"
        case skInc = "sk_inc"
        case elFire = "el_fire"
        case elIce = "el_ice"
        case elDark = "el_dark"
        case eldmgLght = "eldmg_lght"
        case targetRes = "target_res"
        case eldmgFire = "eldmg_fire"
        case intl
        case speedMove = "speed_move"
        case accu = "Accu"
        case speedCast = "speed_cast"
        case strn
        case speedAtk = "speed_atk"
        case cdmgInc = "cdmg_inc"
        case skLV = "sk_lv"
        case dmgAdd = "dmg_add"
        case targetDef = "target_def"
        case hpmax, mpmax
        case elLght = "el_lght"
        case skVal = "sk_val"
        case skHit = "sk_hit"
        case skCool = "sk_cool"
        case skDur = "sk_dur"
    }
}

// MARK: - SkLV
struct SkLV: Codable, Hashable {
    let lv50: Int

    enum CodingKeys: String, CodingKey {
        case lv50 = "Lv50"
    }
}

// MARK: - The5_Branch
struct Set5_Branch: Codable, Hashable {
    let when: String
    let attrs: StickyAttrs
}

// MARK: - StickyAttrs
struct StickyAttrs: Codable, Hashable {
    let speedAtk, speedCast, elFire: Int?

    enum CodingKeys: String, CodingKey {
        case speedAtk = "speed_atk"
        case speedCast = "speed_cast"
        case elFire = "el_fire"
    }
}

// MARK: - Set5_Exclusive
struct Set5_Exclusive: Codable, Hashable {
    let name, label: String
    let children: [FluffyChild]
}

// MARK: - FluffyChild
struct FluffyChild: Codable, Hashable {
    let name: String
    let attrs: IndigoAttrs
}

// MARK: - IndigoAttrs
struct IndigoAttrs: Codable, Hashable {
    let critPh, critMg, cdmgInc, strInc: Int?
    let intInc, dmgAdd: Int?

    enum CodingKeys: String, CodingKey {
        case critPh = "crit_ph"
        case critMg = "crit_mg"
        case cdmgInc = "cdmg_inc"
        case strInc = "str_inc"
        case intInc = "int_inc"
        case dmgAdd = "dmg_add"
    }
}

// MARK: - SetOptions
struct SetOptions: Codable, Hashable {
    let attrs: SetOptionsAttrs
}

// MARK: - SetOptionsAttrs
struct SetOptionsAttrs: Codable, Hashable {
    let strn, intl: Int
    let atkPh, atkMg, critPh, critMg: Int?

    enum CodingKeys: String, CodingKey {
        case strn, intl
        case atkPh = "atk_ph"
        case atkMg = "atk_mg"
        case critPh = "crit_ph"
        case critMg = "crit_mg"
    }
}

// MARK: - Set8
struct Set8: Codable, Hashable {
    let attrs: Set8_Attrs
    let name: String
}

// MARK: - Set8_Attrs
struct Set8_Attrs: Codable, Hashable {
    let skInc: Int
    let skVal, skCool: [String: Int]?
    let misc: [String]?
    let skbAdd: SkbAdd?
    let targetDef: Int?
    let skHit: SkHit?

    enum CodingKeys: String, CodingKey {
        case skInc = "sk_inc"
        case skVal = "sk_val"
        case skCool = "sk_cool"
        case misc
        case skbAdd = "skb_add"
        case targetDef = "target_def"
        case skHit = "sk_hit"
    }
}

// MARK: - SkHit
struct SkHit: Codable, Hashable {
    let 폭풍1식선풍베기: Int

    enum CodingKeys: String, CodingKey {
        case 폭풍1식선풍베기 = "폭풍 1식: 선풍베기"
    }
}

// MARK: - SkbAdd
struct SkbAdd: Codable, Hashable {
    let 카이: Int
}
