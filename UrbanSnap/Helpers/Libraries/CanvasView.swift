//
//  CanvasView.swift
//  UrbanSnap
//
//  Created by Dhiky Aldwiansyah on 09/06/21.
//

import Foundation

import UIKit

extension UIView {

    // Using a function since `var image` might conflict with an existing variable
    // (like on `UIImageView`)
    func asImage() -> UIImage {
        if #available(iOS 10.0, *) {
            let renderer = UIGraphicsImageRenderer(bounds: bounds)
            return renderer.image { rendererContext in
                layer.render(in: rendererContext.cgContext)
            }
        } else {
            UIGraphicsBeginImageContext(self.frame.size)
            self.layer.render(in:UIGraphicsGetCurrentContext()!)
            let image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return UIImage(cgImage: image!.cgImage!)
        }
    }
}

struct Line {
    let strokeWidth: Float
    let color: UIColor
    var points: [CGPoint]
}

class Canvas: UIView {
    
    // public function
    fileprivate var strokeColor = UIColor.systemGreen
    fileprivate var strokeWidth: Float = 3
    
    func setStrokeWidth(width: Float) {
        self.strokeWidth = width
    }
    
    func setStrokeColor(color: UIColor) {
        self.strokeColor = color
    }
    
    func undo() {
        _ = lines.popLast()
        setNeedsDisplay()
    }
    
    func clear() {
        lines.removeAll()
        setNeedsDisplay()
    }
    
    var lines = [Line]()
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        
        lines.forEach { (line) in
            context.setStrokeColor(line.color.cgColor)
            context.setLineWidth(CGFloat(line.strokeWidth))
            context.setLineCap(.round)
            for (i, p) in line.points.enumerated() {
                if i == 0 {
                    context.move(to: p)
                } else {
                    context.addLine(to: p)
                }
            }
            context.strokePath()
        }
        
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        lines.append(Line.init(strokeWidth: strokeWidth, color: strokeColor, points: []))
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let point = touches.first?.location(in: nil) else { return }
        guard var lastLine = lines.popLast() else { return }
        lastLine.points.append(point)
        lines.append(lastLine)
        setNeedsDisplay()
    }
    
}

class DrawingView: UIView {

      private var drawingLayer: CAShapeLayer?
      private var currentPath: UIBezierPath?
      private var temporaryPath: UIBezierPath?
      private var points = [CGPoint]()

      var drawColor = UIColor.blue

      var lineWidth: CGFloat = 2.0

      var opacity: CGFloat = 0.8

      var sublayers: [CALayer] {
        return self.layer.sublayers ?? [CALayer]()
      }

    func undo() {
        _ = points.popLast()
        setNeedsDisplay()
    }
    
    func clear() {
        points.removeAll()
        setNeedsDisplay()
    }
    
      // MARK: Init

      override public init(frame: CGRect) {
        super.init(frame: frame)

        commonInit()
      }

      required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        commonInit()
      }

      private func commonInit() {
        self.layer.removeAllAnimations()
        self.layer.masksToBounds = true  // Restrict the drawing within the canvas
        self.backgroundColor = UIColor.white
        self.isMultipleTouchEnabled = false
      }

      // MARK: Drawing

      override func draw(_ rect: CGRect) {
        // TODO: This orveriding is still required. Need to find a way to remove this
      }

      override func draw(_ layer: CALayer, in ctx: CGContext) {
        
        print("asdasdsadsaddsa")

        let drawingLayer = self.drawingLayer ?? CAShapeLayer()
        drawingLayer.contentsScale = UIScreen.main.scale

        drawingLayer.lineWidth = lineWidth
        drawingLayer.opacity = Float(opacity)
        drawingLayer.lineJoin = .round
        drawingLayer.lineCap = .round
        drawingLayer.fillColor = UIColor.clear.cgColor
        drawingLayer.miterLimit = 0
        drawingLayer.strokeColor = drawColor.cgColor

        let linePath = UIBezierPath()

        if let tempPath = temporaryPath, let bezierPath = currentPath {
          linePath.append(tempPath)
          linePath.append(bezierPath)
          drawingLayer.path = linePath.cgPath
        }

        if self.drawingLayer == nil {
          self.drawingLayer = drawingLayer
          self.layer.addSublayer(drawingLayer)
        }
      }

      // MARK: - Touches

      override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let point = touches.first?.preciseLocation(in: self) else {
          return
        }
        points.removeAll()
        points.append(point)
      }

      override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let point = touches.first?.preciseLocation(in: self) else {
          return
        }
//        guard let point = touches.first?.preciseLocation(in: self) else { return }
//        guard var lastLine = points.popLast() else { return }
        
        points.append(point)
        updatePaths()
        layer.setNeedsDisplay()
      }

      override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {

        // single touch support
        if points.count == 1 {
          currentPath = createPathStarting(at: points[0])
          currentPath?.lineWidth = self.lineWidth / 2.0
          currentPath?.addArc(withCenter: points[0], radius: lineWidth / 4.0, startAngle: 0, endAngle: .pi * 2.0, clockwise: true)
        }

        finishPath()
      }

      override func touchesCancelled(_ touches: Set<UITouch>?, with event: UIEvent?) {
        finishPath()
      }

      // MARK: - Bezier paths Management

      private func updatePaths() {

        // update main path
        while points.count > 4 {

          points[3] = CGPoint(x: (points[2].x + points[4].x)/2.0, y: (points[2].y + points[4].y)/2.0)

          if currentPath == nil {
            currentPath = createPathStarting(at: points[0])
          }

          currentPath?.addCurve(to: points[3], controlPoint1: points[1], controlPoint2: points[2])
          points.removeFirst(3)
          temporaryPath = nil
        }

        // build temporary path up to last touch point
        switch points.count {
        case 2:
          temporaryPath = createPathStarting(at: points[0])
          temporaryPath?.addLine(to: points[1])
          break
        case 3:
          temporaryPath = createPathStarting(at: points[0])
          temporaryPath?.addQuadCurve(to: points[2], controlPoint: points[1])
          break
        case 4:
          temporaryPath = createPathStarting(at: points[0])
          temporaryPath?.addCurve(to: points[3], controlPoint1: points[1], controlPoint2: points[2])
          break
        default:
          break
        }
      }

      private func finishPath() {

        // add temp path to current path to reflect the changes in canvas
        if let tempPath = temporaryPath {
          currentPath?.append(tempPath)
        }

        currentPath = nil
      }

      private func createPathStarting(at point: CGPoint) -> UIBezierPath {
        let localPath = UIBezierPath()
        localPath.move(to: point)
        return localPath
      }
    
}
