import UIKit

class ProductTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var priceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
    
    func configure(with model: Product) {
        self.nameLabel?.text = model.title
        self.descriptionLabel?.text = model.desc
        self.priceLabel?.text = model.price
        DispatchQueue.main.async {
            if let url = model.imageURL,
                let imageData = try? Data(contentsOf: url),
                let image = UIImage(data: imageData) {
                self.productImageView?.image = image
            }
        }
    }
}
