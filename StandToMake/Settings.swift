//
//  Settings.swift
//  StandToMake
//
//  Created by Karl Oscar Weber on 9/14/14.
//  Copyright (c) 2014 Karl Oscar Weber. All rights reserved.
//

import UIKit

class Settings: UIViewController {
    
    // important variables
    var priceStepValue: Int = 0
    var priceAdjustedValue: Double = 0.99
    var salesStepValue: Int = 100
    var periodMultiplier = 12
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // load the user interface
        self.loadPrice()
        self.loadSales()
        self.loadPeriod()
        self.loadMerchant()
        
        self.view.backgroundColor = UIColor.whiteColor()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /**
    *  Load the User Interface elements
    *  Price Related Stuff
    */
    
    // Change Price Actions
    func updateSliderPrice(){
        // get the sliders number.
        var rawValue = self.priceSlider.value
        var newValue: Int = Int(rawValue * 100)
        if(newValue == 100){
            newValue = 99
        }
        // update the step
        self.priceStepValue = newValue
        // update the stepper
        self.priceStepper.value = Double(newValue)
        // update the price
        self.updateAdjustedPrice()
    }
    
    func updateStepValue() {
        // update the step
        self.priceStepValue = Int(self.priceStepper.value)
        // update the slider
        self.priceSlider.setValue(Float(self.priceStepper.value * 0.01), animated: true)
        // update the price
        self.updateAdjustedPrice()
    }
    
    func updateAdjustedPrice() {
        self.priceAdjustedValue = Double(self.priceStepValue * 100 + 99) * 0.01
        self.priceValueLabel.text = "$ \(self.priceAdjustedValue)"
    }
    
    // Price Related Elements
    let priceLabel: UILabel = {
        let label = UILabel()
        label.frame = CGRectMake(20, 80, 280, 30)
        label.font = UIFont(name: "Avenir", size:20)
        label.textColor = UIColor.blackColor()
        label.textAlignment = .Center
        label.text = "Price"
        return label
        }()
    
    let priceSlider: UISlider = {
        let slider = UISlider()
        slider.frame = CGRectMake(20, 105, 280, 30)
        return slider
        }()
    
    let priceStepper: UIStepper = {
        let stepper = UIStepper()
        stepper.frame = CGRectMake(200, 140, 100, 30)
        stepper.maximumValue = 99
        return stepper
        }()
    let priceValueLabel: UILabel = {
        let label = UILabel()
        label.frame = CGRectMake(20, 140, 280, 30)
        label.font = UIFont(name: "Avenir", size: 20)
        label.textAlignment = .Left
        label.text = "$0.99"
        return label
        }()
    
    func loadPrice() {
        // price has a label, a slider, a stepper, and another label
        priceSlider.addTarget(self, action: "updateSliderPrice", forControlEvents: UIControlEvents.ValueChanged)
        priceSlider.continuous = true
        priceStepper.addTarget(self, action: "updateStepValue", forControlEvents: UIControlEvents.ValueChanged)
        self.view.addSubview(priceLabel)
        self.view.addSubview(priceSlider)
        self.view.addSubview(priceStepper)
        self.view.addSubview(priceValueLabel)
    }
    
    
    /**
    *  Load the User Interface elements
    *  Sales Related Stuff
    */
    // Change Sales Actions
    func updateSliderSales(){
        // get the sliders number.
        var rawValue = self.salesSlider.value
        //        println("\(rawValue)")
        var newValue: Int = Int(rawValue * 5000)
        //        if(newValue == 100){
        //            newValue = 99
        //        }
        //        println("\(newValue)")
        // update the step
        self.salesStepValue = newValue
        // update the stepper
        self.salesStepper.value = Double(newValue)
        // update the price
        self.updateAdjustedSales()
    }
    
    func updateSalesStepValue() {
        // update the step
        self.salesStepValue = Int(self.salesStepper.value)
        // update the slider
        self.salesSlider.setValue(Float(self.salesStepper.value * 0.0002), animated: true)
        // update the price
        self.updateAdjustedSales()
    }
    
    func updateAdjustedSales() {
        self.salesValueLabel.text = "\(self.salesStepValue)"
    }
    
    let salesLabel: UILabel = {
        let label = UILabel()
        label.frame = CGRectMake(20, 100+80, 280, 30)
        label.font = UIFont(name: "Avenir", size:20)
        label.textColor = UIColor.blackColor()
        label.textAlignment = .Center
        label.text = "Sales"
        return label
        }()
    
    let salesSlider: UISlider = {
        let slider = UISlider()
        slider.frame = CGRectMake(20, 100+105, 280, 30)
        return slider
        }()
    
    let salesStepper: UIStepper = {
        let stepper = UIStepper()
        stepper.frame = CGRectMake(200, 100+140, 100, 30)
        stepper.maximumValue = 5000
        return stepper
        }()
    let salesValueLabel: UILabel = {
        let label = UILabel()
        label.frame = CGRectMake(20, 100+140, 280, 30)
        label.font = UIFont(name: "Avenir", size: 20)
        label.textAlignment = .Left
        label.text = "100"
        return label
        }()
    
    func loadSales() {
        // price has a label, a slider, a stepper, and another label
        salesSlider.addTarget(self, action: "updateSliderSales", forControlEvents: UIControlEvents.ValueChanged)
        salesSlider.continuous = true
        salesStepper.addTarget(self, action: "updateSalesStepValue", forControlEvents: UIControlEvents.ValueChanged)
        salesStepper.continuous = true
        self.view.addSubview(salesLabel)
        self.view.addSubview(salesSlider)
        self.view.addSubview(salesStepper)
        self.view.addSubview(salesValueLabel)
    }
    
    
    /**
    *  Load the User Interface elements
    *  Sales Related Stuff
    */
    func periodChanged() {
        var segment = self.periodSegmentedControl.selectedSegmentIndex
        println("selected segment: \(segment)")
        
        switch segment {
        case 0:
            self.periodMultiplier = 365 // Daily
        case 1:
            self.periodMultiplier = 52 // Weekly
        case 3:
            self.periodMultiplier = 1 // Yearly
        default:
            self.periodMultiplier = 12 // Monthly
        }
    }
    
    let periodLabel: UILabel = {
        let label = UILabel()
        label.frame = CGRectMake(20, 200+80, 280, 30)
        label.font = UIFont(name: "Avenir", size:20)
        label.textColor = UIColor.blackColor()
        label.textAlignment = .Center
        label.text = "Period"
        return label
        }()
    
    let periodSegmentedControl: UISegmentedControl = {
        let control = UISegmentedControl()
        control.frame = CGRectMake(20, 200+115, 280, 30)
        return control
        }()
    
    func loadPeriod() {
        periodSegmentedControl.insertSegmentWithTitle("Daily", atIndex: 0, animated: true)
        periodSegmentedControl.insertSegmentWithTitle("Weekly", atIndex: 1, animated: true)
        periodSegmentedControl.insertSegmentWithTitle("Monthly", atIndex: 2, animated: true)
        periodSegmentedControl.insertSegmentWithTitle("Yearly", atIndex: 3, animated: true)
        periodSegmentedControl.selectedSegmentIndex = 2
        periodSegmentedControl.addTarget(self, action: "periodChanged", forControlEvents: UIControlEvents.ValueChanged)
        self.view.addSubview(periodLabel)
        self.view.addSubview(periodSegmentedControl)
    }
    
    func loadMerchant() {
        
    }
}
