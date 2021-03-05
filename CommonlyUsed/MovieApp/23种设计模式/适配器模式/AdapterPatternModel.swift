//
//  StrategyPatternModel.swift
//  MovieApp
//
//  Created by 湛亚磊 on 2021/3/5.
//
/**
 适配器模式
 介绍文档
 https://www.runoob.com/design-pattern/adapter-pattern.html
 
 适配器模式（Adapter Pattern）是作为两个不兼容的接口之间的桥梁。这种类型的设计模式属于结构型模式，它结合了两个独立接口的功能。

 这种模式涉及到一个单一的类，该类负责加入独立的或不兼容的接口功能。举个真实的例子，读卡器是作为内存卡和笔记本之间的适配器。您将内存卡插入读卡器，再将读卡器插入笔记本，这样就可以通过笔记本来读取内存卡。
 
 我们通过下面的实例来演示适配器模式的使用。其中，音频播放器设备只能播放 mp3 文件，通过使用一个更高级的音频播放器来播放 vlc 和 mp4 文件。
 
 
 
 
 意图：将一个类的接口转换成客户希望的另外一个接口。适配器模式使得原本由于接口不兼容而不能一起工作的那些类可以一起工作。
 
 主要解决：主要解决在软件系统中，常常要将一些"现存的对象"放到新的环境中，而新环境要求的接口是现对象不能满足的。
 
 何时使用： 1、系统需要使用现有的类，而此类的接口不符合系统的需要。 2、想要建立一个可以重复使用的类，用于与一些彼此之间没有太大关联的一些类，包括一些可能在将来引进的类一起工作，这些源类不一定有一致的接口。 3、通过接口转换，将一个类插入另一个类系中。（比如老虎和飞禽，现在多了一个飞虎，在不增加实体的需求下，增加一个适配器，在里面包容一个虎对象，实现飞的接口。）
 
 如何解决：继承或依赖（推荐）
 
 关键代码：适配器继承或依赖已有的对象，实现想要的目标接口。
 
 优点： 1、可以让任何两个没有关联的类一起运行。 2、提高了类的复用。 3、增加了类的透明度。 4、灵活性好。

 缺点： 1、过多地使用适配器，会让系统非常零乱，不易整体进行把握。比如，明明看到调用的是 A 接口，其实内部被适配成了 B 接口的实现，一个系统如果太多出现这种情况，无异于一场灾难。因此如果不是很有必要，可以不使用适配器，而是直接对系统进行重构。 2.由于 JAVA 至多继承一个类，所以至多只能适配一个适配者类，而且目标类必须是抽象类。

 使用场景：有动机地修改一个正常运行的系统的接口，这时应该考虑使用适配器模式。

 注意事项：适配器不是在详细设计时添加的，而是解决正在服役的项目的问题。
 
 */

import UIKit

//1.为媒体播放器和更高级的媒体播放器创建接口。
protocol MediaPlayer {
    func play(with audioType:String,with fileName:String)
}

protocol AdvancedMediaPlayer {
    func playVlc(with fileName:String)
    func playMp4(with fileName:String)
}


//2.创建实现了 AdvancedMediaPlayer 接口的实体类。
class VlcPlayer:NSObject,AdvancedMediaPlayer {
    func playVlc(with fileName: String) {
        print("playing vlc fileName: \(fileName)")
    }
    
    func playMp4(with fileName: String) {
        //不用处理
    }
}

class Mp4Player:NSObject,AdvancedMediaPlayer {
    func playVlc(with fileName: String) {
        //不用处理
    }
    
    func playMp4(with fileName: String) {
        print("playing mp4 fileName: \(fileName)")
    }
}


//3.创建实现了 MediaPlayer 接口的适配器类。
class MediaAdapter: NSObject,MediaPlayer {
    var advancedMusicPlayer:AdvancedMediaPlayer?
    
    init(with audioType:String) {
        super.init()
        if audioType == "vlc" {
            advancedMusicPlayer = VlcPlayer()
        }else if audioType == "mp4"{
            advancedMusicPlayer=Mp4Player()
        }
    }
    
    func play(with audioType: String, with fileName: String) {
        if audioType == "vlc" {
            advancedMusicPlayer?.playVlc(with: fileName)
        }else if audioType == "mp4"{
            advancedMusicPlayer?.playMp4(with: fileName)
        }
    }
}

//4.创建实现了 MediaPlayer 接口的实体类。
class AudioPlayer: NSObject,MediaPlayer {
    var mediaAdapter:MediaAdapter?
    
    func play(with audioType: String, with fileName: String) {
        ////播放 mp3 音乐文件的内置支持
        if audioType == "mp3"{
            print("playing mp3 filename:\(fileName)")
        }
        //mediaAdapter 提供了播放其他文件格式的支持
        else if audioType == "vlc" || audioType == "mp4"{
            mediaAdapter = MediaAdapter(with: audioType)
            mediaAdapter?.play(with: audioType, with: fileName)
        }else{
            print("位置媒体\(audioType)format not supported")
        }
    }
}

