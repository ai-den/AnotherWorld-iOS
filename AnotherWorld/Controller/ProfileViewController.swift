//
//  ProfileViewController.swift
//  AnotherWorld
//
//  Created by Aiden on 06/08/2021.
//

import UIKit

struct Setting {
    var title: String
    var image: String
    var count: Int?
    var clickable: Bool
}

class ProfileViewController: UIViewController {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var profileLabel: UILabel!
    @IBOutlet weak var settingTable: UITableView!
    
    var settingList: [[Setting]] = [
        [
            Setting(title: "Diary", image: "doc.richtext.fill", count: 0, clickable: false),
            Setting(title: "Experience", image: "timelapse", count: 0, clickable: false),
            Setting(title: "Places", image: "photo.circle.fill", count: 0, clickable: false)
        ],
        [
            Setting(title: "Favorites", image: "heart.circle.fill", count: nil, clickable: true),
            Setting(title: "Attractions", image: "mappin.circle.fill", count: nil, clickable: true),
            Setting(title: "Language", image: "globe", count: nil, clickable: true)
        ]
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settingTable.delegate = self
        settingTable.dataSource = self
        print(settingList.count)
    }

}

extension ProfileViewController: UITableViewDelegate {
    
}

extension ProfileViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(settingList[section].count)
        return settingList[section].count
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        print(settingList.count)
        return settingList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        var config = cell.defaultContentConfiguration()
        let sysImgName = settingList[indexPath.section][indexPath.row].image
        config.image = UIImage(systemName: sysImgName) ?? UIImage(named: "Places")
        config.imageProperties.cornerRadius = 10
//        config.imageProperties.reservedLayoutSize = CGSize(width: 10, height: 10)
        config.text = settingList[indexPath.section][indexPath.row].title
        cell.contentConfiguration = config
        return cell
    }




}
