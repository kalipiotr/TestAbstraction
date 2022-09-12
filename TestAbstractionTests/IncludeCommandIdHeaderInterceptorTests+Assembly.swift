import Foundation

@testable import TestAbstraction

final class IncludeCommandIdHeaderInterceptorTestsAssembly: Assembly {
    lazy var url = URL(staticString: "https://kalisoft.eu")
    lazy var request = URLRequest(url: url)
    lazy var commandId = "_command_id_"
    lazy var requestCommandId = "_request_command_id_"
    
    func assemble(injector: Injectable) { }
}
