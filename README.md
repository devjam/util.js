util.js
=======
util.js v1.2  
Copyright (c) 2012 SHIFTBRAIN Inc.  
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
Util.window.bindResize(callback) : void  
Util.window.unbindResize(callback, isReset = false) : void (isReset is unbind all)  

### Util.array
Util.array.setRemove(Array = Array.prototype) : Bool (add "remove" method)  

### console
consoleが無い場合に空のオブジェクト作成  
console.logでエラーが出る場合の対策

---

## HISTORY
_2012.11.30_  
- Util.stats 追加

_2012.11.28_  
- とりあえずアップ。
- Util.array 追加