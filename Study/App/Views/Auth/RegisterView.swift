import SwiftUI

struct RegisterView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var firstName = ""
    @State private var lastName = ""
    @AppStorage("isLoggedIn") var isLoggedIn = false
    @AppStorage("firstName") var storedFirstName = ""
    @AppStorage("lastName") var storedLastName = ""
    @AppStorage("email") var storedEmail = ""
    @StateObject var authVM = AuthViewModel()
    
    var body: some View {
        Form {
            Section(header: Text("Регистрация")) {
                TextField("Имя", text: $firstName)
                TextField("Фамилия", text: $lastName)
                TextField("Email", text: $email)
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
                SecureField("Пароль", text: $password)
            }

            Button("Зарегистрироваться") {
                Task {
                    await authVM.register(
                        email: email,
                        password: password,
                        firstName: firstName,
                        lastName: lastName
                    )
                }
            }
            .disabled(email.isEmpty || password.count < 6 || firstName.isEmpty || lastName.isEmpty)
        }
    }
}
