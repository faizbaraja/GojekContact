//
//  ModelWebServiceDataParse.swift
//  Gojek Contacts
//
//  Created by Faiz Umar Baraja on 28/11/2017.
//  Copyright © 2017 FaizBarajaApps. All rights reserved.
//

import UIKit

class ModelWebServiceDataParse: NSObject {

    func isDataArray(rawData:Any) -> Bool{
        if (rawData is NSArray){
            return true
        }
        return false
    }
    
    func isDataDictionary(rawData:Any) -> Bool{
        if (rawData is NSDictionary){
            return true
        }
        return false
    }
}
