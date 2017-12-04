//
//  ModelContactDataState.swift
//  Gojek Contacts
//
//  Created by Faiz Umar Baraja on 03/12/2017.
//  Copyright © 2017 FaizBarajaApps. All rights reserved.
//

import UIKit
import CoreData

class ModelContactDataState: NSObject {
    var dictionarySelectedContactData:[String:Any]!
    
    func setSelectedContactData(contactDataSelected:NSManagedObject){
        let keys = Array(contactDataSelected.entity.attributesByName.keys)
        dictionarySelectedContactData = contactDataSelected.dictionaryWithValues(forKeys: keys)
    }
    
    func getSelectedContactData() -> [String:Any]{
        return dictionarySelectedContactData!
    }
}
