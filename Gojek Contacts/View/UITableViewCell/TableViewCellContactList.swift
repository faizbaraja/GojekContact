//
//  TableViewCellContactList.swift
//  Gojek Contacts
//
//  Created by Faiz Umar Baraja on 26/11/2017.
//  Copyright © 2017 FaizBarajaApps. All rights reserved.
//

import UIKit

class TableViewCellContactList: UITableViewCell {
    @IBOutlet var labelContactName:UILabel!
    @IBOutlet var imageContact:UIImageView!
    @IBOutlet var imageContactFavourite:UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
