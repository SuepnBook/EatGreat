//
//  RealtimeDatabaseRepository.swift
//  EatGreat
//
//  Created by Book on 2022/7/8.
//

import Foundation
import FirebaseCore
import FirebaseDatabase

class RealtimeDatabaseRepository {
    
    static let shared:RealtimeDatabaseRepository = RealtimeDatabaseRepository()
    
    lazy var ref: DatabaseReference = Database.database().reference()
    
    init() {
        Database.database().isPersistenceEnabled = true
    }
    
    func fetchDB() {
        ref
            .child("v1")
            .observe(.value) { (snapshot) in
                do {
                    let root = try JSONDecoder().decode(RealTimeDatabaseDomainObject.Root.self,
                                             from: snapshot.valueToJSON)
                    PhysiqueRepository.shared.updateQuestion(questions: root.questions)

                } catch {
                    print(error)
                }
            }
    }
}
