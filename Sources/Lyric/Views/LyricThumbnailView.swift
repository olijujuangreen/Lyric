//
//  LyricThumbnailView.swift
//  Lyric
//
//  Created by Codex on 5/30/26.
//

import SwiftUI

struct LyricThumbnailView: View {
    let thumbnail: LyricThumbnail
    let size: CGFloat
    var cornerRadius: CGFloat = 8

    var body: some View {
        content
            .frame(width: size, height: size)
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius, style: .continuous))
    }

    @ViewBuilder
    private var content: some View {
        switch thumbnail {
        case .image(let image):
            image
                .resizable()
                .scaledToFill()
        case .remote(let url):
            AsyncImage(url: url) { phase in
                switch phase {
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()
                case .empty:
                    ProgressView()
                        .controlSize(.small)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(Color.secondary.opacity(0.12))
                case .failure:
                    placeholder(symbol: "photo")
                @unknown default:
                    placeholder(symbol: "photo")
                }
            }
        case .symbol(let symbol):
            placeholder(symbol: symbol)
        }
    }

    private func placeholder(symbol: String) -> some View {
        Image(systemName: symbol)
            .font(.callout.weight(.semibold))
            .foregroundStyle(.secondary)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.secondary.opacity(0.12))
    }
}
