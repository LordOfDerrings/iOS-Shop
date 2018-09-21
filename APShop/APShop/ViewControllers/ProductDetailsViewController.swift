import UIKit
import WebKit

class ProductDetailsViewController: UIViewController {

    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    var product: Product!
    
    func configure(with model: Product) {
        loadViewIfNeeded()
        navigationItem.title = model.title
        priceLabel?.text = model.price
        descriptionTextView?.text = model.desc
        descriptionTextView?.scrollRangeToVisible(NSRange(location: 0, length: 0))
        if let url = model.imageURL {
            webView?.load(URLRequest(url: url))
        }
    }
    
}
