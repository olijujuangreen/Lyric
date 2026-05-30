//
//  LyricDemoScreen+View.swift
//  LyricDemoUI
//
//  Created by Codex on 5/30/26.
//

import Lyric
import SwiftUI

extension LyricDemoScreen: View {
    public var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                List {
                    Section("State") {
                        Picker("Mode", selection: $mode) {
                            ForEach(DemoMode.allCases) { mode in
                                Text(mode.rawValue).tag(mode)
                            }
                        }
                    }

                    Section("Transcript") {
                        ForEach(sampleMessages, id: \.self) { message in
                            Text(message)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                    }
                }

                LyricComposer(
                    draftMessage: $draftMessage,
                    placeholder: placeholder,
                    attachments: attachments,
                    reply: reply,
                    state: state,
                    actions: actions
                )
            }
            .navigationTitle("Lyric Demo")
        }
    }

    private var sampleMessages: [String] {
        [
            "This screen exercises the public composer API.",
            "Switch modes to preview attachments, replies, sending, disabled input, and dictation states.",
        ]
    }

    private var placeholder: String {
        mode == .disabled ? "Reply is locked" : "Send a message"
    }

    private var state: LyricComposerState {
        LyricComposerState(
            canAttach: mode != .disabled,
            isSending: mode == .sending,
            isSendDisabled: mode == .disabled || mode == .sending,
            isMicDisabled: mode == .disabled || mode == .sending,
            isMicActive: mode == .micActive
        )
    }

    private var attachments: [LyricAttachmentPreview] {
        switch mode {
        case .attachment:
            [
                LyricAttachmentPreview(
                    id: "clip",
                    title: "Favorite podcast moment",
                    subtitle: "Clip",
                    thumbnail: .symbol("waveform")
                ),
            ]
        case .attachments:
            [
                LyricAttachmentPreview(
                    id: "selfie",
                    title: "Dinner selfie",
                    subtitle: "Photo",
                    thumbnail: .remote(URL(string: "https://picsum.photos/id/64/240")!)
                ),
                LyricAttachmentPreview(
                    id: "studio",
                    title: "Studio still",
                    subtitle: "Photo",
                    thumbnail: .remote(URL(string: "https://picsum.photos/id/42/240")!)
                ),
                LyricAttachmentPreview(
                    id: "pasted-text",
                    title: "Pasted",
                    subtitle: "Text(6)",
                    kind: .text
                ),
                LyricAttachmentPreview(
                    id: "voice-note",
                    title: "Voice note",
                    subtitle: "0:18",
                    kind: .audio
                ),
            ]
        case .localImage:
            [
                LyricAttachmentPreview(
                    id: "local-image",
                    title: "Studio still",
                    subtitle: "Photo",
                    thumbnail: .image(Image(systemName: "photo.fill"))
                ),
            ]
        case .remoteImage:
            [
                LyricAttachmentPreview(
                    id: "remote-image",
                    title: "Remote media",
                    subtitle: "Photo",
                    thumbnail: .remote(URL(string: "https://picsum.photos/128")!)
                ),
            ]
        case .textAttachment:
            [
                LyricAttachmentPreview(
                    id: "text",
                    title: "Pasted",
                    subtitle: "Text(6)",
                    kind: .text
                ),
            ]
        default:
            []
        }
    }

    private var reply: LyricReplyPreview? {
        guard mode == .reply else { return nil }
        return LyricReplyPreview(
            senderName: "Morgan",
            previewText: "That section is worth clipping.",
            thumbnail: .symbol("person.crop.circle.fill")
        )
    }

    private var actions: LyricComposerActions {
        LyricComposerActions(
            presentAttachments: { mode = .attachments },
            send: { draftMessage = "" },
            toggleDictation: { mode = mode == .micActive ? .empty : .micActive },
            removeAttachment: { mode = .empty },
            removeAttachmentWithID: { _ in mode = .empty },
            clearReply: { mode = .empty }
        )
    }
}

#Preview("Lyric Demo") {
    LyricDemoScreen()
}
