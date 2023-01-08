//
//  DetailViewController.swift
//  easycomExam
//
//  Created by Jao Garcia on 1/8/23.
//

import UIKit

class DetailViewController: UIViewController {

    
    @IBOutlet weak var detApiImage: UIImageView!
    @IBOutlet weak var detApiLabel: UILabel!
    
    var fullImageURL:String = "https://via.placeholder.com/600/92c952"
    var titleValue:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        detApiLabel.text = titleValue
        detApiImage.downloaded(from: fullImageURL, contentMode: .scaleToFill)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
