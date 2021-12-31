//
//  HeroHeaderView.swift
//  NetflixClone
//
//  Created by Rijo Samuel on 31/12/21.
//

import UIKit

final class HeroHeaderView: UIView {
	
	private let heroImageView: UIImageView = {
		
		let imageView = UIImageView()
		imageView.contentMode = .scaleAspectFill
		imageView.clipsToBounds = true
		imageView.image = UIImage(named: "dune")
		return imageView
	}()
	
	private let playButton: UIButton = {
		
		let button = UIButton()
		button.setTitle("Play", for: .normal)
		button.layer.borderColor = UIColor.white.cgColor
		button.layer.borderWidth = 1
		button.layer.cornerRadius = 5
		button.translatesAutoresizingMaskIntoConstraints = false
		return button
	}()
	
	private let downloadButton: UIButton = {
		
		let button = UIButton()
		button.setTitle("Download", for: .normal)
		button.layer.borderColor = UIColor.white.cgColor
		button.layer.borderWidth = 1
		button.layer.cornerRadius = 5
		button.translatesAutoresizingMaskIntoConstraints = false
		return button
	}()

	override init(frame: CGRect) {
		
		super.init(frame: frame)
		
		addSubview(heroImageView)
		addGradient()
		
		addSubview(playButton)
		addSubview(downloadButton)
		applyConstraints()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func layoutSubviews() {
		
		super.layoutSubviews()
		heroImageView.frame = bounds
	}
	
	private func addGradient() {
		
		let gradientLayer = CAGradientLayer()
		gradientLayer.colors = [UIColor.clear.cgColor, UIColor.systemBackground.cgColor]
		gradientLayer.frame = bounds
		layer.addSublayer(gradientLayer)
	}
	
	private func applyConstraints() {
		
		let playButtonConstraints = [
			playButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 100),
			playButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -50),
			playButton.widthAnchor.constraint(equalToConstant: 100)
		]
		
		let downloadButtonConstraints = [
			downloadButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -100),
			downloadButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -50),
			downloadButton.widthAnchor.constraint(equalToConstant: 100)
		]
		
		NSLayoutConstraint.activate(playButtonConstraints)
		NSLayoutConstraint.activate(downloadButtonConstraints)
	}
}
