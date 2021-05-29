//
//  ViewController.swift
//  pattern_example
//
//  Created by Zedd on 2021/05/25.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var myImageView: UIImageView!
    @IBOutlet weak var myView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "stripe_green")!)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let size = self.myImageView.frame.size
        let generator = StripesGenerator(size: size,
                                         backgroundColor: .white,
                                         stripeColor: .blue,
                                         stripeWidth: 10, angle: .pi / 4)
        self.myImageView.image = generator.apply()
    }
}
