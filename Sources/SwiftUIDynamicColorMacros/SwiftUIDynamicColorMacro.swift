import SwiftCompilerPlugin
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros

public struct DynamicColorMacro: DeclarationMacro {
    public static func expansion(of node: some SwiftSyntax.FreestandingMacroExpansionSyntax,
                                 in context: some SwiftSyntaxMacros.MacroExpansionContext) throws -> [SwiftSyntax.DeclSyntax] {
        print("MONKEY BONES")
        print(node.arguments)

        guard node.arguments.count == 3 else {
            fatalError("compiler bug: the macro must have exactly 3 arguments")
        }

        guard let name = node.arguments.first?.expression.as(StringLiteralExprSyntax.self)?.representedLiteralValue else {
            throw MacroExpansionErrorMessage("the first argument must be a string literal")
        }

        guard let defaultColor = node.arguments.dropFirst().first?.expression else {
            throw MacroExpansionErrorMessage("The 2nd argument (`defaultColor`) must be a `SwiftUI.Color`")
        }
        guard let darkColor = node.arguments.dropFirst(2).first?.expression else {
            throw MacroExpansionErrorMessage("The 3rd argument (`darkColor`) must be a `SwiftUI.Color`")
        }
        
//        let name = node.arguments.
//        print(context)
//        let name = context.makeUniqueName("birds")
        var prints: [String] = []
        for lexContext in context.lexicalContext {
            prints.append("""
                print("ctx>>  \(lexContext.description)") 
                """)
        }

        return [
            // Must be within:
            // extension ShapeStyle where Self == SwiftUIDynamicColor {
            """
            static public var \(raw: name): SwiftUIDynamicColorShapeStyle {
                SwiftUIDynamicColorShapeStyle(defaultColor: \(defaultColor), darkColor: \(darkColor))
            }
            """
        ]
    }
    

}

/// Implementation of the `stringify` macro, which takes an expression
/// of any type and produces a tuple containing the value of that expression
/// and the source code that produced the value. For example
///
///     #stringify(x + y)
///
///  will expand to
///
///     (x + y, "x + y")
//public struct StringifyMacro: ExpressionMacro {
//    public static func expansion(
//        of node: some FreestandingMacroExpansionSyntax,
//        in context: some MacroExpansionContext
//    ) -> ExprSyntax {
//        guard let argument = node.arguments.first?.expression else {
//            fatalError("compiler bug: the macro does not have any arguments")
//        }
//
//        return "(\(argument), \(literal: argument.description))"
//    }
//}

@main
struct SwiftUIDynamicColorPlugin: CompilerPlugin {
    let providingMacros: [Macro.Type] = [
        DynamicColorMacro.self,
    ]
}
