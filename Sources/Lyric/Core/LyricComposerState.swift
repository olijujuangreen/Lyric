//
//  LyricComposerState.swift
//  Lyric
//
//  Created by Codex on 5/30/26.
//

public struct LyricComposerState: Equatable {
    public let canAttach: Bool
    public let isSending: Bool
    public let isSendDisabled: Bool
    public let isMicDisabled: Bool
    public let isMicActive: Bool

    public var micButtonOpacity: Double { isMicDisabled ? 0.42 : 0.82 }
    public var sendButtonOpacity: Double { isSendDisabled ? 0.48 : 0.86 }
    public var micButtonAccessibilityLabel: String { isMicActive ? "Stop dictation" : "Start dictation" }
    public var sendButtonAccessibilityLabel: String { isSending ? "Sending message" : "Send message" }

    public init(
        canAttach: Bool = true,
        isSending: Bool = false,
        isSendDisabled: Bool = false,
        isMicDisabled: Bool = false,
        isMicActive: Bool = false
    ) {
        self.canAttach = canAttach
        self.isSending = isSending
        self.isSendDisabled = isSendDisabled
        self.isMicDisabled = isMicDisabled
        self.isMicActive = isMicActive
    }
}
