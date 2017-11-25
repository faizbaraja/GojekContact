//
//  ViewController.swift
//  Gojek Contacts
//
//  Created by Faiz Umar Baraja on 25/11/2017.
//  Copyright © 2017 FaizBarajaApps. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var viewContactAddOrEditPage:ViewControllerContactAddOrEdit!
    var viewControllerContactDetail:ViewControllerContactDetail!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewContactAddOrEditPage = ViewControllerContactAddOrEdit(nibName: "ViewControllerContactAddOrEdit", bundle: nil, viewPurpose:"AddContact");
        viewControllerContactDetail = ViewControllerContactDetail(nibName: "ViewControllerContactDetail", bundle: nil)
        // Do any additional setup after loading the view, typically from a nib.
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

}

