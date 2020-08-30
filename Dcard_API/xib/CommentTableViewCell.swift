//
//  CommentTableViewCell.swift
//  Dcard_API
//
//  Created by Wei Lun Hsu on 2020/8/30.
//  Copyright © 2020 Wei Lun Hsu. All rights reserved.
//

import UIKit

class CommentTableViewCell: UITableViewCell {
    
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var schoolLabel: UILabel!
    @IBOutlet weak var floorLabel: UILabel!
    @IBOutlet weak var commentTxtView: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        commentTxtView.isSelectable = false
        commentTxtView.isScrollEnabled = false
        commentTxtView.isEditable = false
        commentTxtView.sizeToFit()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
