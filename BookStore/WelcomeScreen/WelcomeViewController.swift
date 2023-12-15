//
//  WelcomeViewController.swift
//  BookStore
//
//  Created by sidzhe on 03.12.2023.
//

import UIKit
import SnapKit

final class WelcomeViewController: UIViewController {
    
    //MARK: - Presenter
    var presenter: WelcomePresenterProtocol!
    
    //MARK: - UI Elements
    private lazy var getStartedButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.white, for: .normal)
        button.setTitle("Get Started", for: .normal)
        button.backgroundColor = .black
        button.layer.cornerRadius = 5
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(getStartedButtonPressed), for: .touchUpInside)
        return button
    }()
    
    private let pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.currentPageIndicatorTintColor = .black
        pageControl.backgroundStyle = .minimal
        return pageControl
    }()
    
    private let scrollView: UIScrollView = {
        let view = UIScrollView()
        view.backgroundColor = .white
        return view
    }()
    
    private let logoImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "logoImage")
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private let welcomeImage: UIImageView = {
        let image = UIImageView(frame: .zero)
        image.image = UIImage(named: "welcomeImage")
        image.contentMode = .scaleToFill
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    //MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "welcomeImage.png")!)
        scrollView.delegate = self
        pageControl.addTarget(self,
                              action: #selector(pageControlDidChange(_:)),
                              for: .valueChanged)
        view.addSubview(getStartedButton)
        view.addSubview(scrollView)
        view.addSubview(pageControl)
        view.addSubview(logoImage)
        view.insertSubview(welcomeImage, at: 0)
    }
    
    //MARK: - viewDidLayoutSubviews
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupUI()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        presenter.safeUserDefaults()
        
    }
    
    @objc private func pageControlDidChange(_ sender: UIPageControl) {
        let current = sender.currentPage
        scrollView.setContentOffset(CGPoint(x: CGFloat(current) * view.frame.size.width,
                                            y: 0), animated: true)
    }
        
    private func setupUI() {
        view.backgroundColor = .white
        
        pageControl.numberOfPages = presenter.onboardingText.count
        
        configureScrollView()
        
        getStartedButton.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(30)
            make.bottom.equalToSuperview().inset(80)
            make.height.equalTo(60)
        }
        
        pageControl.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(130)
            make.bottom.equalTo(getStartedButton).inset(100)
        }
        
        scrollView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalTo(pageControl).inset(30)
            make.height.equalTo(100)
        }
        
        logoImage.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(115)
            make.bottom.equalTo(scrollView).inset(50)
            make.height.greaterThanOrEqualTo(300)
        }
        
        welcomeImage.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalTo(scrollView).inset(120)
            make.top.equalToSuperview()
        }
    }
    
    @objc private func getStartedButtonPressed() {
        let homeVC = Builder.createTabBar()
        homeVC.modalPresentationStyle = .fullScreen
        homeVC.modalTransitionStyle = .crossDissolve
        present(homeVC, animated: true)
    }
    
    func configureScrollView() {
        scrollView.contentSize = CGSize(width: scrollView.frame.size.width * CGFloat(presenter.onboardingText.count), height: scrollView.frame.size.height)
        scrollView.isPagingEnabled = true
        for x in 0..<presenter.onboardingText.count {
            let page = UILabel(frame: CGRect(x: CGFloat(x) * view.frame.size.width, y: 0, width: view.frame.size.width,  height: scrollView.frame.size.height))

            page.text = presenter.onboardingText[x]
            page.textAlignment = .center
            page.numberOfLines = 0
            scrollView.addSubview(page)
        }
    }
}

//MARK: - WelcomePresenterProtocol
extension WelcomeViewController: WelcomeViewProtocol {

}

extension WelcomeViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(scrollView.contentOffset.x / UIScreen.main.bounds.width)
    }
}
