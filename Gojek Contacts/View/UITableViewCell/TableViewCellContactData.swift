//
//  TableViewCellContactData.swift
//  Gojek Contacts
//
//  Created by Faiz Umar Baraja on 26/11/2017.
//  Copyright © 2017 FaizBarajaApps. All rights reserved.
//

import UIKit

class TableViewCellContactData: UITableViewCell {
    @IBOutlet var labelKey:UILabel!
    @IBOutlet var textFieldValue:UITextField!
    
    init(style: UITableViewCellStyle, reuseIdentifier: String?, cellKey: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        // code common to all your cells goes here
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
