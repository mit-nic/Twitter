//
//  TweetCell.swift
//  twitter_alamofire_demo
//
//  Created by Charles Hieger on 6/18/17.
//  Copyright © 2017 Charles Hieger. All rights reserved.
//

import UIKit
import AlamofireImage

@objc protocol TweetCellDelegate {
    func didSelectPhoto(tweetCell: TweetCell)
}

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
    
    var rTweet: Tweet?
    var tweet: Tweet! {
        didSet {
            refreshData()
        }
    }
    var delegate: TweetCellDelegate?
    
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
//                rTweet = Tweet(dictionary: retweetedStatus)
                rTweet!.favoriteCount! -= 1
                rTweet!.favorited = false
                APIManager.shared.unfavorite(rTweet!) { (tweet: Tweet?, error: Error?) in
                    if let error = error {
                        print("Error unfavoriting retweet: \(error.localizedDescription)")
                    } else if let tweet = tweet {
                        print("Successfully unfavorited the following retweet: \n\(tweet.text)")
                        self.refreshData()
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
                        self.refreshData()
                    }
                }
            }
        } else {
            if let retweetedStatus = tweet.retweetedStatus {
//                rTweet = Tweet(dictionary: retweetedStatus)
                rTweet!.favoriteCount! += 1
                rTweet!.favorited = true
                APIManager.shared.favorite(rTweet!) { (tweet: Tweet?, error: Error?) in
                    if let error = error {
                        print("Error favoriting retweet: \(error.localizedDescription)")
                    } else if let tweet = tweet {
                        print("Successfully favorited the following retweet: \n\(tweet.text)")
                        self.refreshData()
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
                        self.refreshData()
                    }
                }
            }
        }
    }
    
    func refreshData() {
        tweetLabel.text = tweet.text
        usernameLabel.text = "@" + tweet.user.screenName
        nameLabel.text = tweet.user.name
        dateLabel.text = tweet.createdAtString
        rtLabel.text = String(describing: tweet.retweetCount)
        profileImageView.af_setImage(withURL: tweet.user.profilePicture!)
        
        if let retweetedStatus = tweet.retweetedStatus {
            rTweet = Tweet(dictionary: retweetedStatus)
            favLabel.text = String(describing: rTweet!.favoriteCount!)
            favButton.isSelected = rTweet!.favorited!
            rtButton.isSelected = rTweet!.retweeted
        } else {
            favLabel.text = String(describing:tweet.favoriteCount!)
            favButton.isSelected = tweet.favorited!
            rtButton.isSelected = tweet.retweeted
        }
    }
    
    @IBAction func profilePress(_ sender: Any) {
        delegate!.didSelectPhoto(tweetCell: self)
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
