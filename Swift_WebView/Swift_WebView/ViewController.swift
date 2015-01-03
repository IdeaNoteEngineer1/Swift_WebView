//
//  ViewController.swift
//  Swift_WebView
//
//  Created by Junji on 2015/01/04.
//  Copyright (c) 2015年 Junji Yamamoto. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UIWebViewDelegate{
    var swiftWebView : UIWebView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //webviewの生成
        swiftWebView = makeWebView(CGRectMake(0, 20, self.view.frame.width, self.view.frame.height-20))
        self.view.addSubview(swiftWebView!)
        
        //インジケータ表示
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        
        //HTMLの読み込み
        var url : NSURL = NSURL(string: "https://www.google.co.jp")!
        var urlRequest : NSURLRequest = NSURLRequest(URL: url)
        swiftWebView?.loadRequest(urlRequest)
    }

    ////////////////////////////
    //webviewの詳細設定
    ////////////////////////////
    func makeWebView (frame:CGRect) ->UIWebView
    {
        //webviewの生成
        let webView = UIWebView()
        webView.backgroundColor = UIColor.blackColor() //webviewの背景色
        webView.scalesPageToFit = true //ページをフィットさせる
        webView.autoresizingMask = //ビューサイズの自動調整
            UIViewAutoresizing.FlexibleRightMargin |
            UIViewAutoresizing.FlexibleLeftMargin |
            UIViewAutoresizing.FlexibleTopMargin |
            UIViewAutoresizing.FlexibleBottomMargin |
            UIViewAutoresizing.FlexibleWidth |
            UIViewAutoresizing.FlexibleHeight
        webView.delegate = self
        
        return webView
    }
    
    ////////////////////////////
    //アラート表示
    ////////////////////////////
    func showAlert(title:NSString? , text:NSString?)
    {
        let alert = UIAlertController(title: title, message: text, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
        
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    ////////////////////////////
    //webviewDelegate
    ////////////////////////////
    
    //HTML読み込み時に呼ばれる
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool
    {
        //クリック時のアクション
        if navigationType == UIWebViewNavigationType.LinkClicked ||
        navigationType == UIWebViewNavigationType.FormSubmitted
        {
            //通信途中の場合には再度URLへジャンプさせない
            if UIApplication.sharedApplication().networkActivityIndicatorVisible
            {
                return false
            }
            
            //ナビゲーションバーにインジケータを表示
            UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        }
        
        return true
    }
    
    //HTML読み込み成功時に呼ばれる
    func webViewDidFinishLoad(webView: UIWebView) {
        //インジケータの非表示
        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
    }
    
    //HTML読み込み失敗時に呼ばれる
    func webView(webView: UIWebView, didFailLoadWithError error: NSError) {
        //インジケータの非表示
        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
        //func showAlertで表示
        showAlert(nil, text: "通信に失敗しました")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

