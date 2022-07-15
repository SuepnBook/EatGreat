//
//  MyPhysiqueViewModel.swift
//  EatGreat
//
//  Created by Book on 2022/7/9.
//

import RxCocoa
import RxSwift

extension MyPhysiqueViewModel {
    enum Section {
        case mainPhysique(type:PhysiqueType)
        case detail(type:DetailViewType)
    }

    enum DetailViewType {
        case analyze(viewObjects:[PhysiquePercentageTableViewCell.Object])
        case explain(explains:[ExplainType])
        
        enum ExplainType {
            case description(ExplainResultTableViewCell.Object)
            case insertLinks([InsertDomainObject.Link])
        }
    }
    
    enum MyPhysiqueDetailType {
        case analyze
        case explain
    }
}

protocol MyPhysiqueViewModelDelegate:AnyObject {
    func reload(mainPhysique:PhysiqueType)
    func reload(dataSource:[MyPhysiqueViewModel.Section])
}

class MyPhysiqueViewModel: BaseViewModel {
    
    private let repo:PhysiqueRepository = .shared
    
    weak var delegate:MyPhysiqueViewModelDelegate?

    func setup(type:MyPhysiqueDetailType) {
        updateMainPhysique()
        updateDataSource(type: type)
    }
    
    func selectViewType(type:MyPhysiqueDetailType) {
        updateDataSource(type: type)
    }
}

// MARK: - Private Function
extension MyPhysiqueViewModel {
    
    private func updateDataSource(type:MyPhysiqueDetailType) {
        var result: [Section] = []
        let mainPhysique = getMainPhysique()
        result.append(.mainPhysique(type: mainPhysique))
        
        switch type {
        case .analyze:
            let vos = getAllPhysiquePercentage()
            result.append(.detail(type: .analyze(viewObjects: vos)))
        case .explain:
            var explains:[DetailViewType.ExplainType] = []
                    
            let causes = repo.getPhysiqueCauses(type: mainPhysique)
            
            var subTitles = causes.map({$0.title})
            var links = causes.flatMap({$0.links})

            if !subTitles.isEmpty {
                explains.append(.description(.init(title: "體質成因",
                                                   subTitles: subTitles)))
            }
            
            if !links.isEmpty {
                explains.append(.insertLinks(links))
            }
            
            let features = repo.getPhysiqueFeatures(type: mainPhysique)
            
            subTitles = features.map({$0.title})
            links = features.flatMap({$0.links})

            if !subTitles.isEmpty {
                explains.append(.description(.init(title: "體質特色",
                                                   subTitles: subTitles)))
            }
            
            if !links.isEmpty {
                explains.append(.insertLinks(links))
            }
            
            result.append(.detail(type: .explain(explains: explains)))
        }
        
        delegate?.reload(dataSource: result)
    }
    
    private func updateMainPhysique()  {
        let mainType = getMainPhysique()
        delegate?.reload(mainPhysique: mainType)
    }
    
    private func getMainPhysique() -> PhysiqueType {
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
    
    private func getAllPhysiquePercentage() -> [PhysiquePercentageTableViewCell.Object] {
        var result:[PhysiquePercentageTableViewCell.Object] = []
        for physique in PhysiqueType.allCases {
            let percentage = getPercentage(type: physique)
            result.append(.init(type: physique, percentage: percentage))
        }
        
        result.sort(by: {$0.percentage >= $1.percentage})
        return result
    }
    
    private func getPercentage(type:PhysiqueType) -> Float {
        repo.getPhysiquePercentage(type: type)
    }
}
