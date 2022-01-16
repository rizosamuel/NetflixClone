//
//  SearchResultsVC.swift
//  NetflixClone
//
//  Created by Rijo Samuel on 01/01/22.
//

import UIKit

protocol SearchResultsDelegate: AnyObject {
	
	func searchResultsDidTapItem(_ model: TitlePreviewVM)
}

final class SearchResultsVC: UIViewController {
	
	private var titles: [Title] = []
	
	weak var delegate: SearchResultsDelegate?
	
	private let searchResultsCollectionView: UICollectionView = {
		
		let layout = UICollectionViewFlowLayout()
		layout.itemSize = CGSize(width: UIScreen.main.bounds.width / 3 - 10, height: 200)
		layout.minimumInteritemSpacing = 0
		
		let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
		collectionView.register(TitleCollectionViewCell.self, forCellWithReuseIdentifier: TitleCollectionViewCell.identifier)
		return collectionView
	}()
	
	override func viewDidLoad() {
		
		super.viewDidLoad()
		view.backgroundColor = .systemBackground
		view.addSubview(searchResultsCollectionView)
		
		searchResultsCollectionView.dataSource = self
		searchResultsCollectionView.delegate = self
	}
	
	override func viewDidLayoutSubviews() {
		
		super.viewDidLayoutSubviews()
		searchResultsCollectionView.frame = view.bounds
	}
	
	func setTitles(with titles: [Title]) {
		self.titles = titles
		searchResultsCollectionView.reloadData()
	}
}

// MARK: - Collection View Delegate Methods
extension SearchResultsVC: UICollectionViewDataSource, UICollectionViewDelegate {
	
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
		
		APICaller.shared.getMovie(with: titleName) { result in
			
			switch result {
					
				case .success(let videoElement):
					DispatchQueue.main.async {
						let overview = title.overview ?? ""
						self.delegate?.searchResultsDidTapItem(TitlePreviewVM(title: titleName, youtubeView: videoElement.first!, titleOverview: overview))
					}
					
				case .failure(let error):
					print(error.localizedDescription)
			}
		}
	}
}
