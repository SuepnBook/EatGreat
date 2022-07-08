//
//  QuestionDomainObject.swift
//  EatGreat
//
//  Created by Book on 2022/7/8.
//

import Foundation

struct QuestionDomainObject{
    
    struct Question:Decodable {
        let id:String
        var title:String
        let physicalType:[PhysiqueType]
        let questionType:QuestionType
        
        var frequency:Int? = 1
        var serious:Int? = 3
        var isFinish:Bool {
            frequency != nil && serious != nil
        }
    }
}
