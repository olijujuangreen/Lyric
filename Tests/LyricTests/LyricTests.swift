//
//  LyricTests.swift
//  LyricTests
//
//  Created by Codex on 5/30/26.
//

import SwiftUI
import Testing
@testable import Lyric

@Test("default composer state uses enabled labels and opacity")
func defaultComposerStateUsesEnabledLabelsAndOpacity() {
    let state = LyricComposerState()

    #expect(state.canAttach)
    #expect(!state.isSending)
    #expect(state.micButtonOpacity == 0.82)
    #expect(state.sendButtonOpacity == 0.86)
    #expect(state.micButtonAccessibilityLabel == "Start dictation")
    #expect(state.sendButtonAccessibilityLabel == "Send message")
}

@Test("disabled composer state lowers button opacity")
func disabledComposerStateLowersButtonOpacity() {
    let state = LyricComposerState(
        canAttach: false,
        isSendDisabled: true,
        isMicDisabled: true
    )

    #expect(!state.canAttach)
    #expect(state.micButtonOpacity == 0.42)
    #expect(state.sendButtonOpacity == 0.48)
}

@Test("active and sending state updates accessibility labels")
func activeAndSendingStateUpdatesAccessibilityLabels() {
    let state = LyricComposerState(
        isSending: true,
        isMicActive: true
    )

    #expect(state.micButtonAccessibilityLabel == "Stop dictation")
    #expect(state.sendButtonAccessibilityLabel == "Sending message")
}

@Test("reply preview reports thumbnail presence")
func replyPreviewReportsThumbnailPresence() {
    let textOnly = LyricReplyPreview(
        senderName: "Taylor",
        previewText: "No thumbnail"
    )
    let withThumbnail = LyricReplyPreview(
        senderName: "Taylor",
        previewText: "With thumbnail",
        thumbnail: .symbol("person.fill")
    )

    #expect(!textOnly.hasThumbnail)
    #expect(withThumbnail.hasThumbnail)
}

@Test("attachment preview exposes default remove label")
func attachmentPreviewExposesDefaultRemoveLabel() {
    let preview = LyricAttachmentPreview(
        id: "clip",
        title: "Clip",
        subtitle: "Audio",
        thumbnail: .symbol("waveform")
    )

    #expect(preview.id == "clip")
    #expect(preview.title == "Clip")
    #expect(preview.subtitle == "Audio")
    #expect(preview.hasThumbnail)
    #expect(preview.removeAccessibilityLabel == "Remove attachment")
}

@Test("attachment preview supports non-thumbnail file types")
func attachmentPreviewSupportsNonThumbnailFileTypes() {
    let preview = LyricAttachmentPreview(
        id: "pasted-text",
        title: "Pasted",
        subtitle: "Text(6)",
        kind: .text
    )

    #expect(preview.kind.typeLabel == "TXT")
    #expect(preview.kind.systemImage == "doc.plaintext")
    #expect(!preview.hasThumbnail)
}

@Test("attachment removal falls back to legacy action")
func attachmentRemovalFallsBackToLegacyAction() {
    var didRemove = false
    let actions = LyricComposerActions(
        removeAttachment: { didRemove = true }
    )

    actions.removeAttachmentWithID("clip")

    #expect(didRemove)
}

@Test("remote thumbnail rejects blank URL strings")
func remoteThumbnailRejectsBlankURLStrings() {
    if case .some = LyricThumbnail.remote(nil) {
        Issue.record("Nil remote thumbnail input should be rejected.")
    }
    if case .some = LyricThumbnail.remote("   ") {
        Issue.record("Blank remote thumbnail input should be rejected.")
    }
}
