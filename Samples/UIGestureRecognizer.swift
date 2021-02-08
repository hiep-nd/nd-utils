//
//  UIGestureRecognizer.swift
//  Samples
//
//  Created by Nguyen Duc Hiep on 22/12/2020.
//

import NDMVVM
import NDModificationOperators
import NDLog

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
  }
}
