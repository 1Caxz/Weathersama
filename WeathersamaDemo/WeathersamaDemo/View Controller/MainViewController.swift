//
//  MainViewController.swift
//  WeathersamaDemo
//
//  Created by Saiful I. Wicaksana on 10/6/17.
//  Copyright © 2017 icaksama. All rights reserved.
//

import UIKit
import AVFoundation

protocol MainViewDelegete {
    func viewDidLoad()
    func viewDidAppear()
}

class MainViewController: UIViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {

    fileprivate let TAG = "MainViewController"
    fileprivate var presenter: MainPresenter!
    fileprivate var player: AVPlayer!
    fileprivate var coreDataManager: CoreDataManager = CoreDataManager()
    
    @IBOutlet weak var pageView: UIView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var btnOWM: UIButton!
    @IBOutlet weak var btnWeatherList: UIButton!
    
    fileprivate var orderedViewControllers: [UIViewController] = [UIViewController]()
    fileprivate var pageViewController: UIPageViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
//        startVideoBackground(weatherVideo: .CLEAR_DAY)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        pageViewSetup()
        presenter = MainPresenter(viewController: self)
//        presenter.setWeatherData()
    }
    
    @objc func viewDidBecomeActive() {
        if player != nil {
            appUtilities.videoAlwaysPlay(videoPlayer: player)
        }
    }
    
    @IBAction func btnOWMOnTouchUp(_ sender: Any) {
        if let url = URL(string: "https://openweathermap.org") {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url, options: [:])
            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }
    
    @IBAction func btnWeatherListOnTouchUp(_ sender: Any) {
        let weatherList = WeatherListViewController(nibName: "WeatherListViewController", bundle: nil)
        weatherList.coord = presenter.coord
        self.present(weatherList, animated: true, completion: nil)
    }
    
    
    // Page view Setting
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if let firstViewController = pageViewController.viewControllers?.first,
            let index = orderedViewControllers.index(of: firstViewController) {
            pageControl.currentPage = index
        }
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        pageControl.numberOfPages = orderedViewControllers.count
        return orderedViewControllers.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        guard let firstViewController = pageViewController.viewControllers?.first,
            let firstViewControllerIndex = orderedViewControllers.index(of: firstViewController) else {
                return 0
        }
        return firstViewControllerIndex
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.index(of: viewController) else {
            return nil
        }
        let previousIndex = viewControllerIndex - 1
        guard previousIndex >= 0 else {
            return nil
        }
        guard orderedViewControllers.count > previousIndex else {
            return nil
        }
        return orderedViewControllers[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.index(of: viewController) else {
            return nil
        }
        let nextIndex = viewControllerIndex + 1
        let orderedViewControllersCount = orderedViewControllers.count
        guard orderedViewControllersCount != nextIndex else {
            return nil
        }
        guard orderedViewControllersCount > nextIndex else {
            return nil
        }
        return orderedViewControllers[nextIndex]
    }
    
    // Prevent rotation and keep potrait
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.portrait
    }
    
    override var shouldAutorotate: Bool {
        return true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    fileprivate func pageViewSetup() {
        pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        pageViewController.dataSource = self
        pageViewController.delegate = self
        appUtilities.addChildViewController(parentVC: self, containerView: pageView, childVC: pageViewController)
    }
    
    internal func addWeatherPage(viewControllers: [UIViewController]) {
        orderedViewControllers.removeAll()
        for viewController in viewControllers {
            orderedViewControllers.append(viewController)
        }
    }
    
    internal func reloadWeatherPage() {
        if orderedViewControllers.indices.contains(indexPage) {
            pageControl.currentPage = indexPage
            pageViewController.setViewControllers([orderedViewControllers[indexPage]],
                               direction: .forward,
                               animated: true,
                               completion: nil)
        }
    }
    
    fileprivate func startVideoBackground(weatherVideo: AssetManager.WEATHER_VIDEO) {
        appUtilities.delay(second: 0.3) {
            UIView.animate(withDuration: 0.5, animations: {
                self.player = appUtilities.setVideoUIView(view: self.view, videoType: weatherVideo)
            })
            appUtilities.videoAlwaysPlay(videoPlayer: self.player)
            NotificationCenter.default.addObserver(self, selector: #selector(self.viewDidBecomeActive), name: .UIApplicationDidBecomeActive, object: nil)
        }
    }
}
