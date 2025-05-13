import SwiftUI

struct WishlistView: View {
    @EnvironmentObject var viewModel: WishlistViewModel

    var body: some View {
        NavigationView {
            if viewModel.items.isEmpty {
                Text("Список желаемого пуст")
                    .foregroundColor(.gray)
                    .padding()
            } else {
                List {
                    ForEach(viewModel.items) { product in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(product.name)
                                    .font(.headline)
                                Text("\(product.price) $")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                            Spacer()
                            Button(action: {
                                viewModel.remove(product)
                            }) {
                                Image(systemName: "trash")
                                    .foregroundColor(.red)
                            }
                        }
                        .padding(.vertical, 6)
                    }
                }
                .navigationTitle("Желаемое")
            }
        }
    }
}
