//
//  DisneyCharacterTableViewCell.swift
//  DisneyCharacter
//
//  Created by Андрей Сорокин on 20.01.2025.
//

import UIKit

final class DisneyCharacterTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    
    @IBOutlet weak var characterNameLabel: UILabel!
    @IBOutlet weak var characterImageView: UIImageView!
    @IBOutlet private weak var gradientView: UIView!
    
    // MARK: - Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        applyGradientToView()
    }
    
    // MARK: - Private Methods
    
    private func setupUI() {
        characterImageView.layer.masksToBounds = true
        characterImageView.layer.cornerRadius = 16
    }
    
    //Градиент тоже исправлю пока для теста
    private func applyGradientToView() {
        gradientView.layer.sublayers?.forEach { if $0 is CAGradientLayer { $0.removeFromSuperlayer() } }
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = gradientView.bounds
        gradientLayer.colors = [
            UIColor.clear.cgColor,
            UIColor.lightGray.cgColor
        ]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        
        gradientView.layer.insertSublayer(gradientLayer, at: 0)
        gradientView.layer.cornerRadius = 8
    }
    
}
