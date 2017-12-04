//
//  ViewControllerContactDetail.swift
//  Gojek Contacts
//
//  Created by Faiz Umar Baraja on 25/11/2017.
//  Copyright © 2017 FaizBarajaApps. All rights reserved.
//

import UIKit

class ViewControllerContactDetail: UIViewController,UITableViewDataSource,UITableViewDelegate
{
    var modelContactDataState:ModelContactDataState!
    var viewContactAddOrEditPage:ViewControllerContactAddOrEdit!
    
    @IBOutlet var tableContactData:UITableView!
    @IBOutlet var labelContactName:UILabel!
    @IBOutlet var imageViewContactPicutre:UIImageView!
    
    let controllerContactDetail = ControllerContactDetail()
    var arrayCotactKeyData:NSArray!
    
    required init?(coder aDecoder: NSCoder) {
        print("init coder style")
        super.init(coder: aDecoder)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?)   {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.navigationItem.title = ""
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit", style: UIBarButtonItemStyle.plain,     target: self, action: #selector(editContactData))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewContactAddOrEditPage = ViewControllerContactAddOrEdit(nibName: "ViewControllerContactAddOrEdit", bundle: nil, viewPurpose:"EditContact");
        
        tableContactData.dataSource = self
        tableContactData.delegate = self
        tableContactData.register(UINib(nibName: "TableViewCellContactData", bundle: nil), forCellReuseIdentifier: "TableViewCellContactData")
        
        arrayCotactKeyData = NSArray(objects: "mobile","email")
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("contact data selected \(modelContactDataState.getSelectedContactData())")
        self.setContactDetailData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        tableContactData.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setContactDetailData(){
        let dictionaryContactSelected = modelContactDataState.getSelectedContactData()
        labelContactName.text = "\(dictionaryContactSelected["first_name"] as! String) \(dictionaryContactSelected["last_name"] as! String)"
    }
    
    @IBAction func editContactData(_ sender: Any){
        self.navigationController?.pushViewController(viewContactAddOrEditPage, animated: true)
    }
    
    @IBAction func operMessageApp(sender : Any){
        if (controllerContactDetail.canSendText()){
            let messageComposeVC = controllerContactDetail.actionComposeMessage(contactPhoneNumber: "1212121", bodyMessage: "1adkadadadsa")
            present(messageComposeVC, animated: true, completion: nil)
        }
        else{
            let viewAlertError = UIAlertController(title: "Cannot Send Text Message", message: "Your device is not able to send text messages.", preferredStyle: .alert)
            let actionAlert = UIAlertAction(title: "OK", style: .cancel, handler: {(alert: UIAlertAction!) in
                viewAlertError.dismiss(animated: true, completion: nil)})
            viewAlertError.addAction(actionAlert)
            present(viewAlertError, animated: true, completion: nil)
        }
    }
    
    @IBAction func makePhoneCall(sender : Any){
        if (controllerContactDetail.canMakePhoneCall()){
            controllerContactDetail.actionCallContact(contactPhoneNumber: "13131313")
        }
        else{
            let viewAlertError = UIAlertController(title: "Cannot Make Phone Call", message: "Your device is not able to make phone call.", preferredStyle: .alert)
            let actionAlert = UIAlertAction(title: "OK", style: .cancel, handler: {(alert: UIAlertAction!) in
                viewAlertError.dismiss(animated: true, completion: nil)})
            viewAlertError.addAction(actionAlert)
            present(viewAlertError, animated: true, completion: nil)
        }
    }
    
    @IBAction func sendEmailToContact(sender : Any){
        if (controllerContactDetail.canSendMail()){
            //controllerContactDetail.actionCallContact(contactPhoneNumber: "13131313")
            controllerContactDetail.actionMailContact(recipientAddress: "faiz.baraja89@gmail.com", mailSubject: "Test Subject", messageBody: "test body")
        }
        else{
            let viewAlertError = UIAlertController(title: "Cannot Send EMail", message: "Your device is not able to send email.", preferredStyle: .alert)
            let actionAlert = UIAlertAction(title: "OK", style: .cancel, handler: {(alert: UIAlertAction!) in
                viewAlertError.dismiss(animated: true, completion: nil)})
            viewAlertError.addAction(actionAlert)
            present(viewAlertError, animated: true, completion: nil)
        }
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
        cell.isUserInteractionEnabled = false
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
