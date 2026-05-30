//
//  LyricAttachmentPreview.swift
//  Lyric
//
//  Created by Codex on 5/30/26.
//

import Foundation

public enum LyricAttachmentPreviewKind {
    case thumbnail(LyricThumbnail)
    case text
    case audio
    case video(LyricThumbnail?)
    case link
    case document(typeLabel: String, systemImage: String)

    public var thumbnail: LyricThumbnail? {
        switch self {
        case .thumbnail(let thumbnail):
            thumbnail
        case .video(let thumbnail):
            thumbnail
        case .text, .audio, .link, .document:
            nil
        }
    }

    public var typeLabel: String {
        switch self {
        case .thumbnail:
            "IMG"
        case .text:
            "TXT"
        case .audio:
            "AUD"
        case .video:
            "VID"
        case .link:
            "URL"
        case .document(let typeLabel, _):
            typeLabel.uppercased()
        }
    }

    public var systemImage: String {
        switch self {
        case .thumbnail:
            "photo"
        case .text:
            "doc.plaintext"
        case .audio:
            "waveform"
        case .video:
            "play.rectangle.fill"
        case .link:
            "link"
        case .document(_, let systemImage):
            systemImage
        }
    }
}

public struct LyricAttachmentPreview: Identifiable {
    public let id: String
    public let title: String
    public let subtitle: String
    public let kind: LyricAttachmentPreviewKind
    public let removeAccessibilityLabel: String

    public var thumbnail: LyricThumbnail? { kind.thumbnail }
    public var hasThumbnail: Bool { thumbnail != nil }

    public init(
        id: String = UUID().uuidString,
        title: String,
        subtitle: String,
        kind: LyricAttachmentPreviewKind,
        removeAccessibilityLabel: String = "Remove attachment"
    ) {
        self.id = id
        self.title = title
        self.subtitle = subtitle
        self.kind = kind
        self.removeAccessibilityLabel = removeAccessibilityLabel
    }

    public init(
        id: String = UUID().uuidString,
        title: String,
        subtitle: String,
        thumbnail: LyricThumbnail,
        removeAccessibilityLabel: String = "Remove attachment"
    ) {
        self.id = id
        self.title = title
        self.subtitle = subtitle
        kind = .thumbnail(thumbnail)
        self.removeAccessibilityLabel = removeAccessibilityLabel
    }
}
