//
//  MainTVCell.swift
//  NewsApp
//
//  Created by Isagulov urmat on 19/9/22.
//

import UIKit

class MainTVCell: UITableViewCell {

    
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    
    
    let imageDownloader = ImageService.shared
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func initialSetup(article: Article) {
        
        titleLabel.text = article.author
        subTitleLabel.text = article.title
        
        if let urlImage = article.urlToImage{
            
            imageDownloader.createRequest(urlString: urlImage) { [weak self] (data) in
                DispatchQueue.main.async {
                    self?.mainImageView.image = UIImage(data: data )
                }
            }
        }
    }
}
