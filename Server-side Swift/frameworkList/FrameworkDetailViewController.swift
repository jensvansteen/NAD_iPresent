//
//  FrameworkDetailViewController.swift
//  Server-side Swift
//
//  Created by Jens Van Steen on 04/05/2018.
//  Copyright © 2018 Jens Van Steen. All rights reserved.
//

import UIKit

class FrameworkDetailViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource  {
    
    
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
    @IBOutlet weak var dataFormat: UICollectionView!
    @IBOutlet weak var dataBase: UICollectionView!
    @IBOutlet weak var cloudOptions: UICollectionView!
    
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataFormat.delegate = self;
        dataFormat.dataSource = self;
        dataBase.dataSource = self;
        dataBase.delegate = self;
        cloudOptions.delegate = self;
        cloudOptions.dataSource = self;
        
        formats = (framework?.format)!
        databases = (framework?.databases)!
        clouds = (framework?.cloud)!
        

        
        
        self.title = framework?.name
        frameworkName.text = framework?.name
        githubStars.text = "\(framework?.stars! ?? 0)"
        frameworkImage.image = UIImage(named: (framework?.picture)!)
        frameworkText.text = framework?.text
        
 
        // Do any additional setup after loading the view.
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
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "formatCell", for: indexPath) as! DataFormatCollectionViewCell
            cell.formatLabel.text = formats[indexPath.row]
            return cell
        } else if collectionView.tag == 2 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "dataCell", for: indexPath) as! DataBaseCollectionViewCell
            cell.databaseLabel.text = databases[indexPath.row]
            return cell
        } else if collectionView.tag == 3 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cloudCell", for: indexPath) as! CloudCollectionViewCell
            cell.cloudLabel.text = clouds[indexPath.row]
            return cell
        } else {
            let cell = UICollectionViewCell()
            return cell
        }
   
    }
    


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

