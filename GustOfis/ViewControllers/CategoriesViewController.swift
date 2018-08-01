//
//  CategoriesViewController.swift
//  GustOfis
//
//  Created by Cihangir Sungur on 13/04/2018.
//  Copyright © 2018 Cihangir Sungur. All rights reserved.
//

import UIKit

class CategoriesViewController: ViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var categoryTableView: UITableView!
    
    weak var delegate: HomeViewController?
    var selectedRow: Int = 0
    var categorieArray = [Categorie]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.categoryTableView.register(UINib(nibName: "CategoryTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellReuseIdentifier = "cell"
        // create a new cell if needed or reuse an old one
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as? CategoryTableViewCell  else {
            fatalError("The dequeued cell is not an instance of MealTableViewCell.")
        }
        
        cell.categorie = self.categorieArray[indexPath.row]
        cell.categorieLabel.text = self.categorieArray[indexPath.row].name
    
//        cell.separatorInset = UIEdgeInsets.zero;
//        cell.contentView.backgroundColor = UIColor(red: 49/255, green: 49/255, blue: 57/255, alpha: 1.0)
//        cell.backgroundColor = UIColor(red: 49/255, green: 49/255, blue: 57/255, alpha: 1.0)
        // set the text from the data model
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.categorieArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 42.5
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedRow = indexPath.row
        
        let cell:CategoryTableViewCell = tableView.cellForRow(at: indexPath) as! CategoryTableViewCell
        
        if(cell.isSelected){
            cell.contentView.backgroundColor = UIColor(red: 153/255, green: 204/255, blue: 0/255, alpha: 1.0)
        }else{
            cell.contentView.backgroundColor = UIColor.clear
        }
        
        print("cell.categorie: \(cell.categorie)")

        //self.delegate?.fetchCategorieProducts(categorieId: cell.categorie.categorieId!)
    }

}
