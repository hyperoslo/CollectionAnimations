import UIKit

class CollectionViewCell: UICollectionViewCell {

  var cardView: CardView

  override init(frame: CGRect) {
    cardView = CardView(frame: frame)
    super.init(frame: frame)

    contentView.addSubview(cardView)
  }

  required init(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
  }

  func setText(text:String) {
    cardView.label.text = text
  }

  override func layoutSubviews() {
    self.cardView.frame = self.bounds
  }
}
