//
//  UtilityMethods.swift
//  BillManager
//
//  Created by Muhammad Nasir on 20/07/2014.
//  Copyright (c) 2014 Muhammad Nasir. All rights reserved.
//

import UIKit

class UtilityMethods
{
    class func getUsersFromUserDefaults() -> NSMutableArray
    {
        let userDefaults = NSUserDefaults.standardUserDefaults()
        var mutableArrayUsers:NSMutableArray = NSMutableArray()
        if userDefaults.objectForKey("MutableArrayUsersData")
        {
            mutableArrayUsers = userDefaults.objectForKey("MutableArrayUsersData") as NSMutableArray
        }
        return mutableArrayUsers;
    }
    class func setUsersToUserDefaults(mutableArrayUsers:NSMutableArray)
    {
        let userDefaults = NSUserDefaults.standardUserDefaults()
        userDefaults.setObject(mutableArrayUsers, forKey: "MutableArrayUsersData")
        userDefaults.synchronize()
    }
    
    class func getBillsFromUserDefaults() -> NSMutableArray
    {
        let userDefaults = NSUserDefaults.standardUserDefaults()
        var mutableArrayUsers:NSMutableArray = NSMutableArray()
        if userDefaults.objectForKey("MutableArrayBillsData")
        {
            mutableArrayUsers = userDefaults.objectForKey("MutableArrayBillsData") as NSMutableArray
        }
        return mutableArrayUsers;
    }
    class func setBillsToUserDefaults(mutableArrayBills:NSMutableArray)
    {
        let userDefaults = NSUserDefaults.standardUserDefaults()
        userDefaults.setObject(mutableArrayBills, forKey: "MutableArrayBillsData")
        userDefaults.synchronize()
    }
    
    class func getBillsFromUserDefaults(stringUserName:NSString) -> NSMutableArray
    {
        var maDataToReturn:NSMutableArray = NSMutableArray()
        let maAllUsers:NSMutableArray = UtilityMethods.getBillsFromUserDefaults()
        for (index, value) in enumerate(maAllUsers)
        {
            let mdOneBill:NSMutableDictionary = value as NSMutableDictionary
            let stringUserNameFromDictionary:NSString = mdOneBill.objectForKey("stringUserName") as NSString
            if (stringUserNameFromDictionary == stringUserName)
            {
                maDataToReturn.addObject(mdOneBill)
            }
        }
        return maDataToReturn;
    }
}
