//
//  FiltersViewController.swift
//  GustOfis
//
//  Created by Cihangir Sungur on 13/04/2018.
//  Copyright © 2018 Cihangir Sungur. All rights reserved.
//

import UIKit

class FiltersViewController: ViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var filterTableView: UITableView!
    weak var delegate: HomeViewController?
    
    var selectedRow: Int = 0
    var filterArray = [Filter]()
    //let filterArray = ["Gluten Free", "Dairy Free", "Sugar Free", "Vegan"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.filterTableView.register(UINib(nibName: "FilterTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellReuseIdentifier = "cell"
        // create a new cell if needed or reuse an old one
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as? FilterTableViewCell  else {
            fatalError("The dequeued cell is not an instance of MealTableViewCell.")
        }
        
        cell.contentView.backgroundColor = UIColor(red: 221/255, green: 221/255, blue: 221/255, alpha: 1.0)
        cell.filterName.text = self.filterArray[indexPath.row].filterName
        cell.filterImageView.image = UIImage(named:"filterImageView\(indexPath.row + 1)")
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filterArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 63
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        self.selectedRow = indexPath.row
//
//        let cell:CategoryTableViewCell = tableView.cellForRow(at: indexPath) as! CategoryTableViewCell
//
//        if(cell.isSelected){
//            cell.contentView.backgroundColor = UIColor(red: 153/255, green: 204/255, blue: 0/255, alpha: 1.0)
//        }else{
//            cell.contentView.backgroundColor = UIColor.clear
//        }
//        print("selected")
//    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
