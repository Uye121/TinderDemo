//
//  CardsViewController.swift
//  TinderDemo
//
//  Created by Ulric Ye on 4/26/17.
//  Copyright © 2017 uye. All rights reserved.
//

import UIKit

class CardsViewController: UIViewController {
    
    var cardInitialCenter: CGPoint!
    var picViewUp: CGPoint!
    var picViewDown: CGPoint!
    var picDownOffset: CGFloat!
    
    @IBOutlet var picView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.cardInitialCenter = picView.center

        // Do any additional setup after loading the view.
        //picDownOffset = 160
        //picViewUp = picView.center
        //picViewDown = CGPoint(x: picView.center.x, y: picView.center.y + picDownOffset)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didPan(_ sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: view)
        
        if sender.state == .changed {
            let rotate = CGAffineTransform(rotationAngle: translation.x / 100)
            self.picView.transform = rotate
            self.picView.center = CGPoint(x: self.cardInitialCenter.x + translation.x, y: self.cardInitialCenter.y)
           
            
        } else if sender.state == .ended {
            
            if translation.x > 80 {
                UIView.animate(withDuration: 0.8, animations: {
                    let destination = CGPoint(x: 1000, y: self.cardInitialCenter.y)
                    self.picView.center = destination
                    
                })
                
            } else if (translation.x < -80){
                UIView.animate(withDuration: 0.8, animations: {
                    let destination = CGPoint(x: -1000, y: self.cardInitialCenter.y)
                    self.picView.center = destination
                })
            } else{
                self.picView.center = self.cardInitialCenter
                self.picView.transform = .identity
            }
        }

    }


    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        let profileView = segue.destination as! ProfileViewController
        profileView.picView = self.picView
    }
    

}
