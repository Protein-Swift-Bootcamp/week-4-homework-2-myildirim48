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

extension String {

     func containsLatinCharacters() -> Bool {

         var charSet = NSCharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890")
         charSet = charSet.inverted as NSCharacterSet

         let range = (self as NSString).rangeOfCharacter(from: charSet as CharacterSet)

        if range.location != NSNotFound {
            return false
        }

        return true
    }
}
