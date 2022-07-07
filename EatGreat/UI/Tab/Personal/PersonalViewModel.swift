//
//  PersonalViewModel.swift
//  EatGreat
//
//  Created by Book on 2022/7/8.
//

import UIKit

class PersonalViewModel: BaseViewModel {
    enum CellType {
        case modifyProfile
        case modifyTest
        case more
        
        var description:String {
            switch self {
            case .modifyProfile:
                return "修改個人資料"
            case .modifyTest:
                return "重新進行測驗"
            case .more:
                return "更多體質課程"
            }
        }
    }
    
    func getDataSource() -> [CellType] {
        return  [.modifyProfile,
                 .modifyTest,
                 .more]
    }
}
