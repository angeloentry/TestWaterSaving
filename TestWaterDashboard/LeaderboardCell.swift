//
//  LeaderboardCell.swift
//  TestWaterDashboard
//
//  Created by user167484 on 6/13/20.
//  Copyright © 2020 Allen Savio. All rights reserved.
//

import UIKit

class LeaderboardCell: UITableViewCell {

    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var pointsLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    func generateImageWithText(text: String) -> UIImage? {
        userImageView.backgroundColor = UIColor.gray
        userImageView.makeRounded()
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: userImageView.frame.size.width, height: userImageView.frame.size.height))
        label.backgroundColor = UIColor.clear
        label.textAlignment = .center
        label.textColor = UIColor.white
        label.text = text

        UIGraphicsBeginImageContextWithOptions(label.bounds.size, false, 0)
        userImageView.layer.render(in: UIGraphicsGetCurrentContext()!)
        label.layer.render(in: UIGraphicsGetCurrentContext()!)
        let imageWithText = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return imageWithText
    }
}

extension UIImageView {
    func makeRounded() {
        self.layer.borderWidth = 0
        self.layer.masksToBounds = false
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.cornerRadius = self.frame.height/2 //This will change with corners of image and height/2 will make this circle shape
        self.clipsToBounds = true
    }
}
