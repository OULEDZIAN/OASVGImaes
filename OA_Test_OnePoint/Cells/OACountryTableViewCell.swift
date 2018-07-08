//
//  OACountryTableViewCell.swift
//  OA_Test_OnePoint
//
//  Created by Ahmed OULEDZIAN on 07/07/2018.
//  Copyright © 2018 Ahmed OULEDZIAN. All rights reserved.
//

import UIKit

class OACountryTableViewCell: UITableViewCell {


    @IBOutlet weak var contentViews: UIView!
    @IBOutlet weak var flagImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var capitalLabel: UILabel!
    
    class var identifier: String {
        return String(describing: self)
    }
    class var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        ddBordersRduis() 
    }
    
    // add some borders and raduis to views to be beautiful
    func ddBordersRduis() {
        
        contentViews.layer.cornerRadius = 15.0
        contentViews.layer.borderWidth = 1.0
        contentViews.layer.borderColor = UIColor.black.cgColor
        
        flagImageView.layer.cornerRadius = 15.0
        flagImageView.layer.borderWidth = 1.0
        flagImageView.layer.borderColor = UIColor.black.cgColor
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
