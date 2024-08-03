//
//  GameController.swift
//  NeptisGame
//
//  Created by Harun Begic on 31. 7. 2024..
//
import Foundation

class GameController: ObservableObject {
    @Published var recipeName = ""
    @Published var recipeTags: [String] = []
    
    func fetchRandomRecipe(completion: @escaping (String?, [String]?) -> Void) {
        guard let url = URL(string: "https://dummyjson.com/recipes") else {
            print("Invalid URL for fetching recipes")
            completion(nil, nil)
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error fetching recipe: \(error.localizedDescription)")
                completion(nil, nil)
                return
            }
            
            guard let data = data else {
                print("No data received for recipes")
                completion(nil, nil)
                return
            }
            
            do {
                if let json = try JSONSerialization.jsonObject(with: data) as? [String: Any],
                   let recipes = json["recipes"] as? [[String: Any]],
                   let randomRecipe = recipes.randomElement(),
                   let name = randomRecipe["name"] as? String,
                   let tags = randomRecipe["tags"] as? [String] {
                    DispatchQueue.main.async {
                        self.recipeName = name
                        self.recipeTags = tags
                        print("Recipe fetched: \(name), Tags: \(tags)")
                        completion(name, tags)
                    }
                } else {
                    print("Error parsing recipe JSON")
                    completion(nil, nil)
                }
            } catch {
                print("JSON parsing error: \(error.localizedDescription)")
                completion(nil, nil)
            }
        }.resume()
    }
    
    func fetchTags(completion: @escaping ([String]?) -> Void) {
        guard let url = URL(string: "https://dummyjson.com/recipes/tags") else {
            print("Invalid URL for fetching tags")
            completion(nil)
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error fetching tags: \(error.localizedDescription)")
                DispatchQueue.main.async {
                    completion(nil)
                }
                return
            }
            
            guard let data = data else {
                print("No data received for tags")
                DispatchQueue.main.async {
                    completion(nil)
                }
                return
            }
            
            do {
                if let tags = try JSONSerialization.jsonObject(with: data) as? [String] {
                    DispatchQueue.main.async {
                        print("Tags fetched successfully: \(tags)")
                        completion(tags)
                    }
                } else {
                    print("Unexpected JSON format for tags: \(String(data: data, encoding: .utf8) ?? "nil")")
                    DispatchQueue.main.async {
                        completion(nil)
                    }
                }
            } catch {
                print("Failed to parse tags with error: \(error.localizedDescription)")
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
        }.resume()
    }
}
