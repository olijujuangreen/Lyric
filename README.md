<img width="1536" height="1024" alt="ChatGPT Image May 30, 2026, 05_48_13 PM" src="https://github.com/user-attachments/assets/223d418e-f1b6-4818-a01a-a5a48cd34d8a" />

# Lyric

Lyric is a SwiftUI-only message composer extracted from Ekkos. It provides a reusable input bar with attachment, reply, dictation, and sending states while keeping app-specific message, model, upload, and networking logic in the consuming app.


Lyric is intentionally generic. It does not know about clips, users, conversations, or media upload backends. Apps map their own domain models into lightweight Lyric descriptor values.

## Requirements

- iOS 26+ for the composer UI
- macOS 15+ for SwiftPM host builds and the demo fallback UI
- Swift 6

## Installation

Add Lyric as a Swift Package dependency:

```swift
.package(url: "https://github.com/olijujuangreen/Lyric.git", from: "0.1.0")
```

Then add the product to your app target:

```swift
.product(name: "Lyric", package: "Lyric")
```

## Usage

```swift
import Lyric
import SwiftUI

struct ChatScreen: View {
    @State private var draft = ""

    var body: some View {
        LyricComposer(
            draftMessage: $draft,
            placeholder: "Send a message",
            attachments: [
                LyricAttachmentPreview(
                    id: "episode-clip",
                    title: "Episode clip",
                    subtitle: "Clip",
                    thumbnail: .symbol("waveform")
                ),
                LyricAttachmentPreview(
                    id: "pasted-text",
                    title: "Pasted",
                    subtitle: "Text(6)",
                    kind: .text
                ),
            ],
            reply: LyricReplyPreview(
                senderName: "Morgan",
                previewText: "That section is worth clipping.",
                thumbnail: .symbol("person.crop.circle.fill")
            ),
            state: LyricComposerState(
                showsAttachmentButton: true,
                showsMicButton: true,
                canAttach: true,
                isSending: false,
                isSendDisabled: draft.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty,
                isMicDisabled: false,
                isMicActive: false
            ),
            actions: LyricComposerActions(
                presentAttachments: {},
                send: {},
                toggleDictation: {},
                removeAttachment: {},
                removeAttachmentWithID: { attachmentID in
                    print("Remove", attachmentID)
                },
                clearReply: {}
            )
        )
    }
}
```

## Demo

The package includes a SwiftUI demo target named `LyricDemo`. Open the package in Xcode, select the `LyricDemo` scheme, and run it on an iOS 26 simulator.

The demo app entry point lives in `Sources/LyricDemo`, and the previewable SwiftUI screen lives in `Sources/LyricDemoUI`.
