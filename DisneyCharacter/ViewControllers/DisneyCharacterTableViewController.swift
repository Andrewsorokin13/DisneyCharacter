//
//  DisneyCharacterTableViewController.swift
//  DisneyCharacter
//
//  Created by Андрей Сорокин on 20.01.2025.
//

import UIKit

final class DisneyCharacterTableViewController: UITableViewController {
    
    // MARK: - Private property
    
    private var disneyCharacters: [DisneyCharacter] = []
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchCharacters()
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return disneyCharacters.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: Constants.characterCellIdentifier
        ) as? DisneyCharacterTableViewCell else {
            return UITableViewCell()
        }
        let data = disneyCharacters[indexPath.row]
        cell.characterNameLabel.text = data.name
        return cell
    }
    
    // MARK: - Table View Delegate
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        220 // здесь будет динамическое вычисление, которое зависит от размера изображения
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: Constants.segueToCharacterDetail, sender: disneyCharacters[indexPath.row])
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard
            segue.identifier == Constants.segueToCharacterDetail,
            let character = sender as? DisneyCharacter
        else { return }
        
        if let detailsVC = segue.destination as? DetailsCharacterViewController {
            detailsVC.disneyCharacter = character
        }
    }
}

// MARK: - Networking

private extension DisneyCharacterTableViewController {
    func fetchCharacters() {
        let baseURL = URL(string: "https://api.disneyapi.dev/character")
        
        guard let baseURL else { return }
        let task = URLSession.shared.dataTask(with: baseURL) {
            [weak self] data, _, error in
            if let error = error {
                print("Error fetching data: \(error.localizedDescription)")
                return
            }
            
            guard let data else { return }
            
            do {
                let decoder = JSONDecoder()
                let data = try decoder.decode(DisneyAPIResponse.self, from: data)
                DispatchQueue.main.async {
                    self?.disneyCharacters = data.data
                    self?.tableView.reloadData()
                }
                print(data.data)
            } catch {
                print("Decoding error: \(error.localizedDescription)")
            }
        }
        task.resume()
    }
}
