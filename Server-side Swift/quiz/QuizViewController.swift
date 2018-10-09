//
//  QuizViewController.swift
//  Server-side Swift
//
//  Created by Jens Van Steen on 11/05/2018.
//  Copyright © 2018 Jens Van Steen. All rights reserved.
//

import UIKit


var quizEnteries: [QuizEntries] = []


var currentQuestion = 0
var rightAnswerPlacement:UInt32 = 0
var yourscore = 0
var numberOfQuestions = 0
var answerdQuestions = 0
var rightAnswer = 0

class QuizViewController: UIViewController {

    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var quizImage: UIImageView!
    
   
    @IBAction func answer(_ sender: UIButton) {
        
        if (sender.tag == Int(rightAnswerPlacement)) {
            yourscore += 1
        } else {
        }
        
        answerdQuestions += 1
        
        if (currentQuestion != quizEnteries.count) {
            newQuestion()
        } else
        {
           performSegue(withIdentifier: "score", sender: self)
        }
    }
    
    
    func newQuestion() {
        
        quizImage.image = UIImage(named: (quizEnteries[currentQuestion].picture))
        
        questionLabel.text = quizEnteries[currentQuestion].question
        
        scoreLabel.text = "Your score: \(yourscore)/\(answerdQuestions)"
        
        //Right answer is always in the first place of the array 
        rightAnswerPlacement = arc4random_uniform(3)+1
        
        
        var button: UIButton = UIButton()
        
        var x = 1
        
        for i in 1...3  {
            
            button = view.viewWithTag(i) as! UIButton
            
            if (i == Int(rightAnswerPlacement)) {
                button.setTitle(quizEnteries[currentQuestion].answers[0], for: .normal)
            } else {
                button.setTitle(quizEnteries[currentQuestion].answers[x], for: .normal)
                x = 2
            }
           
        }
        
         currentQuestion += 1
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        loadJSON()

        
        // Do any additional setup after loading the view.
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
            let quizList = try decoder.decode([String:Quizlist].self, from: data!)
            quizEnteries = (quizList["frameworks"]?.quizListing)!
            
        } catch let error {
            print(error)
        }
        
        
    }

    
    override func viewDidAppear(_ animated: Bool) {
        numberOfQuestions = quizEnteries.count
        newQuestion()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        currentQuestion = 0
        rightAnswerPlacement = 0
        yourscore = 0
        numberOfQuestions = 0
        answerdQuestions = 0
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        let toVC = segue.destination as! ScoreViewController
        toVC.numberOfQuestions = numberOfQuestions
        toVC.correctAnswered = yourscore
        
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
