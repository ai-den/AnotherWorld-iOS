//
//  EditDiaryViewController.swift
//  AnotherWorld
//
//  Created by Aiden on 09/09/2021.
//

import UIKit

class EditDiaryViewController: UIViewController {

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var diaryCreation: UILabel!
    @IBOutlet weak var diaryModification: UILabel!
    @IBOutlet weak var bodyTextView: UITextView!
    @IBOutlet weak var imageSlider: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    var images: [UIImage] = [
        UIImage(named: "img1")!,
        UIImage(named: "img2")!,
        UIImage(named: "img3")!,
        UIImage(named: "img4")!,
        UIImage(named: "img5")!
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // PageControl
        pageControl.numberOfPages = images.count
        pageControl.currentPage = 0
        
        // ImageSlider
        imageSlider.delegate = self
        imageSlider.dataSource = self
        imageSlider.register(UINib(nibName: "\(DiaryCollectionViewCell.self)", bundle: nil), forCellWithReuseIdentifier: K.diaryCollectionCell)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.barStyle = .default
    }
    
    @IBAction func didChangePageControl(_ sender: UIPageControl) {
        imageSlider.scrollToItem(at: IndexPath(row: pageControl.currentPage, section: 0), at: .centeredHorizontally, animated: true)
    }
    
    @IBAction func cancelEditing(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func doneEditing(_ sender: Any) {
    }
    
}


// MARK: Collection Delegate
extension EditDiaryViewController: UICollectionViewDelegate {
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        // Updating pageControl current page
        let x = scrollView.contentOffset.x
        let w = scrollView.bounds.size.width
        print("X: \(x), W: \(w)")
        pageControl.currentPage = Int(x/w)
        
    }
    
}

// MARK: Collection DataSource
extension EditDiaryViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: K.diaryCollectionCell, for: indexPath) as! DiaryCollectionViewCell
        cell.diaryImageView.contentMode = .scaleAspectFit
        cell.diaryImageView.image = images[indexPath.row]
        return cell
    }
    
    
}


// MARK: Collection Flowlayout
extension EditDiaryViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.frame.size
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
}
