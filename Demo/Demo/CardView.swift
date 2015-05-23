import UIKit

class CardView: UIView {

  var label:UILabel

  override init(frame: CGRect) {
    label = UILabel()
    label.font = UIFont.systemFontOfSize(26)
    label.textAlignment = NSTextAlignment.Center
    super.init(frame: frame)

    addSubview(label)
    backgroundColor = UIColor.whiteColor()
    layer.cornerRadius = 10.0
  }

  required init(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func layoutSubviews() {
    super.layoutSubviews()
    label.frame = bounds
  }
}
