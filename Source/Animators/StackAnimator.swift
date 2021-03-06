import UIKit

public class StackAnimator: LayoutAnimator {

  public enum Direction {
    case Back, Top
  }

  public var appearingFrom: Direction
  public var disappearingTo: Direction

  public var scaleBack: CGFloat = 0.7

  public var zPositionForDisappearing: CGFloat {
    return disappearingTo == .Back ? -100 : 100
  }

  public convenience init() {
    self.init(appearingFrom: .Back, disappearingTo: .Top)
  }

  public init(appearingFrom: Direction, disappearingTo: Direction) {
    self.appearingFrom = appearingFrom
    self.disappearingTo = disappearingTo
  }

  public func animateAppearingAttributes(attributes: UICollectionViewLayoutAttributes) {
    applyTransformToAttributes(attributes, direction: appearingFrom)
  }

  public func animateDisappearingAttributes(attributes: UICollectionViewLayoutAttributes,
    forCell cell: UICollectionViewCell) {
      cell.layer.zPosition = zPositionForDisappearing

      applyTransformToAttributes(attributes, direction: disappearingTo)
  }

  private func applyTransformToAttributes(attributes: UICollectionViewLayoutAttributes, direction: Direction) {
    let frame = attributes.frame

    if direction == .Back {
      attributes.center = CGPoint(x: CGRectGetMidX(frame), y: CGRectGetMidY(frame))
      attributes.transform3D = CATransform3DMakeScale(scaleBack, scaleBack, 1.0)
    } else {
      var transform: CATransform3D?

      attributes.center = CGPoint(x: CGRectGetMinX(frame) - CGRectGetMidX(frame), y: CGRectGetMinY(frame) - CGRectGetMinY(frame))
      transform = CATransform3DIdentity
      transform = CATransform3DRotate(transform!, CGFloat(-M_PI / 2.0), 0.0, 0.0, 1.0)

      if let transform = transform {
        attributes.transform3D = transform
      }

      attributes.alpha = 1.0
    }
  }
}
