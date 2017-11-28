//
//  Constants.swift
//  xiphiastecProject
//
//  Created by admin on 11/27/17.
//  Copyright © 2017 Jeff. All rights reserved.
//

import Foundation

// Base Url for Api 
let BaseUrl = "https://www.googleapis.com/youtube/v3/search?part=id,snippet&maxResults=20&channelId=UCCq1xDJMBRF61kiOgU90_kw&key=AIzaSyBRLPDbLkFnmUv13B-Hq9rmf0y7q8HOaVs"

// Static Messages
struct LabelTexts {
    
    static let main = LabelTexts()
    
    let inValidUrl = "InValid Url"
    let couldNotConnectToServer = "Could not connect to server..."
    let couldnotParseData = "Could not parse Data..."
    let OK = "Ok"
    let Cancel = "Cancel"
    let InBuiltPlayer = "InBuild Player"
    let youtube = "YouTube"
    let playVideoIn = "Play Video In"
    let saveError = "Could not save to Core Data..."
    let fetchError = "Could not fetch from Core Data..."
    
}

// Date Formats

struct DateFormats {
    
    static let main = DateFormats()
    
    let yyyyMMddTHHmmssSSSZ = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
    let MMMddyyyyHHmmaaa = "MMM dd, yyyy HH:mm aaa"
   
}



// Api protocol Delegate Object

var apiProtocolObject : ApiProtocol?

// Global Formatter

let formatter = DateFormatter()


// Storyboard Id

let detailedViewStoryboardId = "detailedViewStoryoardID"


// Core Data Entity Name

let coreDataEntity_ItemEntity = "ItemEntity"
