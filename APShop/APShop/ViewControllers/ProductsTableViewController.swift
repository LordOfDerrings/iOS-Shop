import UIKit

class ProductsTableViewController: UITableViewController {

    let repository = Repository()
    var products: [Product] = []
    var category: Category! {
        didSet {
            navigationItem.title = category?.name
            getProducts()
        }
    }
    
    func getProducts() {
        guard let category = category else {
            return
        }
        repository.getProducts(of: category, { products in
            self.products = products
            self.tableView.reloadData()
        })
    }
    
    func route(to product: Product) {
        if let productDetailsVC = storyboard?.instantiateViewController(withIdentifier: "ProductDetailsViewController") as? ProductDetailsViewController {
            productDetailsVC.configure(with: product)
            show(productDetailsVC, sender: nil)
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductTableViewCell") as! ProductTableViewCell
        let product = products[indexPath.row]
        cell.configure(with: product)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let product = products[indexPath.row]
        route(to: product)
    }

}
