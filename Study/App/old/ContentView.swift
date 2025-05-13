//import SwiftUI
//
//struct ContentView: View {
//    var body: some View {
//        VStack {
//            HStack {
//                RoundedRectangle(cornerRadius: 10)
//                    .stroke(Color.white, lineWidth: 2)
//                    .frame(maxWidth: 44, maxHeight: 44)
//                    .padding(.leading, 10)
//                    .overlay(
//                        CustomArrowView(arrowColor: .white, width: 44, height: 44)
//                        )
//            }
//            .frame(
//                maxWidth: .infinity,
//                maxHeight:100,
//                alignment: .leading)
//            .border(Color(.green))
//            Spacer()
//            VStack {
//                ZStack {
//                    Image(.strongMan)
//                        .resizable()
//                        .frame(width: 30, height: 30)
//                        .aspectRatio(contentMode: .fit)
//                        .position(x: 35, y: 25)
////                        .border(Color.white)
//                        .overlay(
//                            RoundedRectangle(cornerRadius: 25)
//                                .stroke(Color.yellow, lineWidth: 1)
//                        )
//                }.frame(width: 70, height: 50)
//            }
//        }.background(Color("generalColor"))
//    }
//}
//        
//#Preview {
//    ContentView()
//}
