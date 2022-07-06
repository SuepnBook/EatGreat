//
//  ProfileViewModel.swift
//  EatGreat
//
//  Created by Book on 2022/7/6.
//

import Foundation
import RxCocoa
import RxSwift

class ProfileViewModel: BaseViewModel {
    func genderDataSource() -> [String] {
        ["男","女"]
    }
    
    func heightDataSource() -> [String] {
        var result:[String] = []
        for i in 140...200 {
            result.append("\(i)")
        }
        return result
    }
    
    func weightDataSource() -> [String] {
        var result:[String] = []
        for i in 40...100 {
            result.append("\(i)")
        }
        return result
    }
    
    func bornDataSource() -> [String] {
        var result:[String] = []
        for i in 1922...2010 {
            result.append("\(i)")
        }
        return result
    }
    
    func updateProfile(nickName:String?,gender:String?,
                       height:String?,weight:String?,
                       born:String?) -> Single<Void> {
        guard let nickName = nickName,
              let gender = gender,
              let height = height,
              let height = Int(height),
              let weight = weight,
              let weight = Int(weight),
              let born = born,
              let born = Int(born) else {
            return Single.error(SwiftError.errorMessage(message: "Error - UpdateProfile"))
        }
        UserDefaultManager.nickName = nickName
        UserDefaultManager.gender = gender
        UserDefaultManager.height = height
        UserDefaultManager.weight = weight
        UserDefaultManager.born = born
        
        return Single.just(())
    }
}
