//
//  SearchResultsViewController.swift
//  BillManager
//
//  Created by Muhammad Nasir on 25/07/2014.
//  Copyright (c) 2014 Muhammad Nasir. All rights reserved.
//

import UIKit

let StringSearchTypeAllResults:NSString = "ALL"
let StringSearchTypeDatesResults:NSString = "DATES"

class SearchResultsViewController: UIViewController, UITableViewDelegate
{
    
    @IBOutlet var labelUserName:UILabel? = UILabel()
    @IBOutlet var tableviewResults:UITableView? = UITableView()

    var stringUserName:NSString = NSString()
    var stringSearchType:NSString = NSString()
    var dateFromDate:NSDate = NSDate()
    var dateToDate:NSDate = NSDate()
    var mutableArrayResults:NSMutableArray = NSMutableArray()
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    override func viewWillAppear(animated: Bool)
    {
        super.viewWillAppear(animated)
        self.navigationItem.title = "Search Results"
    }
    override func viewDidLoad()
    {
        super.viewDidLoad()
        labelUserName?.text = stringUserName
        mutableArrayResults = UtilityMethods.getBillsFromUserDefaults(stringUserName)
        if (mutableArrayResults.count == 0)
        {
            // results not found
            return;
        }

        if (stringSearchType == StringSearchTypeDatesResults)
        {
            var maFilteredResults:NSMutableArray = self.filterSearchResults()
            mutableArrayResults.removeAllObjects()
            mutableArrayResults.addObjectsFromArray(maFilteredResults)
        }
        tableviewResults?.reloadData()
    }
    func filterSearchResults() -> NSMutableArray
    {
        var maDataToReturn:NSMutableArray = NSMutableArray()
        for (index, value) in enumerate(mutableArrayResults)
        {
            let mdOneBill:NSMutableDictionary = value as NSMutableDictionary
            let dateBillDate:NSDate = mdOneBill.objectForKey("dateBillDate") as NSDate
            let dateOneDayBefore:NSDate = dateFromDate.dateByAddingTimeInterval(-24*60*60)
            let comparisonFromDate:NSComparisonResult = dateBillDate.compare(dateOneDayBefore)
            let comparisonToDate:NSComparisonResult = dateBillDate.compare(dateToDate)
            
            var isFromComparisonValid = false;
            var isToComparisonValid = false;
            
            if (comparisonFromDate == NSComparisonResult.OrderedDescending
                || comparisonFromDate == NSComparisonResult.OrderedSame)
            {
                isFromComparisonValid = true
            }

            if (comparisonToDate == NSComparisonResult.OrderedAscending
                || comparisonToDate == NSComparisonResult.OrderedSame)
            {
                isToComparisonValid = true
            }
            if (isFromComparisonValid == true && isToComparisonValid == true)
            {
                maDataToReturn.addObject(mdOneBill)
                println(mdOneBill)
            }

        }
        return maDataToReturn
    }
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int
    {
        return mutableArrayResults.count
    }
    
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell!
    {
        var cell:CustomCellSearchResults = CustomCellSearchResults()
        if (tableView.dequeueReusableCellWithIdentifier("CellID") != nil)
        {
            cell = tableView.dequeueReusableCellWithIdentifier("CellID") as CustomCellSearchResults
        }
        else
        {
            cell = CustomCellSearchResults(style:UITableViewCellStyle.Default, reuseIdentifier:"CellID")
        }
        let mdOneItem:NSMutableDictionary = mutableArrayResults.objectAtIndex(indexPath.row) as NSMutableDictionary
        let dateBillDate:NSDate = mdOneItem.objectForKey("dateBillDate") as NSDate
        let dateFormatter:NSDateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "dd-MMM-yyyy"
        let stringDate:NSString = dateFormatter.stringFromDate(dateBillDate)
        var stringAmount:NSString = mdOneItem.objectForKey("stringBillAmount") as NSString
        stringAmount = "£" + stringAmount
        let stringBillType:NSString = mdOneItem.objectForKey("stringBillType") as NSString

        cell.stringBillAmount = stringAmount
        cell.stringBillType = stringBillType
        cell.stringBillDate = stringDate
        cell.setupCell()

        return cell
    }
    
}
