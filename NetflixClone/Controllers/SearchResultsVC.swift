//
//  SearchResultsVC.swift
//  NetflixClone
//
//  Created by Rijo Samuel on 01/01/22.
//

import UIKit

final class SearchResultsVC: UIViewController {
	
	var titles: [Title] = []
	
	let searchResultsCollectionView: UICollectionView = {
		
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
}
