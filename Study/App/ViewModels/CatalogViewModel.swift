import Foundation

@MainActor
class CatalogViewModel: ObservableObject {
    @Published var products: [Product] = []
    private let network = NetworkManager.shared

    func loadProducts() async {
        do {
            products = try await network.request(.products)
        } catch {
            print("Ошибка загрузки каталога:", error)
        }
    }
}
