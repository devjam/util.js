###
util.js v1.2.4
Copyright (c) 2013 SHIFTBRAIN Inc.
Licensed under the MIT license.

https://github.com/devjam

Util.UA.browser					: String
Util.UA.isIE						: Bool
Util.UA.isIE6						: Bool
Util.UA.isIE7						: Bool
Util.UA.isIE8						: Bool
Util.UA.isIE9						: Bool
Util.UA.isLtIE9					: Bool
Util.UA.isIOS						: Bool
Util.UA.isIPhone				: Bool
Util.UA.isIPad					: Bool
Util.UA.isIPhone4				: Bool
Util.UA.isIPad3					: Bool
Util.UA.isAndroid				: Bool
Util.UA.isAndroidMobile	: Bool
Util.UA.isChrome				: Bool
Util.UA.isSafari				: Bool
Util.UA.isMozilla				: Bool
Util.UA.isWebkit				: Bool
Util.UA.isOpera					: Bool
Util.UA.isPC						: Bool
Util.UA.isTablet				: Bool
Util.UA.isSmartPhone		: Bool

Util.venderPrefix				:String

Util.stats.show()				:void
Util.stats.remove()			:void

Util.animationFrameDelta						:Number
Util.animationFrameDelta.setDelta()	:void

Util.window.onResize()															:void (trigger resize event)
Util.window.size(withUpdate = false)								:{width:Integer, height:Integer}
Util.window.pageSize(withUpdate = false)						:{width:Integer, height:Integer}
Util.window.scrollTop()															:Number
Util.window.scrollBottom()													:Number
Util.window.bindResize(callback)										:void
Util.window.unbindResize(callback, isReset = false)	:void (isReset is unbind all)

Util.cursor.over																	:"mouseenter touchstart"
Util.cursor.out 																	:"mouseleave touchend"
Util.cursor.down 																	:"mousedown touchstart"
Util.cursor.move 																	:"mousemove touchmouve"
Util.cursor.up 																		:"mouseup touchend"
Util.cursor.click 																:"mouseup touchend"
Util.cursor.clientXY(e:MouseEvent or TouchEvent)	:{x:Number, y:Number}
Util.cursor.pageXY(e:MouseEvent or TouchEvent)		:{x:Number, y:Number}

Util.array.setRemove(Array = Array.prototype)	:Bool ary.remove(value)
Util.array.setQuery(Array = Array.prototype)	:Bool ary.q(id)

Util.QueryString():Object

## debug
debug.log(value)					: void
debug.active(Bool = true) : Bool

###

unless @console?
	@console =
		log: ->

class @Util
	@UA = (->
		_ua = navigator.userAgent.toLowerCase()
		ua =
			isIE: false
			isIE6: false
			isIE7: false
			isIE8: false
			isIE9: false
			isLtIE9: false
			isIOS: false
			isIPhone: false
			isIPad: false
			isIPhone4: false
			isIPad3: false
			isAndroid: false
			isAndroidMobile: false
			isChrome: false
			isSafari: false
			isMozilla: false
			isWebkit: false
			isOpera: false
			isPC: false
			isTablet: false
			isSmartPhone: false
			browser: _ua
			
		if ua.isIE = /msie\s(\d+)/.test _ua
			ver = RegExp.$1
			ver *= 1
			ua.isIE6 = ver == 6
			ua.isIE7 = ver == 7
			ua.isIE8 = ver == 8
			ua.isIE9 = ver == 9
			ua.isLtIE9 = ver < 9
		if ua.isIE7 and _ua.indexOf('trident/4.0') != -1
			ua.isIE7 = false
			ua.isIE8 = true
		if ua.isIPhone = /i(phone|pod)/.test _ua
			ua.isIPhone4 = window.devicePixelRatio == 2
		if ua.isIPad = /ipad/.test _ua
			isIPad3 = window.devicePixelRatio == 2
		ua.isIOS = ua.isIPhone || ua.isIPad
		ua.isAndroid = /android/.test _ua
		ua.isAndroidMobile = /android(.+)?mobile/.test _ua
		ua.isPC = !ua.isIOS && !ua.isAndroid
		ua.isTablet = ua.isIPad || (ua.isAndroid && ua.isAndroidMobile)
		ua.isSmartPhone = ua.isIPhone || ua.isAndroidMobile
		ua.isChrome = /chrome/.test _ua
		ua.isWebkit = /webkit/.test _ua
		ua.isOpera = /opera/.test _ua
		ua.isMozilla = _ua.indexOf("compatible") < 0 && /mozilla/.test _ua
		ua.isSafari = !ua.isChrome && ua.isWebkit
		ua
	)()

	@venderPrefix = (->
		if Util.UA.isIE then return "-ms-"
		if Util.UA.isWebkit then return "-webkit-"
		if Util.UA.isMozilla then return "-moz-"
		if Util.UA.isOpera then return "-o-"
		""
	)()

	@stats = (->
		sts = null
		stsTimer = null
		update = ->
			if !Stats? or !sts?
				return false
			stsTimer = requestAnimationFrame update
			sts.update()

		show: (mode = 0) ->
			if !Stats? or sts? or Util.UA.isLtIE9
				return false
			sts = new Stats()
			sts.setMode(mode)
			document.body.appendChild( sts.domElement )
			sts.domElement.style.cssText = "position:fixed; top:0; left:0; z-index:9999999;"
			update()

		remove: ->
			if !Stats? or !sts?
				return false
			if stsTimer?
				cancelAnimationFrame(stsTimer)
			document.body.removeChild( sts.domElement )
			sts = null
	)()

	@animationFrameDelta = 0
	(->
		isDateHasNow = !!Date.now
		lastTime = if isDateHasNow then Date.now() else +new Date
		callbacks = []
		
		setDelta = (calledTime)->
			Util.animationFrameDelta = calledTime - lastTime
			lastTime = calledTime
			window.requestAnimationFrame setDelta
			return
		
		if !window.requestAnimationFrame
			prefix = Util.venderPrefix.replace /-/g, ""
			window.requestAnimationFrame = window[prefix + "RequestAnimationFrame"]
			window.cancelAnimationFrame = window[prefix + "CancelAnimationFrame"] || window[prefix + "CancelRequestAnimationFrame"]
			
		if !window.requestAnimationFrame
			window.requestAnimationFrame = (->
				id = 0
				(callback, element)->
					if callbacks.length == 0
						id = setTimeout ->
							now = if isDateHasNow then Date.now() else +new Date
							
							#同期だと処理が溢れるかなと思って非同期を試したけど
							#パフォーマンスが悪かった。他になにかいい方法がある?
							#(今は同期)
							cbs = callbacks
							callbacks = []
							while cb = cbs.shift()
								cb now

							return
						, 16
						#setTimeoutのdelay値をdelta値によって可変させてみたけど、
						#具合が悪そうなので固定にした。
					if $.inArray?
						if typeof callback == "function" && $.inArray(callback, callbacks) == -1
							callbacks.push callback
					else
						callbacks.push callback
					id
			)()
			
			window.cancelAnimationFrame = (id)->
				callbacks = []
				clearTimeout id
	
		setDelta if isDateHasNow then Date.now() else +new Date
		return
	)()

	@window = (->
		win = $ window
		doc = $ document
		width = 0
		height = 0
		pageWidth = 0
		pageHeight = 0
		resizeCallbacks = []
		isUpdate = 0

		onResize = ->
			isUpdate = 3
			callbacks = resizeCallbacks.concat()
			for callback in callbacks
				callback()
			return

		win.resize onResize
		$(->
			width = win.width()
			height = win.height()
			pageWidth = doc.width()
			pageHeight = doc.height()
		)

		size: (withUpdate = false)->
			if withUpdate || isUpdate & 1
				isUpdate = (isUpdate | 1) ^ 1
				width = win.width()
				height = win.height()

			width: width
			height: height
			
		pageSize: (withUpdate = false)->
			if withUpdate || isUpdate & 2
				isUpdate = (isUpdate | 2) ^ 2
				pageWidth = doc.width()
				pageHeight = doc.height()

			width: pageWidth
			height: pageHeight

		scrollTop: ->
			if window.pageYOffset?
				return window.pageYOffset
			return win.scrollTop()

		scrollBottom: ->
			if window.pageYOffset?
				return window.pageYOffset + window.innerHeight
			return win.scrollTop() + height

		bindResize: (callback)->
			if typeof callback == "function" && $.inArray(callback, resizeCallbacks) == -1
				resizeCallbacks.push callback
			return

		unbindResize: (callback, isReset = false)->
			if callback && (index = $.inArray callback, resizeCallbacks) != -1
				resizeCallbacks.splice index, 1
			if isReset
				resizeCallbacks = []
			return

	)()

	@cursor = (->
		c =
			over : "mouseenter touchstart"
			out : "mouseleave touchend"
			down : "mousedown touchstart"
			move : "mousemove touchmouve"
			up : "mouseup touchend"
			click : "mouseup touchend"

			clientXY : (e)=>
				pos = {x:0, y:0}
				if e?
					if "ontouchstart" of window
						if e.touches?
							e = e.touches[0]
						else
							e = e.originalEvent.touches[0]
					if e.clientX?
						pos.x = e.clientX
						pos.y = e.clientY
				return pos

			pageXY : (e)=>
				pos = {x:0, y:0}
				if e?
					if "ontouchstart" of window
						if e.touches?
							e = e.touches[0]
						else
							e = e.originalEvent.touches[0]
					if e.pageX?
						pos.x = e.pageX
						pos.y = e.pageY
				return pos
	)()

	@array = (->
		setRemove: (ary)->
			unless ary?
				ary = Array.prototype
			else 
				unless ary instanceof Array
					return false

			if ary.remove?
				return false

			ary.remove = ->
				# BUG：IE で thisがarrayでなく functionになってしまう
				l = arguments.length
				i = 0
				while i < l
					m = @.length
					j = 0
					while j < m
						if arguments[i] == @[j]
							@.splice(j, 1)
							m--
						else
							j++
					i++
				@.length
			true

		setQuery: (ary)->
			unless ary?
				ary = Array.prototype
			else 
				unless ary instanceof Array
					return false		
			
			if ary.remove?
				return false

			ary.q = (key, value)->
				# BUG：IE で thisがarrayでなく functionになってしまう
				unless value?
					value = key
					key = "id"
				ary_match =[]
				i = 0
				l = @.length
				while i < l
					item = @[i]
					if item[key] == value
						ary_match.push(item)
					i++

				if ary_match.length == 1
					return ary_match[0]
				else
					return ary_match
			true
	)()

	@QueryString = ((a)->
		unless a?
			return {}
		data = {}
		value = []
		i = 0
		l = a.length
		n = 0
		while i < l
			ary = a[i].split('=')
			if ary.length == 1 or ary[0] == "value"
				value.push(decodeURIComponent(ary[0].replace(/\+/g, " ")))
			else if ary.length == 2
				data[ary[0]] = decodeURIComponent(ary[1].replace(/\+/g, " "))
				n++
			i++
		if value.length > 0
			if value.length == 1
				if n == 0
					return value[0]
				else
					data["value"] = value[0]
			else
				if n == 0
					return value
				else
					data["value"] = value
		return data
	)(window.location.search.substr(1).split('&'))

	constructor: ->
		throw new Error('it is static class')

class @debug

	mode = false

	@log: (v)->
		if mode then console.log v
		false

	@active: (flg = true)->
		mode = new Boolean(flg)

	constructor: ->
		throw new Error('it is static class')
