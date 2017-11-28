//
//  Cache.swift
//  xiphiastecProject
//
//  Created by admin on 11/27/17.
//  Copyright © 2017 Jeff. All rights reserved.
//

import UIKit

class Cache {
    
    static let shared = NSCache<AnyObject, UIImage>()
    
    //
    class func get(image : String?, completion : @escaping ((url : String, image : UIImage?)?)->()){
        
        DispatchQueue.global(qos: .utility).async {
            
            var uiImage : UIImage?
            
            guard let imageUrl = image else {
                completion(nil)
                return
            }
            
            // Retreving previous image from cache
            
            uiImage = self.shared.object(forKey: imageUrl as AnyObject)
            
            if uiImage == nil, let url = URL(string: imageUrl){
                
                do {
                    
                    let data = try Data(contentsOf: url)
                    uiImage = UIImage(data: data)
                    
                    if uiImage != nil {
                        // If Image is not nil, store in cache
                        self.shared.setObject(uiImage!, forKey: imageUrl as AnyObject)
                        
                    }
                    
                    completion((url : imageUrl, image : uiImage))
                    return
                    
                }catch let err {
                    
                    print(err.localizedDescription)
                    
                    completion(nil)
                    return
                }
                
            } else {
             
                 completion((url : imageUrl, image : uiImage))
                
            }
            
            
            
        }
    }
    
    
    
}
