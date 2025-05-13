import Foundation

struct Product: Identifiable, Decodable, Hashable {
    let id: Int
    let name: String
    let description: String
    let price: Int
}
