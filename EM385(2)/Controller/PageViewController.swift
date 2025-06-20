//
//  PageViewController.swift
//  EM385(2)
//
//  Created by Joy on 4/11/25.
//

import UIKit

class PageView: UIView {
    let titleLabel = UILabel()
    let imageView = UIImageView()
    let descriptionLabel = UILabel()
    
    init(title: String, image: UIImage?, description: String) {
        super.init(frame: .zero)
        setupView(title: title, image: image, description: description)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView(title: String, image: UIImage?, description: String) {
            backgroundColor = .clear
            // Customize here
            titleLabel.text = title
            titleLabel.textAlignment = .center
            titleLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)

            imageView.image = image
            imageView.contentMode = .scaleAspectFit
            imageView.tintColor = .systemBlue

            descriptionLabel.text = description
            descriptionLabel.textAlignment = .center
            descriptionLabel.font = UIFont.systemFont(ofSize: 20)
            descriptionLabel.numberOfLines = 0

        let stackView = UIStackView(arrangedSubviews: [titleLabel, imageView, descriptionLabel])
        stackView.axis = . vertical
        stackView.alignment = .center
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)

        
            NSLayoutConstraint.activate([
                stackView.centerYAnchor.constraint(equalTo: centerYAnchor),
                stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
                stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant:  -20),
                
                imageView.widthAnchor.constraint(equalToConstant: 150),
                imageView.heightAnchor.constraint(equalToConstant: 150)
            ])
        }
}

