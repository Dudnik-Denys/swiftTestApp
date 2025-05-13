import SwiftUI

struct CatalogView: View {
    @EnvironmentObject var appState: AppState
    @EnvironmentObject var cartVM: CartViewModel
    @StateObject var viewModel = CatalogViewModel()
    @EnvironmentObject var wishlistVM: WishlistViewModel


    var body: some View {
        NavigationView {
            List(viewModel.products) { product in
                VStack(alignment: .leading, spacing: 6) {
                    Text(product.name).font(.headline)
                    Text(product.description).font(.subheadline)
                    Text("\(product.price) $").font(.caption)

                    HStack {
                        Button("В корзину") {
                            appState.addToCart(product)
                            cartVM.add(product)
                        }
                        .buttonStyle(.bordered)

                        Button("В желания") {
                            appState.addToWishlist(product)
                            wishlistVM.add(product)
                        }
                        .buttonStyle(.bordered)
                    }
                }
                .padding(.vertical, 6)
            }
            .navigationTitle("Каталог")
            .task {
                await viewModel.loadProducts()
            }
        }
    }
}
