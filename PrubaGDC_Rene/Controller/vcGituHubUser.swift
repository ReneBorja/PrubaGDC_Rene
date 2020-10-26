//
//  vcGituHubUser.swift
//  PrubaGDC_Rene
//
//  Created by Prueba IOS on 10/24/20.
//

import UIKit
import SDWebImage


@objc class vcGituHubUser: UIViewController, UISearchResultsUpdating {
    


    @IBOutlet weak var tvUsers: UITableView!
    
    var userArray :NSArray = []
    var urlRepo = [String]()
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
   getUser()

       
    }
    func configUI(){
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    func getUser(){
        
        let url = URL(string: "https://api.github.com/users")
        guard let requestUrl = url else { fatalError() }
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "GET"
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            if let error = error {
                print("Error took place \(error)")
                return
            }
            
            if let response = response as? HTTPURLResponse {
                print("Response HTTP Status code: \(response.statusCode)")
            }
            
           if let data = data, let dataString = String(data: data, encoding: .utf8) {
                do {
                    self.userArray = try JSONSerialization.jsonObject(with: data , options: JSONSerialization.ReadingOptions.mutableContainers) as! NSArray
                    print("Parse success")
                } catch {
                    print("Parse error")
                    print("Error: \(error)")
                }
            print("Response data string:\n \(self.userArray.object(at: 0))")
            DispatchQueue.main.async {
                self.tvUsers.reloadData()
                       }
            }
          
        }
        task.resume()
        
        

             
        
    }
    
   
    func updateSearchResults(for searchController: UISearchController) {
        filteredTableData.removeAll(keepingCapacity: false)

        let searchPredicate = NSPredicate(format: "SELF CONTAINS[c] %@", searchController.searchBar.text!)
        let array = (userArray as NSArray).filtered(using: searchPredicate)
      //  filteredTableData = array as! [String]

        self.tvUsers.reloadData()
    }
  
    //--------------------------------------------------------------
    
      

}// TABLEVIEW DELEGATES METODS
class cellCustom: UITableViewCell {
    
    @IBOutlet weak var imgUser: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblLogin: UILabel!
    @IBOutlet weak var lblType: UILabel!
}
extension vcGituHubUser: UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("CLICK")
        let sharedManager = MyManager()
        let dicUser: NSMutableDictionary = userArray[indexPath.row] as! NSMutableDictionary
        let repoUrl = dicUser["repos_url"] as? String
        sharedManager.urlRepos = repoUrl!
        print(repoUrl!)
        let vcDetalle = vcDetalleUser.init()
        vcDetalle.viewDidLoad()
        vcDetalle.urlRepos = repoUrl as NSString?
        vcDetalle.getRequest(repoUrl!)
        performSegue(withIdentifier: "detailSegue", sender: self)
      }
    
    func tableView(_ tableView: UITableView,
            numberOfRowsInSection section: Int) -> Int {

    if  (resultSearchController.isActive) {
    return filteredTableData.count
    } else {
        return self.userArray.count
    }

    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cellCustom", for: indexPath) as! cellCustom
        print("COUMNT:.... \(self.userArray.count)")
    cell.imgUser.layer.cornerRadius  = cell.imgUser.frame.size.width * 0.50
    if (resultSearchController.isActive) {
      cell.lblName?.text = filteredTableData[indexPath.row]

    return cell
    }
    else {
        let dicUser: NSMutableDictionary = userArray[indexPath.row] as! NSMutableDictionary
        cell.lblName?.text = dicUser["login"] as? String
        cell.lblLogin?.text = dicUser["login"] as? String
        cell.lblType?.text = dicUser["type"] as? String
        cell.imgUser.sd_setImage(with: URL(string:dicUser["avatar_url"] as! String), placeholderImage: UIImage(named: ""))
        print(userArray[indexPath.row])
        return cell
    }
   }

}

