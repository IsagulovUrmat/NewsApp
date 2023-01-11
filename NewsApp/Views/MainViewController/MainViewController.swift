//
//  MainViewController.swift
//  NewsApp
//
//  Created by Isagulov urmat on 16/9/22.
//

import UIKit

class MainViewController: UIViewController{
    
    private lazy var mainLabel: UILabel = {
        let label = UILabel()
        label.text = "Text"
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.backgroundColor = .clear
        label.textAlignment = .center
        
        
        return label
    }()
    
    private lazy var searchTextField: UITextField = {
        let tf = UITextField()
        tf.attributedPlaceholder = NSAttributedString(string: "Where oyu want to go", attributes: [NSAttributedString.Key.foregroundColor: UIColor.blue])
        tf.font = UIFont.systemFont(ofSize: 24, weight: .black)
        tf.placeholder = "Type a keyword"
        tf.textAlignment = .center
        tf.delegate = self
        
        return tf
    }()
    
    private lazy var mainSwitcher: UISwitch = {
        let sw = UISwitch()
        sw.isOn = true
        sw.addTarget(self, action: #selector(switcherTapped), for: .valueChanged)
        
        return sw
    }()
    
    private lazy var mainTableView: UITableView = {
        let tv = UITableView()
        tv.dataSource = self
        tv.delegate = self
        tv.register(UINib(nibName: "MainTVCell", bundle: nil), forCellReuseIdentifier: "cell")
        tv.rowHeight = 230
        
        return tv
    }()
    
    var newsNetworkManager = NewsNetworkService.shared
    var newsData: [Article] = []
    var isEnglish: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        mainLabelSetup()
        searchTextFieldSetup()
        switcherTappedSetuo()
        mainTableViewSetup()
        
        newsNetworkManager.newsDelegate = self
        
    }
    
    func mainLabelSetup(){
        view.addSubview(mainLabel)
        mainLabel.translatesAutoresizingMaskIntoConstraints = false
        let mainLabelConstraints = [
            mainLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            mainLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        
        ]
        
        NSLayoutConstraint.activate(mainLabelConstraints)
    }
    
    func searchTextFieldSetup(){
        view.addSubview(searchTextField)
        
        searchTextField.translatesAutoresizingMaskIntoConstraints = false
        
        let constraints = [
            searchTextField.topAnchor.constraint(equalTo: mainLabel.bottomAnchor, constant: 20),
            searchTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            searchTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            searchTextField.heightAnchor.constraint(equalToConstant: 60)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    func switcherTappedSetuo(){
        view.addSubview(mainSwitcher)
        mainSwitcher.translatesAutoresizingMaskIntoConstraints = false
        
        let constraints = [
            mainSwitcher.topAnchor.constraint(equalTo: searchTextField.bottomAnchor, constant: 10),
            mainSwitcher.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mainSwitcher.heightAnchor.constraint(equalToConstant: 40)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    func mainTableViewSetup(){
        view.addSubview(mainTableView)
        mainTableView.translatesAutoresizingMaskIntoConstraints = false
        
        let constraints = [
            mainTableView.topAnchor.constraint(equalTo: searchTextField.bottomAnchor, constant: 60),
            mainTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            mainTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            mainTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 20)
        ]
        NSLayoutConstraint.activate(constraints)
        
    }
    
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MainTVCell
        let article = newsData[indexPath.row]
        cell.initialSetup(article: article)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        
        let article = newsData[indexPath.row]
        
        let vc = DetailedViewController(article: article)
        vc.article = article
        
        present(vc, animated: true)
    }
}

extension MainViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        if let text = textField.text{
            mainLabel.text = text
            newsNetworkManager.getNews(keyWord: text, language: self.isEnglish ? "en" : "ru")
        }
        
        return true
    }
}

extension MainViewController: NewsNetworkDelegate{
    func fetchNews(news: NewsModelAPI) {
     
        self.newsData = news.articles
        
        DispatchQueue.main.async {
            self.mainTableView.reloadData()
        }
        
    }
    
    func errorFetchingNews(error: Error) {
        print(error)
    }
    
    
}

extension MainViewController{
    
    @objc func switcherTapped(){
        self.isEnglish = mainSwitcher.isOn
    }
}
