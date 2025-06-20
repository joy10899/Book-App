//
//  TutorialPageViewController.swift
//  EM385(2)
//
//  Created by Joy on 4/8/25.
//

import UIKit

class TutorialPageViewController: UIViewController {
    @IBOutlet weak var slideView: UIView!
    @IBOutlet weak var indicator: UIPageControl!
    let pageViews = [
        PageView(title: "Search", image: UIImage(systemName: "text.page.badge.magnifyingglass"), description: "Auto-complete functionality to quickly find what you need."),
        PageView(title: "Save", image: UIImage(systemName: "bookmark.circle.fill"), description: "Save important sections for quick access."),
        PageView(title: "Share", image: UIImage(systemName: "shareplay"), description: "Easily share with your team.")
    ]
    var currentPageIndex = 0
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        indicator?.numberOfPages = pageViews.count
        indicator.currentPage = currentPageIndex
        
        showPage(at: currentPageIndex)
        
        slideView.isUserInteractionEnabled = true
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.swipeGesture))
        swipeRight.direction = UISwipeGestureRecognizer.Direction.right
        slideView.addGestureRecognizer(swipeRight)
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(self.swipeGesture))
        swipeLeft.direction = UISwipeGestureRecognizer.Direction.left
        slideView.addGestureRecognizer(swipeLeft)
    }
    
    override func didReceiveMemoryWarning() {
        
    }
    
    private func showPage(at index: Int) {
        slideView.subviews.forEach { $0.removeFromSuperview() }
        
        let page = pageViews[index]
//        page.frame = slideView.bounds
//        page.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        slideView.addSubview(page)
        page.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            page.topAnchor.constraint(equalTo: slideView.topAnchor),
            page.bottomAnchor.constraint(equalTo: slideView.bottomAnchor),
            page.leadingAnchor.constraint(equalTo: slideView.leadingAnchor),
            page.trailingAnchor.constraint(equalTo: slideView.trailingAnchor)
        ])
        
        indicator.currentPage = index
    }
    
    @objc func swipeGesture(sender: UISwipeGestureRecognizer?) {
        guard let swipeGesture = sender else { return}
        print("Swipe detected: \(swipeGesture.direction == .left ? "left" : "right")")
        if swipeGesture.direction == .right {
            currentPageIndex = max(currentPageIndex - 1,0)
        } else if swipeGesture.direction == .left {
            currentPageIndex = min(currentPageIndex + 1, pageViews.count - 1)
        }
        showPage(at: currentPageIndex)
    }
}
