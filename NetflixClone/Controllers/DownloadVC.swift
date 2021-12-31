//
//  DownloadVC.swift
//  NetflixClone
//
//  Created by Rijo Samuel on 31/12/21.
//

import UIKit

final class DownloadVC: UIViewController {

    override func viewDidLoad() {
		
        super.viewDidLoad()
		
		title = "Downloads"
		view.backgroundColor = .systemBackground
		navigationController?.navigationBar.prefersLargeTitles = true
		navigationController?.navigationItem.largeTitleDisplayMode = .always
    }
}
