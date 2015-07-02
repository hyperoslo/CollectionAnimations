import UIKit

public class FlyAnimator: LayoutAnimator {

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
      attributes.transform = CGAffineTransformRotate(CGAffineTransformMakeScale(CGFloat(0.2), CGFloat(0.2)), CGFloat(M_PI))
      attributes.center = CGPoint(x: CGRectGetMidX(frame), y: CGRectGetMaxY(frame))
    } else {
      var flyUpTransform = CATransform3DIdentity
      flyUpTransform.m34 = 1.0 / -20000
      flyUpTransform = CATransform3DTranslate(flyUpTransform, 0, 0, 19500)
      attributes.transform3D = flyUpTransform

      attributes.alpha = 0.2
      attributes.zIndex = 1
    }
  }
}
