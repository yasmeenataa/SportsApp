//
//  SportsController.swift
//  SportsApp
//
//  Created by Mac on 23/05/2023.
//

import UIKit
import Reachability

class SportsController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
   
    

    @IBOutlet weak var sportsCollection: UICollectionView!
    var sportsArray : [String] = ["Football", "Basketball", "Cricket", "Tennis"]
    let reachability = try! Reachability()
    override func viewDidLoad() {
        super.viewDidLoad()
        sportsCollection.dataSource = self
        sportsCollection.delegate = self
        self.navigationItem.title = "Sports"
        
      
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width:  (UIScreen.main.bounds.size.width/2 - 25), height: 180)
    }
    
    

    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sportsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? SportsCollectionViewCell
        cell?.sportImage.image = UIImage(named: sportsArray[indexPath.row])
        cell?.sportName.text = sportsArray[indexPath.row]
        return cell!
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let reachability = try! Reachability()
        if reachability.connection != .unavailable {
            print("Network is available")
            
            let defaults = UserDefaults.standard
            defaults.setValue(sportsArray[indexPath.row] ,forKey: "sportName")
            self.performSegue(withIdentifier: "league", sender: nil)
            
        } else {
            print("Network is not available")
            //alert
            let alert : UIAlertController = UIAlertController(title: "Internet Connection", message: "Check connection and try again", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel,handler: nil))
            self.present(alert, animated: true, completion: nil)
            
        }
        
    }
    
}
