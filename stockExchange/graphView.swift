//
//  graphView.swift
//  stockExchange
//
//  Created by Mateusz Matejczyk on 23.11.2017.
//  Copyright © 2017 Mateusz Matejczyk. All rights reserved.
//

// class from Tutorial

import UIKit

@IBDesignable class graphView: UIView {

    @IBInspectable var startColor: UIColor = .red
    @IBInspectable var endColor: UIColor = .green
    
    var graphPoints: [Double] = [4.0, 2.0, 6.0, 4.0, 5.0, 8.0, 3.0]
    
    private struct Constants
    {
        static let cornerRadiusSize = CGSize(width: 8.0, height: 8.0)
        static let margin: CGFloat = 20.0
        static let topBorder: CGFloat = 60
        static let bottomBorder: CGFloat = 50
        static let colorAlpha: CGFloat = 0.3
        static let circleDiameter: CGFloat = 5.0
    }
    
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        let width = rect.width
        let height = rect.height
        
        let context = UIGraphicsGetCurrentContext()!
        let colors = [startColor.cgColor, endColor.cgColor]
        
        // 3
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        
        // 4
        let colorLocations: [CGFloat] = [0.0, 1.0]
        
        // 5
        let gradient = CGGradient(colorsSpace: colorSpace,
                                  colors: colors as CFArray,
                                  locations: colorLocations)!
        
        // 6
        let startPoint = CGPoint.zero
        let endPoint = CGPoint(x: 0, y: bounds.height)
        context.drawLinearGradient(gradient,
                                   start: startPoint,
                                   end: endPoint,
                                   options: [])
        
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: .allCorners, cornerRadii: Constants.cornerRadiusSize)
        
        path.addClip()
        
        
        let margin = Constants.margin
        let graphWidth = width - margin * 2 - 4
        let columnXPoint = { (column: Int) -> CGFloat in
            //Calculate the gap between points
            let spacing = graphWidth / CGFloat(self.graphPoints.count - 1)
            return CGFloat(column) * spacing + margin + 2
        }
            
            
            let topBorder = Constants.topBorder
            let bottomBorder = Constants.bottomBorder
            let graphHeight = height - topBorder - bottomBorder
            let maxValue = self.graphPoints.max()!
            let columnYPoint = { (graphPoint: Int) -> CGFloat in
                let y = CGFloat(graphPoint) / CGFloat(maxValue) * graphHeight
                return graphHeight + topBorder - y // Flip the graph
        }
                
                
            UIColor(red: 2/255, green: 240/255, blue: 178/255, alpha: 1.0).setFill()
                UIColor(red: 2/255, green: 240/255, blue: 178/255, alpha: 1.0).setStroke()
                
                // set up the points line
                let graphPath = UIBezierPath()
                
                // go to start of line
        graphPath.move(to: CGPoint(x: columnXPoint(0), y: columnYPoint(Int(graphPoints[0]))))
                
                // add points for each item in the graphPoints array
                // at the correct (x, y) for the point
                for i in 1..<self.graphPoints.count {
                    let nextPoint = CGPoint(x: columnXPoint(i), y: columnYPoint(Int(graphPoints[i])))
                    graphPath.addLine(to: nextPoint)
                }
                
                graphPath.stroke()
        
        
        
        for i in 0..<graphPoints.count {
            var point = CGPoint(x: columnXPoint(i), y: columnYPoint(Int(graphPoints[i])))
            point.x -= Constants.circleDiameter / 2
            point.y -= Constants.circleDiameter / 2
            
            let circle = UIBezierPath(ovalIn: CGRect(origin: point, size: CGSize(width: Constants.circleDiameter, height: Constants.circleDiameter)))
            circle.fill()
        }
    }
}

    


