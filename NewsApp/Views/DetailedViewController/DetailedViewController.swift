//
//  DetailedViewController.swift
//  NewsApp
//
//  Created by Isagulov urmat on 8/1/23.
//

import UIKit

class DetailedViewController: UIViewController {
    
    private lazy var mainTitle: UILabel = {
        let label = UILabel()
        
        label.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        label.textAlignment = .left
        label.textColor = .yellow
        label.numberOfLines = 0
        
        return label
    }()
    
    private lazy var subTitle: UILabel = {
        let st = UILabel()
        
        st.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        st.textAlignment = .left
        st.textColor = .green
        st.numberOfLines = 0
        
        return st
    }()
    
    private lazy var textView: UITextView = {
        let tv = UITextView()
        
        tv.isEditable = false
        tv.textAlignment = .left
        tv.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        tv.textColor = .cyan
        tv.backgroundColor = .gray
        
        return tv
    }()
    
    
    var article: Article
    
    init(article: Article){
        
        self.article = article
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        
        view.backgroundColor = .brown
        
        mainLabelSetup()
        subLabelSetup()
        textViewSetup()
        initialSetup()
        
    }
    
    func mainLabelSetup(){
        view.addSubview(mainTitle)
        mainTitle.translatesAutoresizingMaskIntoConstraints = false
        
        let constraints = [
            mainTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            mainTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            mainTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    func subLabelSetup(){
        view.addSubview(subTitle)
        subTitle.translatesAutoresizingMaskIntoConstraints = false
        
        let constraints = [
            subTitle.topAnchor.constraint(equalTo: mainTitle.bottomAnchor, constant: 20),
            subTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            subTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    func textViewSetup(){
        view.addSubview(textView)
        textView.translatesAutoresizingMaskIntoConstraints = false
        
        let constraints = [
            textView.topAnchor.constraint(equalTo: subTitle.bottomAnchor, constant: 20),
            textView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            textView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            textView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 20)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    func initialSetup(){
        
        mainTitle.text = article.author
        subTitle.text = article.title
        textView.text = article.content
    }
}
