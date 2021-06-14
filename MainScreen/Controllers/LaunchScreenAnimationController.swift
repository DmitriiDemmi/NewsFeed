//
//  LaunchScreenAnimationController.swift
//  NewsFeed
//
//  Created by RM on 13.06.2021.
//

import UIKit
import Lottie

class LaunchScreenAnimationController: UIViewController {
    
    var animation = AnimationView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.setUpAnimation()
    }
    
    func setUpAnimation() {
         view.addSubview(animation)
         animation.animation = Animation.named("44161-coffe-orange")
         animation.backgroundColor = .white
         animation.frame = view.bounds
         animation.contentMode = .scaleAspectFit
         animation.loopMode = .loop
         animation.play()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5, execute:  {
         let viewController = TableViewController()
         viewController.modalTransitionStyle = .crossDissolve
         viewController.modalPresentationStyle = .fullScreen
         self.present(viewController, animated: true)
     })
 }
    
}
