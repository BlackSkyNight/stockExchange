//
//  MainViewController.swift
//  stockExchange
//
//  Created by Mateusz Matejczyk on 09.11.2017.
//  Copyright © 2017 Mateusz Matejczyk. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var stocksArray = [stocksStruct]()
    var totalBalance = "9,804"
   
    @IBOutlet weak var myCell: MainTableViewCell!
    let generatorSelection = UISelectionFeedbackGenerator()
    let generatorImpact = UIImpactFeedbackGenerator(style: .medium)
    
    
    // topView Outlets
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var topViewImage: UIImageView!
    @IBOutlet weak var topViewBalanceNumberLabel: UILabel!
    @IBOutlet weak var topViewBalanceLabel: UILabel!
    
    // middleViewOutlets
    @IBOutlet weak var middleView: UIView!
    @IBOutlet weak var middleViewLabel: UILabel!
    @IBOutlet weak var middleViewButton: UIButton!
    
    // tableView
    @IBOutlet weak var myTableView: UITableView!
    
    // tabBar
    @IBOutlet weak var tabBar: UITabBar!
    @IBOutlet weak var tabBarWatchlistButton: UITabBarItem!
    @IBOutlet weak var tabBarStocksButton: UITabBarItem!
    @IBOutlet weak var tabBarNewsButton: UITabBarItem!
    @IBOutlet weak var tabBarProfileButton: UITabBarItem!
    
   
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        myTableView.separatorStyle = .none
        return stocksArray.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MainTableViewCell
        
        let stock = stocksArray[indexPath.row]
        
        cell.nameLabel.text = stock.name
        cell.priceLabel.text = "$\(stock.price)"
        cell.logoImage.image = UIImage(named: String("\(stock.name)").lowercased())
        cell.changeLabel.text = "\(stock.change)%"
       
        
        if (stock.change >= 0)
        {
            cell.changeLabel.textColor = UIColor.green
            cell.changeLabel.text = "+" + cell.changeLabel.text!
        }
        else
        {
            cell.changeLabel.textColor = UIColor.red
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (indexPath.row >= stocksArray.count)
        {
            return 0
        }
        return 98
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let cell = stocksArray[sourceIndexPath.row]
        stocksArray.remove(at: sourceIndexPath.row)
        stocksArray.insert(cell, at: destinationIndexPath.row)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete
        {
            
            self.stocksArray.remove(at: indexPath.row)
            
            self.myTableView.reloadData()
        }
        
    }
    

    
    
    
    // SET TOPVIEW
    func setTopViewLayout()
    {
        // set labels
        topViewBalanceLabel.text = "TOTAL BALANCE"
        topViewBalanceNumberLabel.text = "$" + totalBalance
        
        
        /// set image avatar
        topViewImage.image = #imageLiteral(resourceName: "person")
        topViewImage.layer.cornerRadius = topViewImage.frame.size.width / 2
        topViewImage.clipsToBounds = true
        
        // set gradient
        topView.backgroundColor = .clear
        let firstGradientColor = UIColor(red: 2/255, green: 178/255, blue: 240/255, alpha: 1.0)
        let secondGradientColor = UIColor(red: 3/255, green: 235/255, blue: 190/255, alpha: 1.0)
        let gradientx = CAGradientLayer()
        gradientx.colors = [firstGradientColor.cgColor,secondGradientColor.cgColor]
        gradientx.startPoint = CGPoint(x: 0.0, y: 0.0) // 0.5 0.0
        gradientx.endPoint = CGPoint(x: 0.5, y: 0.5) // 0.5 1.0
        gradientx.frame = topView.bounds
        gradientx.cornerRadius = topView.layer.cornerRadius
        topView.layer.insertSublayer(gradientx, at: 0)
    }
    // END OF SETTING TOPVIEW
    
    
    // SET MIDDLEVIEW
    func setMiddleViewLayout()
    {
        // set middle button
        middleViewButton.layer.cornerRadius = middleViewButton.bounds.width / 2
        
        middleViewButton.setImage(#imageLiteral(resourceName: "plus"), for: .normal)
        middleViewButton.setTitle("", for: .normal)
        middleViewButton.tintColor = UIColor(red: 29/255, green: 15/255, blue: 74/255, alpha: 1.0)
        
        // zmienia wielkos obrazka w przycisku
        middleViewButton.imageEdgeInsets = UIEdgeInsets(top: 0.2 * middleViewButton.frame.height, left: 0.2 * middleViewButton.frame.width, bottom: 0.2 * middleViewButton.frame.height, right: 0.2 * middleViewButton.frame.width)
        let firstGradientColor =  UIColor(red: 169/255, green: 176/255, blue: 184/255, alpha: 0.5)
        let secondGradientColor = UIColor(red: 184/255, green: 193/255, blue: 200/255, alpha: 0.5)
        let gradientx = CAGradientLayer()
        gradientx.colors = [firstGradientColor.cgColor,secondGradientColor.cgColor]
        gradientx.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradientx.endPoint = CGPoint(x: 0.5, y: 1.0)
        gradientx.frame = middleViewButton.bounds
        gradientx.cornerRadius = middleViewButton.layer.cornerRadius
        
        
        middleViewButton.layer.insertSublayer(gradientx, below: middleViewButton.imageView?.layer)
    }
    
    // END OF SETTING MIDDLEVIEW
    
    // tap gesture recognizer
    
    @objc func tapGestureRecognizer(gestureRecognizer: UIGestureRecognizer)
    {
        let tap = gestureRecognizer as! UITapGestureRecognizer
        let state = tap.state
        let locationInView = tap.location(in: myTableView)
        let indexPath = myTableView.indexPathForRow(at: locationInView)
        
        if (state == .recognized)
        {
            let cell = myTableView.cellForRow(at: indexPath!) as! MainTableViewCell
            print("name: \(cell.nameLabel)")
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let targetViewController = storyBoard.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
            
            // pass information
            targetViewController.stockInformation = stocksArray[(indexPath?.row)!]
            targetViewController.backgroundImageView = snapshotOfView(inputView: self.view)
            
            self.present(targetViewController, animated: true, completion: nil)
            
        }
    }
    
    
    // long gesture recognizer
    @objc func longPressGestureRecognized(gestureRecognizer: UIGestureRecognizer) {
        let longPress = gestureRecognizer as! UILongPressGestureRecognizer
        let state = longPress.state
        let locationInView = longPress.location(in: myTableView)
        let indexPath = myTableView.indexPathForRow(at: locationInView)
        
        struct My {
            static var cellSnapshot : UIView? = nil
            static var cellIsAnimating : Bool = false
            static var cellNeedToShow : Bool = false
        }
        struct Path {
            static var initialIndexPath : NSIndexPath? = nil
        }
        
        switch state {
        case UIGestureRecognizerState.began:
            if indexPath != nil {
                
                generatorImpact.impactOccurred()
                
                Path.initialIndexPath = indexPath! as NSIndexPath
                let cell = myTableView.cellForRow(at: indexPath!) as! MainTableViewCell!
                My.cellSnapshot  = snapshotOfCell(inputView: (cell?.contentCardView!)!)
                
                var center = cell?.center
                My.cellSnapshot!.center = center!
                My.cellSnapshot!.alpha = 0.0
                myTableView.addSubview(My.cellSnapshot!)
                
                UIView.animate(withDuration: 0.25, animations: { () -> Void in
                    center?.y = locationInView.y
                    My.cellIsAnimating = true
                    My.cellSnapshot!.center = center!
                    My.cellSnapshot!.transform = CGAffineTransform(scaleX: 1.05, y: 1.05)
                    My.cellSnapshot!.alpha = 0.98
                    cell?.alpha = 0.0
                }, completion: { (finished) -> Void in
                    if finished {
                        My.cellIsAnimating = false
                        if My.cellNeedToShow {
                            My.cellNeedToShow = false
                            UIView.animate(withDuration: 0.25, animations: { () -> Void in
                                cell?.alpha = 1
                            })
                        } else {
                            cell?.isHidden = true
                        }
                    }
                })
            }
            
        case UIGestureRecognizerState.changed:
            if My.cellSnapshot != nil {
                var center = My.cellSnapshot!.center
                center.y = locationInView.y
                My.cellSnapshot!.center = center
                
                
                
                if ((indexPath != nil) && (indexPath != (Path.initialIndexPath)! as IndexPath)) {
                    stocksArray.insert(stocksArray.remove(at: Path.initialIndexPath!.row), at: indexPath!.row)
                    myTableView.moveRow(at: Path.initialIndexPath! as IndexPath, to: indexPath!)
                    Path.initialIndexPath = (indexPath! as NSIndexPath)
                    self.generatorSelection.selectionChanged()
                }
            }
        default:
            if Path.initialIndexPath != nil {
                let cell = myTableView.cellForRow(at: Path.initialIndexPath! as IndexPath) as! MainTableViewCell!
                if My.cellIsAnimating {
                    My.cellNeedToShow = true
                } else {
                    cell?.isHidden = false
                    cell?.alpha = 0.0
                }
                
                if cell != nil // test
                {
                
                UIView.animate(withDuration: 0.25, animations: { () -> Void in
                    My.cellSnapshot!.center = (cell?.center)!
                    My.cellSnapshot!.transform = .identity
                    My.cellSnapshot!.alpha = 0.0
                    cell?.alpha = 1.0
                    
                }, completion: { (finished) -> Void in
                    if finished {
                        Path.initialIndexPath = nil
                        My.cellSnapshot!.removeFromSuperview()
                        My.cellSnapshot = nil
                        self.generatorImpact.impactOccurred()
                        
                    }
                })
            }
                else
                {
                    My.cellSnapshot!.alpha = 0.0
                    Path.initialIndexPath = nil
                    My.cellSnapshot!.removeFromSuperview()
                    My.cellSnapshot = nil
                    self.generatorImpact.impactOccurred()
                }
            }
        }
    }
    
    func snapshotOfCell(inputView: UIView) -> UIView {
        UIGraphicsBeginImageContextWithOptions(inputView.bounds.size, false, 0.0)
        inputView.layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        let cellSnapshot : UIView = UIImageView(image: image)
        cellSnapshot.layer.masksToBounds = false
        cellSnapshot.layer.cornerRadius = 0.0
        cellSnapshot.layer.shadowOffset = CGSize(width: -5.0, height: 0.0)//CGSize(-5.0, 0.0)
        cellSnapshot.layer.shadowRadius = 5.0
        cellSnapshot.layer.shadowOpacity = 0.4
        return cellSnapshot
    }
    
    func snapshotOfView(inputView: UIView) -> UIImageView
    {
        UIGraphicsBeginImageContextWithOptions(inputView.bounds.size, false, 0.0)
        inputView.layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        let viewSnapshot: UIImageView = UIImageView(image: image)
 
        /*
        let renderer = UIGraphicsImageRenderer(size: inputView.bounds.size)
        let image = renderer.image { ctx in
            view.drawHierarchy(in: view.bounds, afterScreenUpdates: true)
        }
        */
        return viewSnapshot
    }
    /*
     if locationOnScreen.y < 400 && indexPath!.row > 1 {
     let indexPath = IndexPath.init(row: Path.initialIndexPath!.row - 1, section: 0) //NSIndexPath(row: Path.initialIndexPath!.row - 1, inSection: 0)
     myTableView.scrollToRow(at: indexPath as IndexPath, at: UITableViewScrollPosition.top, animated: true)
     } else if locationOnScreen.y > 550 && indexPath!.row < stocksCount {
     let indexPath = IndexPath.init(row: Path.initialIndexPath!.row + 1, section: 0)// NSIndexPath(forRow: indexPath!.row+1, inSection: 0)
     myTableView.scrollToRow(at: indexPath as IndexPath, at: UITableViewScrollPosition.bottom, animated: true)
     }*/
    
    
    // SET TABBAR LAYOUT
    func setTabBarLayout()
    {
        // set buttons images
        //tabBar.backgroundImage = UIImage.imageWithColor(UIColor.clearColor())
        
        let frost = UIVisualEffectView(effect: UIBlurEffect(style: .light))
        frost.frame = tabBar.bounds
        tabBar.insertSubview(frost, at: 0)
       
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myTableView.tableFooterView = UIView(frame: CGRect())

        myTableView.backgroundColor = UIColor.white
        
        
        
        // topView
        setTopViewLayout()
        
        // middleView
        setMiddleViewLayout()
        
        // set toolbar
        setTabBarLayout()
        
        stocksArray.append(stocksStruct(stockName: "PKOBP", stockPrice: 38.85, stockVolume: 300000, stockChange: -2.39, stockValue: 135281318))
        stocksArray.append(stocksStruct(stockName: "PKNORLEN", stockPrice: 122.85, stockVolume: 684, stockChange: 0.84, stockValue: 88995971))
        stocksArray.append(stocksStruct(stockName: "WITTCHEN", stockPrice: 18.46, stockVolume: 6258, stockChange: 0.84, stockValue: 11674))
        stocksArray.append(stocksStruct(stockName: "ORANGEPL", stockPrice: 5.66, stockVolume: 5135265, stockChange: 0.84, stockValue: 28504237))
        stocksArray.append(stocksStruct(stockName: "TAURONPE", stockPrice: 3.21, stockVolume: 3404946, stockChange: 0.84, stockValue: 10811096))
        stocksArray.append(stocksStruct(stockName: "PGE", stockPrice: 12.22, stockVolume: 1948035, stockChange: 0.84, stockValue: 23543496))
        stocksArray.append(stocksStruct(stockName: "PGNIG", stockPrice: 6.73, stockVolume: 2823398, stockChange: 0.84, stockValue: 18704689))
    
        
        // add long press to cell
        let longPresscellGesture = UILongPressGestureRecognizer(target: self, action: #selector(longPressGestureRecognized))
        myTableView.addGestureRecognizer(longPresscellGesture)
        
        // add tap gesture to cell
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapGestureRecognizer))
        myTableView.addGestureRecognizer(tapGesture)
        
        
        //stocksArray[0].showLast24Price()
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




