//
//  ScoreViewController.swift
//  Server-side Swift
//
//  Created by Jens Van Steen on 11/05/2018.
//  Copyright © 2018 Jens Van Steen. All rights reserved.
//

import UIKit

class ScoreViewController: UIViewController {
    
    var numberOfQuestions = Int()
    var correctAnswered = Int()
    
    @IBOutlet weak var score: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        score.text = "\(correctAnswered)/\(numberOfQuestions)"

        // Do any additional setup after loading the view.
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
