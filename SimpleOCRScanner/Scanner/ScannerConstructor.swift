import Foundation

final class ScannerConstructor {
    func build() -> ScannerViewController {
        let viewController = ScannerViewController()
        let view = ScannerView()
        viewController.scannerView = view
        return viewController
    }
}
