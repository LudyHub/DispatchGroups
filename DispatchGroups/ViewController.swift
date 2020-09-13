//
//  ViewController.swift
//  DispatchGroups
//
//  Created by Mario Alberto Barragán Espinosa on 27/08/20.
//  Copyright © 2020 Mario Alberto Barragán Espinosa. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let urls = [
        URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png")!,
        URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/2.png")!,
        URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/3.png")!,
        URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/4.png")!,
        URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/5.png")!,
        URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/6.png")!,
        URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/7.png")!,
        URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/8.png")!,
        URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/9.png")!
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchPokemonStarters()
    }
    
    func fetchPokemonStarters() {
        let group = DispatchGroup()
        
        for (index, url) in urls.enumerated() {
            group.enter()
            print("Entrando a dispatchGroup con indice: \(index)")
            
            let session = URLSession(configuration: .ephemeral)
            
            session.dataTask(with: url) { (data, response, error) in
                defer {
                    group.leave()
                    print("Saliendo de dispatchGroup del con indice \(index)")
                }
                if let error = error {
                    print("Error al descargar \(error.localizedDescription)")
                }
            }.resume()
        }
        
        group.notify(queue: .main) {
            //  Update UI
            print("Todas las descargas terminaron")
            self.view.backgroundColor = .blue
        }
    }
}

