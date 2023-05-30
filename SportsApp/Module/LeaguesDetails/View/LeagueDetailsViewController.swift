//
//  LeagueDetailsViewController.swift
//  SportsApp
//
//  Created by Mac on 24/05/2023.
//

import UIKit
import Kingfisher

class LeagueDetailsViewController: UIViewController  ,UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    @IBOutlet weak var teamsLabel: UILabel!
    @IBOutlet weak var latestLabel: UILabel!
    
    @IBOutlet weak var upCommingLabel: UILabel!
    
    @IBOutlet weak var TeamsCollection: UICollectionView!
    @IBOutlet weak var LetestCollection: UICollectionView!
    @IBOutlet weak var upcommingCollection: UICollectionView!
    @IBOutlet weak var favButton: UIButton!
    var boolFav = false
    var leagueDetailsViewModel: LeagueDetailsViewModel!
    var upComing: [Event] = []
    var latest: [Event] = []
    var sportName: String!
    var leagueID: Int!
    var leagueDisplaying: LocalLeague!
    var teams: [Teams] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        upcommingCollection.dataSource = self
        upcommingCollection.delegate = self
        
        TeamsCollection.dataSource = self
        TeamsCollection.delegate = self
        
        LetestCollection.dataSource = self
        LetestCollection.delegate = self
        
        let defaults = UserDefaults.standard
        sportName = defaults.value(forKey:"sportName") as? String
        leagueID = defaults.value(forKey:"leagueID") as? Int
        let leagueName = defaults.value(forKey:"leagueName" ) as? String ?? ""
        let leagueLogo = defaults.value(forKey:"leagueLogo" ) as? String ?? ""
        leagueDisplaying = LocalLeague(leagueKey: leagueID, leagueName: leagueName, sportName: sportName, leagueLogo: leagueLogo)
        
        leagueDetailsViewModel = LeagueDetailsViewModel(sport: sportName.lowercased(),leagueId: leagueID, coredata: CoreData())
        
        leagueDetailsViewModel.upComingArrayToViewController = {
            [weak self ] in
            DispatchQueue.main.async {
                self?.upComing = self?.leagueDetailsViewModel.upComingEvents ?? []
                print("////////comming\(String(describing: self?.upComing.count))")
                if self?.upComing.count == 0{
                    print (" not returned")
                    self?.upCommingLabel.isHidden = true
                    self?.upcommingCollection.isHidden = true
                }
                else{
                    self?.upCommingLabel.isHidden = false
                    self?.upcommingCollection.isHidden = false
                    print ("returned")
                    self?.upcommingCollection.reloadData()
                }
               
            }
        }
        if upComing.count == 0{
            print (" not returned")
            upCommingLabel.isHidden = true
            upcommingCollection.isHidden = true
        }
        leagueDetailsViewModel.latestArrayToViewController = {
            [weak self ] in
            DispatchQueue.main.async {
                
                self?.latest = self?.leagueDetailsViewModel.latestEvents ?? []
                print("////////latest\(String(describing: self?.latest.count))")
                if self?.latest.count == 0{
                    print (" not returned")
                    self?.latestLabel.isHidden = true
                    self?.LetestCollection.isHidden = true
                }
                else{
                    self?.latestLabel.isHidden = false
                    self?.LetestCollection.isHidden = false
                    self?.LetestCollection.reloadData()
                }
            }
        }
        if latest.count == 0{
            print (" not returned")
            latestLabel.isHidden = true
            LetestCollection.isHidden = true
        }
        leagueDetailsViewModel.teamArrayToViewController = {
            [weak self ] in
            DispatchQueue.main.async {
                
                self?.teams = self?.leagueDetailsViewModel.teams ?? []
                print("////////team\(String(describing: self?.teams.count))")
                self?.TeamsCollection.reloadData()
                
                if self?.teams.count == 0   {
                    self?.teamsLabel.isHidden = true
                    self?.TeamsCollection.isHidden = true
                }
                else{
                    self?.teamsLabel.isHidden = false
                    self?.TeamsCollection.isHidden = false
                    self?.TeamsCollection.reloadData()
                }
                
            }
        }
        if teams.count == 0   {
            teamsLabel.isHidden = true
            TeamsCollection.isHidden = true
        }
        leagueDetailsViewModel.getUpComingEvents()
        leagueDetailsViewModel.getLatestEvents()
        leagueDetailsViewModel.getTeams()
       
    }
    override func viewWillAppear(_ animated: Bool) {
        let isFav =  leagueDetailsViewModel.getSelectedLeague(leagueName: leagueDisplaying.leagueName, leagueKey: leagueDisplaying.leagueKey)
         
            if isFav == nil {
                boolFav = false
                favButton.setImage(UIImage(systemName: "heart"), for: .normal)
            }else{
                boolFav = true
                favButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        }
    }
    

    @IBAction func back_action(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func heartButtonClicked(_ sender: Any) {
        if !boolFav {
            print("added to fav from leg details vc")
            let img = UIImage(systemName: "heart.fill")
            leagueDetailsViewModel.addToFav(league: leagueDisplaying)
            favButton.setImage(img, for: .normal)
            boolFav = true
        }else{
            boolFav = false
            let alert : UIAlertController = UIAlertController(title: "Delete League from favourites", message: "ARE YOU SURE TO DELETE?", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "YES", style: .default,handler: { [weak self] action in
                print("delete begin")
                print("heart fill")
                let img = UIImage(systemName: "heart")
                self?.favButton.setImage(img, for: .normal)
                self?.leagueDetailsViewModel.deleteFavLeague(leagueName: self?.leagueDisplaying.leagueName ?? "", leagueKey: self?.leagueDisplaying.leagueKey ?? 0)
                
            }))
            alert.addAction(UIAlertAction(title: "NO", style: .cancel,handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == self.TeamsCollection {
            return CGSize(width: collectionView.frame.width / 2, height: collectionView.frame.height)
        }
        else if collectionView == self.LetestCollection {
            return CGSize(width: collectionView.frame.width , height: collectionView.frame.height/2)
        }
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height )
    }
   func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
       if collectionView == self.LetestCollection{
           return 2
       }
       return 0
       }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.upcommingCollection {
            return upComing.count
        }else if collectionView == LetestCollection{
            return latest.count
        }else {
            return teams.count

        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.upcommingCollection {
            let event = upComing[indexPath.row]
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UpCommingCell", for: indexPath) as! UpCommingViewCell
            let url = URL(string: event.homeTeamLogo ?? "")
            cell.teamOneImage.kf.setImage(with: url,
                                            placeholder: UIImage(named: "noImg"))
            let url2 = URL(string: event.awayTeamLogo ?? "")
            cell.teamTwoImage.kf.setImage(with: url2,
                                            placeholder: UIImage(named: "noImg"))
            
            cell.teamOneName.text = event.eventHomeTeam
            cell.TeamTwoName.text = event.eventAwayTeam
            cell.eventDate.text = event.eventDay
            cell.eventTime.text = event.eventTime
            
            return cell
        } else if collectionView == LetestCollection {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LatestCell", for: indexPath) as! LatestEventsViewCell
            let event = latest[indexPath.row]
            
            let url = URL(string: event.homeTeamLogo ?? "")
            cell.teamOneImage.kf.setImage(with: url,
                                            placeholder: UIImage(named: "noImg"))
            let url2 = URL(string: event.awayTeamLogo ?? "")
            cell.teamTwoImage.kf.setImage(with: url2,
                                            placeholder: UIImage(named: "noImg"))
            
            cell.teamOneName.text = event.eventHomeTeam
            cell.teamTwoName.text = event.eventAwayTeam
            cell.eventDate.text = event.eventDay
            cell.eventTime.text = event.eventTime
            return cell
            }
        else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TeamsCell", for: indexPath) as! TeamsCollectionViewCell
            let team = teams[indexPath.row]
            let url = URL(string: team.team_logo ?? "")
            cell.teamImage.kf.setImage(with: url,
                                            placeholder: UIImage(named: "noImg"))
            cell.teamName.text = team.team_name
            return cell
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == self.TeamsCollection {
            let team = teams[indexPath.row]
            
            print("team key \(String(describing: team.team_key))")
            let defaults = UserDefaults.standard
            defaults.setValue(team.team_key ,forKey: "teamId")
            
                self.performSegue(withIdentifier: "TeamDatails", sender: nil)
            
        }
    }
    
}
