import UIKit

class ViewController: UIViewController {

  var data1 = ["First 1", "First 2"]
  var data2 = ["Second 1", "Second 2"]

  var items = [String]()

  lazy var collectionView: UICollectionView = { [unowned self] in
    var frame = self.view.bounds
    frame.origin.y += 20

    var collectionView = UICollectionView(frame: frame, collectionViewLayout: self.flowLayout)
    collectionView.delegate = self
    collectionView.dataSource = self
    collectionView.bounces = true
    collectionView.alwaysBounceVertical = true
    collectionView.autoresizingMask = UIViewAutoresizing.FlexibleHeight | UIViewAutoresizing.FlexibleWidth
    collectionView.backgroundColor = .lightTextColor()

    collectionView.registerClass(CollectionViewCell.self, forCellWithReuseIdentifier: "CellIdentifier")

    return collectionView
    }()

  lazy var flowLayout: CollectionViewFlowLayout = {
    var layout = CollectionViewFlowLayout()
    layout.sectionInset = UIEdgeInsetsMake(2.0, 2.0, 2.0, 2.0)
    return layout
    }()

  lazy var rightButton: UIBarButtonItem = { [unowned self] in
    let button = UIBarButtonItem(
      title: "Next",
      style: .Plain,
      target: self,
      action: "next")

    return button
    }()

  lazy var leftButton: UIBarButtonItem = { [unowned self] in
    let button = UIBarButtonItem(
      title: "Prev",
      style: .Plain,
      target: self,
      action: "prev")

    return button
    }()

  override func viewDidLoad() {
    super.viewDidLoad()
    title = "Items"
    navigationItem.leftBarButtonItem = self.leftButton
    navigationItem.leftBarButtonItem?.enabled = false
    navigationItem.rightBarButtonItem = self.rightButton
    navigationController?.hidesBarsWhenVerticallyCompact = true

    items = data1
    view.addSubview(self.collectionView)
  }

  func prev() {
    items = data1
    flowLayout.animator = FlyAnimator(appearingFrom: .Top, disappearingTo: .Back)
    reloadData(completion: { [unowned self] in
      self.navigationItem.leftBarButtonItem?.enabled = false
      self.navigationItem.rightBarButtonItem?.enabled = true
      })
  }

  func next() {
    items = data2
    flowLayout.animator = FlyAnimator(appearingFrom: .Back, disappearingTo: .Top)
    reloadData(completion: { [unowned self] in
      self.navigationItem.leftBarButtonItem?.enabled = true
      self.navigationItem.rightBarButtonItem?.enabled = false
      })
  }

  private func reloadData(completion: (() -> Void)? = nil) {
    let indexPaths = [
      NSIndexPath(forItem: 0, inSection: 0),
      NSIndexPath(forItem: 1, inSection: 0)]

    UIView.animateWithDuration(0.8,
      animations: { _ in
        self.collectionView.performBatchUpdates({ _ in
          self.collectionView.reloadItemsAtIndexPaths(indexPaths)
          }, completion: nil)
      }, completion: { _ in
        completion?()
    })
  }
}

extension ViewController : UICollectionViewDataSource {

  func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
    return self.items.count
  }

  func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCellWithReuseIdentifier("CellIdentifier",
      forIndexPath: indexPath) as! CollectionViewCell

    cell.setText(self.items[indexPath.row])
    cell.layer.borderWidth = 0.5
    cell.layer.borderColor = UIColor.lightGrayColor().CGColor
    cell.layer.cornerRadius = 4
    cell.backgroundColor = UIColor.whiteColor()

    return cell
  }
}

extension ViewController : UICollectionViewDelegate {

  func collectionView(collectionView: UICollectionView,
    layout collectionViewLayout: UICollectionViewLayout,
    sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {

      let width:CGFloat = self.view.bounds.size.width * 0.98
      let height:CGFloat = 150.0

      return CGSizeMake(width, height)
  }
}
