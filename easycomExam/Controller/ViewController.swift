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
            //print(result)
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
        
        let apiData:AlbumModel
        apiData = data[indexPath.row]
        cell.apiImage.downloaded(from: apiData.thumbnailUrl, contentMode: .scaleToFill)
        cell.apiLabel.text = data[indexPath.row].title
        return cell
    }
    
}

extension UIImageView {
    func downloaded(from url: URL, contentMode mode: ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    func downloaded(from link: String, contentMode mode: ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}

