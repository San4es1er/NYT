//
//  ArticleCollectionViewCell.swift
//  NYT
//
//  Created by Alex Lebedev on 12.11.2019.
//  Copyright © 2019 Alex Lebedev. All rights reserved.
//

import UIKit
import SDWebImage

class ArticleCollectionViewCell: UICollectionViewCell {
    // MARK: - Outlets
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    @IBOutlet weak var articleImageView: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // MARK: - Public methods
    func setup(model: Article){
        activityIndicator.startAnimating()
        headerLabel.text = model.header
        bodyLabel.text = model.body
        if let link = model.photoLink {
            articleImageView.sd_setImage(with: URL(string: link)) { [weak self] (_, _, _, _) in
                self?.activityIndicator.stopAnimating()
            }
            
        }
    }
}
