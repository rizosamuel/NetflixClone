//
//  TitleCollectionViewCell.swift
//  NetflixClone
//
//  Created by Rijo Samuel on 31/12/21.
//

import UIKit
import SDWebImage

final class TitleCollectionViewCell: UICollectionViewCell {
    
	static let identifier = "TitleCollectionViewCell"
	
	private let posterImageView: UIImageView = {
		
		let imageView = UIImageView()
		imageView.contentMode = .scaleAspectFill
		return imageView
	}()
	
	override init(frame: CGRect) {
		
		super.init(frame: frame)
		contentView.addSubview(posterImageView)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func layoutSubviews() {
		
		super.layoutSubviews()
		posterImageView.frame = contentView.bounds
	}
	
	func configure(with posterPath: String) {
		
		guard let url = URL(string: Constants.imageBaseUrl + posterPath) else { return }
		
		posterImageView.sd_setImage(with: url, completed: nil)
	}
}
