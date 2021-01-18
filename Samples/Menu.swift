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
      $0.text = "Swipe to dismiss"
      $0.select.addHandler { [weak self] _ in
        let now = Date()
        (self?.view as? MenuViewController)?
          .present(UIControlViewController() • {
            $0.view.backgroundColor = .green
            $0.modalPresentationStyle = .fullScreen
            $0.nd_enableSlideTransitioning(options: [
              .coverAlpha: 0.4,
//              .transitionDuration: 0.33,
              .dockingEdge: UIRectEdge.left,
              .panPercentThreshold: 0.8
            ])
          },
          animated: true,
          completion: {
            print(Date().timeIntervalSince(now))
          })
      }
    },
    TextSelectableViewModel(identifier: "item") • {
      $0.text = "Swipe to dismiss 2"
      $0.select.addHandler { [weak self] _ in
        let now = Date()
        (self?.view as? MenuViewController)?
          .present(SFSafariViewController(url: URL(string: "https://google.com")!) • {
            $0.modalPresentationStyle = .fullScreen
          },
          animated: true,
          completion: {
            print(Date().timeIntervalSince(now))
          })
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

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    self.dismiss(animated: true)
  }
}

protocol TextItemViewModelProtocol: NDItemViewModelProtocol {
  var text: String { get }
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
