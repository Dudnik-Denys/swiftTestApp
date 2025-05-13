//import SwiftUI
//
//
//struct CustomArrowView: View {
//    var arrowColor: Color
//    var width: CGFloat
//    var height: CGFloat
//
//    private var position: CGPoint {
//        let x = width * 0.75
//        let y = height * 0.6
//        return CGPoint(x: x, y: y)
//    }
//
//    var body: some View {
//        Path { path in
//            path.move(to: CGPoint(x: 15, y: 18))
//            path.addLine(to: CGPoint(x: 24, y: 26))
//            path.move(to: CGPoint(x: 15, y: 18))
//            path.addLine(to: CGPoint(x: 24, y: 10))
//            path.move(to: CGPoint(x: 15, y: 18))
//            path.addLine(to: CGPoint(x: 14.5, y: 18.5))
//        }
//        .stroke(arrowColor, lineWidth: 2)
//        .frame(width: width, height: height)
//        .position(position)
//    }
//}
