import SwiftUI

@MainActor
class WishlistViewModel: ObservableObject {
    @Published var items: [Product] = []

    func add(_ product: Product) {
        if !items.contains(product) {
            items.append(product)
        }
    }

    func remove(_ product: Product) {
        items.removeAll { $0.id == product.id }
    }

    func clear() {
        items.removeAll()
    }
}
