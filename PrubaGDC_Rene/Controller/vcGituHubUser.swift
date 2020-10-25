//
//  vcGituHubUser.swift
//  PrubaGDC_Rene
//
//  Created by Prueba IOS on 10/24/20.
//

import UIKit

class vcGituHubUser: UIViewController, UISearchResultsUpdating {
    


    @IBOutlet weak var tvUsers: UITableView!
    
    let tableData = ["One","Two","Three","Twenty-One"]
    var filteredTableData = [String]()
    var resultSearchController = UISearchController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    configUI()
    resultSearchController = ({
    let controller = UISearchController(searchResultsController: nil)
    controller.searchResultsUpdater = self
    controller.obscuresBackgroundDuringPresentation = false
    controller.searchBar.sizeToFit()

    tvUsers.tableHeaderView = controller.searchBar

    return controller
    })()

    tvUsers.reloadData()
    }
    func configUI(){
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
   
    func updateSearchResults(for searchController: UISearchController) {
        filteredTableData.removeAll(keepingCapacity: false)

        let searchPredicate = NSPredicate(format: "SELF CONTAINS[c] %@", searchController.searchBar.text!)
        let array = (tableData as NSArray).filtered(using: searchPredicate)
        filteredTableData = array as! [String]

        self.tvUsers.reloadData()
    }

}
// TABLEVIEW DELEGATES METODS
class cellCustom: UITableViewCell {
    
    @IBOutlet weak var imgUser: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblLogin: UILabel!
    @IBOutlet weak var lblType: UILabel!
}
extension vcGituHubUser: UITableViewDataSource {
    func tableView(_ tableView: UITableView,
            numberOfRowsInSection section: Int) -> Int {

    if  (resultSearchController.isActive) {
    return filteredTableData.count
    } else {
    return tableData.count
    }

    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cellCustom", for: indexPath) as! cellCustom
    cell.imgUser.layer.cornerRadius  = cell.imgUser.frame.size.width * 0.50
    if (resultSearchController.isActive) {
    cell.lblName?.text = filteredTableData[indexPath.row]

    return cell
    }
    else {
    cell.lblName?.text = tableData[indexPath.row]
    print(tableData[indexPath.row])
    return cell
    }
   }
   
    
    func tableView(_ tableView: UITableView!, didSelectRowAt indexPath: NSIndexPath!) {
            
            print("You selected cell #\(indexPath.row)!")
            
        performSegue(withIdentifier: "detailSegue", sender: nil)

            
        }
}

