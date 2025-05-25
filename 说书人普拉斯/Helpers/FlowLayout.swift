//
//  FlowLayout.swift
//  说书人普拉斯
//
//  Created by Xuan Tang on 5/22/25.
//

import SwiftUI

struct FlowLayout: Layout {
    var spacing: CGFloat = 8
    var alignment: HorizontalAlignment = .leading

    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        layout(in: proposal, subviews: subviews).size
    }

    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        let layout = layout(in: ProposedViewSize(width: bounds.width, height: bounds.height), subviews: subviews)
        for (index, frame) in layout.frames.enumerated() {
            subviews[index].place(at: frame.origin, proposal: ProposedViewSize(frame.size))
        }
    }

    private func layout(in proposal: ProposedViewSize, subviews: Subviews) -> (size: CGSize, frames: [CGRect]) {
        var frames: [CGRect] = []
        var currentX: CGFloat = 0
        var currentY: CGFloat = 0
        var maxHeight: CGFloat = 0

        let maxWidth = proposal.width ?? .infinity

        for subview in subviews {
            let size = subview.sizeThatFits(ProposedViewSize(width: maxWidth, height: .infinity))

            if currentX + size.width > maxWidth {
                currentX = 0
                currentY += maxHeight + spacing
                maxHeight = 0
            }

            frames.append(CGRect(origin: CGPoint(x: currentX, y: currentY), size: size))
            currentX += size.width + spacing
            maxHeight = max(maxHeight, size.height)
        }

        return (
            size: CGSize(width: maxWidth, height: currentY + maxHeight),
            frames: frames
        )
    }
}
