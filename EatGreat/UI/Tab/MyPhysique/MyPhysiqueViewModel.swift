//
//  MyPhysiqueViewModel.swift
//  EatGreat
//
//  Created by Book on 2022/7/9.
//

import RxCocoa
import RxSwift

class MyPhysiqueViewModel: BaseViewModel {
    
    private let repo:PhysiqueRepository = .shared
    
    func getMainPhysique() -> PhysiqueType {
        var mainType:PhysiqueType = .armFat
        var highestPercentage:Float = 0
        for physique in PhysiqueType.allCases {
            let currentPercentage = getPercentage(type: physique)
            if currentPercentage >= highestPercentage {
                mainType = physique
                highestPercentage = currentPercentage
            }
        }
        return mainType
    }
    
    func getAllPhysiquePercentage() -> [(PhysiqueType,Float)] {
        var result:[(PhysiqueType,Float)] = []
        for physique in PhysiqueType.allCases {
            let percentage = getPercentage(type: physique)
            result.append((physique,percentage))
        }
        
        result.sort(by: {$0.1 >= $1.1})
        return result
    }
}

// MARK: - Private Function
extension MyPhysiqueViewModel {
    private func getPercentage(type:PhysiqueType) -> Float {
        repo.getPhysiquePercentage(type: type)
    }
}
