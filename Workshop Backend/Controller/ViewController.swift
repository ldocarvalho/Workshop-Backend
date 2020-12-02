//
//  ViewController.swift
//  Workshop Backend
//
//  Created by Lucas Carvalho on 02/12/20.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var image1: UIImageView!
    @IBOutlet weak var image2: UIImageView!
    @IBOutlet weak var image3: UIImageView!
    
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var label3: UILabel!
    
    @IBOutlet weak var progresssBar: UIProgressView!
    
    @IBOutlet weak var button: UIButton!
    
    struct WebsiteDescription: Decodable {
        let name: String
        let description: String
        let courses: [Course]
    }

    struct Course: Decodable {
        let id: Int?
        let name: String?
        let link: String?
        let imageUrl: String?
        
    //    init(json: [String: Any]) {
    //        id = json["id"] as? Int ?? -1
    //        name = json["name"] as? String ?? ""
    //        link = json["link"] as? String ?? ""
    //        imageUrl = json["imageUrl"] as? String ?? ""
    //    }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if JSONSerialization.isValidJSONObject(validDictionary) { // True
            do {
                _ = try JSONSerialization.data(withJSONObject: validDictionary, options: .prettyPrinted)
            } catch {
                // Handle Error
            }
        }
         
        if JSONSerialization.isValidJSONObject(invalidDictionary) { // False
            // NSJSONSerialization.dataWithJSONObject(validDictionary, options: .PrettyPrinted) will produce an error if called
        }
        let jsonUrlString = "https://api.letsbuildthatapp.com/jsondecodable/courses_missing_fields"
        guard let url = URL(string: jsonUrlString) else { return }

        URLSession.shared.dataTask(with: url) { (data, response, err) in
            //perhaps check err
            //also perhaps check response status 200 OK
            
            guard let data = data else { return }
            
        //            let dataAsString = String(data: data, encoding: .utf8)
        //            print(dataAsString)
            
            do {
        //                let websiteDescription = try JSONDecoder().decode(WebsiteDescription.self, from: data)
        //                print(websiteDescription.name, websiteDescription.description)
                
                let courses = try JSONDecoder().decode([Course].self, from: data)
                print(courses)
                
                //Swift 2/3/ObjC
        //                guard let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] else { return }
        //
        //                let course = Course(json: json)
        //                print(course.name)
                
            } catch let jsonErr {
                print("Error serializing json:", jsonErr)
            }
            
                        
            
        }.resume()

        //        let myCourse = Course(id: 1, name: "my course", link: "some link", imageUrl: "some image url")
        //        print(myCourse)
    }
    
   

    @IBAction func buttonTapped(_ sender: Any) {
    }
    
}

