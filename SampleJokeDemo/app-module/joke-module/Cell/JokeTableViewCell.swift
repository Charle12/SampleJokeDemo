//
//  ArticleTVC.swift
//  Sample
//
//  Created by Prabhat Pandey on 23/05/23.
//

import UIKit

class JokeTableViewCell: UITableViewCell {
    
    var jokeCellVM : JokeCellViewModel? {
        didSet {
            guard let jokeCellVM = jokeCellVM else {
                return
            }
            nameLabel.text = jokeCellVM.title
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configCellUI() {}
       
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = kPrimaryTextColor
        label.numberOfLines = 12
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()


    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(nameLabel)

        nameLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 12).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 12).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -12).isActive = true
        nameLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -12).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

}
