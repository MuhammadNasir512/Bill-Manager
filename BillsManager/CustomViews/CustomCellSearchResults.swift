//
//  CustomCellSearchResults.swift
//  BillManager
//
//  Created by Muhammad Nasir on 26/07/2014.
//  Copyright (c) 2014 Muhammad Nasir. All rights reserved.
//

import UIKit

class CustomCellSearchResults: UITableViewCell
{
    @IBOutlet var labelBillAmountValue:UILabel = UILabel()
    @IBOutlet var labelBillDateValue:UILabel = UILabel()
    @IBOutlet var labelBillTypeValue:UILabel = UILabel()

    var stringBillAmount:NSString = NSString()
    var stringBillType:NSString = NSString()
    var stringBillDate:NSString = NSString()
    
    func setupCell()
    {
        labelBillAmountValue.text = stringBillAmount
        labelBillTypeValue.text = stringBillType
        labelBillDateValue.text = stringBillDate
    }
}
