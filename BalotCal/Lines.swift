//
//  LinesView.swift
//  BalotCal
//
//  Created by Yasser Tamimi on 11/11/2021.
//

import SwiftUI

struct VerticalLine: Shape {
    func path(in rect: CGRect) -> Path {
        return Path { path in
            path.move(to: CGPoint(x: rect.midX, y: 0))
            path.addLine(to: CGPoint(x: rect.midX, y: rect.maxY))
        }
    }
}

struct HorizontalLine: Shape {
    func path(in rect: CGRect) -> Path {
        return Path { path in
            path.move(to: CGPoint(x: 0, y: 0))
            path.addLine(to: CGPoint(x: rect.maxX, y: 0))
        }
    }
}
