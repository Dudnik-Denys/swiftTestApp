import SwiftUI

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    @AppStorage("isLoggedIn") var isLoggedIn = false
    @StateObject var authVM = AuthViewModel()

    var body: some View {
        Form {
            Section(header: Text("Вход")) {
                TextField("Email", text: $email)
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
                    .accessibilityIdentifier("emailField")
                SecureField("Пароль", text: $password)
                    .accessibilityIdentifier("passwordField")
            }

            Button(action: {
                Task {
                    await authVM.login(email: email, password: password)
                }
            }) {
                Text("Войти")
                    .frame(maxWidth: .infinity, alignment: .center)
            }
            .disabled(email.isEmpty || password.isEmpty)
            .accessibilityIdentifier("loginButton")
        }
    }
}
