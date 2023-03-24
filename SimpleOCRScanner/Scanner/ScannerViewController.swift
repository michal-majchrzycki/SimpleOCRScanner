import UIKit
import VisionKit
import Vision

class ScannerViewController: UIViewController {
    var scannerView: ScannerView?
    
    private var ocrRecognizeRequest = VNRecognizeTextRequest(completionHandler: nil)
    
    override func loadView() {
        view = scannerView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scannerView?.delegate = self
        configureOCR()
    }

}

//MARK: - View implementation
extension ScannerViewController: ScannerViewDelegate {
    func didTapScanButton() {
        let vnDocumentController = VNDocumentCameraViewController()
        vnDocumentController.delegate = self
        present(vnDocumentController, animated: false)
    }
}

//MARK: - VNDocumentCameraViewControllerDelegate implementation
extension ScannerViewController: VNDocumentCameraViewControllerDelegate {
    func documentCameraViewController(_ controller: VNDocumentCameraViewController, didFinishWith scan: VNDocumentCameraScan) {
        guard scan.pageCount >= 1 else {
            controller.dismiss(animated: true)
            return
        }
        
        let image = scan.imageOfPage(at: 0)
        scannerView?.updateImage(image)
        processImage(scan.imageOfPage(at: 0))
        controller.dismiss(animated: true)
    }
    
    func documentCameraViewController(_ controller: VNDocumentCameraViewController, didFailWithError error: Error) {
        controller.dismiss(animated: true)
    }
    
    func documentCameraViewControllerDidCancel(_ controller: VNDocumentCameraViewController) {
        controller.dismiss(animated: true)
    }
}

extension ScannerViewController {
    private func configureOCR() {
        ocrRecognizeRequest = VNRecognizeTextRequest { (request, error) in
            guard let textObservations = request.results as? [VNRecognizedTextObservation] else { return }
            
            var text = ""
            for observation in textObservations {
                guard let topCandidate = observation.topCandidates(1).first else { return }
                
                text += topCandidate.string + "\n"
            }
            print("texttexttexttexttext", text)
            DispatchQueue.main.async {
                self.scannerView?.updateTextView(text)
            }
        }
        
        ocrRecognizeRequest.recognitionLevel = .accurate
        ocrRecognizeRequest.recognitionLanguages = ["en-US", "en-GB", "pl-PL"]
        ocrRecognizeRequest.usesLanguageCorrection = true
    }
    
    private func processImage(_ image: UIImage) {
        guard let cgImage = image.cgImage else { return }

        let requestHandler = VNImageRequestHandler(cgImage: cgImage, options: [:])
        do {
            try requestHandler.perform([self.ocrRecognizeRequest])
        } catch {
            print(error)
        }
    }
}
