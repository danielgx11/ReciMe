import os

nonisolated enum AppLog {
    static let repository = Logger(subsystem: "com.danielgx.ReciMe", category: "repository")
}
