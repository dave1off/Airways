import UIKit

class PointView: UIView {

    @IBOutlet weak var title: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    
        frame = CGRect(x: 0, y: 0, width: 55, height: 25)
        backgroundColor = .white
        alpha = 0.8
        layer.cornerRadius = 12
        layer.borderWidth = 2
        layer.borderColor = AWColors.main.cgColor
        
        title.textColor = AWColors.main
    }

}
