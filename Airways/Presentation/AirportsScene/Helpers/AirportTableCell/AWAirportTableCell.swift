import UIKit

class AWAirportTableCell: UITableViewCell {
    
    @IBOutlet weak var name: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        name.textColor = AWColors.main
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        name.text = ""
    }
    
}
