//
//  VehicleTableViewCell.swift
//  ARVDemo
//
//  Created by user1 on 08/04/19.
//  Copyright © 2019 ARV. All rights reserved.
//

import UIKit

class VehicleTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblSubtitle: UILabel!
    @IBOutlet weak var lblDetails: UILabel!
    
    @IBOutlet weak var img: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func configureCell(vmodel:VehicleModel){
        self.lblTitle.text = vmodel.name.capitalized
        self.lblSubtitle.text = vmodel.number.capitalized
        if vmodel.type == "Bike"{
            self.img.image = UIImage(named: "motorcycle")
        }else if vmodel.type == "Car"{
            self.img.image = UIImage(named: "car")
        }else if vmodel.type == "Bus"{
            self.img.image = UIImage(named: "bus")
        }
        self.lblDetails.text =  vmodel.odometer + " Kms"
    }
  
}
