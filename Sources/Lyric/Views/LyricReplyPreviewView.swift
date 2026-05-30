//
//  LyricReplyPreviewView.swift
//  Lyric
//
//  Created by Codex on 5/30/26.
//

import SwiftUI

struct LyricReplyPreviewView: View {
    let preview: LyricReplyPreview
    let clearAction: () -> Void

    var body: some View {
        HStack(spacing: 10) {
            leadingBar
            textContent
            Spacer(minLength: .zero)
            thumbnail
            clearButton
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
        .background(
            Color.secondary.opacity(0.12),
            in: RoundedRectangle(cornerRadius: 12, style: .continuous)
        )
    }

    private var leadingBar: some View {
        RoundedRectangle(cornerRadius: 1.5)
            .fill(Color.accentColor)
            .frame(width: 3, height: 34)
    }

    private var textContent: some View {
        VStack(alignment: .leading, spacing: 2) {
            Text("Replying to \(preview.senderName)")
                .font(.caption.weight(.semibold))
                .foregroundStyle(.secondary)
                .lineLimit(1)

            Text(preview.previewText)
                .font(.subheadline)
                .foregroundStyle(.primary)
                .lineLimit(1)
        }
    }

    @ViewBuilder
    private var thumbnail: some View {
        if let thumbnail = preview.thumbnail {
            LyricThumbnailView(thumbnail: thumbnail, size: 34)
        }
    }

    private var clearButton: some View {
        Button(action: clearAction) {
            Image(systemName: "xmark.circle.fill")
                .foregroundStyle(.secondary)
        }
        .buttonStyle(.plain)
        .accessibilityLabel(preview.clearAccessibilityLabel)
    }
}
