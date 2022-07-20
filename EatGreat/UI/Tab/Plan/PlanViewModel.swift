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
                    .map({ title in
                        let calcProteinx1 = Int(Float( height - 110 ) * 3.75 / 5)
                        let calcProteinx2 = Int(Float( height - 110 ) * 3.75 / 5 * 2)
                        return title.replacingOccurrences(of: "$height",
                                                   with: "\(height)")
                        .replacingOccurrences(of: "$calcProteinx1",
                                                   with: "\(calcProteinx1)")
                        .replacingOccurrences(of: "$calcProteinx2",
                                                   with: "\(calcProteinx2)")
                    })
            }
            
            dataSource.append(.description(.init(title: suggest.title,
                                                 subTitles: subTitles)))
            links.append(contentsOf: suggest.links)
        }
        
        if !links.isEmpty {
            links = links.uniqued()
            dataSource.append(.insertLinks(links))
        }
        
        dataSource.append(.description(.init(title: "更多建議",
                                             subTitles: ["想要了解更多請至個人設定裡頭搜尋🔍更多體質課程",
                                                        "想要重新測試請至個人設定裡點按🔍重新進行測驗"])))
        
        delegate?.reload(dataSource: dataSource)
    }
}
