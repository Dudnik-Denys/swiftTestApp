import XCTest

func step(_ title: String, action: () -> Void) {
    XCTContext.runActivity(named: "🔹 STEP: \(title)") { _ in
        action()
    }
}


func step(_ title: String, action: @escaping () async -> Void) {
    XCTContext.runActivity(named: "🔹 STEP: \(title)") { _ in
        let semaphore = DispatchSemaphore(value: 0)

        Task {
            await action()
            semaphore.signal()
        }

        semaphore.wait()
    }
}
