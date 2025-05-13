import SwiftUI

struct AuthView: View {
    @State private var selectedTab = 0

    var body: some View {
        VStack {
            Picker(selection: $selectedTab, label: Text("Авторизация")) {
                Text("Вход").tag(0)
                Text("Регистрация").tag(1)
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()

            if selectedTab == 0 {
                LoginView()
            } else {
                RegisterView()
            }
        }
    }
}
