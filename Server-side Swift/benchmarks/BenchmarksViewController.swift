//
//  BenchmarksViewController.swift
//  Server-side Swift
//
//  Created by Jens Van Steen on 05/05/2018.
//  Copyright © 2018 Jens Van Steen. All rights reserved.
//

import UIKit

class BenchmarksViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var barChart: BarChart!
    @IBOutlet weak var latencyChart: BarChart!
    @IBOutlet weak var scrollview: UIScrollView!
    @IBOutlet weak var benchmarkInfo: UILabel!
    @IBOutlet weak var segmentedController: UISegmentedControl!
    @IBOutlet weak var requestsecondsLabel: UILabel!
    @IBOutlet weak var requestsecondsSpecs: UILabel!
    @IBOutlet weak var latencyLabel: UILabel!
    @IBOutlet weak var latencySpecs: UILabel!
    @IBOutlet weak var hardwareCollection: UICollectionView!
    
    
    let hardwareConfiguration = [["title": "Server: Mac Mini",
                                  "cpu": "2x2,5GHz",
                                  "ram": "4GB DDR3",
                                  "gpu": "1500MB Intel HD",
                                  "image": "mac-mini",
                                  "url": "https://everymac.com/systems/apple/mac_mini/specs/mac-mini-core-i5-2.5-late-2012-specs.html"],
                                 ["title": "Development: MacBook Pro",
                                  "cpu": "4x2.9GHz",
                                  "ram": "16Gb LPDRR3",
                                  "gpu": "4GB Radeon 460",
                                  "image": "macbook-pro",
                                  "url": "https://everymac.com/systems/apple/macbook_pro/specs/macbook-pro-core-i7-2.9-15-late-2016-retina-display-touch-bar-specs.html"]]
    
    
    var benchmarks: [Benchmark] = []
        
    var blogRequests = [BarEntry]()
    var blogLatency = [BarEntry]()
    var jsonRequests = [BarEntry]()
    var jsonLatency = [BarEntry]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hardwareCollection.delegate = self
        hardwareCollection.dataSource = self
        
         loadJSON()
        
        var contentRect = CGRect.zero
        
        for view in scrollview.subviews {
            contentRect = contentRect.union(view.frame)
        }
        scrollview.contentSize = contentRect.size
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
         setBLogContent()
    }
    
    func loadJSON() {
        
        let path = Bundle.main.path(forResource: "frameworks", ofType: "json")
        let url: URL = URL(fileURLWithPath: path!)
        
        let loadingTask = URLSession.shared.dataTask(with: url, completionHandler: completeHandler)
        loadingTask.resume()
        
    }
    
    func setTextAttributes(textToSet: String) {
        
        let stringValue = textToSet
        
        let attributedString = NSMutableAttributedString(string: stringValue)
        
        // *** Create instance of `NSMutableParagraphStyle`
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 4.4
        paragraphStyle.minimumLineHeight = 20
        
        // *** Apply attribute to string ***
        attributedString.addAttribute(NSAttributedStringKey.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attributedString.length))
        
        // *** Set Attributed String to your label ***
        benchmarkInfo.attributedText = attributedString;
        
    }
    
    
    func completeHandler(data:Data?, response:URLResponse?, error:Error?) {
        
//        let parsedData = String.init(data: data!, encoding: String.Encoding.utf8)
        
        
        let decoder = JSONDecoder()
        
        do {
            let benchmarkList = try decoder.decode([String:BenchmarkList].self, from: data!)
            benchmarks = (benchmarkList["frameworks"]?.benchmarkListing)!
            blogRequests = generateDataEntries(entry: 0)
            blogLatency = generateDataEntries(entry: 1)
            jsonRequests = generateDataEntries(entry: 2)
            jsonLatency = generateDataEntries(entry: 3)
        } catch let error {
            print(error)
        }
        
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return hardwareConfiguration.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "sectionCell", for: indexPath) as! SectionCollectionViewCell
        let section = hardwareConfiguration[indexPath.row]
        cell.title.text = section["title"]
        cell.cpu.text = section["cpu"]
        cell.ram.text = section["ram"]
        cell.gpu.text = section["gpu"]
        cell.image.image = UIImage(named: section["image"]!)
        return cell
    }
    
    
    func generateDataEntries(entry: Int) -> [BarEntry] {
        let colors = ["Perfect":#colorLiteral(red: 0.9921568627, green: 0.4823529412, blue: 0.1647058824, alpha: 1),"Vapor": #colorLiteral(red: 0.7098039216, green: 0.7019607843, blue: 0.8078431373, alpha: 1),"Node.js": #colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1),"Kitura": #colorLiteral(red: 0.02745098039, green: 0.09803921569, blue: 0.2862745098, alpha: 1),"Zewo": #colorLiteral(red: 0.2196078431, green: 0.1921568627, blue: 0.2549019608, alpha: 1)]
        let benchmarkToList = benchmarks[entry]
        var count = -1
        var result: [BarEntry] = []
        for i in benchmarkToList.results {
            count += 1;
            var valueToDisplay: String
            let value = benchmarkToList.results[count].value
            if entry == 1 || entry == 3 {
                valueToDisplay = "\(value)ms"
            } else {
                valueToDisplay = "\(value)"
            }
            let height: Float = Float(value) / benchmarkToList.scale
            result.append(BarEntry(color: colors[benchmarkToList.results[count].name]!, height: height, textValue: valueToDisplay, title: benchmarkToList.results[count].name))
        }
        return result
    }
    
    func setBLogContent() {
        
        barChart.dataEntries = blogRequests
        latencyChart.dataEntries = blogLatency

        
        requestsecondsLabel.text = "Blog Benchmarks - Request/Seconds"
        latencyLabel.text = "Blog Benchmarks - Average Latency"
        
        let textToGive = "The first benchmark is the /blog route in each, which is a page that returns 5 random images and fake blog posts for each request."
        
        setTextAttributes(textToSet: textToGive)
    }
    
    func setJsonContent() {
        
        barChart.dataEntries = jsonRequests
        latencyChart.dataEntries = jsonLatency
        
        
        requestsecondsLabel.text = "JSON Benchmarks - Request/Seconds"
        latencyLabel.text = "JSON Benchmarks - Average Latency"
        
        let textToGive = "The second benchmark is the /json route in each framework, which is a page that returns a JSON dictionary of ten random numbers."
        
        setTextAttributes(textToSet: textToGive)
    }
    
    @IBAction func SegmentedValueChange(_ sender: UISegmentedControl) {
        if segmentedController.selectedSegmentIndex == 0 {
            setBLogContent()
        }
        
        if segmentedController.selectedSegmentIndex == 1 {
            setJsonContent()
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        let toNav = segue.destination as! UINavigationController
        let toVC = toNav.viewControllers.first as! WebViewController
        var selectedUrl : String?
        
        if segue.identifier == "forHardware" {
            
            if let cell = sender as? SectionCollectionViewCell,
                let indexPath = self.hardwareCollection.indexPath(for: cell) {
                
                let identifier = hardwareConfiguration[indexPath.row]
                selectedUrl = identifier["url"]
            }
            
        }
        
        toVC.urlString = selectedUrl!
        
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
