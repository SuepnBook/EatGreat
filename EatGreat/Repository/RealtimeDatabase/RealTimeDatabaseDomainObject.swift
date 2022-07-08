//
//  RealTimeDatabaseDomainObject.swift
//  EatGreat
//
//  Created by Book on 2022/7/8.
//

import Foundation

enum PhysiqueType: String, Codable {
    case armFat = "ArmFat"
    case bellyFat = "BellyFat"
    case liverFire = "LiverFire"
    case waterFat = "WaterFat"
    case waterHeart = "WaterHeart"
    case weakHeart = "WeakHeart"
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
