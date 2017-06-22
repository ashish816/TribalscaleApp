//
//  UserListCell.swift
//  TribalscaleApp
//
//  Created by Ashish Mishra on 6/21/17.
//  Copyright © 2017 Ashish Mishra. All rights reserved.
//

import UIKit

class UserListCell: UITableViewCell {

    @IBOutlet var userAvatar : UIImageView!
    @IBOutlet var userName : UILabel!
    
    override func layoutSubviews() {
        self.userAvatar?.layer.cornerRadius = (self.userAvatar?.bounds.width)!/2
        self.userAvatar?.clipsToBounds = true
    }
    
    override func prepareForReuse() {
        self.userAvatar.image = nil
    }
    
}
