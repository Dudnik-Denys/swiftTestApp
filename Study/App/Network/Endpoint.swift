enum Endpoint {
    case login
    case register
    case me
    case products

    var path: String {
        switch self {
        case .login: return "/login"
        case .register: return "/register"
        case .me: return "/me"
        case .products: return "/products"
        }
    }
}
