//
//  DetailViewController.swift
//  stockExchange
//
//  Created by Mateusz Matejczyk on 23.11.2017.
//  Copyright © 2017 Mateusz Matejczyk. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    var index = Int()
    var stockInformation = stocksStruct()
    var backgroundImageView = UIImageView()
    
    // backgroudView
    @IBOutlet weak var backgroundView: backgroundView!
    
    
    // detailView
    @IBOutlet var detailView: UIView!
    
    // topView
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var topViewCostLabel: UILabel!
    @IBOutlet weak var topViewNameLabel: UILabel!
    @IBOutlet weak var topViewLogoImage: UIImageView!
    
    @IBOutlet weak var backButton: UIButton!
    
    // graphView
    @IBOutlet weak var graphView: graphView!
    
    func prepareTopView()
    {
        topViewCostLabel.text = "$" + String (stockInformation.price)
        topViewNameLabel.text = stockInformation.name
        topViewLogoImage.image = UIImage(named: String("\(stockInformation.name)").lowercased())
        
        topViewLogoImage.layer.cornerRadius = topViewLogoImage.bounds.width / 2
        topViewLogoImage.clipsToBounds = true
        
        topView.backgroundColor = UIColor.white

        topViewCostLabel.textColor = UIColor(red: 2/255, green: 240/255, blue: 178/255, alpha: 1.0)
        
    }
    
    func prepareBackgroundView()
    {
        backgroundView = backgroundImageView as! backgroundView
    }
    
    func prepareGraphView()
    {
        graphView.graphPoints = stockInformation.last24Price
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // prepare backgroundView
        
        
        // prepare TopView
        prepareTopView()
        
        // prepare graph View
        prepareGraphView()
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
