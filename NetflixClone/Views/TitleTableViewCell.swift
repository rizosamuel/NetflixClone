//
//  TitleTableViewCell.swift
//  NetflixClone
//
//  Created by Rijo Samuel on 31/12/21.
//

import UIKit
import SDWebImage

final class TitleTableViewCell: UITableViewCell {
	
	static let identifier = "TitleTableViewCell"
	
	private let titlePoster: UIImageView = {
		
		let imageView = UIImageView()
		imageView.translatesAutoresizingMaskIntoConstraints = false
		imageView.contentMode = .scaleAspectFill
		imageView.clipsToBounds = true
		return imageView
	}()
	
	private let titleLabel: UILabel = {
		
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	
	private let playTitleButton: UIButton = {
		
		let button = UIButton()
		button.tintColor = .label
		let image = UIImage(systemName: "play.circle", withConfiguration: UIImage.SymbolConfiguration(pointSize: 30))
		button.setImage(image, for: .normal)
		button.translatesAutoresizingMaskIntoConstraints = false
		return button
	}()
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		
		contentView.addSubview(titlePoster)
		contentView.addSubview(titleLabel)
		contentView.addSubview(playTitleButton)
		
		applyConstraints()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func layoutSubviews() {
		super.layoutSubviews()
	}
	
	private func applyConstraints() {
		
		let posterConstraints = [
			titlePoster.leadingAnchor.constraint(equalTo: leadingAnchor),
			titlePoster.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
			titlePoster.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
			titlePoster.widthAnchor.constraint(equalToConstant: 100)
		]
		
		let titleLabelConstraints = [
			titleLabel.leadingAnchor.constraint(equalTo: titlePoster.trailingAnchor, constant: 20),
			titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
		]
		
		let playButtonConstraints = [
			playTitleButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
			playTitleButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
		]
		
		NSLayoutConstraint.activate(posterConstraints)
		NSLayoutConstraint.activate(titleLabelConstraints)
		NSLayoutConstraint.activate(playButtonConstraints)
	}
	
	func configure(with model: TitleVM) {
		
		guard let url = URL(string: Constants.imageBaseUrl + model.posterUrl) else { return }
		
		titlePoster.sd_setImage(with: url, completed: nil)
		titleLabel.text = model.titleName
	}
}
