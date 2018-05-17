//
//  InnerBottomView.swift
//  GustOfis
//
//  Created by Cihangir Sungur on 15.05.2018.
//  Copyright © 2018 Cihangir Sungur. All rights reserved.
//

import UIKit

class InnerBottomView: UIView, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var goesWellByTableView: UITableView!
    
    weak var delegate: ProductDetailViewController?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed("InnerBottomView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        self.goesWellByTableView.register(UINib(nibName: "GoesWellByTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellReuseIdentifier = "cell"
        // create a new cell if needed or reuse an old one
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as? GoesWellByTableViewCell else {
            fatalError("The dequeued cell is not an instance of MealTableViewCell.")
        }
        
//        cell.nutritionName.text = self.nutritionsArray[indexPath.row].name
//        cell.nutritionValue.text = self.nutritionsArray[indexPath.row].value
        
        return cell
    }
 
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3 //self.productArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    // Set the spacing between sections
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 15
    }
    
    // Make the background color show through
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
}
