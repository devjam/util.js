util.js
=======
util.js v 1.2.5  
Copyright (c) 2013 SHIFTBRAIN Inc.  
Licensed under the MIT license.  
https://github.com/devjam  

## REQUIRE:
jquery.js

## ADDITIONAL:
stats.js

---

## USAGE
### Util.UA
Util.UA.browser : String  
Util.UA.isIE : Bool  
Util.UA.isIE6 : Bool  
Util.UA.isIE7 : Bool  
Util.UA.isIE8 : Bool  
Util.UA.isIE9 : Bool  
Util.UA.isLtIE9 : Bool  
Util.UA.isIOS : Bool  
Util.UA.isIPhone : Bool  
Util.UA.isIPad : Bool  
Util.UA.isIPhone4 : Bool  
Util.UA.isIPad3 : Bool  
Util.UA.isAndroid : Bool  
Util.UA.isAndroidMobile	: Bool  
Util.UA.isChrome : Bool  
Util.UA.isSafari : Bool  
Util.UA.isMozilla : Bool  
Util.UA.isWebkit : Bool  
Util.UA.isOpera : Bool  
Util.UA.isPC : Bool  
Util.UA.isTablet : Bool  
Util.UA.isSmartPhone : Bool  

### Util.venderPrefix
Util.venderPrefix : String  

### Util.stats
Util.stats.show() : void  
Util.stats.remove() : void  

### Util.animationFrameDelta
Util.animationFrameDelta : Number  
Util.animationFrameDelta.setDelta() : void  

### Util.window
Util.window.onResize() : void (trigger resize event)  
Util.window.size(withUpdate = false) : {width:Integer, height:Integer}  
Util.window.pageSize(withUpdate = false) : {width:Integer, height:Integer}  
Util.window.scrollTop() : Number  
Util.window.scrollBottom() : Number  
Util.window.bindResize(callback) : void  
Util.window.unbindResize(callback, isReset = false) : void (isReset is unbind all)  

### Util.cursor
Util.cursor.over : "mouseenter touchstart"  
Util.cursor.out : "mouseleave touchend"  
Util.cursor.down : "mousedown touchstart"  
Util.cursor.move : "mousemove touchmouve"  
Util.cursor.up : "mouseup touchend"  
Util.cursor.click : "mouseup touchend"  
Util.cursor.clientXY(MouseEvent or TouchEvent) : {x:Number, y:Number}  
Util.cursor.pageXY(MouseEvent or TouchEvent) : {x:Number, y:Number}  

### Util.array
Util.array.setRemove(Array = Array.prototype) : Bool (add "remove" method)  
Util.array.setQuery(Array = Array.prototype) : Bool (add "q(id)" method)  

### Util.QueryString
Util.QueryString():Object

### Util.consoleKill
Util.consoleKill():void  
console.log 無効化  

### console
consoleが無い場合に空のオブジェクト作成  
console.logでエラーが出る場合の対策


---

## HISTORY
_2013.02.08 : v1.2.5_  
- debug -> consoleKill  

_2013.02.07 : v1.2.4_  
- Util.window.scrollTop()追加  
- Util.window.scrollBottom()追加  
- Util.cursor追加  
- Util.array.setQuery追加  
- debug追加  

_2012.12.13 : v1.2.1_  
- Util.UA 修正(min版のバグfix)
- requestAnimationFrame にcallback追加時多重登録修正

_2012.11.30 : v1.2_  
- Util.stats 追加

_2012.11.28 : v1.1_  
- とりあえずアップ。
- Util.array 追加