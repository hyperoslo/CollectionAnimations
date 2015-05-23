import UIKit

extension UICollectionView {

  convenience init(frame: CGRect, animatedLayout: Bool = false) {
    var collectionViewLayout = CollectionViewFlowLayout()

    self.init(frame: frame, collectionViewLayout: collectionViewLayout)
  }
}
