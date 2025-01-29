//
//  CharacterCollectionViewCell.swift
//  DisneyCharacter
//
//  Created by Андрей Сорокин on 27.01.2025.
//

import UIKit

class CharacterCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Outlets
    
    @IBOutlet weak var characterImageView: UIImageView!
    @IBOutlet weak var characterNameLabel: UILabel!
    @IBOutlet private weak var gradientView: UIView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // MARK: - Configuration
    
    func configure(with character: DisneyCharacter, imageLoader: NetworkManager) {
        characterNameLabel.text = character.name
        characterImageView.image = nil
        activityIndicator.startAnimating()
        
        if let urlString = character.imageUrl, let url = URL(string: urlString) {
            imageLoader.fetchImage(from: url) { [weak self] result in
                guard let self else { return }
                DispatchQueue.main.async {
                    self.activityIndicator.stopAnimating()
                    self.activityIndicator.hidesWhenStopped = true
                    switch result {
                    case .success(let imageData):
                        self.characterImageView.image = UIImage(data: imageData)
                    case .failure:
                        self.characterImageView.image = UIImage(systemName: Constants.defaultImageName)
                    }
                }
            }
        }
        setupUI()
    }
    
    // MARK: - Private methods
    
    private func setupUI() {
        characterImageView.layer.cornerRadius = 16
        characterImageView.layer.masksToBounds = true
        characterImageView.layer.shadowColor = UIColor.black.cgColor
        characterImageView.layer.shadowOpacity = 0.2
        characterImageView.layer.shadowOffset = CGSize(width: 0, height: 6)
        characterImageView.layer.shadowRadius = 8
        
        applyGradientToView()
    }
    
    private func applyGradientToView() {
        gradientView.layer.sublayers?.forEach { if $0 is CAGradientLayer { $0.removeFromSuperlayer() } }
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = gradientView.bounds
        gradientLayer.colors = [
            UIColor.clear.cgColor,
            UIColor.black.withAlphaComponent(0.6).cgColor
        ]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
        gradientView.layer.insertSublayer(gradientLayer, at: 0)
    }
}
