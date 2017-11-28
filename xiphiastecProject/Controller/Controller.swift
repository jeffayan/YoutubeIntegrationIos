//
//  Controller.swift
//  xiphiastecProject
//
//  Created by admin on 11/27/17.
//  Copyright © 2017 Jeff. All rights reserved.
//

import Foundation

class Controller {
        
    class func on(response : Data){
       
        guard let dictionary = self.parse(data: response) else {
            Controller.on(error: LabelTexts.main.couldnotParseData)
            return
        }
        
        apiProtocolObject?.getItems(data: self.send(dictionary: dictionary))
        
        
    }
    
    class func on(error : String) {
        
        apiProtocolObject?.on(error: error)
        
    }
    
    
    
    //  Json parsing
    
   static private func parse(data : Data)->NSDictionary?{
        
        do {
            
            if let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? NSDictionary {
                
                return dictionary
            }
            
            
        } catch let err {
            
            Controller.on(error: err.localizedDescription)
        }
        
        return nil
    }
    
    
    // parse Items data from Api
    
    static private func send(dictionary : NSDictionary)->[Item]{
        
        var itemsArray = [Item]()
        
        if let items = dictionary.value(forKey: Web.constants.items) as? [NSDictionary]{
         
            for item in items {
             
                 var itemObject = Item()
                
                 // Retriving video Id
                 if let idValues = item.value(forKey: Web.constants.id) as? NSDictionary {
                 
                    itemObject.videoId = idValues.value(forKey: Web.constants.videoId) as? String
                    
                 }
                
                // Retreiving Video Details
                
                if let snippet = item.value(forKey: Web.constants.snippet) as? NSDictionary {
                 
                    itemObject.title = snippet.value(forKey: Web.constants.title) as? String
                    
                    itemObject.description = snippet.value(forKey: Web.constants.description) as? String
                    
                    formatter.dateFormat = DateFormats.main.yyyyMMddTHHmmssSSSZ
                    
                    if let publishedDate = snippet.value(forKey : Web.constants.publishedAt) as? String, let date = formatter.date(from: publishedDate){
                        
                        formatter.dateFormat = DateFormats.main.MMMddyyyyHHmmaaa
                        
                        itemObject.publishedDate = formatter.string(from: date)
                        
                    }
                    
                    if let thumbnails = snippet.value(forKey: Web.constants.thumbnails) as? NSDictionary, let medium = thumbnails.value(forKey : Web.constants.medium) as? NSDictionary {
                        
                        itemObject.imageUrl = medium.value(forKey: Web.constants.url) as? String
                    
                    }
                    
                }
               
                itemsArray.append(itemObject)
                
            }
            
            
        }
        
        return itemsArray
        
    }
    
    
    
    
    
    
    
}
