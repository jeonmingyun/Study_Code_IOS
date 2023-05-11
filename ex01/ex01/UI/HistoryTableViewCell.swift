//
//  HistoryTableViewCell.swift
//  ex01
//
//  Created by jjglobal on 2023/05/08.
//

import Foundation
import UIKit

class HistoryTableViewCell: UITableViewCell {

    @IBOutlet weak var qrData: UILabel!
    @IBOutlet weak var regDate: UILabel!
    @IBOutlet weak var cellIcon: UIImageView!
    
    // 셀이 랜더링 될때
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
