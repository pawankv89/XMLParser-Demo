//
//  ArticleTableCell.swift
//  XMLParser Demo
//
//  Created by Pawan kumar on 05/06/19.
//  Copyright © 2019 Pawan Kumar. All rights reserved.
//

import UIKit

class ArticleTableCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    
    static let identifier: String = "ArticleTableCell"

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
