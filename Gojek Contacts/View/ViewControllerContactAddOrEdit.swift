//
//  ViewControllerContactAddOrEdit.swift
//  Gojek Contacts
//
//  Created by Faiz Umar Baraja on 25/11/2017.
//  Copyright © 2017 FaizBarajaApps. All rights reserved.
//

import UIKit

class ViewControllerContactAddOrEdit: UIViewController {
    @IBOutlet var layoutConstraintTrailingCameraIcon:NSLayoutConstraint!
    @IBOutlet var imageViewCameraIcon:UIImageView!
    required init?(coder aDecoder: NSCoder) {
        print("init coder style")
        super.init(coder: aDecoder)
    }

    init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?, viewPurpose viewPurposeOrNil: String?)   {
        print("init nibName style "+viewPurposeOrNil!)
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        if (viewPurposeOrNil=="AddContact"){
            self.navigationItem.title = ""
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: UIBarButtonItemStyle.plain,     target: self, action: #selector(saveContactData))
            self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.plain,     target: self, action: #selector(cancelContactData))
        }
    }
    
    override func viewDidLoad() {
        //layoutConstraintTrailingCameraIcon.constant = -(imageViewCameraIcon.frame.size.width/2)
        //self.view.layoutIfNeeded()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func saveContactData(_ sender: Any){
        
    }
    
    @IBAction func cancelContactData(_ sender: Any){
        self.navigationController?.popViewController(animated: true)
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
