//
//  UserDefaultManager.swift
//  Gozeppelin
//
//  Created by Book on 2021/6/3.
//

import Foundation

@propertyWrapper
struct UserDefaultOptional<T> {
    let key: String
    let defaultValue: T?

    init(key: String, defaultValue: T?) {
        self.key = key
        self.defaultValue = defaultValue
    }

    var wrappedValue: T? {
        get {
            UserDefaults.standard.object(forKey: key) as? T ?? defaultValue
        }
        set {
            if newValue == nil {
                UserDefaults.standard.removeObject(forKey: key)
            } else {
                UserDefaults.standard.set(newValue, forKey: key)
            }
        }
    }
}

@propertyWrapper
struct UserDefault<T> {
    let key: String
    let defaultValue: T

    init(key: String, defaultValue: T) {
        self.key = key
        self.defaultValue = defaultValue
    }

    var wrappedValue: T {
        get {
            UserDefaults.standard.object(forKey: key) as? T ?? defaultValue
        }
        set {
            UserDefaults.standard.set(newValue, forKey: key)
        }
    }
}

enum UserDefaultManager {
    
}

// MARK: - PhysiquePercentage
extension UserDefaultManager {
    static func savePhysiquePercentage(type:PhysiqueType, percentage:Float) {
        let key = "\(type.rawValue)Percentage"
        
        @UserDefault(key: key, defaultValue: 0)
        var physiquePercentage:Float
        
        physiquePercentage = percentage
    }
    
    static func getPhysiquePercentage(type:PhysiqueType) -> Float{
        let key = "\(type.rawValue)Percentage"
        
        @UserDefault(key: key, defaultValue: 0)
        var physiquePercentage:Float
        
        return physiquePercentage
    }
}

// MARK: - Profile
extension UserDefaultManager {

    @UserDefault(key: "nickName", defaultValue: nil)
    static var nickName:String?
    
    @UserDefault(key: "gender", defaultValue: nil)
    static var gender:String?
    
    @UserDefault(key: "height", defaultValue: nil)
    static var height:Int?
    
    @UserDefault(key: "weight", defaultValue: nil)
    static var weight:Int?
    
    @UserDefault(key: "born", defaultValue: nil)
    static var born:Int?
}
