//
//  ViewController.swift
//  Assignment
//
//  Created by Iree García on 12/12/18.
//  Copyright © 2018 Iree García. All rights reserved.
//

import UIKit
import AlamofireImage

class ViewController: UIViewController {
   
   var person: Person?
   let formatter: DateFormatter = {
      let formatter = DateFormatter()
      formatter.dateFormat = "MM/dd/yyyy"
      return formatter
   }()

   override func viewDidLoad() {
      super.viewDidLoad()
      
      if let path = Bundle.main.url(forResource: "data", withExtension: "json"),
         let data = try? Data(contentsOf: path)
      {
         do {
            person = try JSONDecoder().decode(Person.self, from: data)
         } catch {
            print(error)
         }
      }
   }
}


// MARK: - Table view

extension ViewController: UITableViewDataSource, UITableViewDelegate {
   
   func numberOfSections(in tableView: UITableView) -> Int {
      return person != nil ? 3: 0
   }
   
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return section == 2 ? 2: 1 // 2 pets in the last section
   }
   
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ObjectCell
      
      func display(_ object: BaseObject) {
         let summ = object.objectSummary
         cell.nameLabel.text = summ.name
         cell.typeLabel.text = "\(summ.type), \(summ.color)"
         cell.descriptionLabel.text = summ.description
         
         cell.objectImageView.isHidden = (object.image?.url == nil)
         if let img = object.image, let url = img.url {
            cell.objectImageView.af_setImage(withURL: url)
            cell.imageWidth.constant = CGFloat(img.width)
            cell.imageHeight.constant = CGFloat(img.height)
         }
      }
      
      switch (indexPath.section, indexPath.row) {
      case (0, _):
         let car = person!.car
         display(car)
         
         cell.detailsLabel.text = """
         Doors: \(car.doors)
         Price: \(car.price)
         Milage: \(car.milage) miles
         """
         
      case (1, _):
         display(person!.computer)
         
         let date = formatter.string(from: person!.computer.purchaseDate)
         cell.detailsLabel.text = "Purchased: \(date)"
         
      case (_, let i):
         let pet = (i == 0 ? person!.cat: person!.dog)
         display(pet)
         
         cell.detailsLabel.text = """
         Age: \(pet.age) years
         Favorite toy: \(pet.favoriteToy)
         """
      }
      
      return cell
   }
   
   func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
      return section == 0 ? "Car": section == 1 ? "Computer": "Pets"
   }
   
   
   // -
   
   func tableView(_ tableView: UITableView, willDisplayHeaderView view:UIView, forSection: Int) {
      if let headerView = view as? UITableViewHeaderFooterView {
         headerView.textLabel?.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
      }
   }
}

class ObjectCell: UITableViewCell {
   @IBOutlet weak var nameLabel: UILabel!
   @IBOutlet weak var typeLabel: UILabel!
   @IBOutlet weak var descriptionLabel: UILabel!
   @IBOutlet weak var detailsLabel: UILabel!
   
   @IBOutlet weak var objectImageView: UIImageView!
   @IBOutlet weak var imageWidth: NSLayoutConstraint!
   @IBOutlet weak var imageHeight: NSLayoutConstraint!
}
