//
//  ControllerMainView.swift
//  Gojek Contacts
//
//  Created by Faiz Umar Baraja on 27/11/2017.
//  Copyright © 2017 FaizBarajaApps. All rights reserved.
//

import UIKit

class ControllerMainView: NSObject {
    
    func getDataForTableView() -> [String:[String]]{
        let arrayContactData = ["AAA","BBB","CCC","DDD","EEE","FFF","GGG","HHH","III","JJJ","KKK","LLL","MMM","NNN","OOO","PPP"]
        return convertArrayToDictionaryWithFirstLetterAsKey(arrayData: arrayContactData)
    }
    
    func convertArrayToDictionaryWithFirstLetterAsKey(arrayData : [String]) -> [String:[String]]{
        let alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ".characters.map({ String($0) })
        
        let words = arrayData
        
        var result = [String:[String]]()
        
        for letter in alphabet {
            result[letter] = []
            let matches = words.filter({ $0.hasPrefix(letter) })
            if !matches.isEmpty {
                for word in matches {
                    result[letter]?.append(word)
                }
            }
        }
        
        return result
    }
}
