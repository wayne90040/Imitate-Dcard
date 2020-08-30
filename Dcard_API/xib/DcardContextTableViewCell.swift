//
//  DcardContextTableViewCell.swift
//  Dcard_API
//
//  Created by Wei Lun Hsu on 2020/8/19.
//  Copyright © 2020 Wei Lun Hsu. All rights reserved.
//

import UIKit

class DcardContextTableViewCell: UITableViewCell {
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var schoolLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contextTxtView: UITextView!
    @IBOutlet weak var forumLabel: UILabel!
    @IBOutlet weak var dateTimeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        contextTxtView.isScrollEnabled = false
        contextTxtView.isEditable = false
        contextTxtView.isSelectable = false
        contextTxtView.sizeToFit()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
