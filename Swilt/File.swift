//
//  SecondViewController.swift
//  TiltIT
//

import UIKit
import CoreMotion

class Second2ViewController: UIViewController {
    var counter_button_scroll = 1
    var maxFontSize = 30
    var minFontSize = 10
    var f = 20
    var up_timestamp = 0.0
    var down_timestamp = 0.0
    var motionManager = CMMotionManager()
    var i = 0
    var maxScrollSize = 0
    
    @IBOutlet var popupView2: UIView!
    @IBOutlet weak var startTimerButton: UIButton!
    @IBOutlet weak var readingTimer: UIButton!
    @IBOutlet weak var ScrollButton: UIButton!
    @IBOutlet weak var LargerText: UIButton!
    @IBOutlet weak var SmallerText: UIButton!
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
    
    func animateIn() {
        self.view.addSubview(popupView2)
        popupView2.center = self.view.center
        popupView2.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
        UIView.animate(withDuration: 0.4) {
            self.popupView2.transform = CGAffineTransform.identity
        }
    }
    
    func animateOut () {
        UIView.animate(withDuration: 0.3, animations: {
            self.popupView2.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
            
            
        }) { (success:Bool) in
            self.popupView2.removeFromSuperview()
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
    
    @IBAction func startTimerButton(_ sender: UIButton) {
        animateOut()
        startTimestamp = NSDate().timeIntervalSince1970
        Tview.isUserInteractionEnabled = true
        readingTimer.isUserInteractionEnabled = true
        readingTimer.alpha = 1.0
    }
    
    @IBAction func readingButton(_ sender: UIButton) {
        endTimestamp = Double(NSDate().timeIntervalSince1970)
        result = String(format: "%.2f",(endTimestamp-startTimestamp))
        stories[myIndex] = stories[myIndex] + "  " + result
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        readingTimer.isUserInteractionEnabled = false
        readingTimer.alpha = 0.5
        Tview.text = myStories[myIndex]
        popupView2.layer.cornerRadius = 5
        animateIn()
        Tview.isUserInteractionEnabled = true
        Tview.isScrollEnabled = true
        let rec = CGRect(x: 0, y: 0, width: Sview.frame.size.width, height: Sview.frame.size.height)
        Sview.scrollRectToVisible(rec, animated: true)
        Tview.contentSize = CGSize(width: Tview.frame.size.width, height: CGFloat(i+50))
        motionManager.gyroUpdateInterval = 0.1
        motionManager.startGyroUpdates(to: OperationQueue.current!){ (data, error) in
            if let myData = data{
                if myData.rotationRate.x > 1.2{
                    self.scrollDown()
                    
                } else if myData.rotationRate.x < -1.8{
                    self.scrollUp()
                }
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(false)
        Tview.scrollRangeToVisible(NSMakeRange(0, 0))
    }
    
    public var screenHeight: CGFloat {
        return UIScreen.main.bounds.height
    }
    
    func scrollDown(){
        let maxHeight:Int = Int(Tview.frame.size.height)
        let new_down_timestamp = NSDate().timeIntervalSince1970
        maxScrollSize = Int(screenHeight)
        if (new_down_timestamp - up_timestamp) > 0.8{
            down_timestamp = new_down_timestamp
            if i < maxHeight {
                i += maxScrollSize
            }
            let rec = CGRect(x: 0, y: CGFloat(i), width: Tview.frame.size.width, height: Tview.frame.size.height)
            Tview.scrollRectToVisible(rec, animated: true)
        }
    }
    
    
    func scrollUp(){
        let minHeight = 0
        let new_up_timestamp = NSDate().timeIntervalSince1970
        maxScrollSize = Int(screenHeight)
        if(new_up_timestamp - down_timestamp) > 0.8{
            up_timestamp = new_up_timestamp
            if i > minHeight{
                i -= maxScrollSize
            }
            let rec = CGRect(x: 0, y: CGFloat(i), width: Tview.frame.size.width, height: Tview.frame.size.height)
            Tview.scrollRectToVisible(rec, animated: true)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}

