//
//  BaseObject.swift
//  Assignment
//
//  Created by Iree García on 12/12/18.
//  Copyright © 2018 Iree García. All rights reserved.
//

import UIKit

class BaseObject: Decodable {
   
   /// General summary for all the objects
   struct ObjectSummary: Decodable {
      var type: String
      var name: String
      var color: String
      var descripton: String
   }
   
   /// Image that most objects share
   struct ObjectImage: Decodable {
      var url: URL?
      var width: Int
      var height: Int
      
      enum CodingKeys: String, CodingKey {
         case url, width, height
      }
      
      init(from decoder: Decoder) throws {
         let container = try decoder.container(keyedBy: CodingKeys.self)
         url = try container.decode(URL.self, forKey: CodingKeys.url)
         width = try int(fromStringIn: container, forKey: .width)
         height = try int(fromStringIn: container, forKey: .height)
      }
   }
   
   var objectSummary: ObjectSummary
   var image: ObjectImage?
   
   private enum CodingKeys: String, CodingKey {
      case objectSummary = "object_summary", image
   }
}

/// converts strings with a number and some text to an Int
func int<T>(fromStringIn container: KeyedDecodingContainer<T>, forKey key: T) throws -> Int {
   let px = try container.decode(String.self, forKey: key)
   return (px as NSString).integerValue
}
