import Foundation

protocol NetworkService {
    func login(email: String, password: String) async throws -> String
    func register(email: String, password: String, firstName: String, lastName: String) async throws
    func fetchUserProfile() async throws -> UserProfile
}
