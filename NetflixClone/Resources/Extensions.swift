//
//  Extensions.swift
//  NetflixClone
//
//  Created by Rijo Samuel on 31/12/21.
//

extension String {
	
	func capitalizedFirstLetter() -> String {
		return self.prefix(1).uppercased() + self.lowercased().dropFirst()
	}
}
