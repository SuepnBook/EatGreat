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
            dataSource.append(.description(.init(title: suggest.title,
                                                 subTitles: suggest.subTitles)))
            links.append(contentsOf: suggest.links)
        }
        
        dataSource.append(.insertLinks(links))
        delegate?.reload(dataSource: dataSource)
    }
}
