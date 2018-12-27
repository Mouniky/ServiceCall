//
//  ViewController.swift
//  ServiceCall
//
//  Created by Sai Sailesh Kumar Suri on 12/12/18.
//  Copyright © 2018 Sailesh. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    let urlString = "https://www.googleapis.com/books/v1/volumes?q=apple"
    var titleArray : [String] = []
    var saleInfo : [String] = []
    var countryInfo : [String] = []

    @IBOutlet weak var titleTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.initiateServiceCall()
    }
    
    func initiateServiceCall()  {
        
        
        let request = NSMutableURLRequest()
        request.url = URL.init(string: urlString)
        request.httpMethod = "GET"
        request.timeoutInterval = 60
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        // create session managere
        
        let sessionService = URLSession.shared
        
        let dataTask = sessionService.dataTask(with: request as URLRequest){(data,response,error) in
            
            
            if data != nil{
                let dict: [String : Any] = try! JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! [String : Any]
                //print(dict)
                
                let itemsArray = dict["items"] as! [Any]
                
                
                for dictionary in itemsArray{
                    let itemDictionary = dictionary as! [String : Any]
                    let volumeDictionary = itemDictionary["volumeInfo"] as![String :Any]
                    
                    let title = volumeDictionary["title"] as! String
                    
                    let salesInfoDict = itemDictionary["saleInfo"] as![String :Any]
                    
                    
                    let Country = salesInfoDict["country"] as! String
                    let SaleAbility = salesInfoDict["saleability"] as! String
                    
                    self.countryInfo.append(Country)
                    
                    self.saleInfo.append(SaleAbility)
                    
                    self.titleArray.append(title)
                }
                
                print(self.titleArray)
                print(self.countryInfo)
                print(self.saleInfo)
                

                }else{
                    print("Error fetching data from service")
                }
            DispatchQueue.main.async {
                self.titleTableView.reloadData()
            }

        }

        dataTask.resume()
        
    }
    
    //MARK:- tableview
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return titleArray.count
    }
    
    
    // Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
    // Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)
    
    @available(iOS 2.0, *)
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = UITableViewCell.init(style: .default, reuseIdentifier: "cell")
        cell.textLabel?.text = titleArray[indexPath.row]
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "second") as! SecondViewController
        viewController.saleInfo = saleInfo
        viewController.countryInfo = countryInfo
        self.navigationController?.pushViewController(viewController, animated: true)
        
    }
    
    
    

    



}

