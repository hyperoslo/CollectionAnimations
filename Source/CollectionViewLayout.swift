import UIKit

public class CollectionViewFlowLayout: UICollectionViewFlowLayout {

  public var animator: LayoutAnimator?

  override public func initialLayoutAttributesForAppearingItemAtIndexPath(itemIndexPath: NSIndexPath) -> UICollectionViewLayoutAttributes? {
    var attributes = layoutAttributesForItemAtIndexPath(itemIndexPath)

    if let animator = animator {
      animator.animateAppearingAttributes(attributes)
    } else {
      attributes = super.initialLayoutAttributesForAppearingItemAtIndexPath(itemIndexPath)
    }

    return attributes
  }

  override public func finalLayoutAttributesForDisappearingItemAtIndexPath(itemIndexPath: NSIndexPath) -> UICollectionViewLayoutAttributes? {
    var attributes = layoutAttributesForItemAtIndexPath(itemIndexPath)
    let cell = collectionView!.cellForItemAtIndexPath(itemIndexPath)!

    if let animator = animator {
      animator.animateDisappearingAttributes(attributes, forCell:cell)
    } else {
      attributes = super.finalLayoutAttributesForDisappearingItemAtIndexPath(itemIndexPath)
    }

    return attributes
  }
}
