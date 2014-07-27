//
//  StatisticsDetailsViewController.swift
//  BillManager
//
//  Created by Muhammad Nasir on 26/07/2014.
//  Copyright (c) 2014 Muhammad Nasir. All rights reserved.
//

import UIKit

class StatisticsDetailsViewController: UIViewController
{
    @IBOutlet var labelUserName:UILabel = UILabel()
    @IBOutlet var labelTotalAmountAllBills:UILabel = UILabel()
    @IBOutlet var labelTotalAmountGas:UILabel = UILabel()
    @IBOutlet var labelTotalAmountElectricity:UILabel = UILabel()
    @IBOutlet var labelTotalAmountWater:UILabel = UILabel()
    @IBOutlet var labelAverageAmountAllBills:UILabel = UILabel()
    @IBOutlet var labelAverageAmountGas:UILabel = UILabel()
    @IBOutlet var labelAverageAmountElectricity:UILabel = UILabel()
    @IBOutlet var labelAverageAmountWater:UILabel = UILabel()
    @IBOutlet var labelDailyAverageAllBills:UILabel = UILabel()
    @IBOutlet var labelDailyAverageGas:UILabel = UILabel()
    @IBOutlet var labelDailyAverageElectricity:UILabel = UILabel()
    @IBOutlet var labelDailyAverageWater:UILabel = UILabel()

    var stringUserName:NSString = NSString()
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    override func viewWillAppear(animated: Bool)
    {
        super.viewWillAppear(animated)
        self.navigationItem.title = "Statistics Results"
    }
    override func viewDidLoad()
    {
        super.viewDidLoad()
        labelUserName.text = stringUserName
        self.doStatistics()
    }
    func doStatistics()
    {
        var maAllBillsForThisUser:NSMutableArray = UtilityMethods.getBillsFromUserDefaults(stringUserName)
        self.sortWRTDate(maAllBillsForThisUser)
        
        var totalBill:Float = 0.0
        var totalGas:Float = 0.0
        var totalElec:Float = 0.0
        var totalWater:Float = 0.0
        
        var gasCount:Int = 0
        var elecCount:Int = 0
        var waterCount:Int = 0

        var dateFirstBill:NSDate = NSDate()
        
        for (index, value) in enumerate(maAllBillsForThisUser)
        {
            let mdOneBill:NSMutableDictionary = value as NSMutableDictionary
            if index == 0
            {
                dateFirstBill = mdOneBill.objectForKey("dateBillDate") as NSDate
            }
            
            var floatBillAmount:Float = mdOneBill.objectForKey("stringBillAmount").floatValue
            totalBill += floatBillAmount
            
            var stringBillType:NSString = mdOneBill.objectForKey("stringBillType") as NSString
            if (stringBillType.isEqualToString("Gas"))
            {
                totalGas += floatBillAmount
                gasCount++
            }
            if (stringBillType.isEqualToString("Electricity"))
            {
                totalElec += floatBillAmount
                elecCount++
            }
            if (stringBillType.isEqualToString("Water"))
            {
                totalWater += floatBillAmount
                waterCount++
            }
            labelTotalAmountAllBills.text = NSString(format: "£%.2f", totalBill)
            labelTotalAmountElectricity.text = NSString(format: "£%.2f", totalElec)
            labelTotalAmountWater.text = NSString(format: "£%.2f", totalWater)
            labelTotalAmountGas.text = NSString(format: "£%.2f", totalGas)
            
            var allAvg:Float = totalBill / Float(maAllBillsForThisUser.count)
            var gasAvg:Float = totalGas / Float(gasCount)
            var elecAvg:Float = totalElec / Float(elecCount)
            var waterAvg:Float = totalWater / Float(waterCount)
            if (allAvg.isNaN == true) { allAvg = 0.0 }
            if (gasAvg.isNaN == true) { gasAvg = 0.0 }
            if (elecAvg.isNaN == true) { elecAvg = 0.0 }
            if (waterAvg.isNaN == true) { waterAvg = 0.0 }

            labelAverageAmountAllBills.text = NSString(format: "£%.2f", allAvg)
            labelAverageAmountElectricity.text = NSString(format: "£%.2f", elecAvg)
            labelAverageAmountWater.text = NSString(format: "£%.2f", waterAvg)
            labelAverageAmountGas.text = NSString(format: "£%.2f", gasAvg)
            
            let dateToday:NSDate = NSDate()
            var days:Int = self.daysBetweenDate(dateFirstBill, toDateTime:dateToday)
            days = abs(days);

            var allDailyAvg:Float = totalBill / Float(days)
            var gasDailyAvg:Float = totalGas / Float(days)
            var elecDailyAvg:Float = totalElec / Float(days)
            var waterDailyAvg:Float = totalWater / Float(days)

            labelDailyAverageAllBills.text = NSString(format: "£%.2f", allDailyAvg)
            labelDailyAverageElectricity.text = NSString(format: "£%.2f", elecDailyAvg)
            labelDailyAverageWater.text = NSString(format: "£%.2f", waterDailyAvg)
            labelDailyAverageGas.text = NSString(format: "£%.2f", gasDailyAvg)
        }

    }
    func sortWRTDate(maBills:NSMutableArray)
    {
        for var ii=0; ii<maBills.count; ii++
        {
            let mdOneBill1:NSMutableDictionary = maBills.objectAtIndex(ii) as NSMutableDictionary
            let dateBillDate1:NSDate = mdOneBill1.objectForKey("dateBillDate") as NSDate
            
            for var jj=ii+1; jj<maBills.count; jj++
            {
                let mdOneBill2:NSMutableDictionary = maBills.objectAtIndex(jj) as NSMutableDictionary
                let dateBillDate2:NSDate = mdOneBill2.objectForKey("dateBillDate") as NSDate
                
                if (dateBillDate1.compare(dateBillDate2) == NSComparisonResult.OrderedDescending)
                {
                    maBills.exchangeObjectAtIndex(jj, withObjectAtIndex: ii)
                }
            }
        }
    }
    func daysBetweenDate(fromDateTime:NSDate, toDateTime:NSDate) -> Int
    {
        var fromDate:NSDate
        var toDate:NSDate
        
        var calendar:NSCalendar = NSCalendar.currentCalendar()
        let components = calendar.components(NSCalendarUnit.DayCalendarUnit, fromDate: fromDateTime, toDate: toDateTime, options: nil)
        var days:Int = components.day
        days += 1 // include start day
        return days;
    }
}
