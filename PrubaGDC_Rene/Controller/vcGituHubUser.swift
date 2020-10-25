//
//  vcGituHubUser.swift
//  PrubaGDC_Rene
//
//  Created by Prueba IOS on 10/24/20.
//

import UIKit

class vcGituHubUser: UIViewController, UISearchResultsUpdating {
    


    @IBOutlet weak var tvUsers: UITableView!
    
    let tableData = ["One","e","Three","Twenty-One"]
    var Login  = [String]()
    var Id  = [Int]()
    var Avatar  = [String]()
    var type  = [String]()
    var Site_Admin  = [String]()
    var repos_url  = [String]()
    var userArray :NSArray = []
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

        struct User {
            var avatar_url: String
            var events_url: String
            var followers_url: String
            var following_url: String
            var gists_url: String
            var gravatar_id: String
            var html_url: String
            var id: Int
            var login: String
            var node_id: String
            var organizations_url: String
            var received_events_url: String
            var repos_url: String
            var site_admin: String
            var starred_url: String
            var subscriptions_url: String
            var type: String
            var url: String

        }
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
             //   let object = try! JSONSerialization.jsonObject(with: data, options: [])
                do {
                    self.userArray = try JSONSerialization.jsonObject(with: data , options: JSONSerialization.ReadingOptions.mutableContainers) as! NSArray

                    print("Parse success")
                } catch {
                    print("Parse error")
                    print("Error: \(error)")
                }
                print("Response data string:\n \(self.userArray)")
//                if let array = object as? [[String: Any]] {
//                    //If you want array of task id you can try like
//                    let taskArray = array.flatMap { $0[] as? String }
//                    print(taskArray)
//                }
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
        filteredTableData = array as! [String]

        self.tvUsers.reloadData()
    }
  
    //--------------------------------------------------------------
    
      }

// TABLEVIEW DELEGATES METODS
class cellCustom: UITableViewCell {
    
    @IBOutlet weak var imgUser: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblLogin: UILabel!
    @IBOutlet weak var lblType: UILabel!
}
extension vcGituHubUser: UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("CLICK")
        
        print("You selected cell #\(indexPath.row)!")
        performSegue(withIdentifier: "detailSegue", sender: nil)
       
      }
    
    func tableView(_ tableView: UITableView,
            numberOfRowsInSection section: Int) -> Int {

    if  (resultSearchController.isActive) {
    return filteredTableData.count
    } else {
    return userArray.count
    }

    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cellCustom", for: indexPath) as! cellCustom
        print("COUMNT:.... \(self.userArray.count)")

    cell.imgUser.layer.cornerRadius  = cell.imgUser.frame.size.width * 0.50
    if (resultSearchController.isActive) {
  //  cell.lblName?.text = filteredTableData[indexPath.row]

    return cell
    }
    else {
    cell.lblName?.text = "HOLA"
   print(userArray[indexPath.row])
        cell.lblName?.text = userArray[indexPath.row] as? String
    return cell
    }
   }

}

