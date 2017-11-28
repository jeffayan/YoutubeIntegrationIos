//
//  MainPageTableViewCell.swift
//  xiphiastecProject
//
//  Created by admin on 11/27/17.
//  Copyright © 2017 Jeff. All rights reserved.
//

import UIKit

class MainPageTableViewCell : UITableViewCell {
    
    @IBOutlet private var labelTitle : UILabel!
    
    @IBOutlet private var labelDescription : UILabel!
    
    @IBOutlet private var imageViewVideo : UIImageView!
    
    @IBOutlet private var labelDate : UILabel!
    
    // Set TableView Cell Values from Item
    
    private var imageUrl : String?
    
    func set(values : ItemEntity){
        
        self.labelTitle.text = values.title
        self.labelDescription.text = values.desc
        self.labelDate.text = values.publishedDate
        self.imageUrl = values.imageUrl
        self.imageViewVideo.image = #imageLiteral(resourceName: "placeholder")
        
        Cache.get(image: imageUrl) { (image) in
            
            // Retrieving Image from Cache
            
            if self.imageUrl == image?.url, image?.image != nil {
                
                DispatchQueue.main.async {
                    
                    self.imageViewVideo.image = image?.image
                    
                }
                
            }
            
            
        }
        
    }
    
    
}
