//
//  PhysiqueRepository.swift
//  EatGreat
//
//  Created by Book on 2022/7/14.
//

import Foundation

class PhysiqueRepository {
    
    static let shared:PhysiqueRepository = PhysiqueRepository()
    
    private var features:[PhysiqueDomainObject.Feature] = []
    private var causes:[PhysiqueDomainObject.Cause] = []
    private var suggests:[PhysiqueDomainObject.Suggest] = []
}

//MARK: - CREATE
extension PhysiqueRepository {
    func savePhysiquePercentage(type:PhysiqueType, percentage:Float) {
        UserDefaultManager.savePhysiquePercentage(type: type, percentage: percentage)
        print("type : \(type) , percentage : \(percentage)")
    }
}

//MARK: - READ
extension PhysiqueRepository {
    
    func getPhysiquePercentage(type:PhysiqueType) -> Float {
        UserDefaultManager.getPhysiquePercentage(type: type)
    }
}

//MARK: - UPDATE
extension PhysiqueRepository {
    
    func update(features:[PhysiqueDomainObject.Feature]) {
        var result:[PhysiqueDomainObject.Feature] = []
        
        for feature in features {
            result.append(.init(id: feature.id,
                                title: feature.title,
                                links: feature.links))
        }
        
        self.features = result
    }
    
    func update(causes:[PhysiqueDomainObject.Cause]) {
        var result:[PhysiqueDomainObject.Cause] = []
        
        for cause in causes {
            result.append(.init(id: cause.id,
                                title: cause.title,
                                links: cause.links))
        }
        
        self.causes = result
    }
    
    func update(suggests:[PhysiqueDomainObject.Suggest]) {
        var result:[PhysiqueDomainObject.Suggest] = []
        
        for suggest in suggests {
            result.append(.init(id: suggest.id,
                                title: suggest.title,
                                links: suggest.links,
                                subTitles: suggest.subTitles))
        }
        
        self.suggests = result
    }
}
