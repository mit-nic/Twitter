//
//  ComposeViewController.swift
//  twitter_alamofire_demo
//
//  Created by Nicolas Rodriguez on 7/5/17.
//  Copyright © 2017 Charles Hieger. All rights reserved.
//

import UIKit
import AlamofireImage

protocol ComposeViewControllerDelegate {
    func did(post: Tweet)
}

class ComposeViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var composeTextView: UITextView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var textCountLabel: UILabel!
    
    var imageLink: URL!
    var delegate: ComposeViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        composeTextView.delegate = self
        composeTextView.text = "What's happening?"
        composeTextView.textColor = UIColor.lightGray
        composeTextView.selectedTextRange = composeTextView.textRange(from: composeTextView.beginningOfDocument, to: composeTextView.beginningOfDocument)
        
        
        composeTextView.becomeFirstResponder()
        profileImageView.layer.borderWidth = 1
        profileImageView.layer.masksToBounds = false
        profileImageView.layer.borderColor = UIColor.lightGray.cgColor
        profileImageView.layer.cornerRadius = profileImageView.frame.height/2
        profileImageView.clipsToBounds = true
        profileImageView.af_setImage(withURL: imageLink)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let currentText = textView.text as NSString?
        let updatedText = currentText?.replacingCharacters(in: range, with: text)
        
        if (updatedText?.isEmpty)! {
            textView.text = "What's happening?"
            textView.textColor = UIColor.lightGray
            textView.selectedTextRange = textView.textRange(from: textView.beginningOfDocument, to: textView.beginningOfDocument)
            
            return false
        } else if textView.textColor == UIColor.lightGray && !text.isEmpty {
            textView.text = nil
            textView.textColor = UIColor.black
        }
//        let length = count(textView.text.utf16) + count(text.utf16) - range.length
        return true
    }
    
    @IBAction func didCancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func didTapPost(_ sender: Any) {
        APIManager.shared.composeTweet(with: composeTextView.text) { (tweet, error) in
            if let error = error {
                print("Error composing Tweet: \(error.localizedDescription)")
            } else if let tweet = tweet {
                self.delegate?.did(post: tweet)
                print("Compose Tweet Success!")
            }
        }
    }

    @IBAction func didTap(_ sender: Any) {
        view.endEditing(true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
