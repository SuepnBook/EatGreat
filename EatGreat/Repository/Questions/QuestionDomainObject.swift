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
//        FIXME:Remember to remove
        var frequency:Int? = Int.random(in: 1...5)
        var serious:Int? = Int.random(in: 1...5)
        var isFinish:Bool {
            frequency != nil && serious != nil
        }
    }
}
