import SwiftUI

@MainActor
class AuthViewModel: ObservableObject {
    private let network = NetworkManager.shared

    @AppStorage("isLoggedIn") var isLoggedIn = false

    @AppStorage("email") var email = ""
    @AppStorage("firstName") var firstName = ""
    @AppStorage("lastName") var lastName = ""
    @AppStorage("authToken") var authToken = ""

    func login(email: String, password: String) async {
        let payload = ["email": email, "password": password]
        guard let body = try? JSONEncoder().encode(payload) else { return }

        do {
            let token: TokenResponse = try await network.request(.login, method: .post, body: body)
            self.authToken = token.access_token
            self.isLoggedIn = true

            // ⬇️ Запрос на /me
            let user = try await network.fetchUserProfile()
            self.email = user.email
            self.firstName = user.first_name
            self.lastName = user.last_name
        } catch {
            print("Login failed:", error)
        }
    }
    
    func register(email: String, password: String, firstName: String, lastName: String) async {
        let payload = [
            "email": email,
            "password": password,
            "first_name": firstName,
            "last_name": lastName
        ]
        guard let body = try? JSONEncoder().encode(payload) else { return }

        do {
            // 1. Регистрация
            struct EmptyResponse: Decodable {}
            let _: EmptyResponse = try await network.request(.register, method: .post, body: body, responseType: EmptyResponse.self)

            // 2. Авто-логин
            let token = try await network.login(email: email, password: password)
            authToken = token
            isLoggedIn = true

            // 3. Получение данных профиля
            let user = try await network.fetchUserProfile()
            self.email = user.email
            self.firstName = user.first_name
            self.lastName = user.last_name

        } catch {
            print("Registration failed:", error)
        }
    }
}
