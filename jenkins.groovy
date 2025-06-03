pipeline {
    agent any

    environment {
        SCHEME = "Study"
        PROJECT_PATH = "Study.xcodeproj"
        SIMULATOR_NAME = "iPhone 16"
        ALLURE_TOOL_PATH = "/Users/dendarkholme/swiftLearning/Study/allure-xcresult/.build/release/AllureXCResult"
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
                              -resultBundlePath TestResults/Wishlist.xcresult
                        """
                    }
                }

                stage('Auth') {
                    steps {
                        sh """
                            xcodebuild test \
                              -scheme ${SCHEME} \
                              -project ${PROJECT_PATH} \
                              -destination 'platform=iOS Simulator,name=${SIMULATOR_NAME}' \
                              -only-testing:StudyTests/AuthViewModelTests \
                              -resultBundlePath TestResults/Auth.xcresult
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
                              -resultBundlePath TestResults/UI.xcresult
                        """
                    }
                }
            }
        }

        stage('🛠 Конвертация в Allure') {
            steps {
                sh '''
                    ${ALLURE_TOOL_PATH} --input TestResults/Cart.xcresult --output allure-results
                    ${ALLURE_TOOL_PATH} --input TestResults/Wishlist.xcresult --output allure-results
                    ${ALLURE_TOOL_PATH} --input TestResults/Auth.xcresult --output allure-results
                    ${ALLURE_TOOL_PATH} --input TestResults/UI.xcresult --output allure-results
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
