//
//  FavoritesViewController.swift
//  AnotherWorld
//
//  Created by Aiden on 13/05/2021.
//

import UIKit

class FavoritesViewController: UIViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 127
        tableView.register(UINib(nibName: K.attractionTableViewCellNIB, bundle: nil), forCellReuseIdentifier: K.attractionTableViewCell)

    }
}

// =========================================
// MARK: - TableView Delegate
// =========================================
extension FavoritesViewController: UITableViewDelegate {
    
}


// =========================================
// MARK: - TablView DataSource
// =========================================
extension FavoritesViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.attractionTableViewCell, for: indexPath) as! AttractionTableViewCell
        cell.attractionTitle.text = "Eiffle Tower"
        cell.attractionLocation.text = "Paris, France"
        cell.attractionStatus.text = "New"
        cell.attractionImage.image = UIImage(imageLiteralResourceName: "EiffleTower1")
        return cell
    }

}