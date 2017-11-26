//
//  ControllerContactDetail.swift
//  Gojek Contacts
//
//  Created by Faiz Umar Baraja on 26/11/2017.
//  Copyright © 2017 FaizBarajaApps. All rights reserved.
//

import UIKit
import MessageUI
class ControllerContactDetail: NSObject,MFMessageComposeViewControllerDelegate,MFMailComposeViewControllerDelegate {
    
    func canSendText() -> Bool {
        return MFMessageComposeViewController.canSendText()
    }
    
    func canMakePhoneCall() -> Bool {
        return UIApplication.shared.canOpenURL(URL(string: "tel://")!)
    }
    
    func canSendMail() -> Bool {
        return MFMailComposeViewController.canSendMail()
    }
    
    func actionComposeMessage(contactPhoneNumber:String, bodyMessage:String)->MFMessageComposeViewController{
        let messageVC = MFMessageComposeViewController()
        messageVC.body = bodyMessage;
        messageVC.recipients = [contactPhoneNumber]
        messageVC.messageComposeDelegate = self
        return messageVC
    }
    
    func actionCallContact(contactPhoneNumber:String){
        guard let number = URL(string: "tel://" + contactPhoneNumber) else { return }
        UIApplication.shared.open(number)
    }
    
    func actionMailContact(recipientAddress:String, mailSubject:String, messageBody:String){
        let composeVC = MFMailComposeViewController()
        composeVC.mailComposeDelegate = self
        
        // Configure the fields of the interface.
        composeVC.setToRecipients([recipientAddress])
        composeVC.setSubject(mailSubject)
        composeVC.setMessageBody(messageBody, isHTML: false)
    }
    
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        switch result.rawValue {
        case 0:
            print("Message was cancelled")
        case 1:
            print("Message was sent")
        case 2:
            print("Message failed")
        default:
            break
        }
        controller.dismiss(animated: true, completion: nil)
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController,
                               didFinishWith result: MFMailComposeResult, error: Error?) {
        // Check the result or perform other tasks.
        
        // Dismiss the mail compose view controller.
        controller.dismiss(animated: true, completion: nil)
    }

}
