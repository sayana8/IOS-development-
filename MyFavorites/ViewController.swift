//
//  ViewController.swift
//  MyFavorites
//
//  Created by Zhumatay Sayana on 12.11.2025.
//

import UIKit

struct FavoriteItem {
    let title: String
    let subtitle: String
    let image: UIImage
    let review: String
}

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    let movies: [FavoriteItem] = [
        FavoriteItem(title: "Век Адалин", subtitle: "Ли Толанд Кригер", image: UIImage(named: "adaline")!, review: "О любви, способной победить даже вечность."),
        FavoriteItem(title: "Блондинка в законе", subtitle: "Роберт Лукас", image: UIImage(named: "legally")!, review: "О девушке, которая доказала, что розовый цвет и интеллект идеально сочетаются."),
        FavoriteItem(title: "Бойцовский клуб", subtitle: "Дэвид Финчер", image: UIImage(named: "fightclub")!, review: "Фильм, который перевернёт твое восприятие реальности"),
        FavoriteItem(title: "Гордость и предубеждение", subtitle: "Джо Райт", image: UIImage(named: "pride")!, review: "Элегантная история любви и достоинства, наполненная атмосферой Англии"),
        FavoriteItem(title: "Дьявол носит Prada", subtitle: "Дэвид Франкел", image: UIImage(named: "devil")!, review: "Где амбиции сталкиваются с мечтами, а стиль — с самопознанием")
    ]

    let music: [FavoriteItem] = [
        FavoriteItem(title: "See You Again", subtitle: "Tyler, The Creator ft. Kali Uchis", image: UIImage(named: "tyler")!, review: "Мягкая, мечтательная композиция о любви"),
        FavoriteItem(title: "Lucid Dreams", subtitle: "Juice WRLD", image: UIImage(named: "dreams")!, review: "Эмоциональный гимн разбитых сердец"),
        FavoriteItem(title: "Sunflower", subtitle: "Post Malone & Swae Lee", image: UIImage(named: "sunflower")!, review: "Словно из мультвселенной Человека-паука"),
        FavoriteItem(title: "Am I Dreaming", subtitle: "Metro Boomin, A$AP Rocky & Roisee", image: UIImage(named: "amIDreaming")!, review: "Словно путешествие сквозь сны и воспоминания"),
        FavoriteItem(title: "Annihilate", subtitle: "Metro Boomin, Swae Lee, Lil Wayne & Offset", image: UIImage(named: "annihilate")!, review: "Смесь рэпа и энергии, идеально передающая дух супергеройской решимости")
    ]


    let books: [FavoriteItem] = [
        FavoriteItem(title: "Sapiens", subtitle: "Yuval Noah Harari", image: UIImage(named: "sapiens")!, review: "Философское путешествие по истории человечества"),
        FavoriteItem(title: "Ночь в Лиссабоне", subtitle: "Эрих Мария Ремарк", image: UIImage(named: "lissabon")!, review: "Печальная и прекрасная история любви на фоне бегства и надежды в мире"),
        FavoriteItem(title: "Искусство любить", subtitle: "Эрих Фромм", image: UIImage(named: "artOfLove")!, review: "Мудрая книга, раскрывающая тайну любви как осознанного искусства"),
        FavoriteItem(title: "Сказать жизни – да!", subtitle: "Виктор Франкл", image: UIImage(named: "da")!, review: "О силе духа, смысле страдания и человеческом достоинстве."),
        FavoriteItem(title: "Унесённые ветром", subtitle: "Маргарет Митчелл", image: UIImage(named: "veter")!, review: "Величественная сага о любви, гордости и борьбе женщины")
    ]

    let courses: [FavoriteItem] = [
        FavoriteItem(title: "Алгоритмы и структуры данных", subtitle: "CSCI2105", image: UIImage(named: "algo")!, review: "Изучение логики и методов, лежащих в основе программирования"),
        FavoriteItem(title: "ООП и дизайн", subtitle: "CSCI2106", image: UIImage(named: "oop")!, review: "Погружение в объектно-ориентированное мышление и создание чистого кода"),
        FavoriteItem(title: "ИТ инфраструктура и сети", subtitle: "INFT2102", image: UIImage(named: "networks")!, review: "Практическое понимание сетей, серверов и архитектуры ИТ-систем"),
        FavoriteItem(title: "Управление кибербезопасностью", subtitle: "INFS4240", image: UIImage(named: "cybersec")!, review: "Стратегический подход к защите данных и предотвращению киберугроз"),
        FavoriteItem(title: "Введение в финансы", subtitle: "FIN1231", image: UIImage(named: "finance")!, review: "Базовые принципы финансов, инвестиций и управления капиталом")
    ]



    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 120
        tableView.sectionHeaderTopPadding = 0

    }
}

extension ViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int { 4 }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { 5 }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0: return "Favorite Movies"
        case 1: return "Favorite Music"
        case 2: return "Favorite Books"
        case 3: return "Favorite University Courses"
        default: return ""
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! MovieTableViewCell

        let item: FavoriteItem
        switch indexPath.section {
        case 0: item = movies[indexPath.row]
        case 1: item = music[indexPath.row]
        case 2: item = books[indexPath.row]
        case 3: item = courses[indexPath.row]
        default: fatalError("Unknown section")
        }

        cell.configure(movie: item)
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Section: \(indexPath.section), Row: \(indexPath.row)")
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
}
