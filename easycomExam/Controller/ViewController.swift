//
//  ViewController.swift
//  easycomExam
//
//  Created by Jao Garcia on 1/7/23.
//

import UIKit

class ViewController: UIViewController {

    var data = [AlbumModel]()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        fetchingAPIData(URL: "https://jsonplaceholder.typicode.com/photos") { result in
            print(result)
            self.data = result
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    func fetchingAPIData(URL url:String, completion: @escaping ([AlbumModel]) -> Void){
    // 1. Create URL
        let url = URL(string: url)
    // 2. Create Session
        let session = URLSession.shared
    // 3. Create Task
        let dataTask = session.dataTask(with: url!) { data, response, error in
            do {
                let parsingData = try JSONDecoder().decode([AlbumModel].self, from: data!)
                completion(parsingData)
            } catch{
                print(error)
            }
        }
        dataTask.resume()
    }
}

extension ViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomTableViewCell
        cell.apiLabel.text = data[indexPath.row].title
        return cell
    }
    
    
}
