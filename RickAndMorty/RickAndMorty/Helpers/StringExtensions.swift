//
//  StringExtensions.swift
//  RickAndMorty
//
//  Created by YILDIRIM on 29.12.2022.
//

import Foundation

extension String {
    var isNumber: Bool {
        return self.range(
            of: "^[0-9]*$", // 1
            options: .regularExpression) != nil
    }
}
