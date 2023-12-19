//
//  Constant.swift
//  Flash Chat iOS13
//
//  Created by Ajay Kumar on 17/12/23.
//  Copyright © 2023 Angela Yu. All rights reserved.
//

import Foundation

struct k {
    
    static let  RegisterToChat = "RegisterToChat"
    static let  LoginToChat = "LoginToChat"
    static let  textFlashe = "⚡️FlashChat"
    static let cellIdentifier = "ReusableCell"
    static let cellNibName = "MessageCellTableViewCell"
    
    struct BrandColors {
        
        static let purple = "BrandPurple"
        static let lightPurple = "BrandLightPurple"
        static let blue = "BrandBlue"
        static let dateField = "date"
        
    }
    
    struct FStore {
        
        static let collectionName = "message"
        static let senderField = "sender"
        static let bodyField = "body"
        static let dateField = "date"
        
    }
    
}
