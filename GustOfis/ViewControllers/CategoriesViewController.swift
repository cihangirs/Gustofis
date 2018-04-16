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
    var selectedRow: Int = 0
    
    let categorieArray = ["KAHVALTILIKLAR", "SANDVİÇ", "OFİS PAKETLERİ", "SÜT ÜRÜNLERİ", "ATIŞTIRMALIKLAR", "MEYVE & SEBZE", "İÇECEKLER", "DİĞER ÜRÜNLER", "SON SİPARİŞLERİM"]
    
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
        
        cell.categorieLabel.text = self.categorieArray[indexPath.row]
//        cell.separatorInset = UIEdgeInsets.zero;
//        cell.contentView.backgroundColor = UIColor(red: 49/255, green: 49/255, blue: 57/255, alpha: 1.0)
//        cell.backgroundColor = UIColor(red: 49/255, green: 49/255, blue: 57/255, alpha: 1.0)
        // set the text from the data model
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categorieArray.count
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
        print("selected")
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
