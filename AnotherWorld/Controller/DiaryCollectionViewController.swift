//
//  DiaryCollectionViewController.swift
//  AnotherWorld
//
//  Created by Aiden on 04/09/2021.
//

import UIKit

private let reuseIdentifier = "diaryCollectionCell"
private let diaryHeader = "diarySectionHeader"

class DiaryCollectionViewController: UICollectionViewController {
    
    var diaryCollection: [[UIImage]]!
    var column = 3
    var lineSpacing = 2
    var interItemSpacing = 2
    var padding = 20

    override func viewDidLoad() {
        super.viewDidLoad()
        diaryCollection = generateDiary(noOfSection: 3)

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        

        // Register cell classes
        collectionView.register(UINib(nibName: "DiaryCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)
        
        collectionView.register(UINib(nibName: "DiaryCollectionHeader", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: diaryHeader)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if #available(iOS 13.0, *) {
           let app = UIApplication.shared
//            let statusBarHeight: CGFloat = app.windows[0].windowScene!.statusBarManager!.statusBarFrame.height
           let statusBarHeight: CGFloat = app.statusBarFrame.size.height
            
           let statusbarView = UIView()
            statusbarView.backgroundColor = UIColor(named: K.Colors.primary)
           view.addSubview(statusbarView)

           statusbarView.translatesAutoresizingMaskIntoConstraints = false
           statusbarView.heightAnchor
             .constraint(equalToConstant: statusBarHeight).isActive = true
           statusbarView.widthAnchor
             .constraint(equalTo: view.widthAnchor, multiplier: 1.0).isActive = true
           statusbarView.topAnchor
             .constraint(equalTo: view.topAnchor).isActive = true
           statusbarView.centerXAnchor
             .constraint(equalTo: view.centerXAnchor).isActive = true

        } else {
              let statusBar = UIApplication.shared.value(forKeyPath:
           "statusBarWindow.statusBar") as? UIView
            statusBar?.backgroundColor = UIColor(named: K.Colors.primary)
        }

        navigationController?.navigationBar.backgroundColor = UIColor(named: K.Colors.primary)
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.barTintColor = UIColor(named: K.Colors.primary)
    }
    
    func generateDiary(noOfSection section: Int) -> [[UIImage]]{
        var collection: [[UIImage]] = []
        for _ in 0...section-1 {
            let subCollection = [
                UIImage(named: "img1")!,
                UIImage(named: "img2")!,
                UIImage(named: "img3")!,
                UIImage(named: "img4")!
            ]
            collection.append(subCollection)
        }
        return collection
    }
    
    // MARK: Segue
    


    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        print("No of Sections: \(diaryCollection.count)")
        return diaryCollection.count
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return diaryCollection[section].count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! DiaryCollectionViewCell
        
        cell.diaryImageView.image = diaryCollection[indexPath.section][indexPath.row]
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        print("reached 1")
        if kind == UICollectionView.elementKindSectionHeader {
            print("reached 2")
            let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: diaryHeader, for: indexPath) as! DiaryCollectionHeader
            sectionHeader.yearTitle.text = "2012"
            sectionHeader.locationTitle.text = "Bangna"
            
            sectionHeader.setFonts(forYear: K.Fonts.sfprorounded_Bold,
                                   forLocation: K.Fonts.sfprorounded_Bold)
            return sectionHeader
        } else {
            let sectionFooter = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "footer", for: indexPath)
            return sectionFooter
        }
        
        
    }

    // MARK: UICollectionViewDelegate
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "detailDiary", sender: nil)
    }
    

}

extension DiaryCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat(lineSpacing)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat(interItemSpacing)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let side: CGFloat = (collectionView.frame.width - CGFloat(interItemSpacing * (column-1)) - CGFloat(padding*2))/CGFloat(column)
        print("Side of the item: \(side)")
        return CGSize(width: side, height: side)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        
        return UIEdgeInsets(top: 20, left: CGFloat(padding), bottom: 0, right: CGFloat(padding))
    }
}
