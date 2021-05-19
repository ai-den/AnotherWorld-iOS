//
//  MapViewController.swift
//  AnotherWorld
//
//  Created by Aiden on 01/05/2021.
//

import UIKit
import GoogleMaps
import GooglePlaces

@IBDesignable
class MapViewController: UIViewController {

    private var searchBar: UISearchBar!
    var popUpView = UIView()
    private var resultTableView: UITableView!
    private var tableDataSource: GMSAutocompleteTableDataSource!
    
    
        
    override func viewDidLoad() {
        super.viewDidLoad()
        loadAllViews()
        print("SearchBar width \(searchBar.frame.width)  height \(searchBar.frame.height)")
        
        searchBar.delegate = self
        
    }
    
    func loadAllViews() {

        let camera = GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.20, zoom: 6.0)
        let mapView = GMSMapView.map(withFrame: view.frame, camera: camera)
        
        view.addSubview(mapView)
        
        
        // UISearchBar
        searchBar = UISearchBar()
        view.addSubview(searchBar)
        
        searchBar.searchBarStyle = .minimal
        searchBar.frame = CGRect(x: view.safeAreaLayoutGuide.layoutFrame.minX, y: view.safeAreaLayoutGuide.layoutFrame.minY, width: view.frame.width, height: 100.0)
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        searchBar.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true
        searchBar.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor).isActive = true
        searchBar.searchTextField.backgroundColor = .white

        
        
        // TableView
        resultTableView = UITableView(frame: CGRect(x: 0.0, y: searchBar.frame.height, width: self.view.frame.width, height: self.view.frame.height))

        resultTableView.backgroundColor = .white
        resultTableView.rowHeight = 127
        
        tableDataSource = GMSAutocompleteTableDataSource()
        tableDataSource.delegate = self
        
        resultTableView.delegate = tableDataSource
        resultTableView.dataSource = tableDataSource
//        resultTableView.register(UINib(nibName: K.attractionTableViewCellNIB, bundle: nil), forCellReuseIdentifier: K.attractionTableViewCell)
        
        
        // PopUpView
        popUpView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: self.view.frame.width, height: self.view.frame.height))
        popUpView.backgroundColor = .white
        popUpView.addSubview(resultTableView)
        popUpView.bringSubviewToFront(resultTableView)

        view.addSubview(popUpView)
        
        
        // Creates a marker in the center of the map.
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: -33.86, longitude: 151.20)
        marker.title = "Sydney"
        marker.snippet = "Australia"
        marker.map = mapView
        
        
        
        print(popUpView.frame.minX)
        print(popUpView.frame.minY)
        print(popUpView.frame.width)
        print(popUpView.frame.height)
        view.bringSubviewToFront(popUpView)
        view.bringSubviewToFront(searchBar)
        popUpView.isHidden = true
    }

}



// =========================================
// MARK: - SearchBar Delegate Methods
// =========================================
extension MapViewController: UISearchBarDelegate {

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        tableDataSource.sourceTextHasChanged(searchText)
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        // Either GoogleMaps results list appear here or
        // Go to the destination of "Attraction"
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        UIView.transition(with: popUpView, duration: 0.5, options: .transitionCrossDissolve, animations: {
            self.popUpView.isHidden = false
            self.navigationController!.navigationBar.isHidden = true
        }, completion: nil)
        
        searchBar.setShowsCancelButton(true, animated: true)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(false, animated: true)
        searchBar.endEditing(true)
        UIView.transition(with: popUpView, duration: 0.5, options: .transitionCrossDissolve, animations: {
            self.popUpView.isHidden = true
            self.navigationController!.navigationBar.isHidden = false
        }, completion: nil)
    }

}

// =========================================
// MARK: - GoogleMaps TableDataSource Delegate
// =========================================

extension MapViewController: GMSAutocompleteTableDataSourceDelegate {
    
    func didUpdateAutocompletePredictions(for tableDataSource: GMSAutocompleteTableDataSource) {
        
        resultTableView.reloadData()
    }
    
    func didRequestAutocompletePredictions(for tableDataSource: GMSAutocompleteTableDataSource) {
        
        resultTableView.reloadData()
    }
    
    
    func tableDataSource(_ tableDataSource: GMSAutocompleteTableDataSource, didAutocompleteWith place: GMSPlace) {
        
        print("Place name: \(String(describing: place.name))")
        print("Place address: \(String(describing: place.formattedAddress))")
        print("Place attributions: \(String(describing: place.attributions))")

    }
    
    func tableDataSource(_ tableDataSource: GMSAutocompleteTableDataSource, didFailAutocompleteWithError error: Error) {
        
        print("Error: \(error.localizedDescription)")
    }
    
    func tableDataSource(_ tableDataSource: GMSAutocompleteTableDataSource, didSelect prediction: GMSAutocompletePrediction) -> Bool {
        
        return true
    }

    
}




//// =========================================
//// MARK: - TableView DataSource
//// =========================================
//
//extension MapViewController: UITableViewDataSource {
//
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
//    }
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 1
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: K.attractionTableViewCell, for: indexPath) as! AttractionTableViewCell
//        cell.attractionTitle.text = "Shwe Dagon PagoaDagon Pagoa"
//        cell.attractionLocation.text = "Yangon, Myanmar"
//        cell.attractionStatus.text = "Visited 3 weeks ago"
//        cell.attractionImage.image = UIImage(named: "ShweDagonMM")
//        return cell
//    }
//
//
//}

// =========================================
// MARK: - TableView Delegate
// =========================================

//extension MapViewController: UITableViewDelegate {
//
//}



