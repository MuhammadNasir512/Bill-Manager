//
//  UsersTableViewController.swift
//  BillManager
//
//  Created by Muhammad Nasir on 25/07/2014.
//  Copyright (c) 2014 Muhammad Nasir. All rights reserved.
//

import UIKit

protocol UsersTableViewControllerDelegate
{
    func didSelectTableRowUsersTableVC(stringSelectedItem:NSString)
}

class UsersTableViewController: UIViewController, UITableViewDelegate
{
    @IBOutlet var tableviewUsers:UITableView? = UITableView()
    var delegate:UsersTableViewControllerDelegate?
    var mutableArrayUser:NSMutableArray = NSMutableArray()
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.startLoadingView()
    }
    
    func startLoadingView()
    {
        mutableArrayUser = UtilityMethods.getUsersFromUserDefaults()
        tableviewUsers!.reloadData()
    }
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int
    {
        return mutableArrayUser.count
    }
    
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell!
    {
        var cell:UITableViewCell = UITableViewCell()
        if (tableView.dequeueReusableCellWithIdentifier("CellID") != nil)
        {
            cell = tableView.dequeueReusableCellWithIdentifier("CellID")!
        }
        else
        {
            cell = UITableViewCell(style:UITableViewCellStyle.Default, reuseIdentifier:"CellID")
        }
        cell.textLabel?.text = mutableArrayUser.objectAtIndex(indexPath.row) as! NSString as String
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        delegate?.didSelectTableRowUsersTableVC(mutableArrayUser.objectAtIndex(indexPath.row) as! NSString)
    }
}
