//
//  ControllerContactAddEdit.swift
//  Gojek Contacts
//
//  Created by Faiz Umar Baraja on 26/11/2017.
//  Copyright © 2017 FaizBarajaApps. All rights reserved.
//

import UIKit
protocol ContactDataModificationDelegate {
    func setImageViewWithImage(_ imageCaptured:UIImage)
}

class ControllerContactAddEdit: NSObject,UIImagePickerControllerDelegate,
UINavigationControllerDelegate {
    var delegate:ContactDataModificationDelegate?
    
    func canUseCamera() -> Bool{
        return UIImagePickerController.isSourceTypeAvailable(.camera)
    }
    
    func canUseLibrary() -> Bool{
        return UIImagePickerController.isSourceTypeAvailable(.photoLibrary)
    }
    
    func createPickerCamera() -> UIImagePickerController{
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = false
        picker.sourceType = UIImagePickerControllerSourceType.camera
        picker.cameraCaptureMode = .photo
        picker.modalPresentationStyle = .fullScreen
        return picker
    }
    
    func createPickerImageLibrary() -> UIImagePickerController{
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = false
        picker.sourceType = .photoLibrary
        picker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
        return picker
    }
    
    @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            self.delegate?.setImageViewWithImage(pickedImage)
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
}
