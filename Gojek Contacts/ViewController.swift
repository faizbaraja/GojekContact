//
//  ViewController.swift
//  Gojek Contacts
//
//  Created by Faiz Umar Baraja on 25/11/2017.
//  Copyright © 2017 FaizBarajaApps. All rights reserved.
//

import UIKit
import CoreData
class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,ControllerMainViewDelegate {
    let controllerMainView = ControllerMainView()
    let modelContactDataState = ModelContactDataState()
    
    var viewContactAddOrEditPage:ViewControllerContactAddOrEdit!
    var viewControllerContactDetail:ViewControllerContactDetail!
    
    @IBOutlet var tableListContactData:UITableView!
    var indexOfNumbers = [String]()
    
    var images_cache = [String:UIImage]()
    let collation = UILocalizedIndexedCollation.current()
    var sections: [[AnyObject]] = []
    var objects: [AnyObject] = [] {
        didSet {
            let selector: Selector = #selector(getter: UIApplicationShortcutItem.localizedTitle)
            sections = Array(repeating: [], count: collation.sectionTitles.count)
            
            let sortedObjects = collation.sortedArray(from: objects, collationStringSelector: selector)
            for object in sortedObjects {
                let sectionNumber = collation.section(for: object, collationStringSelector: selector)
                sections[sectionNumber].append(object as AnyObject)
            }
            
            self.tableListContactData.reloadData()
        }
    }
    var tableData : [String:[NSManagedObject]]!
    var tableDataKeys : [String]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        controllerMainView.delegate = self
        
        viewContactAddOrEditPage = ViewControllerContactAddOrEdit(nibName: "ViewControllerContactAddOrEdit", bundle: nil, viewPurpose:"AddContact");
        viewControllerContactDetail = ViewControllerContactDetail(nibName: "ViewControllerContactDetail", bundle: nil)
        
        
        // Do any additional setup after loading the view, typically from a nib.
        tableListContactData.dataSource = self
        tableListContactData.delegate = self
        tableListContactData.register(UINib(nibName: "TableViewCellContactList", bundle: nil), forCellReuseIdentifier: "TableViewCellContactList")
        
        tableData = [:]
        tableDataKeys = tableData.keys.sorted()
        
        self.getContactFromServer()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func getContactFromServer(){
        controllerMainView.getContactsDataFromServer()
    }
    
    @IBAction func showAddPage(_ sender: Any) {
        self.navigationController?.pushViewController(viewContactAddOrEditPage, animated: true)
    }
    
    @IBAction func showContactDetail(_ sender: Any) {
        self.navigationController?.pushViewController(viewControllerContactDetail, animated: true)
    }
    
    func loadData(){
        tableData = controllerMainView.getDataForTableView()
        tableDataKeys = tableData.keys.sorted()
        DispatchQueue.main.async{
            self.tableListContactData.reloadData()
        }
    }
    
    func setImageDownloadedFromURL(_ imageFile:UIImage, imageViewContact:UIImageView, stringImageLink:String){
        self.images_cache[stringImageLink] = imageFile
        imageViewContact.image = imageFile
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return tableDataKeys.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let stringSectionTitle = tableDataKeys[section]
        let tableDataForSection = tableData[stringSectionTitle]
        return tableDataForSection!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //set the data here
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCellContactList", for: indexPath) as! TableViewCellContactList
        let sectionTitle = tableDataKeys[indexPath.section];
        let sectionData = tableData[sectionTitle]!
        if (sectionData.count > 0){
            let data = sectionData[indexPath.row];
            cell.labelContactName.text = "\(data.value(forKey: "first_name") as! String) \(data.value(forKey: "last_name") as! String)"
            if let profilePictureURL = data.value(forKey: "profile_pic") as! String? {
                
                if (images_cache[profilePictureURL] != nil)
                {
                    cell.imageContact.image = images_cache[profilePictureURL]
                }
                else
                {
                    controllerMainView.loadImageFromURL(link: profilePictureURL, imageview: cell.imageContact)
                }
            }
            
            if (data.value(forKey: "favorite") as! Int == 0){
                cell.imageContactFavourite.isHidden = true
            }
            else{
                cell.imageContactFavourite.isHidden = false
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        let sectionTitle = tableDataKeys[indexPath.section]
        let sectionData = tableData[sectionTitle]!
        let data = sectionData[indexPath.row]
        
        modelContactDataState.setSelectedContactData(contactDataSelected: data)
        viewControllerContactDetail.modelContactDataState = modelContactDataState
        self.navigationController?.pushViewController(viewControllerContactDetail, animated: true)
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return collation.sectionTitles[section]
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return collation.sectionIndexTitles
    }
    
    func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
        return collation.section(forSectionIndexTitle: index)
    }
}

