import Foundation
import SwiftUI

class AppState: ObservableObject {
    @Published var cart: [Product] = []
    @Published var wishlist: [Product] = []

    func addToCart(_ product: Product) {
        if !cart.contains(product) {
            cart.append(product)
        }
    }

    func addToWishlist(_ product: Product) {
        if !wishlist.contains(product) {
            wishlist.append(product)
        }
    }

    func removeFromWishlist(_ product: Product) {
        wishlist.removeAll { $0 == product }
    }

    func clearSession() {
        cart.removeAll()
        wishlist.removeAll()
    }
}
