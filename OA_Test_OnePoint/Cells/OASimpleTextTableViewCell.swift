//
//  OASimpleTextTableViewCell.swift
//  OA_Test_OnePoint
//
//  Created by Ahmed OULEDZIAN on 08/07/2018.
//  Copyright © 2018 Ahmed OULEDZIAN. All rights reserved.
//

import UIKit

class OASimpleTextTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    
    class var identifier: String {
        return String(describing: self)
    }
    class var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
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
