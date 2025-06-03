set -e
set -x

cd /Users/dendarkholme/swiftLearning/Study

echo "📦 Очистка предыдущих результатов..."
rm -rf TestResults.xcresult
rm -rf allure-results
rm -rf allure-report

echo "🚀 Запуск тестов..."
xcodebuild test \
  -scheme Study \
  -destination 'platform=iOS Simulator,name=iPhone 16' \
  -parallel-testing-enabled NO \
  -resultBundlePath TestResults.xcresult

echo "🛠 Генерация allure-results..."
    /Users/dendarkholme/swiftLearning/Study/allure-xcresult/.build/release/AllureXCResult \
      --input TestResults.xcresult \
      --output allure-results

echo "🌐 Генерация и открытие Allure-отчёта..."
allure generate allure-results --clean -o allure-report
allure open allure-report
