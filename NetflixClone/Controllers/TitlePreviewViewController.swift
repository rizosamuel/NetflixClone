//
//  TitlePreviewViewController.swift
//  NetflixClone
//
//  Created by Rijo Samuel on 09/01/22.
//

import UIKit
import WebKit

final class TitlePreviewViewController: UIViewController {
	
	private let webview: WKWebView = {
		
		let webview = WKWebView()
		webview.translatesAutoresizingMaskIntoConstraints = false
		return webview
	}()
	
	private let titleLabel: UILabel = {
		
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.font = .systemFont(ofSize: 22, weight: .bold)
		label.text = "Harry Potter"
		return label
	}()
	
	private let overviewLabel: UILabel = {
		
		let label = UILabel()
		label.font = .systemFont(ofSize: 18, weight: .regular)
		label.translatesAutoresizingMaskIntoConstraints = false
		label.numberOfLines = 0
		label.text = "This is the best movie ever to watch as a kid"
		return label
	}()
	
	private let downloadbutton: UIButton = {
		
		let button = UIButton()
		button.translatesAutoresizingMaskIntoConstraints = false
		button.backgroundColor = .red
		button.setTitle("Download", for: .normal)
		button.setTitleColor(.white, for: .normal)
		button.layer.cornerRadius = 8
		button.layer.masksToBounds = true
		return button
	}()

    override func viewDidLoad() {
		
        super.viewDidLoad()
		
		view.backgroundColor = .systemBackground
		view.addSubview(webview)
		view.addSubview(titleLabel)
		view.addSubview(overviewLabel)
		view.addSubview(downloadbutton)
		
		configureConstraints()
    }
	
	private func configureConstraints() {
		
		let webviewConstraints = [
			webview.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
			webview.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			webview.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			webview.heightAnchor.constraint(equalToConstant: 300)
		]
		
		let titleLabelConstraints = [
			titleLabel.topAnchor.constraint(equalTo: webview.bottomAnchor, constant: 20),
			titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20)
		]
		
		let overviewLabelConstraints = [
			overviewLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 15),
			overviewLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
			overviewLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
		]
		
		let downloadButtonConstraints = [
			downloadbutton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			downloadbutton.topAnchor.constraint(equalTo: overviewLabel.bottomAnchor, constant: 20),
			downloadbutton.widthAnchor.constraint(equalToConstant: 140)
		]
		
		NSLayoutConstraint.activate(webviewConstraints)
		NSLayoutConstraint.activate(titleLabelConstraints)
		NSLayoutConstraint.activate(overviewLabelConstraints)
		NSLayoutConstraint.activate(downloadButtonConstraints)
	}
	
	func configure(with model: TitlePreviewVM) {
		
		titleLabel.text = model.title
		overviewLabel.text = model.titleOverview
		
		guard let url = URL(string: "https://www.youtube.com/embed/\(model.youtubeView.id.videoId)") else { return }
		
		webview.load(URLRequest(url: url))
	}
}
