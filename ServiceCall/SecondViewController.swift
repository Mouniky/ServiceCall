//
//  SecondViewController.swift
//  ServiceCall
//
//  Created by Mounik Yelakanti on 12/12/18.
//  Copyright © 2018 Sailesh. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var saleInfo : [String] = []
    var countryInfo: [String] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        // Do any additional setup after loading the view.
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return saleInfo.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0{
            
            let cell = UITableViewCell.init(style: .default, reuseIdentifier: "cell")
            cell.textLabel?.text = saleInfo[indexPath.row]
            
            return cell

        }else{
            let cell = UITableViewCell.init(style: .default, reuseIdentifier: "cell")
            cell.textLabel?.text = countryInfo[indexPath.row]
            return cell
        }
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
