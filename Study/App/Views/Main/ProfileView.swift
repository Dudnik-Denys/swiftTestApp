import SwiftUI

struct ProfileView: View {
    @AppStorage("firstName") var firstName = ""
    @AppStorage("lastName") var lastName = ""
    @AppStorage("email") var email = ""
    @AppStorage("authToken") var authToken = ""
    @AppStorage("isLoggedIn") var isLoggedIn = false

    @EnvironmentObject var appState: AppState

    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 20) {
                Group {
                    Text("Имя: \(firstName)")
                    Text("Фамилия: \(lastName)")
                    Text("Email: \(email)")
                }
                .font(.headline)

                Spacer()

                Button(action: {
                    authToken = ""
                    isLoggedIn = false
                    email = ""
                    firstName = ""
                    lastName = ""
                    appState.clearSession()
                }) {
                    Text("Выйти из аккаунта")
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.red)
                        .cornerRadius(10)
                }
            }
            .padding()
            .navigationTitle("Профиль")
        }
    }
}
