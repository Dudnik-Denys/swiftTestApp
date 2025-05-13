import SwiftUI

struct CartView: View {
    @EnvironmentObject var viewModel: CartViewModel

    var body: some View {
        NavigationView {
            VStack {
                if viewModel.items.isEmpty {
                    Text("Корзина пуста")
                        .foregroundColor(.gray)
                        .padding()
                } else {
                    List {
                        ForEach(viewModel.items) { product in
                            HStack {
                                VStack(alignment: .leading) {
                                    Text(product.name).font(.headline)
                                    Text("\(product.price) $").font(.subheadline)
                                }
                                Spacer()
                                Button(action: {
                                    viewModel.remove(product)
                                }) {
                                    Image(systemName: "trash")
                                        .foregroundColor(.red)
                                }
                            }
                        }
                    }

                    HStack {
                        Text("Итого:")
                        Spacer()
                        Text("\(viewModel.totalPrice) $")
                            .bold()
                    }
                    .padding()

                    Button("Купить") {
                        // Позже активируем
                    }
                    .disabled(true)
                    .padding()
                }
            }
            .navigationTitle("Корзина")
        }
    }
}
