//
//  DisneyCharacterCollectionViewController.swift
//  DisneyCharacter
//
//  Created by Андрей Сорокин on 27.01.2025.
//

import UIKit


class DisneyCharacterCollectionViewController: UICollectionViewController {
    
    // MARK: - Private properties
    
    private let networkService = NetworkManager.shared
    private var disneyCharacters: [DisneyCharacter] = []
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        fetchCharacters()
    }
    
    // MARK: - Private methods
    
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: (view.frame.width / 2) - 20, height: 260)
        layout.minimumInteritemSpacing = 8
        layout.minimumLineSpacing = 18
        collectionView.collectionViewLayout = layout
    }
    
    private func fetchCharacters() {
        guard let url = Link.characters.url  else { return }
        networkService.fetch(from: url) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let value):
                disneyCharacters = value.data
                collectionView.reloadData()
            case .failure(let failure):
                showAlert(title: "OOPS!", message: failure.localizedDescription)
            }
        }
    }
}

// MARK: - UICollectionViewDataSource & UICollectionViewDelegate
extension DisneyCharacterCollectionViewController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return disneyCharacters.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: Identifiers.CollectionViewCell.characterCell.identifier,
            for: indexPath
        )
        guard let cell = cell as? CharacterCollectionViewCell else { return UICollectionViewCell() }
        cell.configure(with: disneyCharacters[indexPath.item], imageLoader: networkService)
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: Identifiers.Segue.characterDetailsShow.identifier, sender: disneyCharacters[indexPath.item])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == Identifiers.Segue.characterDetailsShow.identifier,
              let character = sender as? DisneyCharacter,
              let detailsVC = segue.destination as? CharacterDetailViewController else { return }
        
        detailsVC.character = character
    }
}

// MARK: - Alert
private extension DisneyCharacterCollectionViewController {
    func showAlert(title: String, message: String, completion: (() -> Void)? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            completion?()
        }
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
}
