import UIKit

public protocol LayoutAnimator {

  func animateAppearingAttributes(attributes: UICollectionViewLayoutAttributes)
  func animateDisappearingAttributes(attributes: UICollectionViewLayoutAttributes,
    forCell cell: UICollectionViewCell)
}
