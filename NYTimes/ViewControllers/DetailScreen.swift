//
//  DetailScreen.swift
//  NYTimes
//
//  Created by Gaurang Lathiya on 12/12/19.
//  Copyright © 2019 g212gs. All rights reserved.
//

import UIKit
import Kingfisher

class DetailScreen: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var abstractLabel: UILabel!
    @IBOutlet weak var buttonToSafari: UIButton!
    @IBOutlet var placeHolderLabel: UILabel!
    
    public var dataSourceObject:Result? {
        didSet {
            // Update the view.
            configureView()
        }
    }
    
    func configureView() {
        // Update the user interface for the detail item.
        if let detail = dataSourceObject {
            
            if let placeHolder = self.placeHolderLabel {
                placeHolder.isHidden = true
            }
            
            if let imgVw = self.imageView {
                if let imageURLString = detail.media?.first?.mediaMetadata?.first?.url, let imageURL = URL(string: imageURLString){
                    imgVw.kf.indicatorType = .activity
                    imgVw.kf.setImage(with: imageURL, options: [.transition(.fade(0.2))])
                }
            }
            
            if let title = titleLabel {
                title.text = detail.title
            }
            if let abstract = abstractLabel {
                abstract.text = detail.abstract
            }
            
            if let btnToSfr = self.buttonToSafari {
                btnToSfr.layer.cornerRadius = 5.0
                btnToSfr.layer.masksToBounds = true
                btnToSfr.backgroundColor = UIColor.label
                btnToSfr.setTitle("Open in safari", for: .normal)
            }
        } else {
            if let placeHolder = self.placeHolderLabel {
                placeHolder.isHidden = false
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configureView()
    }
    
    // MARK: - Button click action
    @IBAction func openSafari(_ sender: UIButton) {
        if let detail = dataSourceObject, let strURL = detail.url, let urlOriginal = URL(string: strURL) {
            if UIApplication.shared.canOpenURL(urlOriginal) {
                UIApplication.shared.open(urlOriginal, options: [:], completionHandler: nil)
            }
        }
    }
    
}

