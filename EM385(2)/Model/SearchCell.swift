//
//  SearchCellTableViewCell.swift
//  EM385(2)
//
//  Created by Joy on 8/14/24.
//

import UIKit

class SearchCell: UITableViewCell {
    @IBOutlet weak var chapTitle: UILabel!
    @IBOutlet weak var sectionTitle: UILabel!
    @IBOutlet weak var content: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        chapTitle.numberOfLines = 0
        sectionTitle.numberOfLines = 0
        content.numberOfLines  = 0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
