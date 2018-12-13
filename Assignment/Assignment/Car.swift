//
//  Car.swift
//  Assignment
//
//  Created by Iree García on 12/12/18.
//  Copyright © 2018 Iree García. All rights reserved.
//

import UIKit

class Car: BaseObject {
   var doors: Int
   var price: String
   var milage: Int
   
   enum CodingKeys: String, CodingKey {
      case doors, price, milage
   }
   
   required init(from decoder: Decoder) throws {
      let container = try decoder.container(keyedBy: CodingKeys.self)
      doors = try int(fromStringIn: container, forKey: .doors)
      price = try container.decode(String.self, forKey: .price)
      milage = try int(fromStringIn: container, forKey: .milage)
      
      try super.init(from: decoder)
   }
}
