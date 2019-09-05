//
//  ViewController.swift
//  TipCalculator
//
//  Created by Damian Falcon on 7/3/19.
//  Copyright © 2019 Damian Falcon. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //inputs
    @IBOutlet var totalTextField: UITextField!
    @IBOutlet var tipTextField: UITextField!
    @IBOutlet var inputNumOfPeopleLabel: UILabel!
    @IBOutlet var numOfPeopleTextField: UITextField!
    
    //outputs
    @IBOutlet var totalAmountLabel: UILabel!
    @IBOutlet var totalAmount: UILabel!
    @IBOutlet var tipAmountLabel: UILabel!
    @IBOutlet var tipAmount: UILabel!
    @IBOutlet var individualAmountLabel: UILabel!
    @IBOutlet var individualAmount: UILabel!
    
    @IBOutlet var splitBill: UIButton!
    
    lazy var currencyFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        
        formatter.numberStyle = .currency
        
        formatter.locale = Locale(identifier: "en_US")
        
        return formatter
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    
    //calculate tip button
    @IBAction func calcTip(_ sender: Any) {
        unhide()
        calcTotal()
        calcTip()
        calcIndividual()
        showIndividualAmount()
        clearTextFields()
    }
    
    @IBAction func splitTheBillButton(_ sender: Any) {
        unhideForSplitBill()
        splitBill.isHidden = true
    }
    
    func clearTextFields(){
        totalTextField.text = ""
        tipTextField.text = ""
        numOfPeopleTextField.text = ""
    }
    
    //calculate total
    func calcTotal(){
        guard
            let totalConv = Decimal(string: totalTextField.text!),
            let tipConv = Decimal(string: tipTextField.text!)
        else { return }
        
        let totalResult = totalConv * ((tipConv / 100) + 1)
        
        totalAmount.text =  currencyFormatter.string(for: totalResult)
    }

    //convert tip percentage to amount
    func calcTip(){
        let totalConv :Double? = Double(totalTextField.text!)
        let tipConv :Double? = Double(tipTextField.text!)
        guard totalConv != nil && tipConv != nil else{
            return
        }
        
        let result = (totalConv! * ((tipConv! / 100) + 1)) - totalConv!
        
        let output = String(format: "$ %.2f", result)
        
        tipAmount.text = String(output)
    }
    
    //calculate how much people pay if the bill is split
    func calcIndividual(){
        let totalConv :Double? = Double(totalTextField.text!)
        let tipConv :Double? = Double(tipTextField.text!)
        let individualConv :Double? = Double(numOfPeopleTextField.text!)
        guard totalConv != nil && tipConv != nil && individualConv != nil else{
            return
        }
        
        let result = (totalConv! * ((tipConv! / 100) + 1)) / individualConv!
        
        let output = String(format: "$ %.2f", result)
        
        individualAmount.text = String(output)
    }
    
    //unhide the hidden elements
    func unhide(){
        totalAmountLabel.isHidden = false
        totalAmount.isHidden = false
        tipAmountLabel.isHidden = false
        tipAmount.isHidden = false
    }
    
    func unhideForSplitBill(){
        inputNumOfPeopleLabel.isHidden = false
        numOfPeopleTextField.isHidden = false
    }
    
    func showIndividualAmount(){
        if inputNumOfPeopleLabel.isHidden == false{
            individualAmountLabel.isHidden = false
            individualAmount.isHidden = false
        }
    }
    
}


