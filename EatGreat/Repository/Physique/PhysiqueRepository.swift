//
//  PhysiqueRepository.swift
//  EatGreat
//
//  Created by Book on 2022/7/14.
//

import Foundation

class PhysiqueRepository {
    
    static let shared:PhysiqueRepository = PhysiqueRepository()
    
    private var physiqueReference:[PhysiqueType:PhysiqueDomainObject.PhysiqueReference] = [:]
    
    private var features:[String:PhysiqueDomainObject.Feature] = [:]
    private var causes:[String:PhysiqueDomainObject.Cause] = [:]
    private var suggests:[String:PhysiqueDomainObject.Suggest] = [:]
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
    
    func getPhysiqueFeatures(type:PhysiqueType) -> [PhysiqueDomainObject.Feature] {
        guard let ref = physiqueReference[type] else {
            return []
        }
        var result:[PhysiqueDomainObject.Feature] = []
        for id in ref.feature {
            if let feature = features[id] {
                result.append(feature)
            }
        }
        return result
    }
    
    func getPhysiqueCauses(type:PhysiqueType) -> [PhysiqueDomainObject.Cause] {
        guard let ref = physiqueReference[type] else {
            return []
        }
        var result:[PhysiqueDomainObject.Cause] = []
        for id in ref.cause {
            if let cause = causes[id] {
                result.append(cause)
            }
        }
        return result
    }
    
    func getPhysiqueSuggests(type:PhysiqueType) -> [PhysiqueDomainObject.Suggest] {
        guard let ref = physiqueReference[type] else {
            return []
        }
        var result:[PhysiqueDomainObject.Suggest] = []
        for id in ref.suggest {
            if let suggest = suggests[id] {
                result.append(suggest)
            }
        }
        return result
    }
}

//MARK: - UPDATE
extension PhysiqueRepository {
    
    func update(physiqueReference:[RealTimeDatabaseDomainObject.PhysiqueReference]) {
        self.physiqueReference = [:]
        for ref in physiqueReference {
            self.physiqueReference[ref.physiqueType] = .init(feature: ref.feature,
                                                             cause: ref.cause,
                                                             suggest: ref.suggest)
        }
    }
    
    func update(features:[RealTimeDatabaseDomainObject.Feature]) {
        self.features = [:]
        
        for feature in features {
            let links = InsertRepository.shared.getLinks(ids: feature.links)
            self.features[feature.id] = .init(title: feature.title,
                                         links: links)
        }
    }
    
    func update(causes:[RealTimeDatabaseDomainObject.Cause]) {
        self.causes = [:]
        
        for cause in causes {
            let links = InsertRepository.shared.getLinks(ids: cause.links)
            self.causes[cause.id] = .init(title: cause.title,
                                          links: links)
        }
    }
    
    func update(suggests:[RealTimeDatabaseDomainObject.Suggest]) {
        self.suggests = [:]
        
        for suggest in suggests {
            let links = InsertRepository.shared.getLinks(ids: suggest.links)
            self.suggests[suggest.id] = .init(title: suggest.title,
                                              links: links,
                                              subTitles: suggest.subTitles)
        }
    }
}
