//
//  String+Extension.swift
//  Feicui
//
//  Created by people on 2018/3/27.
//  Copyright © 2018年 zhan. All rights reserved.
//

import Foundation
import UIKit
import CommonCrypto
extension String {
    ///获取宽度
    func ga_widthForComment(fontSize: CGFloat, height: CGFloat = 15) -> CGFloat {
        let font = UIFont.systemFont(ofSize: fontSize)
        let rect = NSString(string: self).boundingRect(with: CGSize(width: CGFloat(MAXFLOAT), height: height), options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        return ceil(rect.width)
    }
    ///获取高度
    func ga_heightForComment(fontSize: CGFloat, width: CGFloat) -> CGFloat {
        let font = UIFont.systemFont(ofSize: fontSize)
        let rect = NSString(string: self).boundingRect(with: CGSize(width: width, height: CGFloat(MAXFLOAT)), options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        return ceil(rect.height)
    }
    func ga_heightForComment(fontSize: CGFloat, width: CGFloat, maxHeight: CGFloat) -> CGFloat {
        let font = UIFont.systemFont(ofSize: fontSize)
        let rect = NSString(string: self).boundingRect(with: CGSize(width: width, height: CGFloat(MAXFLOAT)), options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        return ceil(rect.height)>maxHeight ? maxHeight : ceil(rect.height)
    }
    ///获取MD5
    func md5() -> String {
        let str = self.cString(using: String.Encoding.utf8)
        let strLen = CUnsignedInt(self.lengthOfBytes(using: String.Encoding.utf8))
        let digestLen = Int(CC_MD5_DIGEST_LENGTH)
        let result = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: digestLen)
        
        CC_MD5(str!, strLen, result)
        let hash = NSMutableString()
        for i in 0 ..< digestLen {
            hash.appendFormat("%02x", result[i])
        }
        result.deinitialize(count:digestLen)
        return String(format: hash as String)
    }
    ///日期转换 String->Int 时间戳
    func toDateInterval() -> Int {
        let dfmatter = DateFormatter()
        dfmatter.dateFormat="yyyy-MM-dd HH:mm:ss"
        dfmatter.timeZone=TimeZone(abbreviation: "GMT")
        let date = dfmatter.date(from: self)
        let dateStamp:TimeInterval = (date?.timeIntervalSince1970)!
        let dateSt:Int = Int(dateStamp)
        return dateSt
    }
    ///时间转换 String->Date
    func toDate() -> Date  {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        formatter.timeZone=TimeZone(abbreviation: "Asia/Shanghai")
        return formatter.date(from: self)!
    }
    ///获取当前的天
    func getToDay() ->String {
        let date:Date = self.toToDay()
        let todayS=date.toDateString()
        
        return todayS
    }
    ///当前的天
    func toToDay() ->  Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        formatter.timeZone=TimeZone(abbreviation: "Asia/Shanghai")
        return formatter.date(from: self)!
    }
    
    
    ///判断是否是当天
    func isToDay() -> Bool {
        let currentDate = Date()
        let otherDate = self.toDate()
        let tempDate = Int(currentDate.timeIntervalSince(otherDate))
        return tempDate > 24*60*60
    }
    
    ///距现在多长时间
    func distanceNow() -> Int {
        let currentDate = Date()
        let otherDate = self.toDate()
        let tempDate = Int(otherDate.timeIntervalSince(currentDate))
        return tempDate > 0 ? tempDate : 0
    }
    
    
    ///获取文字的行数
    func ga_TextLines(width:CGFloat,fontSize:CGFloat) ->Int {
        let size  = self.size(withAttributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: fontSize)])
        return Int(ceil((size.width)/width))
    }
    func ga_TextLines(width:CGFloat,font:UIFont) ->Int {
        let size  = self.size(withAttributes: [NSAttributedString.Key.font : font])
        return Int(ceil((size.width)/width))
    }
    ///获取文字的行数 size
   func ga_TextSize(width:CGFloat,fontSize:CGFloat) -> CGSize {
        let font:UIFont! = UIFont.systemFont(ofSize: fontSize)
        let attributes : [NSAttributedString.Key : Any] = [NSAttributedString.Key.font:font]
        let option = NSStringDrawingOptions.usesLineFragmentOrigin
        let rect:CGRect = self.boundingRect(with: CGSize(width: width, height: CGFloat(MAXFLOAT)), options: option, attributes: attributes , context: nil)
        return rect.size
    }
    
    func getTextHeigh( font : UIFont, width : CGFloat)  -> CGFloat{
        let normalText : NSString = self as NSString
        let size = CGSize(width: width, height:1000)   //CGSizeMake(width,1000)
        let dic = NSDictionary(object: font, forKey : kCTFontAttributeName as! NSCopying)
        let stringSize = normalText.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: dic as? [NSAttributedString.Key:Any], context:nil).size
        return  stringSize.height
        
    }
    
    ///时间戳String->String(Date)
    func timeStamp(withFormate formate:String="yyyy-MM-dd HH:mm:ss") -> String {
        let timeInt = Int(self)
        let timeInterval:TimeInterval = TimeInterval(timeInt!)
        let date = NSDate(timeIntervalSince1970: timeInterval)
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = formate //自定义日期格式
        let time = dateformatter.string(from: date as Date)
        return time
    }
    
    ///时间字符串->时间字符串
    func stringDataToStringData(withFormate formate:String="yyyy-MM-dd HH:mm:ss") -> String{
        let date = self.toToDay()
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = formate //自定义日期格式
        let time = dateformatter.string(from: date as Date)
        return time
    }
    
    // base64编码
    func toBase64() -> String? {
        if let data = self.data(using: .utf8) {
            return data.base64EncodedString()
        }
        return nil
    }
    
    // base64解码
    func fromBase64() -> String? {
        if let data = Data(base64Encoded: self) {
            return String(data: data, encoding: .utf8)
        }
        return nil
    }
    
    
    func base64Encoding()->String {
        let plainData = self.data(using: String.Encoding.utf8)
        let base64String = plainData?.base64EncodedString(options: NSData.Base64EncodingOptions.init(rawValue: 0))
        return base64String!
    }
   
    func base64Decoding()->String
    {
        var str = self.replacingOccurrences(of: " ", with: "")
        str = str.replacingOccurrences(of: "\n", with: "")
        if let tempData=NSData(base64Encoded: str, options: NSData.Base64DecodingOptions.init(rawValue: 0)){
            if let decodedString = NSString(data: tempData as Data, encoding: String.Encoding.utf8.rawValue){
                return decodedString as String
            }
            return self
        }
        return self
    }
    func StringToFloat()->(CGFloat){
        var cgFloat:CGFloat = 0
        if let doubleValue = Double(self)
        {
            cgFloat = CGFloat(doubleValue)
        }
        return cgFloat
    }
    ///html字符串转 NSMutableAttributedString
    func htmlToAttribute() -> NSMutableAttributedString {
        let attributeString = try! NSMutableAttributedString(data: self.data(using: .unicode, allowLossyConversion: true)!, options: [.documentType:NSAttributedString.DocumentType.html,.characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
        return attributeString
    }
    ///（如果backwards参数设置为true，则返回最后出现的位置）
    func positionOf(sub:String, backwards:Bool = false)->Int {
        // 如果没有找到就返回-1
        var pos = -1
        if let range = range(of:sub, options: backwards ? .backwards : .literal ) {
            if !range.isEmpty {
                pos = self.distance(from:startIndex, to:range.lowerBound)
            }
        }
        return pos
    }
    
    /// range转换为NSRange
    func nsRange(from range: Range<String.Index>) -> NSRange {
        return NSRange(range, in: self)
    }
    
    /*
        *去掉首尾空格
        */
   var removeHeadAndTailSpace:String {
       let whitespace = NSCharacterSet.whitespaces
       return self.trimmingCharacters(in: whitespace)
   }
   /*
    *去掉首尾空格 包括后面的换行 \n
    */
   var removeHeadAndTailSpacePro:String {
       let whitespace = NSCharacterSet.whitespacesAndNewlines
       return self.trimmingCharacters(in: whitespace)
   }
   /*
    *去掉所有空格
    */
   var removeAllSapce: String {
       return self.replacingOccurrences(of: " ", with: "", options: .literal, range: nil)
   }
   /*
    *去掉首尾空格 后 指定开头空格数
    */
   func beginSpaceNum(num: Int) -> String {
       var beginSpace = ""
       for _ in 0..<num {
           beginSpace += " "
       }
       return beginSpace + self.removeHeadAndTailSpacePro
   }
    
    ///手机号隐藏中间四位
    func hiddenPhoneCenter() -> String {
        if self.count != 11{
            return "****"
        }
        let start = self.index(self.startIndex, offsetBy: 3)
        let end = self.index(self.startIndex, offsetBy: 7)
        let range = Range(uncheckedBounds: (lower: start, upper: end))
        return self.replacingCharacters(in: range, with: "****")
    }
    
    ///Range->NSRange
    func toNSRange(_ range: Range<String.Index>) -> NSRange {
        guard let from = range.lowerBound.samePosition(in: utf16), let to = range.upperBound.samePosition(in: utf16) else {
            return NSMakeRange(0, 0)
        }
        return NSMakeRange(utf16.distance(from: utf16.startIndex, to: from), utf16.distance(from: from, to: to))
    }
    ///NSRange->Range
    func toRange(_ range: NSRange) -> Range<String.Index>? {
        guard let from16 = utf16.index(utf16.startIndex, offsetBy: range.location, limitedBy: utf16.endIndex) else { return nil }
        guard let to16 = utf16.index(from16, offsetBy: range.length, limitedBy: utf16.endIndex) else { return nil }
        guard let from = String.Index(from16, within: self) else { return nil }
        guard let to = String.Index(to16, within: self) else { return nil }
        return from ..< to
    }
}

