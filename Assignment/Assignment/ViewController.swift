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
         let string = try? String(contentsOf: path),
         let data = string.data(using: .utf8)
      {
//         print(string.replacingOccurrences(of: "^\\s*", with: "\\\\n", options: .regularExpression))
         do {
            let decoder = JSONDecoder()
            let person = try JSONDecoder().decode(Person.self, from: data)
            print(person)
         } catch {
            print(error)
         }
      }
   }

}
