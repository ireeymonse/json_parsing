//
//  Product.swift
//  Assignment
//
//  Created by Iree García on 12/12/18.
//  Copyright © 2018 Iree García. All rights reserved.
//

import UIKit

class Product: BaseObject {
   
   private static let formatter: DateFormatter = {
      let formatter = DateFormatter()
      formatter.dateFormat = "MMMM d, yyyy"
      return formatter
   }()
   
   
   var purchaseDate: Date
   
   enum CodingKeys: String, CodingKey {
      case purchaseDate = "purchase_date"
   }
   
   required init(from decoder: Decoder) throws {
      let container = try decoder.container(keyedBy: CodingKeys.self)
      
      let string = try container.decode(String.self, forKey: .purchaseDate)
      guard let date = Product.formatter.date(from: string) else {
         throw "Invalid data for key '\(CodingKeys.purchaseDate)'"
      }
      purchaseDate = date
      
      try super.init(from: try container.superDecoder())
   }
}

extension String: Error {}
