//
//  ListScreenCell.swift
//  NYTimes
//
//  Created by Gaurang Lathiya on 13/12/19.
//  Copyright © 2019 g212gs. All rights reserved.
//

import UIKit
import Kingfisher

class ListScreenCell: UITableViewCell {

    @IBOutlet var thumbnilImageView: UIImageView!
    @IBOutlet var title: UILabel!
    @IBOutlet var byWriter: UILabel!
    @IBOutlet var publishedDate: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        thumbnilImageView.layer.cornerRadius = 75.0/2.0 // based on static width
        thumbnilImageView.layer.masksToBounds = true
        
        title.textColor = UIColor.label
        byWriter.textColor = UIColor.secondaryLabel
        publishedDate.textColor = UIColor.secondaryLabel

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func bindData(object: Displayable) {
        guard let mostViewed = object as? Result else {
            return
        }

        title.text = mostViewed.title
        if let writer = mostViewed.byline {
            byWriter.text = writer
        }

        if let date = mostViewed.publishedDate {
            publishedDate.text = "🗓 " + date
        }

        guard let imageURLString = mostViewed.media?.first?.mediaMetadata?.first?.url, let imageURL = URL(string: imageURLString) else {
            return
        }        
        thumbnilImageView.kf.indicatorType = .activity
        thumbnilImageView.kf.setImage(with: imageURL, options: [.transition(.fade(0.2))])
    }

}
