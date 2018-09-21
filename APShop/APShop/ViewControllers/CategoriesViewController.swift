import UIKit

class CategoriesViewController: UITableViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var repository = Repository()
    var categories: [Category] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        repository.getCategories() { categories in
            self.categories = categories
            self.tableView.reloadData()
        }
    }
    
    func routeTo(_ category: Category) {
        if let productsVC = storyboard?.instantiateViewController(withIdentifier: "ProductsTableViewController") as? ProductsTableViewController {
            productsVC.category = category
            show(productsVC, sender: nil)
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryTableViewCell") as! CategoryTableViewCell
        let category = categories[indexPath.row]
        cell.configure(with: category)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let category = categories[indexPath.row]
        routeTo(category)
    }
    
}
