//
//  LyricAttachmentPreviewView.swift
//  Lyric
//
//  Created by Codex on 5/30/26.
//

import SwiftUI

struct LyricAttachmentPreviewView: View {
    let previews: [LyricAttachmentPreview]
    let removeAction: (LyricAttachmentPreview.ID) -> Void

    var body: some View {
        ScrollView(.horizontal) {
            HStack(spacing: 8) {
                ForEach(previews) { preview in
                    LyricAttachmentPreviewCard(
                        preview: preview,
                        removeAction: { removeAction(preview.id) }
                    )
                }
            }
            .scrollTargetLayout()
        }
        .scrollIndicators(.hidden)
        .scrollTargetBehavior(.viewAligned)
    }
}

private struct LyricAttachmentPreviewCard: View {
    private let size: CGFloat = 108

    let preview: LyricAttachmentPreview
    let removeAction: () -> Void

    var body: some View {
        ZStack(alignment: .topTrailing) {
            cardContent
                .frame(width: size, height: size)
                .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))

            Button(action: removeAction) {
                Image(systemName: "xmark")
                    .font(.system(size: 14, weight: .bold))
                    .foregroundStyle(.white)
                    .frame(width: 30, height: 30)
                    .background(.black.opacity(0.72), in: Circle())
            }
            .buttonStyle(.plain)
            .padding(6)
            .accessibilityLabel(preview.removeAccessibilityLabel)
        }
        .frame(width: size, height: size)
    }

    @ViewBuilder
    private var cardContent: some View {
        if let thumbnail = preview.thumbnail {
            ZStack(alignment: .bottomLeading) {
                LyricThumbnailView(thumbnail: thumbnail, size: size, cornerRadius: 18)

                if case .video = preview.kind {
                    Image(systemName: "play.fill")
                        .font(.system(size: 15, weight: .bold))
                        .foregroundStyle(.white)
                        .frame(width: 30, height: 30)
                        .background(.black.opacity(0.48), in: Circle())
                        .padding(8)
                }
            }
        } else {
            VStack(alignment: .leading, spacing: 0) {
                Text(preview.kind.typeLabel)
                    .font(.title3.weight(.semibold))
                    .lineLimit(1)
                    .minimumScaleFactor(0.7)
                    .foregroundStyle(.white.opacity(0.72))

                Spacer(minLength: 8)

                Text(preview.title)
                    .font(.callout.weight(.semibold))
                    .foregroundStyle(.white)
                    .lineLimit(2)

                if !preview.subtitle.isEmpty {
                    Text(preview.subtitle)
                        .font(.callout.weight(.semibold))
                        .foregroundStyle(.white)
                        .lineLimit(1)
                }
            }
            .padding(14)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
            .background(Color.secondary.opacity(0.34))
        }
    }
}
