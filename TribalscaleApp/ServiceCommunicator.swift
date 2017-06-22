//
//  ServiceCommunicator.swift
//  TribalscaleApp
//
//  Created by Ashish Mishra on 6/21/17.
//  Copyright © 2017 Ashish Mishra. All rights reserved.
//

import UIKit
import Alamofire

class ServiceCommunicator: NSObject {
    
    
    func fetchUsers(completionBlock : @escaping ([UserInfo]?, Error?) -> ()) {
        
        let randomUserUrl = "https://randomuser.me/api/?results=5000"
        
        Alamofire.request(randomUserUrl, method: .get, parameters: nil, encoding: JSONEncoding.default).response { (response) in
            if let result = response.data {
                do {
                    
                    var parsedUsers : [UserInfo] = []
                    
                    let parsedData = try JSONSerialization.jsonObject(with: result, options: []) as! [String:Any]
                    
                    let users = parsedData["results"] as! [Dictionary<String, Any>]
                    
                    for aObj in users {
                    
                        let aUserInfo = UserInfo()
                        var userNameComponents = aObj["name"] as! Dictionary<String, String>
                        aUserInfo.name = userNameComponents["first"]! + " " + userNameComponents["last"]!
                        
                        aUserInfo.gender = aObj["gender"] as? String
                        aUserInfo.emailId = aObj["email"] as? String
                        aUserInfo.cellNo = aObj["cell"] as? String
                        aUserInfo.dob = aObj["dob"] as? String
                        
                        var avatarComponents = aObj["picture"] as! Dictionary<String, String>
                        
                        aUserInfo.avatarMedUrl = avatarComponents["medium"]
                        aUserInfo.avatarLarge = avatarComponents["large"]
                        
                        parsedUsers.append(aUserInfo)
                    }
                    
                    completionBlock(parsedUsers,nil)
                    
                    
                } catch let error as NSError {
                    completionBlock(nil,error)
                }
                
            }
        }
    }
    
    
    
    

}
