pipeline {
    agent any

    environment {
        SCHEME = "Study"
        PROJECT_PATH = "Study.xcodeproj"
        SIMULATOR_NAME = "iPhone 16"
        ALLURE_TOOL_PATH = "/Users/dendarkholme/swiftLearning/Study/allure-xcresult/.build/release/AllureXCResult"
        DERIVED_DATA = "${WORKSPACE}/DerivedData"
    }

    stages {
        stage('🧹 Очистка') {
            steps {
                sh '''
                    rm -rf TestResults
                    mkdir -p TestResults
                    rm -rf allure-results
                    mkdir -p allure-results
                    rm -rf allure-report
                    rm -rf DerivedData
                    rm -rf ~/Library/Developer/Xcode/DerivedData
                '''
            }
        }

        stage('🧪 Параллельный запуск тестов') {
            parallel {
                stage('Cart') {
                    steps {
                        sh """
                            xcodebuild test \
                              -scheme ${SCHEME} \
                              -project ${PROJECT_PATH} \
                              -destination 'platform=iOS Simulator,name=${SIMULATOR_NAME}' \
                              -only-testing:StudyTests/CartViewModelTests \
                              -derivedDataPath ${DERIVED_DATA} \
                              -resultBundlePath TestResults/Cart.xcresult
                        """
                    }
                }

                stage('Wishlist') {
                    steps {
                        sh """
                            xcodebuild test \
                              -scheme ${SCHEME} \
                              -project ${PROJECT_PATH} \
                              -destination 'platform=iOS Simulator,name=${SIMULATOR_NAME}' \
                              -only-testing:StudyTests/WishlistViewModelTests \
                              -derivedDataPath ${DERIVED_DATA} \
                              -resultBundlePath TestResults/Wishlist.xcresult
                        """
                    }
                }

                stage('UI Login') {
                    steps {
                        sh """
                            xcodebuild test \
                              -scheme ${SCHEME} \
                              -project ${PROJECT_PATH} \
                              -destination 'platform=iOS Simulator,name=${SIMULATOR_NAME}' \
                              -only-testing:StudyUITests/StudyUITests \
                              -derivedDataPath ${DERIVED_DATA} \
                              -resultBundlePath TestResults/UI.xcresult
                        """
                    }
                }
            }
        }

        stage('🛠 Конвертация в Allure') {
            steps {
                sh '''
                    if [ -d "TestResults/Cart.xcresult" ]; then
                      ${ALLURE_TOOL_PATH} --input TestResults/Cart.xcresult --output allure-results
                    fi
                    if [ -d "TestResults/Wishlist.xcresult" ]; then
                      ${ALLURE_TOOL_PATH} --input TestResults/Wishlist.xcresult --output allure-results
                    fi
                    if [ -d "TestResults/UI.xcresult" ]; then
                      ${ALLURE_TOOL_PATH} --input TestResults/UI.xcresult --output allure-results
                    fi
                '''
            }
        }

        stage('📊 Генерация отчета') {
            steps {
                sh 'allure generate allure-results --clean -o allure-report'
            }
        }

        stage('🌐 Публикация Allure') {
            steps {
                allure includeProperties: false, jdk: '', results: [[path: 'allure-results']]
            }
        }
    }
}
