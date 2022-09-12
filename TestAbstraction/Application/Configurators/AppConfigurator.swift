import Foundation

protocol Configurator {
    static func configure()
}

enum AppConfigurator {
    static func configure(_ configurators: [Configurator.Type]) {
        configurators.forEach { $0.configure() }
    }
}
