//
//  LogsTableViewCell.swift
//  ARVDemo
//
//  Created by user1 on 08/04/19.
//  Copyright © 2019 ARV. All rights reserved.
//

import UIKit

class LogsTableViewCell: UITableViewCell {

    @IBOutlet weak var imgBg: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblSubTitle: UILabel!
    
    @IBOutlet weak var lblDate: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func configureCell(log:LogsModel){
      
        self.lblTitle.text = log.quantity + " " + log.unit
        self.lblSubTitle.text = log.odometer + " Kms"
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        let date = formatter.date(from: log.date)
        formatter.dateFormat = "dd MMM"
        self.lblDate.text = formatter.string(from: date!)
    }
}
