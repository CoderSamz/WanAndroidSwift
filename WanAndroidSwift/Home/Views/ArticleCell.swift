//
//  ArticleCell.swift
//  WanAndroidSwift
//  
//  Created by CoderSamz on 2022.
// 	
// 
    

import UIKit

class ArticleCell: UITableViewCell {

    @IBOutlet weak var autherLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
//        autherLabel.text = "123123"
//        timeLabel.text = "34523023-23"
//        titleLabel.text = "刚学会Transform，你告诉我就要被移除了"
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateUI(model: HomeModel) {
        autherLabel.text = model.author
        timeLabel.text = model.niceDate
        titleLabel.text = model.title
    }
}
