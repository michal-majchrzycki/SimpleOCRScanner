import UIKit

protocol ScannerViewDelegate: AnyObject {
    func didTapScanButton()
}

class ScannerView: UIView {
    weak var delegate: ScannerViewDelegate?
    
    private enum Constants {
        static let topBottomMargin: CGFloat = 30.0
        static let leftRightMargin: CGFloat = 20.0
        static let photoImageHeight: CGFloat = 250.0
        static let textViewHeight: CGFloat = 150.0
        static let scanButtonHeight: CGFloat = 50.0
        static let borderWidth: CGFloat = 2.0
        static let cornerRadius: CGFloat = 10.0
    }
    
    private var photoImage: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .systemGray
        imageView.layer.borderColor = UIColor.systemBlue.cgColor
        imageView.layer.borderWidth = Constants.borderWidth
        imageView.layer.cornerRadius = Constants.cornerRadius
        return imageView
    }()
    
    private var textView: UITextView = {
        let textView = UITextView()
        textView.layer.borderColor = UIColor.systemBlue.cgColor
        textView.layer.borderWidth = Constants.borderWidth
        textView.layer.cornerRadius = Constants.cornerRadius
        textView.backgroundColor = .systemBackground
        textView.textColor = .label
        textView.isEditable = false
        return textView
    }()
    
    private var scanButton: UIButton = {
        let button = UIButton()
        button.setTitle("Scan", for: .normal)
        button.backgroundColor = .systemBlue
        button.addTarget(self, action: #selector(onScannButton), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateImage(_ image: UIImage) {
        photoImage.image = image
    }
    
    func updateTextView(_ text: String) {
        textView.text = text
    }
}


//MARK: - UI Setup
extension ScannerView {
    private func setupUI() {
        [photoImage, textView, scanButton].forEach { view in
            addSubview(view)
            view.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            photoImage.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: Constants.topBottomMargin),
            photoImage.leftAnchor.constraint(equalTo: leftAnchor, constant: Constants.leftRightMargin),
            photoImage.rightAnchor.constraint(equalTo: rightAnchor, constant: -Constants.leftRightMargin),
            photoImage.heightAnchor.constraint(equalToConstant: Constants.photoImageHeight),

            textView.topAnchor.constraint(equalTo: photoImage.bottomAnchor, constant: Constants.topBottomMargin),
            textView.leftAnchor.constraint(equalTo: leftAnchor, constant: Constants.leftRightMargin),
            textView.rightAnchor.constraint(equalTo: rightAnchor, constant: -Constants.leftRightMargin),
            textView.heightAnchor.constraint(equalToConstant: Constants.textViewHeight),
            
            scanButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -Constants.topBottomMargin),
            scanButton.leftAnchor.constraint(equalTo: leftAnchor, constant: Constants.leftRightMargin),
            scanButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -Constants.leftRightMargin),
            scanButton.heightAnchor.constraint(equalToConstant: Constants.scanButtonHeight),
        ])
    }
    
    @objc private func onScannButton() {
        delegate?.didTapScanButton()
    }
}
