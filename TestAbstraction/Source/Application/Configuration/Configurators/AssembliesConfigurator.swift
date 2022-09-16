import Foundation

class AssembliesConfigurator: Configurator {
    static func configure() {
        Injector.main.assemble([
            AppAssembly()
        ])
    }
}
