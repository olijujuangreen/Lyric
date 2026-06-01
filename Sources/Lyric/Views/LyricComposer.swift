//
//  LyricComposer.swift
//  Lyric
//
//  Created by Codex on 5/30/26.
//

import SwiftUI

@MainActor
public struct LyricComposer: View {
    @Binding private var draftMessage: String

    private let placeholder: String
    private let attachments: [LyricAttachmentPreview]
    private let reply: LyricReplyPreview?
    private let state: LyricComposerState
    private let actions: LyricComposerActions

    public var hasAttachment: Bool { !attachments.isEmpty }
    public var hasReply: Bool { reply != nil }

    public init(
        draftMessage: Binding<String>,
        placeholder: String = "Message",
        attachment: LyricAttachmentPreview? = nil,
        attachments: [LyricAttachmentPreview] = [],
        reply: LyricReplyPreview? = nil,
        state: LyricComposerState = LyricComposerState(),
        actions: LyricComposerActions = LyricComposerActions()
    ) {
        _draftMessage = draftMessage
        self.placeholder = placeholder
        self.attachments = attachments.isEmpty ? attachment.map { [$0] } ?? [] : attachments
        self.reply = reply
        self.state = state
        self.actions = actions
    }

    public var body: some View {
        VStack(spacing: 8) {
            replyPreview
            composerRow
        }
    }

    @ViewBuilder
    private var replyPreview: some View {
        if let reply {
            LyricReplyPreviewView(
                preview: reply,
                clearAction: actions.clearReply
            )
            .padding(.horizontal, 16)
            .padding(.top, 10)
        }
    }

    @ViewBuilder
    private var attachmentPreview: some View {
        if !attachments.isEmpty {
            LyricAttachmentPreviewView(
                previews: attachments,
                removeAction: actions.removeAttachmentWithID
            )
            .padding(.top, 10)
            .padding(.horizontal, 10)
            .padding(.bottom, 6)
        }
    }

    private var composerRow: some View {
        HStack(alignment: .bottom, spacing: 8) {
            if state.showsAttachmentButton {
                attachmentButton
            }
            inputCapsule
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal, 16)
        .padding(.top, 6)
        .padding(.bottom, 8)
    }

    private var attachmentButton: some View {
        Button(action: actions.presentAttachments) {
            Image(systemName: "plus")
                .font(.system(size: 24, weight: .regular))
                .squareFrame(44)
        }
        .buttonStyle(.plain)
        .disabled(!state.canAttach)
        #if os(macOS)
        .background(.regularMaterial, in: Circle())
        #endif
    }

    private var inputCapsule: some View {
        VStack(spacing: 0) {
            attachmentPreview

            HStack(alignment: .bottom, spacing: 8) {
                messageField
                if state.showsMicButton {
                    micButton
                }
                sendButton
            }
            .frame(minHeight: 44)
        }
        .frame(maxWidth: .infinity, minHeight: 44)
        #if os(macOS)
        .background(.regularMaterial, in: inputShape)
        #endif
    }

    private var inputShape: RoundedRectangle {
        RoundedRectangle(cornerRadius: hasAttachment ? 24 : 22, style: .continuous)
    }

    private var messageField: some View {
        TextField(placeholder, text: $draftMessage, axis: .vertical)
            .lineLimit(1...5)
            .textFieldStyle(.plain)
            .font(.body.weight(.regular))
            .padding(.vertical, 9)
            .padding(.leading, 18)
            .padding(.trailing, 6)
    }

    private var micButton: some View {
        Button(action: actions.toggleDictation) {
            Image(systemName: state.isMicActive ? "waveform" : "mic")
                .font(.system(size: 20, weight: .regular))
                .foregroundStyle(.white.opacity(state.micButtonOpacity))
                .squareFrame(30)
        }
        .buttonStyle(.plain)
        .disabled(state.isMicDisabled)
        .padding(.bottom, 5)
        .accessibilityLabel(state.micButtonAccessibilityLabel)
    }

    private var sendButton: some View {
        Button(action: actions.send) {
            sendButtonContent
        }
        .buttonStyle(.plain)
        .disabled(state.isSendDisabled)
        .padding(.trailing, 8)
        .padding(.bottom, 5)
        .accessibilityLabel(state.sendButtonAccessibilityLabel)
    }

    @ViewBuilder
    private var sendButtonContent: some View {
        if state.isSending {
            ProgressView()
                .controlSize(.small)
                .tint(.white.opacity(0.86))
                .squareFrame(30)
        } else {
            Image(systemName: "arrow.up.circle.fill")
                .font(.system(size: 25, weight: .regular))
                .opacity(state.sendButtonOpacity)
                .squareFrame(30)
        }
    }
}

private extension View {
    func squareFrame(_ size: CGFloat) -> some View {
        frame(width: size, height: size)
    }
}
