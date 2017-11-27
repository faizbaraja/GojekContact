//
//  ViewController.swift
//  Gojek Contacts
//
//  Created by Faiz Umar Baraja on 25/11/2017.
//  Copyright © 2017 FaizBarajaApps. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    let controllerMainView = ControllerMainView()
    
    var viewContactAddOrEditPage:ViewControllerContactAddOrEdit!
    var viewControllerContactDetail:ViewControllerContactDetail!
    
    @IBOutlet var tableListContactData:UITableView!
    var indexOfNumbers = [String]()
    
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
    var tableData : [String:[String]]!
    var tableDataKeys : [String]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewContactAddOrEditPage = ViewControllerContactAddOrEdit(nibName: "ViewControllerContactAddOrEdit", bundle: nil, viewPurpose:"AddContact");
        viewControllerContactDetail = ViewControllerContactDetail(nibName: "ViewControllerContactDetail", bundle: nil)
        // Do any additional setup after loading the view, typically from a nib.
        tableListContactData.dataSource = self
        tableListContactData.delegate = self
        tableListContactData.register(UINib(nibName: "TableViewCellContactList", bundle: nil), forCellReuseIdentifier: "TableViewCellContactList")
        
        tableData = controllerMainView.getDataForTableView()
        tableDataKeys = tableData.keys.sorted()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func showAddPage(_ sender: Any) {
        self.navigationController?.pushViewController(viewContactAddOrEditPage, animated: true)
    }
    
    @IBAction func showContactDetail(_ sender: Any) {
        self.navigationController?.pushViewController(viewControllerContactDetail, animated: true)
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
            cell.labelContactName.text = data
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
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

