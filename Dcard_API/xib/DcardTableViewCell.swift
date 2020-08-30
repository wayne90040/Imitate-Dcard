//
//  MainTableViewCell.swift
//  Dcard_API
//
//  Created by Wei Lun Hsu on 2020/8/16.
//  Copyright © 2020 Wei Lun Hsu. All rights reserved.
//

import UIKit

class DcardTableViewCell: UITableViewCell {

    @IBOutlet weak var forumLabei: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var stateLabel: UILabel!
    @IBOutlet weak var commitLabel: UILabel!
    @IBOutlet weak var mediaImage: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
