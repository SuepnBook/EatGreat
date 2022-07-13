//
//  PhysiqueDomainObject.swift
//  EatGreat
//
//  Created by Book on 2022/7/14.
//

import UIKit

enum PhysiqueType: String, Codable, CaseIterable {
    case armFat = "ArmFat"
    case bellyFat = "BellyFat"
    case liverFire = "LiverFire"
    case waterFat = "WaterFat"
    case weakHeart = "WeakHeart"
    
    var title:String {
        switch self {
        case .armFat:
            return "肩背手臂肥胖"
        case .bellyFat:
            return "上腹部"
        case .liverFire:
            return "上肝火"
        case .waterFat:
            return "腎虛肥胖"
        case .weakHeart:
            return "心臟無力"
        }
    }
    
    var image:String {
        switch self {
        case .armFat:
            return "Physique-ArmFat"
        case .bellyFat:
            return "Physique-ArmFat"
        case .liverFire:
            return "Physique-ArmFat"
        case .waterFat:
            return "Physique-ArmFat"
        case .weakHeart:
            return "Physique-ArmFat"
        }
    }
    
    var color:UIColor {
        switch self {
        case .armFat:
            return UIColor(red: 0.646, green: 0.302, blue: 0.28, alpha: 1)
        case .bellyFat:
            return UIColor(red: 0.613, green: 0.507, blue: 0.133, alpha: 1)
        case .liverFire:
            return UIColor(red: 0.349, green: 0.45, blue: 0.302, alpha: 1)
        case .waterFat:
            return UIColor(red: 0.267, green: 0.405, blue: 0.533, alpha: 1)
        case .weakHeart:
            return UIColor(red: 0.488, green: 0.289, blue: 0.492, alpha: 1)
        }
    }
}

struct PhysiqueDomainObject {
    struct PhysiqueReference {
        let physiqueType: PhysiqueType
        let feature, cause, suggest: [String]
    }
    
    struct Feature:Codable {
        let id, title: String
        let links: [String]
    }
    
    struct Cause:Codable {
        let id, title: String
        let links: [String]
    }

    struct Suggest:Codable {
        let id, title: String
        let links: [String]
        let subTitles: [String]?
    }
}
