import Foundation
import SwiftUI

final class NetworkManager {
    static let shared = NetworkManager()
    private init() {}

    private let baseURL = URL(string: "http://192.168.1.142:8000")! // 🔁 измени на свой адрес при деплое

    @AppStorage("authToken") private var authToken: String = ""

    // 🔧 Универсальный запрос
    func request<T: Decodable>(
        _ endpoint: Endpoint,
        method: HTTPMethod = .get,
        body: Data? = nil,
        responseType: T.Type = T.self
    ) async throws -> T {
        var urlRequest = URLRequest(url: baseURL.appendingPathComponent(endpoint.path))
        urlRequest.httpMethod = method.rawValue

        if let body = body {
            urlRequest.httpBody = body
            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        }

        // Добавляем токен, если есть
        if !authToken.isEmpty {
            urlRequest.setValue("Bearer \(authToken)", forHTTPHeaderField: "Authorization")
        }

        let (data, response) = try await URLSession.shared.data(for: urlRequest)

        guard let http = response as? HTTPURLResponse, (200..<300).contains(http.statusCode) else {
            throw NetworkError.invalidStatus
        }

        return try JSONDecoder().decode(T.self, from: data)
    }

    // 🔓 POST /login → токен
    func login(email: String, password: String) async throws -> String {
        let payload = ["email": email, "password": password]
        let body = try JSONEncoder().encode(payload)

        let response: TokenResponse = try await request(.login, method: .post, body: body)
        self.authToken = response.access_token
        return response.access_token
    }

    // 🧑‍💻 GET /me → профиль
    func fetchUserProfile() async throws -> UserProfile {
        return try await request(.me)
    }

    // ⛔ Очистка токена (logout)
    func logout() {
        authToken = ""
    }
}
