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
    @IBOutlet var textFieldAmount:UITextField?
    @IBOutlet var labelUserName:UILabel?
    @IBOutlet var labelMessage:UILabel?
    @IBOutlet var datePickerBillDate:UIDatePicker?
    @IBOutlet var segmentedControlBillType:UISegmentedControl?
    
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
        labelUserName?.text = stringUserName as String
    }
    func textFieldDidBeginEditing(textField: UITextField)
    {
        textFieldAmount?.text = ""
        labelMessage?.text = ""
        let tapGestureRecognizer:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "tapGestureSelector:")
        self.view.addGestureRecognizer(tapGestureRecognizer)
    }
    func tapGestureSelector(tapGestureRecognizer: UITapGestureRecognizer!)-> Void
    {
        self.view.removeGestureRecognizer(tapGestureRecognizer)
        textFieldAmount?.resignFirstResponder()
    }
    @IBAction func buttonAddBillActionSelector(button: UIButton!)
    {
        textFieldAmount?.resignFirstResponder()
        var stringUserName:NSString? = textFieldAmount?.text
        if (stringUserName != nil)
        {
            stringUserName = stringUserName?.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        }
        
        if (stringUserName?.length > 0)
        {
            let aFloat = stringUserName?.floatValue
            if (aFloat != 0.0)
            {
                self.addBillToDB(aFloat!)
                labelMessage?.text = "Bill added to database.\nBill Amount: £\(aFloat!)"
                textFieldAmount?.text = ""
            }
            else
            {
                labelMessage?.text = "Please enter valid Amount!"
            }
        }
        else
        {
            labelMessage?.text = "Amount field cannot be left blank!"
        }
    }
    func addBillToDB(floatAmount:Float)
    {
        let dateBillDate:NSDate = datePickerBillDate!.date
        let index:Int? = self.segmentedControlBillType?.selectedSegmentIndex
        let stringBillType:NSString? = segmentedControlBillType?.titleForSegmentAtIndex(index!)
        let stringBillAmount:NSString? = "\(floatAmount)"
        
        let mutableDictionaryBill:NSMutableDictionary = NSMutableDictionary()
        mutableDictionaryBill.setObject(stringUserName, forKey:"stringUserName")
        mutableDictionaryBill.setObject(dateBillDate, forKey:"dateBillDate")
        
        mutableDictionaryBill.setObject(stringBillType!, forKey:"stringBillType")
        mutableDictionaryBill.setObject(stringBillAmount!, forKey:"stringBillAmount")
        
        let maBills:NSMutableArray = UtilityMethods.getBillsFromUserDefaults()
        maBills.addObject(mutableDictionaryBill)
        UtilityMethods.setBillsToUserDefaults(maBills)

    }
}
