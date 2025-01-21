//
//  DetailsCharacterViewController.swift
//  DisneyCharacter
//
//  Created by Андрей Сорокин on 21.01.2025.
//

import UIKit

final class DetailsCharacterViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var filmsLabel: UILabel!
    @IBOutlet weak var sourceLinkLabel: UILabel!
    
    // MARK: - Properties
    
    var disneyCharacter: DisneyCharacter!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        
    }
    
    // MARK: - Private Methods
    
    private func updateUI() {
        title = disneyCharacter.name
        avatarImageView.image = UIImage(named: disneyCharacter.imageUrl ?? "")
        sourceLinkLabel.text = disneyCharacter.sourceUrl
        filmsLabel.text = formatFilmsDescription()
        addTapGestureToSourceLink()
    }
    
    private func addTapGestureToSourceLink() {
          let tapGesture = UITapGestureRecognizer(target: self, action: #selector(openSourceLink))
          sourceLinkLabel.isUserInteractionEnabled = true
          sourceLinkLabel.addGestureRecognizer(tapGesture)
      }
    
    @objc private func openSourceLink() {
        guard  let url = URL(string: disneyCharacter.sourceUrl) else { return }
         UIApplication.shared.open(url)
     }
    
    private func formatFilmsDescription() -> String {
          var allFilms = [String]()
          if let films = disneyCharacter.films { allFilms.append(contentsOf: films) }
          if let shortFilms = disneyCharacter.shortFilms { allFilms.append(contentsOf: shortFilms) }
          if let tvShows = disneyCharacter.tvShows { allFilms.append(contentsOf: tvShows) }
          
          return allFilms.joined(separator: ", ")
      }
}
