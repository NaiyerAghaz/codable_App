//
//  ViewController.swift
//  CodableApiCall
//
//  Created by Naiyer Aghaz on 02/03/20.
//  Copyright © 2020 Naiyer Aghaz. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var nodeIdLbl: UILabel!
    @IBOutlet weak var lblName: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       getUserData()
    }
    func getUserData(){
        let url = URL(string: "https://api.github.com/users/shashikant86")
        var urlReques = URLRequest(url: url!)
        urlReques.httpMethod = "GET"
        let urlSession = URLSession.shared
        urlSession.dataTask(with: urlReques){(data, response, error) in
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let userData = try decoder.decode(Person.self, from: data)
                    DispatchQueue.main.async {
                        self.lblName.text = userData.name
                        self.nodeIdLbl.text = userData.node_id
                    }
                    
                }
                catch let error {
                    print(error.localizedDescription)
                }
            }
        }.resume()
        
    }
}
struct Person: Codable {
    var name: String?
    var node_id: String?
    
}
