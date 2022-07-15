//
//  PlanViewModel.swift
//  EatGreat
//
//  Created by Book on 2022/7/16.
//

import Foundation

extension PlanViewModel {
    enum CellType {
        case description(SuggestTableViewCell.Object)
        case insertLinks([InsertDomainObject.Link])
    }
}

protocol PlanViewModelDelegate:AnyObject {
    func reload(dataSource:[PlanViewModel.CellType])
}

class PlanViewModel: BaseViewModel {

    weak var delegate:PlanViewModelDelegate?
    
    private let repo:PhysiqueRepository = .shared
    
    func setup() {
        updateDataSource()
    }
}

// MARK: - Private Function
extension PlanViewModel {
    private func updateDataSource() {
        var dataSource:[PlanViewModel.CellType] = []
        
        let mainPhysique:PhysiqueType = repo.getMainPhysique()
        
        let suggests = repo.getPhysiqueSuggests(type: mainPhysique)
        
        var links:[InsertDomainObject.Link] = []
        for suggest in suggests {
            var subTitles = suggest.subTitles
            if let height = UserDefaultManager.height {
                subTitles = subTitles
                    .map({$0.replacingOccurrences(of: "$height",
                                                  with: "\(height)")})
            }
            
            dataSource.append(.description(.init(title: suggest.title,
                                                 subTitles: subTitles)))
            links.append(contentsOf: suggest.links)
        }
        
        dataSource.append(.insertLinks(links))
        delegate?.reload(dataSource: dataSource)
    }
}
