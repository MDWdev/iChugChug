//
//  Helpers.swift
//  iChugChug
//
//  Created by Melissa Webster on 6/9/25.
//

import SwiftUI

struct StatefulPreviewWrapper<Value, Content: View>: View {
    @State private var value: Value
    private let content: (Binding<Value>) -> Content

    init(_ initialValue: Value, content: @escaping (Binding<Value>) -> Content) {
        _value = State(initialValue: initialValue)
        self.content = content
    }

    var body: some View {
        content($value)
    }
}

func symbolForTag(_ tag: String) -> String {
    switch tag.lowercased() {
    case "study":
        return "studentdesk"
    case "remote work":
        return "laptopcomputer"
    case "meeting space":
        return "person.3.fill"
    case "fast service":
        return "hare.fill"
    case "artwork":
        return "paintbrush.pointed.fill"
    case "live events":
        return "music.mic"
    case "comfy seating":
        return "chair.lounge.fill"
    case "sensory friendly":
        return "headphones"
    case "natural light":
        return "sun.max.fill"
    case "pastries":
        return "fork.knife.circle.fill"
    default:
        return "questionmark.circle"
    }
}

struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        Path { path in
            path.move(to: CGPoint(x: rect.midX, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
            path.closeSubpath()
        }
    }
}
