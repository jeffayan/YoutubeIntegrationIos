//
//  Protocols.swift
//  xiphiastecProject
//
//  Created by admin on 11/27/17.
//  Copyright © 2017 Jeff. All rights reserved.
//

import Foundation

//MARK:- WebService Protocol

protocol ApiProtocol {
    
    func getItems(data : [Item])
    func on(error : String)
    
}
