//
//  File.swift
//  Reading List
//
//  Created by Madison Waters on 9/11/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import Foundation

struct Book: Equatable, Codable {
    
    let title: String
    let reasonToRead: String
    let hasBeenRead: Bool
    
    init(title: String, reasonToRead: String, hasBeenRead: Bool = false){
        self.title = title
        self.reasonToRead = reasonToRead
        self.hasBeenRead = hasBeenRead
    }
}
