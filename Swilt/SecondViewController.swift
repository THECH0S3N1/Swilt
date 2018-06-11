//
//  SecondViewController.swift
//  Swilt
//

import UIKit
import CoreMotion



class SecondViewController: UIViewController {

    @IBOutlet weak var ScrollButton: UIButton!
    @IBOutlet weak var LargerText: UIButton!
    @IBOutlet weak var SmallerText: UIButton!
    var counter_button_scroll = 1
    var maxFontSize = 20
    var minFontSize = 10
    var f = 14
    
    @IBOutlet weak var Tview: UITextView!
    @IBOutlet  weak var Sview: UIScrollView!
    
    
    @IBAction func SmallerText(_ sender: UIButton) {
       
        if f == (minFontSize+2){
            f-=2
            Tview.font = UIFont.systemFont(ofSize: CGFloat(f))
            SmallerText.isEnabled = false
            SmallerText.alpha = 0.5
        }else if f == maxFontSize {
            f-=2
            Tview.font = UIFont.systemFont(ofSize: CGFloat(f))
            LargerText.isEnabled = true
            LargerText.alpha = 1.0
        }else{
            f-=2
            Tview.font = UIFont.systemFont(ofSize: CGFloat(f))
        }
    }
    
    
    @IBAction func LargerText(_ sender: UIButton) {
        
        if f == (maxFontSize-2){
            f+=2
            Tview.font = UIFont.systemFont(ofSize: CGFloat(f))
            LargerText.isEnabled = false
            LargerText.alpha = 0.5
        }else if f == minFontSize {
            f+=2
            Tview.font = UIFont.systemFont(ofSize: CGFloat(f))
            SmallerText.isEnabled = true
            SmallerText.alpha =  1.0
        }else{
            f+=2
            Tview.font = UIFont.systemFont(ofSize: CGFloat(f))
        }
        
    }
    
    
    @IBAction func ScrollButton(_ sender: UIButton) {
        if counter_button_scroll == 1{
            Tview.isScrollEnabled = false
            counter_button_scroll+=1
            ScrollButton.alpha = 0.5
        }else{
            Tview.isScrollEnabled = true
            counter_button_scroll-=1
            ScrollButton.alpha = 1.0
            
        }
        
    }
    
    var motionManager = CMMotionManager()
    var i = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Tview.isScrollEnabled = true
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
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(false)
        Tview.scrollRangeToVisible(NSMakeRange(0, 0))
        
    }
    
    func scrollDown(){
        if i < 1650 {
            i+=150
        }
        let rec = CGRect(x: 0, y: CGFloat(i), width: Tview.frame.size.width, height: Tview.frame.size.height)
        Tview.scrollRectToVisible(rec, animated: true)
        
        print(i)
       
        
    }
    
    
    func scrollUp(){
        if i > 0{
            i-=150
        }
        let rec = CGRect(x: 0, y: CGFloat(i), width: Tview.frame.size.width, height: Tview.frame.size.height)
        Tview.scrollRectToVisible(rec, animated: true)
        DispatchQueue.main.asyncAfter(deadline: .now() + 6) {}
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }


}

