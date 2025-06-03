import Foundation
@testable import Study

final class MockNetworkManager: NetworkService {
    var mockToken: String = "mock_token_123"
    var mockUser: UserProfile = UserProfile(
        email: "mock@test.com",
        first_name: "Mock",
        last_name: "User"
    )

    func login(email: String, password: String) async throws -> String {
        return mockToken
    }

    func register(email: String, password: String, firstName: String, lastName: String) async throws {
        // Симуляция успешной регистрации — можно логировать или симулировать ошибки
    }

    func fetchUserProfile() async throws -> UserProfile {
        return mockUser
    }
}
