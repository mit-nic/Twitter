//
//  ComposeViewController.swift
//  twitter_alamofire_demo
//
//  Created by Nicolas Rodriguez on 7/5/17.
//  Copyright © 2017 Charles Hieger. All rights reserved.
//

import UIKit
import AlamofireImage

class ComposeViewController: UIViewController {

    @IBOutlet weak var composeTextView: UITextView!
    @IBOutlet weak var profileImageView: UIImageView!
    
    var imageLink: URL!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        composeTextView.becomeFirstResponder()
        profileImageView.af_setImage(withURL: imageLink)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didCancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
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
