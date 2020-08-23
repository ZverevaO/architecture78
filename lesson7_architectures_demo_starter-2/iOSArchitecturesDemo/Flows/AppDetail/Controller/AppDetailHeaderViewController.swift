//
//  AppDetailHeaderViewController.swift
//  iOSArchitecturesDemo
//
//  Created by Veaceslav Chirita on 8/17/20.
//  Copyright © 2020 ekireev. All rights reserved.
//

import UIKit

class AppDetailHeaderViewController: UIViewController {

    private let app: ITunesApp
    private let imageDownloader = ImageDownloader()
    
    private var appDetailHeaderView: AppDetailHeaderView {
        return self.view as! AppDetailHeaderView
    }
    
    init(app: ITunesApp) {
        self.app = app
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        self.view = AppDetailHeaderView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.fillData()
    }
    
    private func fillData() {
        self.downloadImage()
        self.appDetailHeaderView.titleLabel.text = app.appName
        self.appDetailHeaderView.subTitleLabel.text = app.company
        self.appDetailHeaderView.ratingLabel.text = app.averageRating.flatMap { "\($0)" }
    }
    
    private func downloadImage() {
        guard let url = self.app.iconUrl else { return }
        self.imageDownloader.getImage(fromUrl: url) { [weak self] (image, error) in
            if error == nil {
                self?.appDetailHeaderView.imageView.image = image
            }
        }
    }

}
