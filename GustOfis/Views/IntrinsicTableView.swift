//
//  IntrinsicTableView.swift
//  GustOfis
//
//  Created by Cihangir Sungur on 17.05.2018.
//  Copyright © 2018 Cihangir Sungur. All rights reserved.
//

import UIKit

class IntrinsicTableView: UITableView {

    override var contentSize:CGSize {
        didSet {
            self.invalidateIntrinsicContentSize()
        }
    }
    
    override var intrinsicContentSize: CGSize {
        self.layoutIfNeeded()
        return CGSize(width: UIViewNoIntrinsicMetric, height: contentSize.height)
    }

}
