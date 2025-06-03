import XCTest
@testable import Study

@MainActor
final class AuthViewModelTests: XCTestCase {

    func testLoginFlow() async {
        let mock = MockNetworkManager()

        step("Создаём AuthViewModel с мок-сервисом") {
            let viewModel = AuthViewModel(network: mock)
            XCTAssertFalse(viewModel.isLoggedIn)
        }

        step("Логинимся") {
            let viewModel = AuthViewModel(network: mock)
            Task {
                await viewModel.login(email: "test@example.com", password: "123456")
            }
        }
    }

//    func testRegisterFlow() async {
//        let mock = MockNetworkManager()
//        let viewModel = AuthViewModel(network: mock)
//
//        await step("Регистрация нового пользователя") {
//            await viewModel.register(
//                email: "john@doe.com",
//                password: "123456",
//                firstName: "John",
//                lastName: "Doe"
//            )
//        }
//
//        step("Проверка состояния") {
//            XCTAssertTrue(viewModel.isLoggedIn)
//            XCTAssertEqual(viewModel.email, mock.mockUser.email)
//        }
//    }
}
