//
//  TableViewCell.swift
//  Todoshka
//
//  Created by Amir Zhunussov on 23.12.2022.
//

import UIKit
import SnapKit

class TableViewCell: UITableViewCell {

    let label: UILabel = {
        let label = UILabel()
        label.text = "some"
        return label
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.addSubview(label)
        label.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
    }

}
