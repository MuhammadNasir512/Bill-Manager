//
//  AddUserViewController.swift
//  BillManager
//
//  Created by Muhammad Nasir on 19/07/2014.
//  Copyright (c) 2014 Muhammad Nasir. All rights reserved.
//

import UIKit

class AddUserViewController: UIViewController, UITextFieldDelegate
{
    @IBOutlet var textFieldUserName:UITextField! = UITextField()
    @IBOutlet var labelMessage:UILabel! = UILabel()
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
    func textFieldDidBeginEditing(textField: UITextField)
    {
        textFieldUserName.text = ""
        labelMessage.text = ""
        let tapGestureRecognizer:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "tapGestureSelector:")
        self.view.addGestureRecognizer(tapGestureRecognizer)
    }
    func tapGestureSelector(tapGestureRecognizer: UITapGestureRecognizer!)-> Void
    {
        self.view.removeGestureRecognizer(tapGestureRecognizer)
        textFieldUserName.resignFirstResponder()
    }

    @IBAction func buttonAddUserActionSelector(button: UIButton!)
    {
        textFieldUserName.resignFirstResponder()
        var stringUserName:NSString = textFieldUserName.text!
        stringUserName = stringUserName.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        
        if (stringUserName.length > 0)
        {
            let maUsers:NSMutableArray = UtilityMethods.getUsersFromUserDefaults()
            maUsers.addObject(stringUserName)
            UtilityMethods.setUsersToUserDefaults(maUsers)
            labelMessage.text = "User added to database.\nUser Name: " + (stringUserName as String)
            textFieldUserName.text = ""
        }
        else
        {
            labelMessage.text = "Error adding user to database. Please verify input data."
        }
    }
}
