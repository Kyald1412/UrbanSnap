//
//  UserDefaultsWrapper.swift
//  UrbanSnap
//
//  Created by Dhiky Aldwiansyah on 09/06/21.
//

import Foundation

extension UserDefaultManager{
    
    func setOnboardingCompleted(){
        saveDefaultBool(key: UserDefaultManager.ONBOARDING_COMPLETED, value: true)
    }
    
    func isOnboardingCompleted() -> Bool {
        return getDefaultBool(key: UserDefaultManager.ONBOARDING_COMPLETED)
    }
}

class UserDefaultManager {
    
    static let ONBOARDING_COMPLETED = "onboarding_completed"

    static let shared = UserDefaultManager()
    
    func saveDefault(key:String, value:String){
        UserDefaults.standard.set(value, forKey: key)
        UserDefaults.standard.synchronize()
    }
    
    func saveDefaultBool(key:String, value:Bool){
        UserDefaults.standard.set(value, forKey: key)
        UserDefaults.standard.synchronize()
    }
    
    func getDefaultString(key:String) -> String{
        return UserDefaults.standard.object(forKey: key) == nil ? "" : UserDefaults.standard.object(forKey: key) as! String
    }
    
    func getDefaultBool(key:String) -> Bool{

        return (UserDefaults.standard.object(forKey: key) != nil)
    }
    
    func removeDefaultKey(key: String){
        UserDefaults.standard.removeObject(forKey: key)
        UserDefaults.standard.synchronize()
    }
    
    func clearAllData(){
        let defaults = UserDefaults.standard
        let dictionary = defaults.dictionaryRepresentation()
        dictionary.keys.forEach { key in
            defaults.removeObject(forKey: key)
        }
    }
    
}

