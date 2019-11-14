//
//  ArticlesViewController.swift
//  NYT
//
//  Created by Alex Lebedev on 12.11.2019.
//  Copyright © 2019 Alex Lebedev. All rights reserved.
//

import UIKit


class ArticlesViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var articlesCollectionView: UICollectionView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // MARK: - Properties
    var category: String?
    private  var massOfArticles: [Article] = []
    
    // MARK: - LiveCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        articlesCollectionView.dataSource = self
        articlesCollectionView.delegate = self
        activityIndicator.startAnimating()
        title = category
        navigationItem.largeTitleDisplayMode = .never
        extractedFunc(completion: { [weak self] in
            self?.activityIndicator.stopAnimating()
            self?.articlesCollectionView.reloadData()
        })
    }
    
    // MARK: - Private methods
    private func extractedFunc(completion: @escaping ()-> Void) {
        
        guard  let category = category else { return }
        
        NetworkManager().getRequest(category: category.lowercased()) { [weak self] (result) in
            switch result {
            case .failure(let error):
                self?.showAlert(title: error.localizedDescription, message: nil, handler: { _ in
                    self?.navigationController?.popViewController(animated: true)
                })
            case .success(let response):
                self?.setupArticles(response: response)
                completion()
            }
        }
    }
    
    private func setupArticles(response: Any?) {
        guard let allData = response as? [String: Any]
                       else { return }
                   guard let articles = allData["results"] as? [[String: Any]] else { return }
                   
                   articles.forEach { (article) in
                       var model = Article()
                       if let title = article["title"] as? String {
                           model.header = title
                       }
                       if let url = article["url"] as? String {
                           model.link = url
                       }
                       if let body = article["abstract"] as? String {
                           model.body = body
                       }
                       if let multimedia = article["multimedia"] as? [[String: Any]]{
                           if let a = multimedia.last, let imageURL = a["url"] as? String{
                               model.photoLink = imageURL
                           }
                           
                       }
                       self.massOfArticles.append(model)
                   }
    }
}

extension ArticlesViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return massOfArticles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = articlesCollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? ArticleCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.setup(model: massOfArticles[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc: FullArticleViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "FullArticle")
        vc.link = massOfArticles[indexPath.row].link
        navigationController?.show(vc, sender: self)
    }
    
}
