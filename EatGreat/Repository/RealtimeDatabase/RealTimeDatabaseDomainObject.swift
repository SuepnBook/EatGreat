//
//  RealTimeDatabaseDomainObject.swift
//  EatGreat
//
//  Created by Book on 2022/7/8.
//

import Foundation
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
        .themePrimary
    }
}

enum QuestionType: String, Codable {
    case all = "All"
    case digestion = "Digestion"
    case head = "Head"
    case life = "Life"
    case trunk = "Trunk"
}

struct RealTimeDatabaseDomainObject {

    // MARK: - Root
    struct Root: Codable {
        let physiqueReference: [PhysiqueReference]
        let questions: [Question]
        let feature, cause, suggest: [Cause]
        let link: [Link]
    }
    
    // MARK: - Cause
    struct Cause: Codable {
        let id, title: String
        let links: [String]
        let subTitles: [String]?
    }
    
    // MARK: - Link
    struct Link: Codable {
        let id: String
        let image: String
        let title: String
    }
    
    // MARK: - PhysiqueReference
    struct PhysiqueReference: Codable {
        let physiqueType: PhysiqueType
        let feature, cause, suggest: [Int]
    }
    
    // MARK: - Question
    struct Question: Codable {
        let id: String
        let physicalType: [PhysiqueType]
        let questionType: QuestionType
        let title: String
    }
}
