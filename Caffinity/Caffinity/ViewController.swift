//
//  ViewController.swift
//  Caffinity
//
//  Created by Zhumatay Sayana on 18.10.2025.
//

import UIKit

class ViewController: UIViewController {


    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var randomizeButton: UIButton!
    @IBOutlet weak var latte: UIImageView!
    @IBOutlet weak var coldBrew: UIImageView!
    @IBOutlet weak var seasonalDrink: UIImageView!
    @IBOutlet weak var breakfast: UIImageView!

    let cafes = [
           (image: #imageLiteral(resourceName: "lovaa"), name: "Lova Coffee", address: "Tole Bi Street 24B, Almaty"),
           (image: #imageLiteral(resourceName: "eva"), name: "Eva Coffee House", address: "Kazakhfilm 21d, Almaty"),
           (image: #imageLiteral(resourceName: "bonbon"), name: "Bon Bon", address: "Abylay Khan Avenue 123, Almaty")
       ]
    
    let cafeImages = [#imageLiteral(resourceName: "lovaa"),#imageLiteral(resourceName: "eva"),#imageLiteral(resourceName: "bonbon"),#imageLiteral(resourceName: "travelers"),#imageLiteral(resourceName: "marooneRosso"),#imageLiteral(resourceName: "nedelka"),#imageLiteral(resourceName: "sixCoffeeWine"),#imageLiteral(resourceName: "coffeeBoom")]

    let cafeNames = ["Lova Coffee","Eva Coffee House","Bon Bon","Traveler’s Coffee","Maroone Rosso","Nedelka Coffee","Six Coffee + Wine","CoffeeBoom"]

    let cafeAddresses = ["Tole Bi Street 24B, Almaty","Kazakhfilm 21d, Almaty","Abylay Khan Avenue 123, Almaty","Abay Ave 45, Almaty","Nazarbayev Ave 149, Almaty","Shevchenko Street 51, Almaty","Bogenbay Batyr 117, Almaty","8th microdistrict 37/1, Almaty"]

    private var currentIndex: Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        mainImageView.layer.cornerRadius = 20
        mainImageView.clipsToBounds = true
        showInitialCafe()
        
        let images = [latte, coldBrew, seasonalDrink, breakfast]
        for image in images {
            image?.layer.cornerRadius = 15
            image?.clipsToBounds = true
        }
    }

    private func showInitialCafe() {
        updateUI(for: 0)
    }

    @IBAction func randomizeTapped(_ sender: UIButton) {
        var newIndex: Int
        repeat {
            newIndex = Int.random(in: 0..<cafeImages.count)
        } while newIndex == currentIndex
        currentIndex = newIndex
        updateUI(for: newIndex)
    }

    private func updateUI(for index: Int) {
        mainImageView.image = cafeImages[index]
        nameLabel.text = cafeNames[index]
        addressLabel.text = cafeAddresses[index]
        
    }
}
