//
//  Pet.swift
//  Assignment
//
//  Created by Iree García on 12/12/18.
//  Copyright © 2018 Iree García. All rights reserved.
//

import UIKit

class Pet: BaseObject {
   var age: Int
   var favoriteToy: String
   
   enum CodingKeys: String, CodingKey {
      case age, favoriteToy = "favorite_toy"
   }
   
   required init(from decoder: Decoder) throws {
      let container = try decoder.container(keyedBy: CodingKeys.self)
      age = try int(fromStringIn: container, forKey: .age)
      favoriteToy = try container.decode(String.self, forKey: .favoriteToy)
      
      try super.init(from: try container.superDecoder())
   }
}
