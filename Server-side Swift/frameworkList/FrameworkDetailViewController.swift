//
//  FrameworkDetailViewController.swift
//  Server-side Swift
//
//  Created by Jens Van Steen on 04/05/2018.
//  Copyright © 2018 Jens Van Steen. All rights reserved.
//

import UIKit
import WebKit

class FrameworkDetailViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource  {
    
    var framework: Framework?
        
    var formats = [String]()
    var databases = [String]()
    var clouds = [String]()
    var github : String?
    var numberOfFormats : Int = 0
    var numberOfDatabases : Int = 0
    var numberOfClouds : Int = 0
    var stars : Int = 0
    
    @IBOutlet weak var frameworkName: UILabel!
    @IBOutlet weak var frameworkImage: UIImageView!
    @IBOutlet weak var githubStars: UILabel!
    @IBOutlet weak var frameworkDetailView: UIView!
    @IBOutlet weak var frameworkTextView: UIView!
    @IBOutlet weak var frameworkText: UILabel!
    @IBOutlet weak var dataFormat: UICollectionView!
    @IBOutlet weak var dataBase: UICollectionView!
    @IBOutlet weak var cloudOptions: UICollectionView!
    
    
   var formatsList: Dictionary<String, card>?
   var cloudsList: Dictionary<String, card>?
    var databasesList: Dictionary<String, card>?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        setWebView()
        
        dataFormat.delegate = self;
        dataFormat.dataSource = self;
        dataBase.dataSource = self;
        dataBase.delegate = self;
        cloudOptions.delegate = self;
        cloudOptions.dataSource = self;
   
        formats = (framework?.format)!
        databases = (framework?.databases)!
        clouds = (framework?.cloud)!
        github = (framework?.github)!
        githubStars.text = "\(1000)"
        
        
        self.title = framework?.name
        frameworkName.text = framework?.name
        frameworkImage.image = UIImage(named: (framework?.picture)!)
        
        setTextAttributes()
        
        loadJSON()
        
        
    }
    

    override func viewDidAppear(_ animated: Bool) {
        githubStars.text = "\(stars)"
    }
    
    
    func setTextAttributes() {
        
        let stringValue = framework?.text
        
        let attributedString = NSMutableAttributedString(string: stringValue!)
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 6.4
        paragraphStyle.minimumLineHeight = 20
        
        attributedString.addAttribute(NSAttributedStringKey.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attributedString.length))
        
        frameworkText.attributedText = attributedString;
    }
    
    func loadJSON() {
        
        let path = Bundle.main.path(forResource: "frameworks", ofType: "json")
        let url: URL = URL(fileURLWithPath: path!)
        let githubURL: URL = URL(string: github!)!
        
        let loadingTask = URLSession.shared.dataTask(with: url, completionHandler: completeHandler)
        let loadingTask2 = URLSession.shared.dataTask(with: githubURL, completionHandler: completeHandlerGithub)
        loadingTask.resume()
        loadingTask2.resume()
        
    }
    

    
    
    func completeHandler(data:Data?, response:URLResponse?, error:Error?) {
        
//        let parsedData = String.init(data: data!, encoding: String.Encoding.utf8)
        
        
        let decoder = JSONDecoder()
        
        do {
            let frameworkList = try decoder.decode([String:FrameworkList].self, from: data!)
            formatsList = (frameworkList["frameworks"]?.formatInfo)!
            databasesList = (frameworkList["frameworks"]?.databaseInfo)!
            cloudsList = (frameworkList["frameworks"]?.cloudInfo)!
   
        } catch let error {
            print(error)
        }
        
        
    }
    
    func completeHandlerGithub(data:Data?, response:URLResponse?, error:Error?) {
        
//        let parsedData = String.init(data: data!, encoding: String.Encoding.utf8)
        
        
        let decoder = JSONDecoder()
        
        do {
            let githubStats = try decoder.decode(Github.self, from: data!)
            stars = githubStats.stargazers_count
        } catch let error {
            print(error)
        }
        
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView.tag == 1 {
            numberOfFormats = formats.count
            return numberOfFormats
        } else if collectionView.tag == 2 {
            numberOfDatabases = databases.count
            return numberOfDatabases
        } else if collectionView.tag == 3 {
            numberOfClouds = clouds.count
            return numberOfClouds
        } else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView.tag == 1 {
            githubStars.text = "\(stars)"
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "formatCell", for: indexPath) as! DataFormatCollectionViewCell
            let identifier = formatsList!["\(formats[indexPath.row])"]
            cell.formatLabel.text = identifier?.name
            cell.formatLabel.textColor = UIColor(red: (identifier?.textColor[0])!, green: (identifier?.textColor[1])!, blue: (identifier?.textColor[2])!, alpha: (identifier?.textColor[3])!)
            cell.formatImage.image = UIImage(named: (identifier?.picture)!)
            cell.backgroundcolor.backgroundColor = UIColor(red: (identifier?.color[0])!, green: (identifier?.color[1])!, blue: (identifier?.color[2])!, alpha: (identifier?.color[3])!)
            return cell
        } else if collectionView.tag == 2 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "dataCell", for: indexPath) as! DataBaseCollectionViewCell
            let identifier = databasesList!["\(databases[indexPath.row])"]
            cell.databaseLabel.text = identifier?.name
            cell.databaseLabel.textColor = UIColor(red: (identifier?.textColor[0])!, green: (identifier?.textColor[1])!, blue: (identifier?.textColor[2])!, alpha: (identifier?.textColor[3])!)
            cell.databaseImage.image = UIImage(named: (identifier?.picture)!)
            cell.backgroundcolor.backgroundColor = UIColor(red: (identifier?.color[0])!, green: (identifier?.color[1])!, blue: (identifier?.color[2])!, alpha: (identifier?.color[3])!)
            return cell
        } else if collectionView.tag == 3 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cloudCell", for: indexPath) as! CloudCollectionViewCell
            let identifier = cloudsList!["\(clouds[indexPath.row])"]
            cell.cloudLabel.text = identifier?.name
            cell.cloudLabel.textColor = UIColor(red: (identifier?.textColor[0])!, green: (identifier?.textColor[1])!, blue: (identifier?.textColor[2])!, alpha: (identifier?.textColor[3])!)
            cell.cloudImage.image = UIImage(named: (identifier?.picture)!)
            cell.backgroundcolor.backgroundColor = UIColor(red: (identifier?.color[0])!, green: (identifier?.color[1])!, blue: (identifier?.color[2])!, alpha: (identifier?.color[3])!)
            return cell
        } else {
            let cell = UICollectionViewCell()
            return cell
        }
   
    }
    

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        let toNav = segue.destination as! UINavigationController
        let toVC = toNav.viewControllers.first as! WebViewController
        var selectedUrl : String?
        
        if segue.identifier == "forDataFormat" {
            
            if let cell = sender as? DataFormatCollectionViewCell,
            let indexPath = self.dataFormat.indexPath(for: cell) {
                
                let identifier = formatsList!["\(formats[indexPath.row])"]
                selectedUrl = identifier?.url
            }
            
        } else if segue.identifier == "forDatabase" {
            
            if let cell = sender as? DataBaseCollectionViewCell,
                let indexPath = self.dataBase.indexPath(for: cell) {
                let identifier = databasesList!["\(databases[indexPath.row])"]
                selectedUrl = identifier?.url
            }
        } else if segue.identifier == "forCloud" {
            
                if let cell = sender as? CloudCollectionViewCell,
                    let indexPath = self.cloudOptions.indexPath(for: cell) {
                    let identifier = cloudsList!["\(clouds[indexPath.row])"]
                    selectedUrl = identifier?.url
        }
            
        }
        
        
        toVC.urlString = selectedUrl!
        
        
    }

    
    
            override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
  
    
    /*    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

