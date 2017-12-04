//
//  ControllerMainView.swift
//  Gojek Contacts
//
//  Created by Faiz Umar Baraja on 27/11/2017.
//  Copyright © 2017 FaizBarajaApps. All rights reserved.
//

import UIKit
import CoreData
protocol ControllerMainViewDelegate {
    func loadData()
}

class ControllerMainView: NSObject,WebServiceReturnDelegate {
    var delegate:ControllerMainViewDelegate?

    let urlAPIGetContacts = "https://gojek-contacts-app.herokuapp.com/contacts.json"
    let modelWebServiceCall = ModelWebServiceCall()
    let modelWebServiceDataParse = ModelWebServiceDataParse()

    let modelEntityContact = ModelEntityContact()
    
    
    
    func getDataForTableView() -> [String:[NSManagedObject]]{
        let contactAllData = self.getAllContactData()
        //let arrayContactData = ["AAA","BBB","CCC","DDD","EEE","FFF","GGG","HHH","III","JJJ","KKK","LLL","MMM","NNN","OOO","PPP"]
        return convertArrayToDictionaryWithFirstLetterAsKey(arrayData: contactAllData)
    }
    
    func convertArrayToDictionaryWithFirstLetterAsKey(arrayData : [NSManagedObject]) -> [String:[NSManagedObject]]{
        let alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ".map({ String($0) })
        
        var words:[String] = []
        var indexWords:[Int] = []//= arrayData
        for managedObject in arrayData {
            let indexData:Int = arrayData.index(of: managedObject)!
            words.append("\(arrayData[indexData].value(forKey: "first_name") as! String) \(indexData)")
            indexWords.append(indexData as Int)
        }
        
        var result = [String:[NSManagedObject]]()
        
        for letter in alphabet {
            result[letter] = []
            let matches = words.filter({ $0.hasPrefix(letter) })
            if !matches.isEmpty {
                for (index, element) in matches.enumerated() {
                    let arrayString:[String] = element.components(separatedBy: " ")
                    let indexLastElement:String = arrayString[arrayString.count-1]
                    print("\(index) = \(element)")
                    result[letter]?.append(arrayData[Int(indexLastElement)!])
                }
            }
        }
        
        return result
    }
    
    func getContactsDataFromServer (){
        modelWebServiceCall.delegate = self
        modelWebServiceCall.callRESTAPI(stringAPIURL: urlAPIGetContacts, stringHTTPMethod: modelWebServiceCall.httpGET)
    }
    
    func loadImageFromURL(link:String, imageview:UIImageView){
        modelWebServiceCall.delegate = self
        modelWebServiceCall.loadImageFromURL(link:link, imageview:imageview)
    }
    
    func jsonData(_ dataFromServer:Any){
        let isDataArray = modelWebServiceDataParse.isDataArray(rawData: dataFromServer)
        let isDataDictionary = modelWebServiceDataParse.isDataDictionary(rawData: dataFromServer)
        
        if (isDataArray){
            self.modelEntityContact.deleteAllContactRecords()
            let arrayDataContact = dataFromServer as! NSArray
            for dictContact in arrayDataContact {
                print("iteration \(arrayDataContact.index(of: dictContact))")
                self.modelEntityContact.saveContactData(dictContactData: dictContact as! [String:Any])
            }
        }
        
        if (isDataDictionary){
            self.modelEntityContact.deleteAllContactRecords()
            let dictionaryDataContact = dataFromServer as! [String:Any]
            self.modelEntityContact.saveContactData(dictContactData: dictionaryDataContact)
        }
        delegate?.loadData()
    }
    
    func getAllContactData() -> [NSManagedObject] {
        return modelEntityContact.getAllContactData()
    }
    
   
}
