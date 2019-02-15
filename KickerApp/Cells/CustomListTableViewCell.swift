//
//  CustomListTableViewCell.swift
//  KickerApp
//
//  Created by Phuong Nguyen on 17.01.19.
//  Copyright © 2019 Phuong Nguyen. All rights reserved.
//

import UIKit

class CustomListTableViewCell: UITableViewCell {

    @IBOutlet weak var userImage: UIImageView!

    @IBOutlet weak var userName: UILabel!

    @IBOutlet weak var deleteButton: CustomButton!
    

    @IBAction func deleteUser(_ sender: Any) {
        NotificationCenter.default.post(name: NSNotification.Name("deleteUser"), object: nil)
    }
    
    
}
