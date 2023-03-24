import Foundation

final class ScannerConstructor {
    func build() -> ScannerViewController {
        let viewController = ScannerViewController()
        let view = ScannerView()
        let presenter = ScannerPresenter()
        
        viewController.scannerView = view
        viewController.presenter = presenter
        presenter.view = viewController
        
        return viewController
    }
}
