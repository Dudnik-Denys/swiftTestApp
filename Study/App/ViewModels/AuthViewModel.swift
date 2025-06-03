import SwiftUI

@MainActor
class AuthViewModel: ObservableObject {
    private let network: NetworkService

    init(network: NetworkService = NetworkManager.shared) {
        self.network = network
    }

    @AppStorage("isLoggedIn") var isLoggedIn = false
    @AppStorage("email") var email = ""
    @AppStorage("firstName") var firstName = ""
    @AppStorage("lastName") var lastName = ""
    @AppStorage("authToken") var authToken = ""

    func login(email: String, password: String) async {
        do {
            let token = try await network.login(email: email, password: password)
            self.authToken = token
            self.isLoggedIn = true

            let user = try await network.fetchUserProfile()
            self.email = user.email
            self.firstName = user.first_name
            self.lastName = user.last_name
        } catch {
            print("Login failed:", error)
        }
    }

    func register(email: String, password: String, firstName: String, lastName: String) async {
        do {
            try await network.register(email: email, password: password, firstName: firstName, lastName: lastName)

            let token = try await network.login(email: email, password: password)
            self.authToken = token
            self.isLoggedIn = true

            let user = try await network.fetchUserProfile()
            self.email = user.email
            self.firstName = user.first_name
            self.lastName = user.last_name

        } catch {
            print("Registration failed:", error)
        }
    }
}
