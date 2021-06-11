//
//  MapViewController.swift
//  AnotherWorld
//
//  Created by Aiden on 01/05/2021.
//

import UIKit
import GoogleMaps
import GooglePlaces
import CoreLocation

@IBDesignable
class MapViewController: UIViewController, UITableViewDelegate {
    

    private var searchBar: UISearchBar!
    private var resultTableView: UITableView!
    private var tableDataSource: GMSAutocompleteTableDataSource!
    private var placesClient: GMSPlacesClient!
    
    
    var popUpView = UIView()
    var searchResults = [Attraction]()
    var imageView = UIImageView()
    var mapView: GMSMapView!
    var camera: GMSCameraPosition!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        loadAllViews()
        print("SearchBar width \(searchBar.frame.width)  height \(searchBar.frame.height)")
        
        searchBar.delegate = self
        
    }
    
    
    // This is for manual table
    func placeAutocomplete(text: String) {
        
        searchResults.removeAll()
        var attr = Attraction()
        placesClient.findAutocompletePredictions(fromQuery: text, filter: nil, sessionToken: nil) {
            (results, error) in
            if let error = error {
                print("Autocomplete Error: \(error)")
                return
            }
            
            guard let results = results else {
                print("Search place not found.")
                return
            }
            
            print("No. of Results: \(results.count)")
            for result in results {
                let name = result.attributedPrimaryText.string
                let address = result.attributedSecondaryText!.string
                let placeID = result.placeID
                attr = Attraction(name: name, address: address, placeID: placeID, image: nil)
                print("Attr: \(attr.name) \(attr.address) \(attr.placeID)")
                self.searchResults.append(attr)
                
            }
            
            print("No. of SearchResultsArray: \(self.searchResults.count)")
        }
        print("No. of SearchResultsArray: \(self.searchResults.count)")
        self.resultTableView.reloadData()
    }
    
    func loadAllViews() {
        
        placesClient = GMSPlacesClient()
        

        camera = GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.20, zoom: 6.0)
        mapView = GMSMapView.map(withFrame: view.frame, camera: camera)
        
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
        
//        resultTableView.delegate = self
//        resultTableView.dataSource = self
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
//        placeAutocomplete(text: searchText)
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        // Either GoogleMaps results list appear here or
        // Go to the destination of "Attraction"
    }
    
    // Hiding the map and Displaying only the tableview with white bg   
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        UIView.transition(with: popUpView, duration: 0.5, options: .transitionCrossDissolve, animations: {
            self.popUpView.isHidden = false
            self.navigationController!.navigationBar.isHidden = true
        }, completion: nil)
        
        searchBar.setShowsCancelButton(true, animated: true)
    }
    
    // 
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
// MARK: - GMSAutoCompleteTableDataSourceDelegate
// =========================================

extension MapViewController: GMSAutocompleteTableDataSourceDelegate {

    func didUpdateAutocompletePredictions(for tableDataSource: GMSAutocompleteTableDataSource) {

        resultTableView.reloadData()
    }

    func didRequestAutocompletePredictions(for tableDataSource: GMSAutocompleteTableDataSource) {

        resultTableView.reloadData()
    }



    // Selecting a prediction
    //
    func tableDataSource(_ tableDataSource: GMSAutocompleteTableDataSource, didAutocompleteWith place: GMSPlace) {

        print("==============================================================")
        print("Place name: \(place.name ?? "nil")")
        print("Place address: \(place.formattedAddress ?? "nil")")
        print("Place attributions: \(place.attributions?.string ?? "nil")")
        
        
        if let types = place.types {
            var pace = 0
            for type in types {
                print("Place type \(pace): \(type)")
                pace += 1
            }
        } else {
            print("Place types: nil")
        }
        
        if let openingHours = place.openingHours {
            if let weekdayText = openingHours.weekdayText {
                print("Place weekday text (count): \(weekdayText.count)")
                var count = 0
                for text in weekdayText {
                    print("Opening hour (\(count)): \(text)")
                    count += 1
                }
                
            } else {
                print("Place weekday text: nil.")
            }
        } else {
            print("Place opening hours: nil")
        }
        
        
        // Core Location Reverse Geocoding Section
        print("-- Core Location Section --")
        
        let lat = place.coordinate.latitude
        let long = place.coordinate.longitude
        print("Placemark latitude: \(lat)")
        print("Placemark longitude: \(long)")
        CLGeocoder().reverseGeocodeLocation(CLLocation(latitude: lat, longitude: long)) { clplacemarks, error in
            
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            guard let placemarks = clplacemarks else {
                print("Placemarks is nil.")
                return
            }
            print("Placemark count: \(placemarks.count)")
            let placemark = placemarks[0]
            print("Placemark name: \(placemark.name ?? "nil")")
            print("Placemark administrative area: \(placemark.administrativeArea ?? "nil")")
            print("Placemark subadministrative area: \(placemark.subAdministrativeArea ?? "nil")")
            print("Placemark throughfare: \(placemark.thoroughfare ?? "nil")")
            print("Placemark subThroughfare: \(placemark.subThoroughfare ?? "nil")")
            print("Placemark sublocality: \(placemark.subLocality ?? "nil")")
            print("Placemark region: \(placemark.region?.identifier ?? "nil")")
            
            guard let interests = placemark.areasOfInterest else {
                print("** There's no area of interests **")
                return
            }
            
            var i = 0
            for interest in interests {
                print("Interest \(i): \(interest)")
                i += 1
            }
            
            
            
        }
        
        
        // Actual stuff
        var zoom: Float = 0.0
        if isRegion(place) {
            zoom = K.regionZoomLevel
        } else {
            zoom = K.placeZoomLevel
        }
        
        
        
        

        searchBar.delegate!.searchBarCancelButtonClicked?(searchBar)
        mapView.clear()
        let locationMarker = GMSMarker(position: CLLocationCoordinate2D(latitude: lat, longitude: long))
        locationMarker.map = mapView
        camera = GMSCameraPosition(latitude: lat,
                                   longitude: long,
                                   zoom: zoom)
        mapView.animate(to: camera)
        
        
        
        
    }
    
    
    // To identify 'place' and 'area'
    func isRegion(_ place: GMSPlace) -> Bool {
        print("Checking a place is region...")
        guard let placeTypes = place.types else {
            print("Parameter - place: GMSPlace has types as nil.")
            fatalError()
        }
        let type0 = placeTypes[0]
        let type1 = placeTypes[1]
        
        return K.regionIdentifications.contains(type0) || K.regionIdentifications.contains(type1)
    }
    
    // Find places near the location


    // Error on showing autocomplete results
    //
    func tableDataSource(_ tableDataSource: GMSAutocompleteTableDataSource, didFailAutocompleteWithError error: Error) {

        print("Error: \(error.localizedDescription)")
    }


    // Selecting a prediction
    //
    func tableDataSource(_ tableDataSource: GMSAutocompleteTableDataSource, didSelect prediction: GMSAutocompletePrediction) -> Bool {

        return true
    }


}




//=========================================
// MARK: - TableView DataSource
// =========================================

//extension MapViewController: UITableViewDataSource {
//
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
//    }
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        print("No. of table elements: \(searchResults.count)")
//        return searchResults.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: K.attractionTableViewCell, for: indexPath) as! AttractionTableViewCell
//        cell.attractionTitle.text = searchResults[indexPath.row].name
//        cell.attractionLocation.text = searchResults[indexPath.row].address
//        cell.attractionStatus.text = "New"
//        cell.attractionImage.image = searchResults[indexPath.row].image
//        print("Filling TablView OK")
//        return cell
//    }
//
//
//}




