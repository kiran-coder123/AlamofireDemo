//
//  ViewController.swift
//  AlamofireDemo
//
//  Created by Satinder Panesar on 3/19/21.
//

import UIKit
import Alamofire

class ViewController: UIViewController {
    @IBOutlet weak var tblview: UITableView!
     override func viewDidLoad() {
        super.viewDidLoad()
         callAPI()
    }
    var responseArr = [DataModel]()
    func callAPI()
    {
        AF.request(URL(string: "https://jsonplaceholder.typicode.com/posts")!, method: .get, parameters: nil, headers: nil).responseJSON { (response) in
            if let responseData = response.data{
                do{
                    let decodejson = JSONDecoder()
                    decodejson.keyDecodingStrategy = .convertFromSnakeCase
                    
                    self.responseArr = try decodejson.decode([DataModel].self, from: responseData)
                    self.tblview.reloadData()
                  }catch{
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    
     
}
extension ViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return responseArr.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblview.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = String(responseArr[indexPath.row].id ?? 0)
        cell.detailTextLabel?.text = responseArr[indexPath.row].title
        return cell
    }
}
