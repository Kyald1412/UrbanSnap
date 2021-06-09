//
//  UserDefaultsWrapper.swift
//  UrbanSnap
//
//  Created by Dhiky Aldwiansyah on 09/06/21.
//

import Foundation

class UserDef {
    
    static let ONBOARDING_COMPLETED = "onboarding_completed"

    static let shared = UserDef()
    
    func setOnboardingCompleted(isCompleted: Bool){
        UserDefaults.standard.set(isCompleted, forKey: UserDef.ONBOARDING_COMPLETED)
        UserDefaults.standard.synchronize()
    }

    func isOnboardingCompleted() -> Bool{
        return UserDefaults.standard.object(forKey: UserDef.ONBOARDING_COMPLETED) == nil ? false : UserDefaults.standard.object(forKey: UserDef.ONBOARDING_COMPLETED) as! Bool
    }
    
    func removeDefaultKey(key: String){
        UserDefaults.standard.removeObject(forKey: key)
        UserDefaults.standard.synchronize()
    }
    
    func clearAllData(){
        let defaults = UserDefaults.standard
        let dictionary = defaults.dictionaryRepresentation()
        dictionary.keys.forEach { key in
            print("DATA CLEAR \(key)")
            defaults.removeObject(forKey: key)
        }
    }
    
}

