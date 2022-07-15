//
//  RealTimeDatabaseDomainObject.swift
//  EatGreat
//
//  Created by Book on 2022/7/8.
//

import Foundation
import UIKit

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
        let feature: [Feature]
        let cause: [Cause]
        let suggest: [Suggest]
        let link: [Link]
    }
    
    struct Feature:Codable {
        let id, title: String
        let links: [String]?
    }
    
    struct Cause:Codable {
        let id, title: String
        let links: [String]?
    }

    struct Suggest:Codable {
        let id, title: String
        let links: [String]?
        let subTitles: [String]?
    }
    
    struct Link: Codable {
        let id: String
        let image: String
        let title: String
        let url: String
    }
    
    // MARK: - PhysiqueReference
    struct PhysiqueReference: Codable {
        let physiqueType: PhysiqueType
        let feature, cause, suggest: [String]
    }
    
    // MARK: - Question
    struct Question: Codable {
        let id: String
        let physicalType: [PhysiqueType]
        let questionType: QuestionType
        let title: String
    }
}
