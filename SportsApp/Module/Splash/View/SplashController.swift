//
//  SplashController.swift
//  SportsApp
//
//  Created by Mac on 22/05/2023.
//

import UIKit
import Lottie
class SplashController: UIViewController {

    @IBOutlet weak var animation: AnimationView!
    override func viewDidLoad() {
        super.viewDidLoad()

        animation.isHidden = false
        let path = Bundle.main.path(forResource: "ball", ofType: "json") ?? ""
        animation.animation = Animation.filepath(path)
        animation.loopMode = .loop
        animation.animationSpeed = 1.5
        animation.play()
        
      DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+3){
            self.performSegue(withIdentifier: "splash", sender: nil)
        }
        
    }
    

}
