//
//  AddBillViewController.swift
//  BillManager
//
//  Created by Muhammad Nasir on 22/07/2014.
//  Copyright (c) 2014 Muhammad Nasir. All rights reserved.
//

import UIKit

class AddBillViewController: UIViewController, UITextFieldDelegate
{
    @IBOutlet var textFieldAmount:UITextField = UITextField()
    @IBOutlet var labelUserName:UILabel = UILabel()
    @IBOutlet var labelMessage:UILabel = UILabel()
    @IBOutlet var datePickerBillDate:UIDatePicker = UIDatePicker()
    @IBOutlet var segmentedControlBillType:UISegmentedControl = UISegmentedControl()
    
    var stringUserName:NSString = NSString()
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    override func viewWillAppear(animated: Bool)
    {
        super.viewWillAppear(animated)
    }
    override func viewDidLoad()
    {
        super.viewDidLoad()
        labelUserName.text = stringUserName
    }
    func textFieldDidBeginEditing(textField: UITextField!)
    {
        textFieldAmount.text = ""
        labelMessage.text = ""
        var tapGestureRecognizer:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "tapGestureSelector:")
        self.view.addGestureRecognizer(tapGestureRecognizer)
    }
    func tapGestureSelector(tapGestureRecognizer: UITapGestureRecognizer!)-> Void
    {
        self.view.removeGestureRecognizer(tapGestureRecognizer)
        textFieldAmount.resignFirstResponder()
    }
    @IBAction func buttonAddBillActionSelector(button: UIButton!)
    {
        textFieldAmount.resignFirstResponder()
        var stringUserName:NSString? = textFieldAmount.text
        if stringUserName
        {
            stringUserName = stringUserName?.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        }
        
        if (stringUserName?.length > 0)
        {
            var aFloat = stringUserName?.floatValue
            if (aFloat != 0.0)
            {
                self.addBillToDB(aFloat!)
                labelMessage.text = "Bill added to database.\nBill Amount: £\(aFloat)"
                textFieldAmount.text = ""
            }
            else
            {
                labelMessage.text = "Please enter valid Amount!"
            }
        }
        else
        {
            labelMessage.text = "Amount field cannot be left blank!"
        }
    }
    func addBillToDB(floatAmount:Float)
    {
        let dateBillDate:NSDate = datePickerBillDate.date;
        let stringBillType:NSString = segmentedControlBillType.titleForSegmentAtIndex(self.segmentedControlBillType.selectedSegmentIndex)
        let stringBillAmount:NSString = String(floatAmount)
        
        let mutableDictionaryBill:NSMutableDictionary = NSMutableDictionary.dictionary()
        mutableDictionaryBill.setObject(stringUserName, forKey:"stringUserName")
        mutableDictionaryBill.setObject(dateBillDate, forKey:"dateBillDate")
        mutableDictionaryBill.setObject(stringBillType, forKey:"stringBillType")
        mutableDictionaryBill.setObject(stringBillAmount, forKey:"stringBillAmount")
        
        var maBills:NSMutableArray = UtilityMethods.getBillsFromUserDefaults()
        maBills.addObject(mutableDictionaryBill)
        UtilityMethods.setBillsToUserDefaults(maBills)
    }
}
