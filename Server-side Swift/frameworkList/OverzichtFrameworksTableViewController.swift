//
//  OverzichtFrameworksTableViewController.swift
//  Server-side Swift
//
//  Created by Jens Van Steen on 02/05/2018.
//  Copyright © 2018 Jens Van Steen. All rights reserved.
//

import UIKit

class OverzichtFrameworksTableViewController: UITableViewController {
    
    var frameWorks: [Framework] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

       loadJSON()
    }
    
    
    func loadJSON() {
        
        let path = Bundle.main.path(forResource: "frameworks", ofType: "json")
        let url: URL = URL(fileURLWithPath: path!)
        
        let loadingTask = URLSession.shared.dataTask(with: url, completionHandler: completeHandler)
        loadingTask.resume()
        
    }
    
    func completeHandler(data:Data?, response:URLResponse?, error:Error?) {
        
//        let parsedData = String.init(data: data!, encoding: String.Encoding.utf8)
        
        let decoder = JSONDecoder()
        
        do {
            let frameworkList = try decoder.decode([String:FrameworkList].self, from: data!)
            frameWorks = (frameworkList["frameworks"]?.frameworkInfo)!
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        } catch let error {
            print(error)
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return frameWorks.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "frameWorkCell", for: indexPath) as! CustomTableViewCell
        
        cell.frameworkLabel.text = frameWorks[indexPath.row].name
        cell.frameworkImage.image = UIImage(named: frameWorks[indexPath.row].picture)
        
      
        return cell
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        let detailVC = segue.destination as! FrameworkDetailViewController
        
        let selectedIndexPath = tableView.indexPathForSelectedRow
        let selectedFramework = frameWorks[(selectedIndexPath?.row)!]
        
        
        detailVC.framework = selectedFramework
        
        
    }
 

}
