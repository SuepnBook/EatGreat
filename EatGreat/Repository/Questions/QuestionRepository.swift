//
//  QuestionRepository.swift
//  EatGreat
//
//  Created by Book on 2022/7/8.
//

import Foundation
import FirebaseCore
import FirebaseDatabase

class QuestionRepository {
    
    static let shared:QuestionRepository = QuestionRepository()
    
    private var questions:[QuestionDomainObject.OriginQuestion] = []
    
    lazy var ref: DatabaseReference = Database.database().reference()
    
    init() {
        Database.database().isPersistenceEnabled = true
    }
}

struct Temp:Decodable {
    var Questions:[QuestionDomainObject.OriginQuestion]
}

extension QuestionRepository {
    func listenQuestion() {
        ref
            .child("v1")
//            .child("v1")
            .observe(.value) { (snapshot) in
                do {
                   let v1 = try JSONDecoder().decode(Temp.self,
                                             from: snapshot.valueToJSON)
                    print(v1)
                } catch {
                    print(error)
                }
            }
    }
}
