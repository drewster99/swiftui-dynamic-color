import SwiftUIDynamicColor

let a = 17
let b = 25

//let (result, code) = #stringify(a + b)

//print("The value \(result) was produced by the code \"\(code)\"")
import SwiftUI



extension ShapeStyle where Self == SwiftUIDynamicColorShapeStyle {
    #DynamicColor("barch", defaultColor: .blue, darkColor: .red)
}

struct Thingy: View {
    var body: some View {
        Text("Hello")
            .foregroundStyle(.barch)
//            .background(Color.markdownKeyword)
//            .background()
    }
}
