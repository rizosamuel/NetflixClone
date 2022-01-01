//
//  Coordinator.swift
//  NetflixClone
//
//  Created by Rijo Samuel on 31/12/21.
//

import UIKit

protocol Coordinator: AnyObject {
	
	func start()
	func route(to router: Coordinator)
}

extension Coordinator {
	
	func route(to router: Coordinator) {
		router.start()
	}
}

// MARK: - Concrete Coordinator implementation
final class MainCoordinator: Coordinator {
	
	private let window: UIWindow?
	private let root: UITabBarController
	
	init(window: UIWindow?, root: UITabBarController) {
		
		self.window = window
		self.root = root
	}
	
	func start() {

		window?.rootViewController = root
		window?.makeKeyAndVisible()
	}
}
