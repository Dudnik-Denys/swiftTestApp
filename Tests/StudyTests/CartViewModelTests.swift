import XCTest
@testable import Study

@MainActor
final class CartViewModelTests: XCTestCase {

    func testAddIncreasesItemCount() async {
        let cart = CartViewModel()
        let product = Product(id: 1, name: "MacBook", description: "", price: 2000)

        step("Добавляем товар в корзину") {
            cart.add(product)
        }

        step("Проверяем, что товар добавился") {
            XCTAssertEqual(cart.items.count, 1)
        }
    }

    func testRemoveDecreasesItemCount() async {
        let cart = CartViewModel()
        let product = Product(id: 2, name: "iPhone", description: "", price: 1000)

        step("Добавляем товар") {
            cart.add(product)
        }

        step("Удаляем товар") {
            cart.remove(product)
        }

        step("Проверяем, что корзина пуста") {
            XCTAssertEqual(cart.items.count, 0)
        }
    }

    func testTotalPriceIsCorrect() async {
        let cart = CartViewModel()

        step("Добавляем два товара") {
            cart.add(Product(id: 1, name: "A", description: "", price: 300))
            cart.add(Product(id: 2, name: "B", description: "", price: 700))
        }

        step("Проверяем итоговую сумму") {
            XCTAssertEqual(cart.totalPrice, 1000)
        }
    }
}
