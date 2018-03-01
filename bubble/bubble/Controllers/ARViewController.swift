//
//  ARViewController.swift
//  bubble
//
//  Created by Sawyer Blatz on 3/1/18.
//  Copyright © 2018 CS 408. All rights reserved.
//

import UIKit
import ARKit
import ARCL
import CoreLocation

class ARViewController: UIViewController {

    var sceneLocationView = SceneLocationView()
    let locationManager = CLLocationManager()
    override func viewDidLoad() {
        super.viewDidLoad()

        sceneLocationView.run()
        view.addSubview(sceneLocationView)

        //40.4275449
        //-86.9201803
        // Do any additional setup after loading the view.
        let coordinate = CLLocationCoordinate2D(latitude:
            40.437468723085639, longitude: -86.921144306239967)
        let location = CLLocation(coordinate: coordinate, altitude: 100)
        var image = #imageLiteral(resourceName: "bubbleImage")
        image = resizeImage(image: image, newWidth: 500)


        let imageWithText = addTextToImage(text: "Hello Bubble!", inImage: image, atPoint: CGPoint(x: 0, y: 0))
        //40.4254867
        //-86.921532099999993

        print(locationManager.location?.coordinate)
        let annotationNode = LocationAnnotationNode(location: location, image: imageWithText)

       // annotationNode.scaleRelativeToDistance = true

        sceneLocationView.addLocationNodeWithConfirmedLocation(locationNode: annotationNode)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        sceneLocationView.frame = view.bounds
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func addTextToImage(text: NSString, inImage: UIImage, atPoint:CGPoint) -> UIImage{

        // Setup the font specific variables
        let textColor = UIColor.white
        let textFont = UIFont.systemFont(ofSize: 17)

        //Setups up the font attributes that will be later used to dictate how the text should be drawn
        let textFontAttributes = [
            NSAttributedStringKey.font: textFont,
            NSAttributedStringKey.foregroundColor: textColor,
            ]

        // Create bitmap based graphics context
        UIGraphicsBeginImageContextWithOptions(inImage.size, false, 0.0)


        //Put the image into a rectangle as large as the original image.
        inImage.draw(in: CGRect(x: 0, y: 0, width: inImage.size.width, height: inImage.size.height))
        // Our drawing bounds
        let drawingBounds = CGRect(x: 0.0, y: 0.0, width: inImage.size.width, height: inImage.size.height)

        let textSize = text.size(withAttributes: [NSAttributedStringKey.font:textFont])
        let textRect = CGRect(x: drawingBounds.size.width/2 - textSize.width/2, y: drawingBounds.size.height/2 - textSize.height/2,
                              width: textSize.width, height: textSize.height)

        text.draw(in: textRect, withAttributes: textFontAttributes)

        // Get the image from the graphics context
        let newImag = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return newImag!

    }

    func resizeImage(image: UIImage, newWidth: CGFloat) -> UIImage {

        let scale = newWidth / image.size.width
        let newHeight = image.size.height * scale
        UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
        image.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return newImage!
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
