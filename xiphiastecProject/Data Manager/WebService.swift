//
//  WebService.swift
//  xiphiastecProject
//
//  Created by admin on 11/27/17.
//  Copyright © 2017 Jeff. All rights reserved.
//

import Foundation

class WebService {
    
    class func getData(){
        
        guard let url = URL(string: BaseUrl) else {
             Controller.on(error: LabelTexts.main.inValidUrl)
             return
        }
        
        let urlRequest = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            
            guard let data = data, error == nil else {
                
                Controller.on(error: LabelTexts.main.couldNotConnectToServer)
                return
                
            }
            
            Controller.on(response: data) // Sending response data to controller for json parsing 
            
            
        }.resume()
        
        
        
    }
    
    
}
