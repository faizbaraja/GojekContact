//
//  ViewControllerContactAddOrEdit.swift
//  Gojek Contacts
//
//  Created by Faiz Umar Baraja on 25/11/2017.
//  Copyright © 2017 FaizBarajaApps. All rights reserved.
//

import UIKit

class ViewControllerContactAddOrEdit: UIViewController,UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,ContactDataModificationDelegate {
    
    @IBOutlet var layoutConstraintTrailingCameraIcon:NSLayoutConstraint!
    @IBOutlet weak var constraintTopHeaderLayout: NSLayoutConstraint!
    @IBOutlet var imageViewCameraIcon:UIImageView!
    @IBOutlet var imageViewProfilePicture:UIImageView!
    
    @IBOutlet var tableContactData:UITableView!
    
    var textFieldActive:UITextField!
    
    var arrayCotactKeyData:NSArray!
    let controllerContactAddEdit = ControllerContactAddEdit()
    
    let intDefaultConstantForTopLayout:CGFloat = 52
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
        controllerContactAddEdit.delegate = self
        
        tableContactData.dataSource = self
        tableContactData.delegate = self
        tableContactData.register(UINib(nibName: "TableViewCellContactData", bundle: nil), forCellReuseIdentifier: "TableViewCellContactData")
        
        arrayCotactKeyData = NSArray(objects: "First Name","Last Name","mobile","email")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShowNotification), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHideNotification), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        tableContactData.reloadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
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
    
    @IBAction func chooseProfilePicture(_ sender: Any){
        let alertSheetImageProfilePicture = UIAlertController(title: "Choose Media", message: "Choose Profile Picture", preferredStyle: .actionSheet)
        
        let actionSheetCamera = UIAlertAction(title: "Camera", style: .default)
        { _ in
            alertSheetImageProfilePicture.dismiss(animated: true, completion:nil)
            if (self.controllerContactAddEdit.canUseCamera()){
                let cameraPicker = self.controllerContactAddEdit.createPickerCamera()
                self.present(cameraPicker, animated: true, completion: nil)
            }
            else{
                let viewAlertError = UIAlertController(title: "Cannot Use Camera", message: "Your device is not able to use camera.", preferredStyle: .alert)
                let actionAlert = UIAlertAction(title: "OK", style: .cancel, handler: {(alert: UIAlertAction!) in
                    viewAlertError.dismiss(animated: true, completion: nil)})
                viewAlertError.addAction(actionAlert)
                self.present(viewAlertError, animated: true, completion: nil)
            }
        }
        
        let actionSheetGallery = UIAlertAction(title: "Library", style: .default)
        { _ in
            alertSheetImageProfilePicture.dismiss(animated: true, completion:nil)
            if (self.controllerContactAddEdit.canUseLibrary()){
                let libraryPicker = self.controllerContactAddEdit.createPickerImageLibrary()
                self.present(libraryPicker, animated: true, completion: nil)
            }
            else{
                let viewAlertError = UIAlertController(title: "Cannot Open Medi Library", message: "Your device is not able to open library.", preferredStyle: .alert)
                let actionAlert = UIAlertAction(title: "OK", style: .cancel, handler: {(alert: UIAlertAction!) in
                    viewAlertError.dismiss(animated: true, completion: nil)})
                viewAlertError.addAction(actionAlert)
                self.present(viewAlertError, animated: true, completion: nil)
            }
        }
        
        let actionSheetCancel = UIAlertAction(title: "Cancel", style: .default)
        { _ in
            alertSheetImageProfilePicture.dismiss(animated: true, completion: nil)
        }
        alertSheetImageProfilePicture .addAction(actionSheetCamera)
        alertSheetImageProfilePicture .addAction(actionSheetGallery)
        alertSheetImageProfilePicture .addAction(actionSheetCancel)
        
        present(alertSheetImageProfilePicture, animated: true, completion: nil)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField){
        let frameInsideTableView:CGPoint = textField.frame.origin
        let frameConvertToSuperView:CGPoint = textField.convert(textField.frame.origin, to: tableContactData)
        let frameConvertToRoot:CGPoint = textField.convert(textField.frame.origin, to: self.view)
        print("\(frameInsideTableView) + \(frameConvertToSuperView) + \(frameConvertToRoot)")
        textFieldActive = textField
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
    
    @objc func keyboardWillShowNotification(notification: NSNotification) {
        let keyboardSize:CGRect = (notification.userInfo![UIKeyboardFrameEndUserInfoKey] as? CGRect)!
        let frameConvertToRoot:CGPoint = textFieldActive.convert(textFieldActive.frame.origin, to: self.view)
        let keyboardOrigin:CGPoint = keyboardSize.origin
        
        let textFieldMaxYPosition:CGFloat = frameConvertToRoot.y + textFieldActive.frame.size.height
        
        if (textFieldMaxYPosition > keyboardOrigin.y){
            let textFieldDistanceToKeyboardOriginY:CGFloat = textFieldMaxYPosition - keyboardOrigin.y
            constraintTopHeaderLayout.constant = intDefaultConstantForTopLayout - textFieldDistanceToKeyboardOriginY - 10
            
            UIView.animate(withDuration: 0.25, animations: {
                self.view.layoutIfNeeded()
            })
        }
    }
    
    @objc func keyboardWillHideNotification(notification: NSNotification) {
        constraintTopHeaderLayout.constant = intDefaultConstantForTopLayout
        UIView.animate(withDuration: 0.25, animations: {
            self.view.layoutIfNeeded()
        })
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
        cell.textFieldValue.delegate = self
        cell.labelKey.text = arrayCotactKeyData.object(at: indexPath.row) as? String
        return cell
    }
    
    func setImageViewWithImage(_ imageCaptured:UIImage){
        imageViewProfilePicture.image = imageCaptured
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
