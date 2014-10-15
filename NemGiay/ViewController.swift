//
//  ViewController.swift
//  NemGiay
//
//  Created by DuyNT on 10/10/14.
//  Copyright (c) 2014 DuyNT. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var trash: UIImageView?
    var paper: UIImageView?
    var vX: Double = 0.0
    var vY: Double = 0.0
    var v0: Double = 20.0
    var alpha = M_2_PI
    var g: Double = 10.0
    var width: Double = 0.0
    var hight: Double = 0.0
    var time: NSTimer?


    
    override func loadView() {
        super.loadView()
        self.edgesForExtendedLayout = UIRectEdge.None
        self.view.backgroundColor = UIColor.whiteColor()
        let size = self.view.bounds.size
        width = Double(size.width)
        hight = Double(size.height)
        trash = UIImageView(image: UIImage(named: "EmptyTrash.png"))
//        trash?.transform = CGAffineTransformMakeRotation(CGFloat(M_PI_2))
        trash?.center = CGPoint(x: size.width * 0.5, y: (size.height * 0.9) - 60)
        self.view.addSubview(trash!)
        
        paper = UIImageView(image: UIImage(named: "wadded_paper.png"))
        paper?.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        paper?.center = CGPoint(x: size.width * 1.5, y: (size.height * 0.3) - 60)
        self.view.addSubview(paper!)
        paper!.multipleTouchEnabled = true
        paper!.userInteractionEnabled = true
        
        let throw = UIPanGestureRecognizer(target: self, action: "nemngang:")
        self.view.addGestureRecognizer(throw)
        
        time = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: "giayBay:", userInfo: nil, repeats: true)
        time?.fire()
    }
    
    func nemngang(nem: UIPanGestureRecognizer){
        if nem.state == UIGestureRecognizerState.Began || nem.state == UIGestureRecognizerState.Changed{
            paper!.center = nem.locationInView(self.view)
            let velocity = nem.velocityInView(paper!)
            vX += Double(velocity.x) * 5 / width
            vY += Double(velocity.y) * 5 / hight
        }
    }
    
    func giayBay(bay: NSTimer){
        var x1 = Double(paper!.center.x) + vX
        var y1 = Double(paper!.center.y) + vY
        let size = self.view.bounds.size
        paper?.center = CGPoint(x: x1, y: y1)
        vX = 0.9 * vX
        vY = 0.9 * vY + 1
        
        if paper!.center.x > (size.width * 0.5) - 30 && paper!.center.x < (size.width * 0.5) + 30 && paper!.center.y < ((size.height * 0.9) - 60 + 30) && paper!.center.y > ((size.height * 0.9) - 60 - 30)  {
            paper!.center = CGPoint(x: size.width * 0.5, y: (size.height * 0.9) - 60)
        }
    }
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        time?.invalidate()
        time = nil
    }

}

