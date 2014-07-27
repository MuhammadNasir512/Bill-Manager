//
//  BillsViewController.swift
//  BillManager
//
//  Created by Muhammad Nasir on 19/07/2014.
//  Copyright (c) 2014 Muhammad Nasir. All rights reserved.
//

import UIKit

class BillsViewController: UIViewController, UsersTableViewControllerDelegate
{
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
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!)
    {
        if (segue?.identifier == "SegueBillsVCToUsersTableVC")
        {
            let userTableVC:UsersTableViewController = segue.destinationViewController as UsersTableViewController
            userTableVC.delegate = self
        }
    }
    func didSelectTableRowUsersTableVC(stringSelectedItem: NSString)
    {
        let storyboardMain:UIStoryboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        let addBillVC:AddBillViewController = storyboardMain.instantiateViewControllerWithIdentifier("StoryboardIDAddBillVC") as AddBillViewController
        addBillVC.stringUserName = stringSelectedItem
        self.navigationController.pushViewController(addBillVC, animated: true)
    }
}
