//
//  LyricThumbnail.swift
//  Lyric
//
//  Created by Codex on 5/30/26.
//

import Foundation
import SwiftUI

public enum LyricThumbnail {
    case image(Image)
    case remote(URL)
    case symbol(String)

    public static func remote(_ rawValue: String?) -> LyricThumbnail? {
        let value = rawValue?.trimmingCharacters(in: .whitespacesAndNewlines)
        guard
            let value,
            !value.isEmpty,
            let url = URL(string: value)
        else {
            return nil
        }
        return .remote(url)
    }
}
