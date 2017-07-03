//
//  User.swift
//  twitter_alamofire_demo
//
//  Created by Charles Hieger on 6/17/17.
//  Copyright © 2017 Charles Hieger. All rights reserved.
//

import Foundation

class User {
    
    var name: String
    var screenName: String
    var profilePicture: URL?
    
    static var current: User?
    
    init(dictionary: [String: Any]) {
        name = dictionary["name"] as? String ?? "No name"
        screenName = dictionary["screen_name"] as? String ?? "No screen name"
        
        let pictureString = dictionary["profile_image_url_https"] as? String
        if let pictureString = pictureString {
            profilePicture = URL(string: pictureString)!
        }
        
    }
}
