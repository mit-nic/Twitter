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
            refreshData()
        }
    }
    
    @IBAction func retweetPress(_ sender: Any) {
        if rtButton.isSelected {
            tweet.retweeted = false
            tweet.retweetCount -= 1
            APIManager.shared.unretweet(tweet) { (tweet: Tweet?, error: Error?) in
                if let error = error {
                    print("Error unretweeting tweet: \(error.localizedDescription)")
                } else if let tweet = tweet {
                    print("Successfully unretweeted the following Tweet: \n\(tweet.text)")
                }
            }
        } else {
            tweet.retweeted = true
            tweet.retweetCount += 1
            APIManager.shared.retweet(tweet) { (tweet: Tweet?, error: Error?) in
                if let error = error {
                    print("Error retweeting tweet: \(error.localizedDescription)")
                } else if let tweet = tweet {
                    print("Successfully retweeted the following Tweet: \n\(tweet.text)")
                }
            }
        }
        refreshData()
    }
    
    @IBAction func favoritePress(_ sender: Any) {
        if favButton.isSelected {
            
            if let retweetedStatus = tweet.retweetedStatus {
                let rTweet = Tweet(dictionary: retweetedStatus)
                rTweet.favoriteCount! -= 1
                rTweet.favorited = false
                APIManager.shared.unfavorite(rTweet) { (tweet: Tweet?, error: Error?) in
                    if let error = error {
                        print("Error unfavoriting tweet: \(error.localizedDescription)")
                    } else if let tweet = tweet {
                        print("Successfully unfavorited the following Tweet: \n\(tweet.text)")
                    }
                }

            
            } else {
                tweet.favorited = false
                tweet.favoriteCount! -= 1
                APIManager.shared.unfavorite(tweet) { (tweet: Tweet?, error: Error?) in
                    if let error = error {
                        print("Error unfavoriting tweet: \(error.localizedDescription)")
                    } else if let tweet = tweet {
                        print("Successfully unfavorited the following Tweet: \n\(tweet.text)")
                    }
                }
            }
        } else {
            if let retweetedStatus = tweet.retweetedStatus {
                let rTweet = Tweet(dictionary: retweetedStatus)
                rTweet.favoriteCount! += 1
                rTweet.favorited = true
                APIManager.shared.favorite(rTweet) { (tweet: Tweet?, error: Error?) in
                    if let error = error {
                        print("Error favoriting tweet: \(error.localizedDescription)")
                    } else if let tweet = tweet {
                        print("Successfully favorited the following Tweet: \n\(tweet.text)")
                    }
                }
                
            } else {
                tweet.favorited = true
                tweet.favoriteCount! += 1
                APIManager.shared.favorite(tweet) { (tweet: Tweet?, error: Error?) in
                    if let error = error {
                        print("Error favoriting tweet: \(error.localizedDescription)")
                    } else if let tweet = tweet {
                        print("Successfully favorited the following Tweet: \n\(tweet.text)")
                    }
                }
            }
        }
        refreshData()
    }
    
    func refreshData() {
        tweetLabel.text = tweet.text
        usernameLabel.text = "@" + tweet.user.screenName
        nameLabel.text = tweet.user.name
        dateLabel.text = tweet.createdAtString
        rtLabel.text = String(describing: tweet.retweetCount)
        profileImageView.af_setImage(withURL: tweet.user.profilePicture!)
        favButton.isSelected = tweet.favorited!
        rtButton.isSelected = tweet.retweeted
        
        if let retweetedStatus = tweet.retweetedStatus {
            let rTweet = Tweet(dictionary: retweetedStatus)
            favLabel.text = String(describing: rTweet.favoriteCount!)
        } else {
            favLabel.text = String(describing:tweet.favoriteCount!)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        profileImageView.layer.borderWidth = 1
        profileImageView.layer.masksToBounds = false
        profileImageView.layer.borderColor = UIColor.lightGray.cgColor
        profileImageView.layer.cornerRadius = profileImageView.frame.height/2
        profileImageView.clipsToBounds = true
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
