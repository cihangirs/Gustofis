//
//  LocationSelectionView.swift
//  GustOfis
//
//  Created by Cihangir Sungur on 10/04/2018.
//  Copyright © 2018 Cihangir Sungur. All rights reserved.
//

import UIKit

protocol LocationSelectionProtocol {
    func didLocationSelected(_ index: Int)
}

class LocationSelectionView: UIView, UITableViewDelegate, UITableViewDataSource {

    weak var delegate: NewMemberViewController?
    var selectedRow: Int = 0
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var okButton: UIButton!
    @IBOutlet weak var locationTableView: UITableView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    private func commonInit() {
        Bundle.main.loadNibNamed("LocationSelectionView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        self.okButton.layer.cornerRadius = 17.5
        self.okButton.layer.borderWidth = 0.5
        self.okButton.layer.borderColor = UIColor(red: 114/255, green: 113/255, blue: 143/255, alpha: 1.0).cgColor
        
        self.locationTableView.register(UINib(nibName: "LocationTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        //self.locationTableView.register(LocationTableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellReuseIdentifier = "cell"
        // create a new cell if needed or reuse an old one
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as? LocationTableViewCell  else {
            fatalError("The dequeued cell is not an instance of MealTableViewCell.")
        }
        
        cell.separatorInset = UIEdgeInsets.zero;
        cell.contentView.backgroundColor = UIColor(red: 49/255, green: 49/255, blue: 57/255, alpha: 1.0)
        cell.backgroundColor = UIColor(red: 49/255, green: 49/255, blue: 57/255, alpha: 1.0)
        cell.setLocationName((self.delegate?.locationArray[indexPath.row])!)
        // set the text from the data model
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.delegate?.locationArray.count)!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 64.5
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedRow = indexPath.row
        
        let cell:LocationTableViewCell = tableView.cellForRow(at: indexPath) as! LocationTableViewCell
        
        if(cell.isSelected){
            cell.contentView.backgroundColor = UIColor(red: 153/255, green: 204/255, blue: 0/255, alpha: 1.0)
        }else{
            cell.contentView.backgroundColor = UIColor.clear
            //cell.backgroundColor = UIColor.clear
        }
        print("selected")
    }
    
    @IBAction func okButtonTapped(_ sender: UIButton) {
        self.delegate?.didLocationSelected(self.selectedRow)
    }
    //    override func awakeFromNib() {
//        super.awakeFromNib()
//    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
