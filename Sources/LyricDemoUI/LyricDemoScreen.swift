//
//  LyricDemoScreen.swift
//  LyricDemoUI
//
//  Created by Codex on 5/30/26.
//

import Lyric
import SwiftUI

@MainActor
public struct LyricDemoScreen {
    enum DemoMode: String, CaseIterable, Identifiable {
        case empty = "Empty"
        case sending = "Sending"
        case disabled = "Disabled"
        case attachment = "Attachment"
        case attachments = "Attachments"
        case reply = "Reply"
        case localImage = "Local Image"
        case remoteImage = "Remote URL"
        case textAttachment = "Text File"
        case micActive = "Mic Active"

        var id: String { rawValue }
    }

    @State var draftMessage = ""
    @State var mode: DemoMode = .empty

    public init() {}
}
