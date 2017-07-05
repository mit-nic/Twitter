//
//  TweetCell.swift
//  twitter_alamofire_demo
//
//  Created by Charles Hieger on 6/18/17.
//  Copyright © 2017 Charles Hieger. All rights reserved.
//

import UIKit
import AlamofireImage

class TweetCell: UITableViewCell {
    
    @IBOutlet weak var tweetLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var replyLabel: UILabel!
    @IBOutlet weak var rtLabel: UILabel!
    @IBOutlet weak var favLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var rtButton: UIButton!
    @IBOutlet weak var favButton: UIButton!
    
    
    var tweet: Tweet! {
        didSet {
            tweetLabel.text = tweet.text
            usernameLabel.text = tweet.user.screenName
            nameLabel.text = tweet.user.name
            dateLabel.text = tweet.createdAtString
            rtLabel.text = String(describing: tweet.retweetCount)
            favLabel.text = String(describing:tweet.favoriteCount!)
            profileImageView.af_setImage(withURL: tweet.user.profilePicture!)
        }
    }
    
    @IBAction func retweetPress(_ sender: Any) {
        if rtButton.isSelected {
            rtButton.isSelected = false
        } else {
            rtButton.isSelected = true
        }
    }
    
    @IBAction func favoritePress(_ sender: Any) {
        if favButton.isSelected {
            favButton.isSelected = false
        } else {
            favButton.isSelected = true
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
