//
//  CollectionViewTableViewCell.swift
//  NetflixClone
//
//  Created by Rijo Samuel on 31/12/21.
//

import UIKit

protocol CollectionViewTableViewCellDelegate: AnyObject {
	func didTapCell(_ cell: CollectionViewTableViewCell, viewModel: TitlePreviewVM)
}

final class CollectionViewTableViewCell: UITableViewCell {
	
	static let identifier = "CollectionViewTableViewCell"
	
	private var titles: [Title] = []
	
	weak var delegate: CollectionViewTableViewCellDelegate?
	
	private let collectionView: UICollectionView = {
		
		let layout = UICollectionViewFlowLayout()
		layout.scrollDirection = .horizontal
		layout.itemSize = CGSize(width: 130, height: 200)

		let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
		collectionView.register(TitleCollectionViewCell.self, forCellWithReuseIdentifier: TitleCollectionViewCell.identifier)
		return collectionView
	}()
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		
		contentView.backgroundColor = .systemBackground
		contentView.addSubview(collectionView)
		
		collectionView.dataSource = self
		collectionView.delegate = self
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func layoutSubviews() {
		
		super.layoutSubviews()
		collectionView.frame = contentView.bounds
	}
	
	func configure(with titles: [Title]) {
		
		self.titles = titles
		DispatchQueue.main.async { self.collectionView.reloadData() }
	}
}

// MARK: - Collection View Delegate Methods
extension CollectionViewTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate {
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return titles.count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TitleCollectionViewCell.identifier, for: indexPath) as! TitleCollectionViewCell
		cell.configure(with: titles, index: indexPath.row)
		return cell
	}
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		
		collectionView.deselectItem(at: indexPath, animated: true)
		let title = titles[indexPath.row]
		
		guard let titleName = title.originalTitle ?? title.originalName else { return }
		
		APICaller.shared.getMovie(with: titleName + " trailer") { result in
			
			switch result {
					
				case .success(let videoElements):
					guard let video = videoElements.first else { return }
					
					let title = self.titles[indexPath.row]
					let titleName = title.originalTitle ?? title.originalName ?? ""
					let overview = title.overview ?? ""
					let vm = TitlePreviewVM(title: titleName, youtubeView: video, titleOverview: overview)
					self.delegate?.didTapCell(self, viewModel: vm)
					
				case .failure(let error):
					print(error.localizedDescription)
			}
		}
	}
}
