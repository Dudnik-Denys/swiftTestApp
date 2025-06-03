import Foundation
import SwiftUI

final class NetworkManager {
    static let shared = NetworkManager()
    private init() {}

    private let baseURL = URL(string: "http://localhost:8000")!
    @AppStorage("authToken") private var authToken: String = ""

    // Универсальный запрос
    func request<T: Decodable>(
        _ endpoint: Endpoint,
        method: HTTPMethod = .get,
        body: Data? = nil
    ) async throws -> T {
        var urlRequest = URLRequest(url: baseURL.appendingPathComponent(endpoint.path))
        urlRequest.httpMethod = method.rawValue

        if let body = body {
            urlRequest.httpBody = body
            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        }

        if !authToken.isEmpty {
            urlRequest.setValue("Bearer \(authToken)", forHTTPHeaderField: "Authorization")
        }

        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        guard let http = response as? HTTPURLResponse, (200..<300).contains(http.statusCode) else {
            throw NetworkError.invalidStatus
        }

        return try JSONDecoder().decode(T.self, from: data)
    }
}

extension NetworkManager: NetworkService {

    func login(email: String, password: String) async throws -> String {
        let payload = ["email": email, "password": password]
        let body = try JSONEncoder().encode(payload)
        let response: TokenResponse = try await request(.login, method: .post, body: body)
        self.authToken = response.access_token
        return response.access_token
    }

    func register(email: String, password: String, firstName: String, lastName: String) async throws {
        let payload = [
            "email": email,
            "password": password,
            "first_name": firstName,
            "last_name": lastName
        ]
        let body = try JSONEncoder().encode(payload)
        let _: TokenResponse = try await request(.register, method: .post, body: body)
    }

    func fetchUserProfile() async throws -> UserProfile {
        return try await request(.me)
    }

    func logout() {
        authToken = ""
    }
}

