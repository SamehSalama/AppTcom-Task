//
//  AthleteDetailsViewController.swift
//  AppTcom Task
//
//  Created by Sameh Salama on 10/16/17.
//  Copyright © 2017 Da Blue Alien. All rights reserved.
//

import UIKit
import Kingfisher

class AthleteDetailsViewController: UIViewController {

    //MARK: - IBOutlets
    @IBOutlet weak var athleteImageView: UIImageView!
    @IBOutlet weak var athleteBriefLabel: UILabel!
    @IBOutlet weak var athleteImageViewHeightConstraint: NSLayoutConstraint!

    //MARK: - Properties
    var athlete:Athlete!

    //MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = self.athlete.name

        if let athleteImageUrlString = self.athlete.imageUrlString, let athleteImageUrl = URL(string:athleteImageUrlString) {
            self.athleteImageView.kf.setImage(with: athleteImageUrl, placeholder: #imageLiteral(resourceName: "placeholder"), options: nil, progressBlock: nil, completionHandler: { (image, _, _, _) in
                if let imageSize = image?.size {
                    self.athleteImageViewHeightConstraint.constant = (self.view.bounds.width * imageSize.height) / imageSize.width
                }
            })
        }

        self.athleteBriefLabel.text = self.athlete.brief
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    



}
