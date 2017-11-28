//
//  ViewController.swift
//  xiphiastecProject
//
//  Created by admin on 11/27/17.
//  Copyright © 2017 Jeff. All rights reserved.
//

import UIKit
import CoreData

class MainViewController: UITableViewController {

    // TableView Cell reusable Identifier
    private let tableViewCellId = "cellId"
    
    private var activityIndicator : UIActivityIndicatorView?
    
    private let context = AppDelegate.shared.persistentContainer.viewContext // CoreData Context
    
    // Table View Datasource
    private var dataSource = [ItemEntity]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.activityIndicator = showActivity(inView: self.view)
        apiProtocolObject = self
        self.loadtableViewDataSource()
        
    }

    // Hide Activity Indicator
    
    private func hideLoaders(){
        
        self.activityIndicator?.stopAnimating()
        
    }
    
    // Load Table View Data Source
    private func loadtableViewDataSource(){
        
        if Reachability.isConnectedToNetwork() {
            WebService.getData()
        } else {
            self.fetch()
        }
        
    }
    
    // Load Video
    
    private func loadVideoIn(index : Int){
        
       let alert = showAlert(message: LabelTexts.main.playVideoIn, actions: [(title : LabelTexts.main.youtube, style : .default, handler :{ Void in
                                      self.loadInApp(videoId: self.dataSource[index].videoId)
                          }),(title : LabelTexts.main.InBuiltPlayer, style : .default, handler :{ Void in
                                      self.loadInBuiltPlayer(index: index)
                          }), (title : LabelTexts.main.Cancel, style : .cancel, handler :nil)], type: .actionSheet)
        
       self.present(alert, animated: true, completion: nil)
        
    }
    
    
    
    // Open in youtube app if installed or else load in safari
    
    private func loadInApp(videoId : String?){
        
        guard let appUrl = URL(string:"youtube://\(videoId ?? "")"), let webUrl = URL(string:"http://www.youtube.com/watch?v=\(videoId ?? "")") else {
            
            self.present(showAlert(message: LabelTexts.main.inValidUrl, type: .alert), animated: true, completion: nil)
            
            return
            
        }
        
        let url = UIApplication.shared.canOpenURL(appUrl) ? appUrl : webUrl
        
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
            
//        } else {
//            self.present(showAlert(message: LabelTexts.main.inValidUrl, type: .alert), animated: true, completion: nil)
//        }

        
    }
    
    
    // Show in InBuild Player
    
    private func loadInBuiltPlayer(index : Int){
        
        if let dvc = self.storyboard?.instantiateViewController(withIdentifier: detailedViewStoryboardId) as? DetailedViewController {
            
            dvc.set(item: dataSource[index])
            
            self.navigationController?.pushViewController(dvc, animated: true)
            
        }
        
    }
    
    

}


//MARK:- Table view Implementation

extension MainViewController {
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let tableViewCell = tableView.dequeueReusableCell(withIdentifier: self.tableViewCellId, for: indexPath) as? MainPageTableViewCell {
            
            if self.dataSource.count > indexPath.row {
                // Setting Cell Values
                tableViewCell.set(values: self.dataSource[indexPath.row])
                
            }
            
            return tableViewCell
        }
        
        return UITableViewCell()
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if dataSource.count > indexPath.row {
            self.loadVideoIn(index: indexPath.row)
        }
        
        
    }
    
    
    
    private func reloadTable(){
        
        DispatchQueue.main.async {
            
            self.hideLoaders()
            self.tableView.reloadData()
        }
        
    }
    
    
}


//MARK:- API Protocol Implementation

extension MainViewController : ApiProtocol {
    
    func on(error: String) {
        
        DispatchQueue.main.async {
            
            self.present(showAlert(message: error, type: .alert), animated: true, completion: {
                self.hideLoaders()
            })
            
        }
        
        
    }
    
    func getItems(data: [Item]) {
        
        self.loadData(items: data)
                
    }
    
}


// MARK:- Core Data Implementation


extension MainViewController {
    
    // Save to Core Data
    
    private func save(){
        
        do {
            
            try context.save()
            
        } catch let err {
            self.present(showAlert(message: LabelTexts.main.saveError+"\n"+err.localizedDescription, type: .alert), animated: true, completion: nil)
        }
        
    }
    
    
    // Load Data into Entity
    
    private func loadData(items : [Item]){
        
        self.clearExistingData()
        
        for item in items{
            
            let itemEntity = NSEntityDescription.insertNewObject(forEntityName: coreDataEntity_ItemEntity, into: self.context) as? ItemEntity
            
            itemEntity?.videoId = item.videoId
            itemEntity?.desc = item.description
            itemEntity?.imageUrl = item.imageUrl
            itemEntity?.publishedDate = item.publishedDate
            itemEntity?.title = item.title
            
            save()
            
        }
        
        self.fetch()
        
        
    }
    
    // Fetch from Core Data
    
    private func fetch(){
        
        do {
            
            let itemFetch = ItemEntity.fetch()
            
            itemFetch.returnsObjectsAsFaults = false
            
            self.dataSource = try context.fetch(itemFetch)
            
            self.reloadTable()
            
            
        }catch let err {
            
            self.present(showAlert(message: LabelTexts.main.fetchError+"\n"+err.localizedDescription, type: .alert), animated: true, completion: nil)
            
        }
        
    }
    
    
    // Delete Existing Data
    
    private func clearExistingData(){
        
        do {
            
            let deleteRequest = NSBatchDeleteRequest(fetchRequest: NSFetchRequest(entityName: coreDataEntity_ItemEntity))
            
            try context.execute(deleteRequest)
            
        } catch let err{
            
            self.present(showAlert(message: err.localizedDescription, type: .alert), animated: true, completion: nil)
        
        }
        
    }
    
    
    
}




