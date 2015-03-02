//
//  ProfitViewController.swift
//  StandToMake
//
//  Created by Karl Oscar Weber on 9/14/14.
//  Copyright (c) 2014 Karl Oscar Weber. All rights reserved.
//

import UIKit

class ProfitViewController: UIViewController, UITextFieldDelegate {
    
    // yearly values
    var profit = 1260000
    var fees = 540000
    
    override init() {
        super.init()
        self.view.backgroundColor = UIColor.whiteColor()
        labels()
        buttons()
        profitsAndFeesLabels()
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        // Custom initialization
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBarHidden = true;
        recalculcateProfitAndFees()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated:animated)
        recalculcateProfitAndFees()
    }
    
    override func viewWillDisappear(animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated:animated)
    }
    
    // Setup UserInterface Elements
    var attributedSummary: UITextView = {
        let label = UITextView()
        label.frame = CGRectMake(20, 20, (320 - 40), 300)
        label.font = UIFont(name: "Avenir", size:20)
        label.textAlignment = .Left
//        label.lineBreakMode = .ByWordWrapping
//        label.numberOfLines = 5
        label.allowsEditingTextAttributes = false;
        label.selectable = false;
        label.text = "My Product will sell for $0.99, I will sell 500 copies, every month, and Gumroad will help me sell it."
        return label
    }()
    
    
    var feeLabel: UIBorderedLabel = {
        let label = UIBorderedLabel()
        label.frame = CGRectMake(20, 170, 280, 26)
        label.font = UIFont(name: "Avenir", size:8)
        label.textAlignment = .Left
        label.lineBreakMode = NSLineBreakMode.ByWordWrapping
        label.text = "Apple's App Store 30% of sales"
        label.layer.cornerRadius = 6.0
        label.leftInset = 10
        label.rightInset = 10
        label.layer.backgroundColor = UIColor.lightGrayColor().CGColor
        return label
        }()
    
    var standToMakeLabel: UIBorderedLabel = {
        let label = UIBorderedLabel()
        label.frame = CGRectMake(20, 210, 280, 26)
        label.font = UIFont(name: "Avenir", size:16)
        label.textAlignment = .Left
        label.lineBreakMode = NSLineBreakMode.ByWordWrapping
        label.text = "I Stand To Make:"
        label.textColor = UIColor.grayColor()
        return label
        }()
    
    func labels() {
        
        var optionsRecognizer = UITapGestureRecognizer()
        optionsRecognizer.addTarget(self, action: "openSettings")
        attributedSummary.addGestureRecognizer(optionsRecognizer)
        
        self.view.addSubview(attributedSummary)
        self.view.addSubview(feeLabel)
        self.view.addSubview(standToMakeLabel)
    }

    var truePrice: Int = {
        let price: Int = 0;
        return price;
    }()
    
    
    func buttons() {
//        settingsButton.addTarget(self, action: "openSettings", forControlEvents: UIControlEvents.TouchUpInside)
//        priceField.delegate = self;
//        self.view.addSubview(priceField)
    }
    
    func openSettings() {
        var appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        self.navigationController?.pushViewController(appDelegate.settingsView, animated: true)
    }
    
    let formatter = NSNumberFormatter()
    
    func recalculcateProfitAndFees() {
        
        if((UIApplication.sharedApplication().delegate) != nil) {
            
            formatter.numberStyle = NSNumberFormatterStyle.CurrencyStyle
            
            var appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
            var price  = appDelegate.settingsView.priceAdjustedValue
            var period = appDelegate.settingsView.periodMultiplier
            var sales  = appDelegate.settingsView.salesStepValue
            println("price: \(price), period: \(period), sales: \(sales)")
            
            var periodCanonical = "month"
            
            switch period {
            case 365:
                periodCanonical = "day"
            case 52:
                periodCanonical = "week"
            case 1:
                periodCanonical = "year"
            default:
                periodCanonical = "month"
            }
            
            var merchant = "Gumroad"
            
            self.attributedSummary.text = "My Product will sell for \(price), I will make \(sales) sales every \(periodCanonical), and \(merchant) will help me sell it."
            
            // calculate yearly profits
            var yearlyProfit = Float(price) * Float(sales) * Float(period) * 0.7
            var yearlyFees = Float(price) * Float(sales) * Float(period) * 0.3
            
            // format and set all of the text like a boss
            var dailyProfits = formatter.stringFromNumber(yearlyProfit / 365)
            var dailyFees = formatter.stringFromNumber(yearlyFees / 365)
            self.dailyProfitLabel.text = "\(dailyProfits!) /day"
            self.dailyFeesLabel.text = "Fees \(dailyFees!)"
            
            var weeklyProfits = formatter.stringFromNumber(yearlyProfit / 52)
            var weeklyFees = formatter.stringFromNumber(yearlyFees / 52)
            self.weeklyProfitLabel.text = "\(weeklyProfits!) /week"
            self.weeklyFeesLabel.text = "Fees \(weeklyFees!)"
            
            var monthlyProfits = formatter.stringFromNumber(yearlyProfit / 12)
            var monthlyFees = formatter.stringFromNumber(yearlyFees / 12)
            self.monthlyProfitLabel.text = "\(monthlyProfits!) /month"
            self.monthlyFeesLabel.text = "Fees \(monthlyFees!)"
            
            var yearlyProfitsFormatted = formatter.stringFromNumber(yearlyProfit)
            var yearlyFeesFormatted = formatter.stringFromNumber(yearlyFees)
            self.yearlyProfitLabel.text = "\(yearlyProfitsFormatted!) /year"
            self.yearlyFeesLabel.text = "Fees \(yearlyFeesFormatted!)"
            
        }
    }
    
    let dailyProfitLabel: UILabel = {
        let label = UILabel()
        label.frame = CGRectMake(20, 240, 280, 36)
        label.font = UIFont(name: "Avenir", size:26)
        label.textAlignment = .Left
        label.lineBreakMode = NSLineBreakMode.ByWordWrapping
        label.text = "$47.55 / day"
        label.textColor = UIColor.blackColor()
        return label
        }()
    
    let dailyFeesLabel: UILabel = {
        let label = UILabel()
        label.frame = CGRectMake(20, 260, 280, 36)
        label.font = UIFont(name: "Avenir", size:12)
        label.textAlignment = .Left
        label.lineBreakMode = NSLineBreakMode.ByWordWrapping
        label.text = "Fees $2.45"
        label.textColor = UIColor.grayColor()
        return label
        }()
    
    let weeklyProfitLabel: UILabel = {
        let label = UILabel()
        label.frame = CGRectMake(20, 260+40, 280, 36)
        label.font = UIFont(name: "Avenir", size:26)
        label.textAlignment = .Left
        label.lineBreakMode = NSLineBreakMode.ByWordWrapping
        label.text = "$47.55 / week"
        label.textColor = UIColor.blackColor()
        return label
        }()
    
    let weeklyFeesLabel: UILabel = {
        let label = UILabel()
        label.frame = CGRectMake(20, 260+60, 280, 36)
        label.font = UIFont(name: "Avenir", size:12)
        label.textAlignment = .Left
        label.lineBreakMode = NSLineBreakMode.ByWordWrapping
        label.text = "Fees $2.45"
        label.textColor = UIColor.grayColor()
        return label
        }()
    
    let monthlyProfitLabel: UILabel = {
        let label = UILabel()
        label.frame = CGRectMake(20, 260+100, 280, 36)
        label.font = UIFont(name: "Avenir", size:26)
        label.textAlignment = .Left
        label.lineBreakMode = NSLineBreakMode.ByWordWrapping
        label.text = "$47.55 / month"
        label.textColor = UIColor.blackColor()
        return label
        }()
    
    let monthlyFeesLabel: UILabel = {
        let label = UILabel()
        label.frame = CGRectMake(20, 260+120, 280, 36)
        label.font = UIFont(name: "Avenir", size:12)
        label.textAlignment = .Left
        label.lineBreakMode = NSLineBreakMode.ByWordWrapping
        label.text = "Fees $2.45"
        label.textColor = UIColor.grayColor()
        return label
        }()
    
    let yearlyProfitLabel: UILabel = {
        let label = UILabel()
        label.frame = CGRectMake(20, 260+160, 280, 36)
        label.font = UIFont(name: "Avenir", size:26)
        label.textAlignment = .Left
        label.lineBreakMode = NSLineBreakMode.ByWordWrapping
        label.text = "$47.55 / year"
        label.textColor = UIColor.blackColor()
        return label
        }()
    
    let yearlyFeesLabel: UILabel = {
        let label = UILabel()
        label.frame = CGRectMake(20, 260+180, 280, 36)
        label.font = UIFont(name: "Avenir", size:12)
        label.textAlignment = .Left
        label.lineBreakMode = NSLineBreakMode.ByWordWrapping
        label.text = "Fees $2.45"
        label.textColor = UIColor.grayColor()
        return label
        }()
    
    func profitsAndFeesLabels() {
        self.view.addSubview(dailyProfitLabel)
        self.view.addSubview(dailyFeesLabel)
        self.view.addSubview(weeklyProfitLabel)
        self.view.addSubview(weeklyFeesLabel)
        self.view.addSubview(monthlyProfitLabel)
        self.view.addSubview(monthlyFeesLabel)
        self.view.addSubview(yearlyProfitLabel)
        self.view.addSubview(yearlyFeesLabel)
    }
    
    // uitextfield delegate for
    func textFieldDidEndEditing(textField: UITextField) {
        textField.resignFirstResponder()
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        
//        if textField == priceField {
//
//            var newLength = countElements(textField.text) + countElements(string) - range.length;
//            
//            // limit the characters to 6, up to 999,999
//            if newLength > 6 {
//                return false
//            } else {
//                return true
//            }
//        }
//        
        return true
    }
//    
//    - (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
//    // Prevent crashing undo bug – see note below.
//    if(range.length + range.location > textField.text.length)
//    {
//    return NO;
//    }
//    
//    NSUInteger newLength = [textField.text length] + [string length] - range.length;
//    return (newLength > 25) ? NO : YES;
//    }
    
}
