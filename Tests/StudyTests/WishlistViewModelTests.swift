import XCTest
@testable import Study

@MainActor
final class WishlistViewModelTests: XCTestCase {

    func testAddProductAppearsInList() async {
         let wishlist = WishlistViewModel()
         let product = Product(id: 3, name: "iPad", description: "", price: 600)

         step("Добавляем iPad в вишлист") {
             wishlist.add(product)
         }

         step("Проверяем, что iPad есть в списке") {
             XCTAssertTrue(wishlist.items.contains(product))
         }
     }

     func testPreventDuplicates() async {
         let wishlist = WishlistViewModel()
         let product = Product(id: 3, name: "iPad", description: "", price: 600)

         step("Добавляем один и тот же товар дважды") {
             wishlist.add(product)
             wishlist.add(product)
         }

         step("Проверяем, что товар не дублируется") {
             XCTAssertEqual(wishlist.items.count, 1)
         }
     }
}
