import Foundation

protocol ScannerPresenterProtocol {
    func startScanning()
}

final class ScannerPresenter: ScannerPresenterProtocol {
    weak var view: ScannerViewProtocol?
    
    func startScanning() {
        
    }
}
