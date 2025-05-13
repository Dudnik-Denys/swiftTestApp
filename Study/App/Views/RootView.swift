import SwiftUI

@main
struct MyApp: App {
    @StateObject var cartVM = CartViewModel()
    @StateObject var wishlistVM = WishlistViewModel()

    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(cartVM)
                .environmentObject(wishlistVM)
        }
    }
}

struct RootView: View {
    @AppStorage("isLoggedIn") var isLoggedIn: Bool = false
    
    var body: some View {
        if isLoggedIn {
            MainTabView()
        } else {
            AuthView()
        }
    }
}
