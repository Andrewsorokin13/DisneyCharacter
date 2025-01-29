//
//  CharacterDetailViewController.swift
//  DisneyCharacter
//
//  Created by Андрей Сорокин on 28.01.2025.
//

import UIKit

class CharacterDetailViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Properties
    
    var character: DisneyCharacter!
    
    // MARK: - Private properties
    
    private var sections: [DisneyCharacterSection] = []
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sections = getSections(from: character)
        title = character.name
        loadImageView(with: character)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Identifiers.Segue.webView.identifier,
           let webVC = segue.destination as? WebViewControllerViewController {
            webVC.url = character.sourceUrl
        }
    }
    
    // MARK: - Actions
    
    @IBAction func openViewSource() {
        performSegue(withIdentifier: Identifiers.Segue.webView.identifier, sender: nil)
    }
    
    // MARK: - Private methods
    private func getSections(from character: DisneyCharacter) -> [DisneyCharacterSection] {
        var sections: [DisneyCharacterSection] = []
        
        if let films = character.films, !films.isEmpty {
            sections.append(DisneyCharacterSection(title: MediaCategory.films, items: films))
        }
        
        if let shortFilms = character.shortFilms, !shortFilms.isEmpty {
            sections.append(DisneyCharacterSection(title: MediaCategory.shortFilms, items: shortFilms))
        }
        
        if let tvShows = character.tvShows, !tvShows.isEmpty {
            sections.append(DisneyCharacterSection(title: MediaCategory.tvShows, items: tvShows))
        }
        
        return sections
    }
    
    private func loadImageView(with character: DisneyCharacter) {
        guard let url = character.getImageUrl else { return }
        NetworkManager.shared.fetchImage(from: url) { [weak self] result in
            guard let self else { return }
            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()
                self.activityIndicator.hidesWhenStopped = true
                switch result {
                case .success(let imageData):
                    self.avatarImageView.image = UIImage(data: imageData)
                case .failure:
                    self.avatarImageView.image = UIImage(systemName: Constants.defaultImageName)
                }
            }
            
        }
    }
}

// MARK: - UITableViewDataSource & UITableViewDelegate

extension CharacterDetailViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        sections[section].title.categoryName
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        sections[section].items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Identifiers.TableViewCell.characterDetailCell.identifier, for: indexPath)
        var content = cell.defaultContentConfiguration()
        let data = sections[indexPath.section]
        content.text = data.items[indexPath.row]
        cell.contentConfiguration = content
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        30
    }
}
