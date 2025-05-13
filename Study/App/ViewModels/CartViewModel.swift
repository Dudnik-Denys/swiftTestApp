import Foundation
import SwiftUI

@MainActor
class CartViewModel: ObservableObject {
    @Published var items: [Product] = []

    var totalPrice: Int {
        items.reduce(0) { $0 + $1.price }
    }

    func add(_ product: Product) {
        items.append(product)
    }

    func remove(_ product: Product) {
        items.removeAll { $0.id == product.id }
    }

    func clear() {
        items.removeAll()
    }
}
