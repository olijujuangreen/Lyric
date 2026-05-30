//
//  LyricComposerActions.swift
//  Lyric
//
//  Created by Codex on 5/30/26.
//

public struct LyricComposerActions {
    public let presentAttachments: () -> Void
    public let send: () -> Void
    public let toggleDictation: () -> Void
    public let removeAttachment: () -> Void
    public let removeAttachmentWithID: (LyricAttachmentPreview.ID) -> Void
    public let clearReply: () -> Void

    public init(
        presentAttachments: @escaping () -> Void = {},
        send: @escaping () -> Void = {},
        toggleDictation: @escaping () -> Void = {},
        removeAttachment: @escaping () -> Void = {},
        removeAttachmentWithID: ((LyricAttachmentPreview.ID) -> Void)? = nil,
        clearReply: @escaping () -> Void = {}
    ) {
        self.presentAttachments = presentAttachments
        self.send = send
        self.toggleDictation = toggleDictation
        self.removeAttachment = removeAttachment
        self.removeAttachmentWithID = removeAttachmentWithID ?? { _ in removeAttachment() }
        self.clearReply = clearReply
    }
}
