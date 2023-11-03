//
//  UserDefaultsManager.swift
//  RealEstateFunding
//
//  Created by iMacRoman on 03.11.2023.
//

import Foundation
class UserDefaultsManager {
    static let shared = UserDefaultsManager()
    var UD = UserDefaults()
       // Private initializer to prevent direct instantiation
       private init() { }

       // MARK: - Keys for UserDefaults
       private struct Keys {
           static let username = "Username"
           static let userAge = "UserAge"
           // Define additional keys as needed
       }
       
       // MARK: - User-related methods
    var user: User? {
        get {
          if let data = UserDefaults.standard.data(forKey: "user") {
                do {
                    let decoder = JSONDecoder()
                    let decodedStruct = try decoder.decode(User.self, from: data)
                    // Use the decoded struct
                    return decodedStruct
                } catch {
                    // Handle decoding error
                }
            }
             return nil
        }
        
        set {
            do {
                let encoder = JSONEncoder()
                if let encoded = try? encoder.encode(newValue) {
                    UserDefaults.standard.set(encoded, forKey: "user")
                }
            } catch {
                // Handle encoding error
            }
        }
    }
}
