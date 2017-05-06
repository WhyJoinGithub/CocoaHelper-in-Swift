//
//  MXHelper-String.swift
//  MXHelper
//
//  Created by Meniny on 2017-04-19.
//  Copyright © 2017年 Meniny. All rights reserved.
//

import Foundation

public extension String {
    
    public var length: Int {
        return self.characters.count
    }
    
    public var localized: String {
        return Bundle.main.localizedString(forKey: self, value: nil, table: nil)
    }
}

public extension String {
    public func substring(pattern: String, options: NSRegularExpression.Options = NSRegularExpression.Options.caseInsensitive) -> String? {
        if let regex = try? NSRegularExpression(pattern: pattern, options: options) {
            if let match = regex.firstMatch(in: self, options: .reportProgress, range: NSMakeRange(0, self.characters.count)) {
                return (self as NSString).substring(with: match.range)
            }
        }
        return nil
    }
    
    public func substring(from: Int) -> String {
        return (self as NSString).substring(from: from)
    }
    
    public func substring(to: Int) -> String {
        return (self as NSString).substring(to: to)
    }
    
    public func uppercasedAtSentenceBoundary() -> String {
        var string = self.lowercased()
        
        let capacity = string.characters.count
        let mutable = NSMutableString(capacity: capacity)
        mutable.append(string)
        
        let pattern = "(?:^|\\b\\.[ ]*)(\\p{Ll})"
        
        if let regex = try? NSRegularExpression(pattern: pattern, options: .anchorsMatchLines) {
            let results = regex.matches(in: string, options: [], range: NSMakeRange(0, capacity))
            for result in results {
                let numRanges = result.numberOfRanges
                if numRanges >= 1 {
                    for i in 1..<numRanges {
                        let range = result.rangeAt(i)
                        let substring = mutable.substring(with: range)
                        mutable.replaceCharacters(in: range, with: substring.uppercased())
                    }
                }
            }
        }
        
        return mutable as String
    }
}

