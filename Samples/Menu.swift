//
//  Menu.swift
//  Samples
//
//  Created by Nguyen Duc Hiep on 14/12/2020.
//

import NDAutolayoutUtils
import NDMVVM
import NDModificationOperators
import SafariServices
import StoreKit

class MenuViewModel: NDViewModel {
  lazy private(set) var listViewModel = NDListViewModel(itemViewModels: [
    TextSelectableViewModel(identifier: "item") • {
      $0.text = "Pan down to dismiss - without scoll view"
      $0.select.addHandler { [weak self] _ in
        (self?.view as? MenuViewController)?.present(
          UIControlViewController() • {
            $0.view.backgroundColor = .green
            $0.modalPresentationStyle = .fullScreen
            $0.nd_enablePanDownToDismiss()
          },
          animated: true
        )
      }
    },
    TextSelectableViewModel(identifier: "item") • {
      $0.text = "Pan down to dismiss - with scroll view"
      $0.select.addHandler { [weak self] _ in
        (self?.view as? MenuViewController)?.present(
          NDTableViewController() • {
            $0.view.backgroundColor = .green
            $0.modalPresentationStyle = .fullScreen
            $0.register(identifier: "item", class: TextTableViewCell.self)
            nd_connect(
              viewModel: NDListViewModel(itemViewModels: (0...100).map {
                let text = "Item \($0)"
                return TextItemViewModel(identifier: "item") • { $0.text = text }
              }),
              view: $0
            )
            $0.nd_enablePanDownToDismiss(
              options: [
                .scrollView: $0.tableView!
              ]
            )
          },
          animated: true
        )
      }
    },
    TextSelectableViewModel(identifier: "item") • {
      $0.text = "Swipe to dismiss"
      $0.select.addHandler { [weak self] _ in
        (self?.view as? MenuViewController)?.present(
          UIControlViewController() • {
            $0.view.backgroundColor = .green
            $0.modalPresentationStyle = .fullScreen
            $0.nd_enableSlideTransitioning(options: [
              .coverAlpha: 0.4,
              .dockingEdge: UIRectEdge.left,
              .panPercentThreshold: 0.8
            ])
          },
          animated: true
        )
      }
    },
    TextSelectableViewModel(identifier: "item") • {
      $0.text = "UIImagePickerController"
      $0.select.addHandler { [unowned self] _ in
        (self.view as? UIViewController)?.nd_present(
          UIImagePickerController() • {
            $0.nd_delegateHandlers.didFinishPickingMediaWithInfo = {
              print(($1[.originalImage] as? UIImage)?.size ?? "nil")
              $0.nd_dismiss()
            }
          }
        )
      }
    },
    TextSelectableViewModel(identifier: "item") • {
      $0.text = "UIGestureRecognizer"
      $0.select.addHandler { [weak self] _ in
        (self?.view as? MenuViewController)?
          .present(UIGestureRecognizerViewController() • {
            $0.modalPresentationStyle = .fullScreen
          },
          animated: true)
      }
    },
    TextSelectableViewModel(identifier: "item") • {
      $0.text = "UIBarButtonItem"
      $0.select.addHandler { [weak self] _ in
        (self?.view as? MenuViewController)?
          .present(UIBarButtonItemViewController() • {
            $0.modalPresentationStyle = .fullScreen
          },
          animated: true)
      }
    },
    TextSelectableViewModel(identifier: "item") • {
      $0.text = "UIControl"
      $0.select.addHandler { [weak self] _ in
        (self?.view as? MenuViewController)?
          .present(UIControlViewController() • {
            $0.modalPresentationStyle = .fullScreen
          },
          animated: true)
      }
    },
    TextSelectableViewModel(identifier: "item") • {
      $0.text = "SKStoreReviewController"
      $0.select.addHandler { [weak self] _ in
        if #available(iOS 10.3, *) {
          SKStoreReviewController.requestReview()
        }
      }
    }
  ])
}

class MenuViewController: NDViewController {
  var listViewController = NDTableViewController() • {
    $0.register(identifier: "item", class: TextTableViewCell.self)
    $0.enableSelectableItems()
  }

  override func manualInit() {
    super.manualInit()

    nd_fill(with: listViewController)
    nd_connect(viewModel: MenuViewModel(), view: self)
    title = "NDUtils Samples"
  }

  override func didSetViewModel(fromOldViewModel oldViewModel: NDViewModelProtocol?) {
    super.didSetViewModel(fromOldViewModel: oldViewModel)
    nd_connect(viewModel: (viewModel as? MenuViewModel)?.listViewModel, view: listViewController)
  }
}

protocol TextItemViewModelProtocol: NDItemViewModelProtocol {
  var text: String { get }
}

class TextItemViewModel: NDItemViewModel, TextItemViewModelProtocol {
  var text = ""
}

class TextSelectableViewModel: NDSelectableItemViewModel, TextItemViewModelProtocol {
  var text = ""
}

class TextTableViewCell: NDTableViewCell {
  override func didSetViewModel(fromOldViewModel oldViewModel: NDViewModelProtocol?) {
    super.didSetViewModel(fromOldViewModel: oldViewModel)
    textLabel?.text = (viewModel as? TextItemViewModelProtocol)?.text
  }
}
