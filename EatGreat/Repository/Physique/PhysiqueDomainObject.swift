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
            return "上腹部肥胖"
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
            return "Physique-BellyFat"
        case .liverFire:
            return "Physique-LiverFire"
        case .waterFat:
            return "Physique-WaterFat"
        case .weakHeart:
            return "Physique-WeakHeart"
        }
    }
    
    var color:UIColor {
        switch self {
        case .armFat:
            return UIColor(red: 89, gre: 115, blu: 75, alp: 1)
        case .bellyFat:
            return UIColor(red: 156, gre: 129, blu: 34, alp: 1)
        case .liverFire:
            return UIColor(red: 165, gre: 77, blu: 71, alp: 1)
        case .waterFat:
            return UIColor(red: 68, gre: 103, blu: 136, alp: 1)
        case .weakHeart:
            return UIColor(red: 124, gre: 75, blu: 125, alp: 1)
        }
    }
}

struct PhysiqueDomainObject {
    struct PhysiqueReference: Codable {
        let feature, cause, suggest: [String]
    }
    
    struct PhysiquePercentage {
        let type:PhysiqueType
        let percentage:Float
    }
    
    struct Feature {
        let title: String
        let links: [InsertDomainObject.Link]
    }
    
    struct Cause {
        let title: String
        let links: [InsertDomainObject.Link]
    }

    struct Suggest {
        let title: String
        let links: [InsertDomainObject.Link]
        let subTitles: [String]
    }
}
