//
//  FrameworkDetailViewController.swift
//  Server-side Swift
//
//  Created by Jens Van Steen on 04/05/2018.
//  Copyright © 2018 Jens Van Steen. All rights reserved.
//

import UIKit

class FrameworkDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
  
     var framework: Framework?
    
    var formats = [String]()
    var databases = [String]()
    var clouds = [String]()
    var numberOfFormats : Int = 0
    var numberOfDatabases : Int = 0
    var numberOfClouds : Int = 0
    
    @IBOutlet weak var frameworkName: UILabel!
    @IBOutlet weak var frameworkImage: UIImageView!
    @IBOutlet weak var githubStars: UILabel!
    @IBOutlet weak var frameworkDetailView: UIView!
    @IBOutlet weak var frameworkTextView: UIView!
    @IBOutlet weak var frameworkText: UILabel!
    @IBOutlet weak var statsTableView: UITableView!
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        formats = (framework?.format)!
        databases = (framework?.databases)!
        clouds = (framework?.cloud)!
        statsTableView.delegate = self
        statsTableView.dataSource = self

        
        
        self.title = framework?.name
        frameworkName.text = framework?.name
        githubStars.text = "\(framework?.stars! ?? 0)"
        frameworkImage.image = UIImage(named: (framework?.picture)!)
        frameworkText.text = framework?.text
        
 
        // Do any additional setup after loading the view.
    }
    


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 3
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        if section == 0 {
            label.text = "Data format support"
        } else if section == 1 {
            label.text = "Databases"
        } else if section == 2 {
            label.text = "Supported cloud services"
        }
        label.font = UIFont.systemFont(ofSize: 24, weight: UIFont.Weight.semibold)
        label.textColor = UIColor.black
        return label
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none;
        let formats = framework?.format
        let databases = framework?.databases
        let cloud = framework?.cloud
        tableView.isScrollEnabled = false;
        if section == 0 {
            numberOfFormats = (formats?.count)!
            return numberOfFormats
        } else if section == 1 {
            numberOfDatabases = (databases?.count)!
            return numberOfDatabases
        } else if section == 2 {
            numberOfClouds = (cloud?.count)!
            return numberOfClouds
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ListItemTableViewCell
        cell.selectionStyle = UITableViewCellSelectionStyle.none;
        
        if indexPath.section == 0 {
            cell.listItem.text = formats[indexPath.row]
        } else if indexPath.section == 1 {
            cell.listItem.text = databases[indexPath.row]
        } else if indexPath.section == 2 {
            cell.listItem.text = clouds[indexPath.row]
        }
        
        return cell
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

