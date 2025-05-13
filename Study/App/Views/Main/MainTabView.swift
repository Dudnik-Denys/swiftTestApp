import SwiftUI

struct MainTabView: View {
    @StateObject var appState = AppState()

    var body: some View {
        TabView {
            CatalogView()
                .tabItem {
                    Image(systemName: "square.grid.2x2")
                    Text("Каталог")
                }

            CartView()
                .tabItem {
                    Image(systemName: "cart")
                    Text("Корзина")
                }

            WishlistView()
                .tabItem {
                    Image(systemName: "heart")
                    Text("Желаемое")
                }

            ProfileView()
                .tabItem {
                    Image(systemName: "person.circle")
                    Text("Профиль")
                }
        }
        .environmentObject(appState) // ⬅️ пробрасываем глобальное состояние
    }
}
