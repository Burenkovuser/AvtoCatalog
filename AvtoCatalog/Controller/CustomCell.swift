//
//  CustomCell.swift
//  AvtoCatalog
//
//  Created by Vasilii on 10/09/2019.
//  Copyright © 2019 Vasilii Burenkov. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell {
    
    @IBOutlet weak var manufactureLabel: UILabel!
    @IBOutlet weak var modelLabel: UILabel!
    @IBOutlet weak var yaerLabel: UILabel!
    @IBOutlet weak var bodyTypeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
