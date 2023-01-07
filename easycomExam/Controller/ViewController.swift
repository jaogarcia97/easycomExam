//
//  ViewController.swift
//  easycomExam
//
//  Created by Jao Garcia on 1/7/23.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        fetchingAPIData(URL: "https://jsonplaceholder.typicode.com/photos") { result in
            print(result)
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

