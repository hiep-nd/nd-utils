//
//  UIGestureRecognizer.swift
//  Samples
//
//  Created by Nguyen Duc Hiep on 22/12/2020.
//

import NDMVVM
import NDModificationOperators
import NDLog
//import NDAutolayoutUtils

class UIGestureRecognizerViewController: NDViewController {
  override func manualInit() {
    super.manualInit()
    view.backgroundColor = .white

    view.addGestureRecognizer(UITapGestureRecognizer() • {
      $0.nd_add { [weak self] in
        nd_log(info: "Gesture action.")
        self?.presentingViewController?.dismiss(animated: true)
      }
      $0.nd_delegateHandlers.shouldBegin = { _ in
        nd_log(info: "Gesture should begin.")
        return true
      }
    })
  }
}

class UIBarButtonItemViewController: NDViewController {
  override func manualInit() {
    super.manualInit()
    view.backgroundColor = .white

    view.nd_wrap(
      item: UIToolbar() • {
        $0.items = [
          UIBarButtonItem() • {
            $0.title = "Dismiss"
            $0.nd_set { [weak self] in
              nd_log(info: "UIBarButtonItem action.")
              self?.presentingViewController?.dismiss(animated: true)
            }
          }
        ]
      },
      visualConstraints: ["V:[safeArea_top][item]", "H:[safeArea_leading][item][safeArea_trailing]"])
  }
}

class UIControlViewController: NDViewController {
  override func manualInit() {
    super.manualInit()
    view.backgroundColor = .white

    view.nd_wrap(
      item: UIButton() • {
        $0.setTitle("Dismiss", for: [])
        $0.setTitleColor(.red, for: [])
        $0.nd_(events: .touchUpInside) { [weak self] in
          nd_log(info: "UIControl action.")
          self?.presentingViewController?.dismiss(animated: true)
        }
      },
      visualConstraints: ["V:[safeArea_center][item_center]", "H:[safeArea_center][item_center]"]
    )
    let labels = [
      UILabel() • { $0.text = "Zero" },
      UILabel() • { $0.text = "One" },
      UILabel() • { $0.text = "Two" },
      UILabel() • { $0.text = "Three" },
      UILabel() • { $0.text = "Four" },
      UILabel() • { $0.text = "Five" },
      UILabel() • { $0.text = "Six" }
    ] • { $0.forEach { $0.frame = .init(origin: .zero, size: .init(width: 100, height: 100)) } }

    view.addSubview(labels[0])
    view.addSubview(labels[1])
    view.addSubview(labels[2])
    view.insertSubview(labels[3], at: 2)
    view.insertSubview(labels[4], belowSubview: labels[2])
    view.insertSubview(labels[5], aboveSubview: labels[2])
  }
}
