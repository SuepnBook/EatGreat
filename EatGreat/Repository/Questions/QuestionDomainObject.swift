//
//  QuestionDomainObject.swift
//  EatGreat
//
//  Created by Book on 2022/7/8.
//

import Foundation

struct QuestionDomainObject{
    struct OriginQuestion:Decodable {
        let id:String
        let physicalType:[String]
        let questionType:String
        let title:String
    }
}
