//
//  SearchOptionsViewController.swift
//  BillManager
//
//  Created by Muhammad Nasir on 26/07/2014.
//  Copyright (c) 2014 Muhammad Nasir. All rights reserved.
//

import UIKit

class SearchOptionsViewController: UIViewController
{
    @IBOutlet var labelUserName:UILabel? = UILabel()
    @IBOutlet var datePickerFromDate:UIDatePicker? = UIDatePicker()
    @IBOutlet var datePickerToDate:UIDatePicker? = UIDatePicker()
    
    var stringUserName:NSString = NSString()
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    override func viewWillAppear(animated: Bool)
    {
        super.viewWillAppear(animated)
        self.navigationItem.title = "Search Options"
    }
    override func viewDidLoad()
    {
        super.viewDidLoad()
        labelUserName?.text = stringUserName
    }
    
    // This method overridden to stop navigating to next view if input is invalid
    override func shouldPerformSegueWithIdentifier(identifier: String!, sender: AnyObject!) -> Bool
    {
        if (identifier == "SegueShowAll")
        {
            return true
        }
        let dateFrom:NSDate = datePickerFromDate!.date;
        let dateTo:NSDate = datePickerToDate!.date
        var stringMessage:NSString = ""
        
        if (dateFrom.compare(dateTo) == NSComparisonResult.OrderedSame)
        {
            stringMessage = "To date has to be later than from date. You may tap 'Show All' button to see all results"
        }
        if (dateFrom.compare(dateTo) == NSComparisonResult.OrderedDescending)
        {
            stringMessage = "To date has to be later than from date"
        }
        if (stringMessage.length > 0)
        {
            var alert = UIAlertController(
                title: "Invalid Dates",
                message: stringMessage,
                preferredStyle: UIAlertControllerStyle.Alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
            
            return false
            
        }
        return true
    }
    // This method overridden to set properties of next view controller
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!)
    {
        let searchResultsVC:SearchResultsViewController = segue.destinationViewController as SearchResultsViewController
        searchResultsVC.stringUserName = stringUserName
        
        if (segue.identifier == "SegueSearchWithDates")
        {
            searchResultsVC.dateFromDate = datePickerFromDate!.date
            searchResultsVC.dateToDate = datePickerToDate!.date
            searchResultsVC.stringSearchType = StringSearchTypeDatesResults
        }
        else
        {
            searchResultsVC.stringSearchType = StringSearchTypeAllResults
        }

    }
}
