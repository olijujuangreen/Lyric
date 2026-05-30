//
//  LyricReplyPreview.swift
//  Lyric
//
//  Created by Codex on 5/30/26.
//

public struct LyricReplyPreview {
    public let senderName: String
    public let previewText: String
    public let thumbnail: LyricThumbnail?
    public let clearAccessibilityLabel: String

    public var hasThumbnail: Bool { thumbnail != nil }

    public init(
        senderName: String,
        previewText: String,
        thumbnail: LyricThumbnail? = nil,
        clearAccessibilityLabel: String = "Cancel reply"
    ) {
        self.senderName = senderName
        self.previewText = previewText
        self.thumbnail = thumbnail
        self.clearAccessibilityLabel = clearAccessibilityLabel
    }
}
