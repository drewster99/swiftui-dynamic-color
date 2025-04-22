// The Swift Programming Language
// https://docs.swift.org/swift-book

/// A macro that produces both a value and a string containing the
/// source code that generated the value. For example,
///
///     #stringify(x + y)
///
/// produces a tuple `(x + y, "x + y")`.
///

import SwiftUI

public struct SwiftUIDynamicColorShapeStyle: ShapeStyle {
    public let defaultColor: Color
    public let darkColor: Color

    public init(defaultColor: Color, darkColor: Color) {
        self.defaultColor = defaultColor
        self.darkColor = darkColor
    }
    public func resolve(in environment: EnvironmentValues) -> Color {
        let colorScheme = environment.colorScheme
        return colorScheme == .dark ? darkColor : defaultColor
    }
}

@freestanding(declaration, names: arbitrary)
public macro DynamicColor(_ name: StaticString, `defaultColor`: SwiftUI.Color, darkColor: SwiftUI.Color) = #externalMacro(module: "SwiftUIDynamicColorMacros", type: "DynamicColorMacro")


