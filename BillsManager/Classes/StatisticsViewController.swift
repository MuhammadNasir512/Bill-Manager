//
//  StatisticsViewController.swift
//  BillManager
//
//  Created by Muhammad Nasir on 26/07/2014.
//  Copyright (c) 2014 Muhammad Nasir. All rights reserved.
//

import UIKit

class StatisticsViewController: UIViewController, UsersTableViewControllerDelegate
{
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!)
    {
        if (segue.identifier == "SegueStatisticsVCToUsersTableVC")
        {
            let userTableVC:UsersTableViewController = segue.destinationViewController as! UsersTableViewController
            userTableVC.delegate = self
        }
    }
    func didSelectTableRowUsersTableVC(stringSelectedItem: NSString)
    {
        let storyboardMain:UIStoryboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        let searchOptionsVC:StatisticsDetailsViewController = storyboardMain.instantiateViewControllerWithIdentifier("StoryboardIDStatisticsVC") as! StatisticsDetailsViewController
        searchOptionsVC.stringUserName = stringSelectedItem
        self.navigationController?.pushViewController(searchOptionsVC, animated: true)
    }

}
