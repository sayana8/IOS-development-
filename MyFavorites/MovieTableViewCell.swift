//
//  MovieTableViewCell.swift
//  MyFavorites
//
//  Created by Zhumatay Sayana on 12.11.2025.
//

import UIKit

class MovieTableViewCell: UITableViewCell {

    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var reviewLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        subtitleLabel.numberOfLines = 0  
        reviewLabel.numberOfLines = 0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }


    func configure(movie: FavoriteItem) {
        movieImageView.image = movie.image
        titleLabel.text = movie.title
        subtitleLabel.text = movie.subtitle
        reviewLabel.text = movie.review
    }
}
