//
//  ViewControllerContactDetail.swift
//  Gojek Contacts
//
//  Created by Faiz Umar Baraja on 25/11/2017.
//  Copyright © 2017 FaizBarajaApps. All rights reserved.
//

import UIKit

class ViewControllerContactDetail: UIViewController,UITableViewDataSource,UITableViewDelegate {
    @IBOutlet var tableContactData:UITableView!
    
    var arrayCotactKeyData:NSArray!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableContactData.dataSource = self
        tableContactData.delegate = self
        tableContactData.register(UINib(nibName: "TableViewCellContactData", bundle: nil), forCellReuseIdentifier: "TableViewCellContactData")
        
        arrayCotactKeyData = NSArray(objects: "mobile","email")
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        tableContactData.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayCotactKeyData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell: TableViewCellContactData = TableViewCellContactData(style: UITableViewCellStyle.default, reuseIdentifier: "CustomCell", cellKey :arrayCotactKeyData.object(at: indexPath.row) as? String)
            //set the data here
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCellContactData", for: indexPath) as! TableViewCellContactData
        cell.labelKey.text = arrayCotactKeyData.object(at: indexPath.row) as? String
        return cell
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
