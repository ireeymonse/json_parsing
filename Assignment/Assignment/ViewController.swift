//
//  ViewController.swift
//  Assignment
//
//  Created by Iree García on 12/12/18.
//  Copyright © 2018 Iree García. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
   
   var person: Person?

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

extension ViewController: UITableViewDataSource {
   
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return person != nil ? 4: 0
   }
   
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ObjectCell
      
      func display(_ object: BaseObject) {
         let summ = object.objectSummary
         cell.nameLabel.text = summ.name
         cell.typeLabel.text = "\(summ.type), \(summ.color)"
         cell.descriptionLabel.text = summ.description
         
         cell.objectImageView.isHidden = (object.image == nil)
         //FIXME: display image
      }
      
      switch indexPath.row {
      case 0:
         let car = person!.car
         display(car)
         
         cell.detailsLabel.text = """
         Doors: \(car.doors)
         Price: \(car.price)
         Milage: \(car.milage) miles
         """
         
      case 1:
         display(person!.computer)
         
         cell.detailsLabel.text = """
         Purchased: \(person!.computer.purchaseDate)
         """
         
      case let i where i > 1:
         let pet = (i == 2 ? person!.cat: person!.dog)
         display(pet)
         
         cell.detailsLabel.text = """
         Age: \(pet.age) years
         Favorite toy: \(pet.favoriteToy)
         """
         
      default: break
      }
      
      return cell
   }
}

class ObjectCell: UITableViewCell {
   @IBOutlet weak var nameLabel: UILabel!
   @IBOutlet weak var typeLabel: UILabel!
   @IBOutlet weak var descriptionLabel: UILabel!
   @IBOutlet weak var detailsLabel: UILabel!
   @IBOutlet weak var objectImageView: UIImageView!
}
