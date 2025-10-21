//
//  ViewController.swift
//  DiceApp
//
//  Created by Zhumatay Sayana on 09.10.2025.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var lhsDice: UIImageView!
    @IBOutlet weak var rhsDice: UIImageView!
    @IBOutlet weak var rolButton: UIButton!
    
    let diceImages: [UIImage] = [#imageLiteral(resourceName: "DiceOne"),#imageLiteral(resourceName: "DiceTwo"),#imageLiteral(resourceName: "DiceThree"),#imageLiteral(resourceName: "DiceFour"),#imageLiteral(resourceName: "DiceFive"),#imageLiteral(resourceName: "DiceSix")] // #imageLiteral()
    let diceImagesEnum: [UIImage] = [
        .diceOne, .diceTwo, .diceThree, .diceFour, .diceFive, .diceSix
    ]   // second variant

    override func viewDidLoad() {
        super.viewDidLoad()
        lhsDice.image = .diceOne
        rhsDice.image = .diceTwo
       // rolButton.layer.cornerRadius = 16    to change the radius of the button via code
       //rolButton.backgroundColor = .systemTeal  to change the button color via code
    }
    @IBAction func rollButtonDidTap(_ sender: UIButton) {
        let randomIndex = Int.random(in: 0..<diceImages.count)
        lhsDice.image = diceImages[randomIndex] // getting random index - first variant
        rhsDice.image = diceImages.randomElement() // built-in collection method  - second variant
    }


}




