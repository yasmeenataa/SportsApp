//
//  FavViewController.swift
//  SportsApp
//
//  Created by Mac on 25/05/2023.
//

import UIKit
import Reachability

class FavViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource{
   
    var leagues: [LocalLeague] = []
    var favouriteViewModel: FavouriteViewModel!
    @IBOutlet weak var favTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        favTable.delegate = self
        favTable.dataSource = self
        favouriteViewModel = FavouriteViewModel(coreData: CoreData())
        let noFavImage = UIImageView()
        noFavImage.image = UIImage(named: "noFav")
        noFavImage.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(noFavImage)
        let noFavLabel = UILabel()
        noFavLabel.translatesAutoresizingMaskIntoConstraints = false
        noFavLabel.text = "no favorite leagues"
        noFavLabel.contentMode = .scaleAspectFit
        noFavLabel.textAlignment = .center
        view.addSubview(noFavLabel)
        NSLayoutConstraint.activate([
            noFavImage.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            noFavImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            noFavImage.widthAnchor.constraint(equalToConstant: 100),
            noFavImage.heightAnchor.constraint(equalToConstant: 100),
            noFavLabel.topAnchor.constraint(equalTo: noFavImage.bottomAnchor, constant: 8),
            noFavLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            noFavLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
        favouriteViewModel.refreshFavouriteLeagues = {
            [weak self] in
            DispatchQueue.main.async {
                self?.leagues = self?.favouriteViewModel.leagues ?? []
                self?.favTable.reloadData()
                if self?.leagues.count == 0{
                    noFavImage.isHidden = false
                    noFavLabel.isHidden = false
                    
                    self?.favTable.isHidden = true
                }else{
                    noFavImage.isHidden = true
                    noFavLabel.isHidden = true
                    self?.favTable.isHidden = false
                }
            }
        }
    }
    override func viewWillAppear(_ animated: Bool) {
         favouriteViewModel.getLeagues()
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       return 114
   }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return leagues.count
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavCell", for: indexPath) as! FavTableViewCell
        
        cell.favLeagueName.text = leagues[indexPath.row].leagueName
        
        let url = URL(string: leagues[indexPath.row].leagueLogo)
        cell.favLeagueImage.kf.setImage(with: url,
                                     placeholder: UIImage(named: "noimage"))
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        let alert : UIAlertController = UIAlertController(title: "Delete League from favourites", message: "Are you sure you want to delete it ?", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "YES", style: .default,handler: { [weak self] action in
            
            self?.favouriteViewModel.deleteLeague(leagueName: self?.leagues[indexPath.row].leagueName ?? "", leagueKey: self?.leagues[indexPath.row].leagueKey ?? 0)
            self?.leagues.remove(at: indexPath.row)
            self?.favTable.reloadData()
            
        }))
        alert.addAction(UIAlertAction(title: "NO", style: .cancel,handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let reachability = try! Reachability()
        if reachability.connection != .unavailable {
            print("Network is available")
            
             let defaults = UserDefaults.standard
           
            defaults.setValue(leagues[indexPath.row].sportName ,forKey: "sportName")
            defaults.setValue(leagues[indexPath.row].leagueKey ,forKey: "leagueID")
            defaults.setValue(leagues[indexPath.row].leagueName ,forKey: "leagueName")
            defaults.setValue(leagues[indexPath.row].leagueLogo ,forKey: "leagueLogo")
            self.performSegue(withIdentifier: "favleaguesDetails", sender: nil)
            
        } else {
            print("Network is not available")
            //alert
            let alert : UIAlertController = UIAlertController(title: "Internet Connection", message: "Check connection and try again", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: .cancel,handler: nil))
            self.present(alert, animated: true, completion: nil)
            
            
        }
        
        reachability.whenReachable = { reachability in
            print("Network is available")
        }
        reachability.whenUnreachable = { reachability in
            print("Network is not available")
            
        }
        do {
            try reachability.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
        
    }
}
