//
//  OnBoardingScrollView.swift
//  EatGreat
//
//  Created by Book on 2022/6/28.
//

import UIKit
import RxCocoa
import RxSwift

class OnBoardingScrollView: UIView {
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.isPagingEnabled = true
        scrollView.alwaysBounceHorizontal = true
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.delegate = self
        return scrollView
    }()
    
    private lazy var stackView:UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        return stackView
    }()

    private let pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.numberOfPages = 3
        pageControl.currentPage = 0
        pageControl.pageIndicatorTintColor = .themeBackground2
        pageControl.currentPageIndicatorTintColor = .themePrimary
        return pageControl
    }()
    
    private var indexObjects:[OnBoardingScrollIndexObject] = [.init(image: "OnBoardingIndexImage1",
                                                                    title: "了解自我體質成因",
                                                                    index: "您是屬於腎虛肥胖、心臟無力還是上肝火體質等呢？從 5 分鐘小測驗，了解您的體質屬性與成因。"),
                                                              .init(image: "OnBoardingIndexImage1",
                                                                    title: "了解自我體質成因",
                                                                    index: "了解體質成因與相關知識了解體質成因與相關知識"),
                                                              .init(image: "OnBoardingIndexImage1",
                                                                    title: "了解自我體質成因",
                                                                    index: "了解體質成因與相關知識了解體質成因與相關知識")]
    
    private let timerRunning: BehaviorRelay<Bool> = BehaviorRelay(value: true)

    private let timer = Observable<Int>.interval(RxTimeInterval.seconds(1), scheduler: MainScheduler.asyncInstance)
    
    private var disposeBag:DisposeBag = DisposeBag()

    override init(frame: CGRect) {
        super.init(frame: frame)
        initView()
        reactiveX()
//        updateFrame()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initView() {
        addSubview(scrollView)
        addSubview(pageControl)
        
        scrollView.addSubview(stackView)
        
        scrollView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
//            make.height.equalTo(320)
        }
        
        stackView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
            make.height.equalToSuperview()
//            make.width.greaterThanOrEqualTo(scrollView)
        }
        
        pageControl.snp.makeConstraints { make in
            make.top.equalTo(scrollView.snp.bottom)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        indexObjects.forEach { vo in
            let view = OnBoardingScrollIndexView()
            view.updateFrame(viewObject: vo)
            stackView.addArrangedSubview(view)
            view.snp.makeConstraints { make in
                make.width.equalTo(scrollView.snp.width)
            }
        }
    }
    
    private func reactiveX() {
        
        pageControl.rx
            .controlEvent(.valueChanged)
            .observe(on: MainScheduler.instance)
            .subscribe { [weak self] _ in
                guard let self = self else { return }
                self.timerRunning.accept(false)
                self.updateScrollOffset()
                self.timerRunning.accept(true)
        }.disposed(by: disposeBag)

        
        timerRunning
            .asObservable()
            .flatMapLatest({ [weak self] isRunning -> Observable<Int> in
                guard let self = self else { return .empty() }
                return isRunning ? self.timer : .empty()
            })
            .filter({ _ in self.indexObjects.count > 1})
            .subscribe(on: MainScheduler.asyncInstance)
            .subscribe(onNext: { [weak self] _ in
                guard let self = self else { return }
                self.pushPageControlToNext()
                self.updateScrollOffset()
            })
            .disposed(by: disposeBag)
    }
    
    private func updateFrame() {
        
        let subViews = indexObjects.map { vo -> UIView in
            let view = OnBoardingScrollIndexView()
            view.updateFrame(viewObject: vo)
            return view
        }
        
        scrollView.layoutPageViews(subViews, withSize: scrollView.bounds.size)
    }
    
    private func pushPageControlToNext() {
        let currentPage = pageControl.currentPage
        pageControl.currentPage = indexObjects.isEnd(index: currentPage) ? 0 : currentPage + 1
    }
    
    private func updateScrollOffset() {
        let width = scrollView.bounds.size.width
        let xOffset = width * CGFloat(pageControl.currentPage)
        scrollView.setContentOffset(CGPoint(x: xOffset, y: 0), animated: true)
    }
}

extension OnBoardingScrollView:UIScrollViewDelegate {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        timerRunning.accept(false)
        updatePageControlPage()
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        timerRunning.accept(true)
        updatePageControlPage()
    }

    private func updatePageControlPage() {
        let width = scrollView.bounds.size.width

        let currentPage = Int(((scrollView.contentOffset.x - width) / width) + 1)

        if pageControl.currentPage != currentPage {
            pageControl.currentPage = currentPage
        }
    }
}
