//
//  SearchCellTableViewCell.swift
//  EM385(2)
//
//  Created by Joy on 8/14/24.
//

import UIKit

class SearchCell: UITableViewCell {
    @IBOutlet weak var chapNumber: UILabel!
    @IBOutlet weak var sectionTitle: UILabel!
    @IBOutlet weak var chapterTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
