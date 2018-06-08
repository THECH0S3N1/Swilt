//
//  SecondViewController.swift
//  Swilt
//

//

import UIKit
import CoreMotion



class SecondViewController: UIViewController {

    
    
    
    
    
  
    @IBOutlet weak var Tview: UITextView!
    @IBOutlet  weak var Sview: UIScrollView!
    var motionManager = CMMotionManager()
    var i = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let rec = CGRect(x: 0, y: 0, width: Sview.frame.size.width, height: Sview.frame.size.height)
        Sview.scrollRectToVisible(rec, animated: true)
        
        Tview.contentSize = CGSize(width: Tview.frame.size.width, height: CGFloat(i+50))
        motionManager.gyroUpdateInterval = 0.3
        motionManager.startGyroUpdates(to: OperationQueue.current!){ (data, error) in
            
            if let myData = data{
                if myData.rotationRate.x > 5{
                    self.scrollDown()
                   
                } else if myData.rotationRate.x < -5{
                    self.scrollUp()
                    
                }
            }
            
        }
    }
    
    func scrollDown(){
        if i < 1650 {
            i+=100
        }
        let rec = CGRect(x: 0, y: CGFloat(i), width: Tview.frame.size.width, height: Tview.frame.size.height)
        Tview.scrollRectToVisible(rec, animated: true)
        
        print(i)
       
        
    }
    
    
    func scrollUp(){
        if i > 0{
            i-=100
        }
        let rec = CGRect(x: 0, y: CGFloat(i), width: Tview.frame.size.width, height: Tview.frame.size.height)
        Tview.scrollRectToVisible(rec, animated: true)
        DispatchQueue.main.asyncAfter(deadline: .now() + 6) {}
        
    }
    
 
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }


}

