//
//  CustomTableViewCell2.swift
//  iFave
//
//  Created by Andrea Pineda on 11/12/2017.
//  Copyright © 2017 Andrea Pineda. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    //Outlets for the Search View
    @IBOutlet var movieYear: UILabel!
    @IBOutlet var movieImageView: UIImageView!
    @IBOutlet var movieTitle: UILabel!
    @IBOutlet var favButton: UIButton!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    
}





    

