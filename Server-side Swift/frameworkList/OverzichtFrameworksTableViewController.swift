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
        
        let parsedData = String.init(data: data!, encoding: String.Encoding.utf8)
        
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
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
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
