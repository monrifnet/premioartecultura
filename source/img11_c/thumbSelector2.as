class thumbSelector2 extends MovieClip {
	private var imgArray = new Array();
	private var btn1_mc:MovieClip;
	private var btn2_mc:MovieClip;
	private var pageNumber:Number;
	public var thumbLoadInterval;
	public function thumbSelector2(images:Array) {
		this.imgArray = images;
		createThumbs(0);
	}
	private function hideThumbs() {
		for (var i = 0; i<=4; i++) {
			delete this["thumb"+i].onEnterFrame;
			this["thumb"+i]._visible = false;
		}
	}
	private function showNextPage() {
		removeSelections();
		hideThumbs();
		this.pageNumber++;
		if (_root.loadThumbsAtOnce == 1) {
			this.loadThumbsAtOnce(this.pageNumber*4);
		} else {
			this.loadThumb(0, this.pageNumber*4, true);
		}
		if (this.pageNumber>0) {
			this.btn1_mc.onPress = function() {
				_parent.showPreviousPage();
			};
			this.btn1_mc.onRollOver = pageButtonRollOver;
			this.btn1_mc.onRollOut = this.btn1_mc.onReleaseOutside=pageButtonRollOut;
			this.btn1_mc.arrow1_mc._alpha = 100;
			this.btn1_mc.arrow2_mc._alpha = 100;
		} else {
			delete this.btn1_mc.onEnterFrame;
			this.btn1_mc.arrow1_mc._x = 0;
			this.btn1_mc.arrow1_mc._alpha = 35;
			this.btn1_mc.arrow2_mc._alpha = 35;
			delete this.btn1_mc.onPress;
			delete this.btn1_mc.onRollOver;
			delete this.btn1_mc.onRollOut;
			delete this.btn1_mc.onReleaseOutside;
		}
		trace(_root.imageArray.length-1+" > "+(this.pageNumber)*4);
		if (_root.imageArray.length-1>(this.pageNumber)*4) {
			this.btn2_mc.onPress = function() {
				_parent.showNextPage();
			};
			this.btn2_mc.onRollOver = pageButtonRollOver;
			this.btn2_mc.onRollOut = this.btn2_mc.onReleaseOutside=pageButtonRollOut;
			this.btn2_mc.arrow1_mc._alpha = 100;
			this.btn2_mc.arrow2_mc._alpha = 100;
		} else {
			delete this.btn2_mc.onEnterFrame;
			this.btn2_mc.arrow1_mc._x = 0;
			delete this.btn2_mc.onPress;
			delete this.btn2_mc.onRollOver;
			delete this.btn2_mc.onRollOut;
			delete this.btn2_mc.onReleaseOutside;
			this.btn2_mc.arrow1_mc._alpha = 35;
			this.btn2_mc.arrow2_mc._alpha = 35;
		}
	}
	private function showPreviousPage() {
		removeSelections();
		hideThumbs();
		this.pageNumber--;
		if (_root.loadThumbsAtOnce == 1) {
			this.loadThumbsAtOnce(this.pageNumber*4);
		} else {
			this.loadThumb(0, this.pageNumber*4, true);
		}
		if (this.pageNumber>0) {
			this.btn1_mc.onPress = function() {
				_parent.showPreviousPage();
			};
			this.btn1_mc.onRollOver = pageButtonRollOver;
			this.btn1_mc.onRollOut = this.btn1_mc.onReleaseOutside=pageButtonRollOut;
			this.btn1_mc.arrow1_mc._alpha = 100;
			this.btn1_mc.arrow2_mc._alpha = 100;
		} else {
			delete this.btn1_mc.onEnterFrame;
			this.btn1_mc.arrow1_mc._x = 0;
			this.btn1_mc.arrow1_mc._alpha = 35;
			this.btn1_mc.arrow2_mc._alpha = 35;
			delete this.btn1_mc.onPress;
			delete this.btn1_mc.onRollOver;
			delete this.btn1_mc.onRollOut;
			delete this.btn1_mc.onReleaseOutside;
		}
		if (_root.imageArray.length-1>(this.pageNumber+1)*3) {
			this.btn2_mc.onPress = function() {
				_parent.showNextPage();
			};
			this.btn2_mc.onRollOver = pageButtonRollOver;
			this.btn2_mc.onRollOut = this.btn2_mc.onReleaseOutside=pageButtonRollOut;
			this.btn2_mc.arrow1_mc._alpha = 100;
			this.btn2_mc.arrow2_mc._alpha = 100;
		} else {
			delete this.btn2_mc.onEnterFrame;
			delete this.btn2_mc.onPress;
			delete this.btn2_mc.onRollOver;
			delete this.btn2_mc.onRollOut;
			delete this.btn2_mc.onReleaseOutside;
			this.btn2_mc.arrow1_mc._alpha = 35;
			this.btn2_mc.arrow1_mc._x = 0;
			this.btn2_mc.arrow2_mc._alpha = 35;
		}
	}
	private function loadThumbsAtOnce(startThumb:Number) {
		var counter = 0;
		if (_root.smoothScroll != 1) {
			while (startThumb<=_root.imageArray.length-1 && counter<4) {
				this.loadThumb(counter, startThumb, false);
				counter++;
				startThumb++;
			}
		} else {
			while (startThumb<=_root.imageArray.length-1) {
				this.loadThumb(counter, startThumb, false);
				counter++;
				startThumb++;
			}
		}
	}
	private function pageButtonRollOver() {
		if (_root.animPageBtns == 1) {
			this.onEnterFrame = function() {
				if (this.arrow1_mc._x<6) {
					this.arrow1_mc._x += 1;
				} else {
					delete this.onEnterFrame;
				}
			};
		}
	}
	private function pageButtonRollOut() {
		if (_root.animPageBtns == 1) {
			this.onEnterFrame = function() {
				if (this.arrow1_mc._x>0) {
					this.arrow1_mc._x -= 1;
				} else {
					delete this.onEnterFrame;
				}
			};
		}
	}
	private function drawTriangle(target_mc:MovieClip) {
		target_mc.moveTo(0, 0);
		target_mc.lineStyle(1, _root.pageBtnColor, 100);
		target_mc.beginFill(_root.pageBtnColor, 100);
		target_mc.lineTo(10, 10);
		target_mc.lineTo(0, 20);
		target_mc.lineTo(0, 0);
		target_mc.endFill();
	}
	private function createThumbs() {
		var columns = 0;
		var rows = 0;
		this.pageNumber = 0;
		if (_root.smoothScroll != 1) {
			this.createEmptyMovieClip("btn1_mc", 2);
			this.createEmptyMovieClip("btn2_mc", 3);
		} else {
			_parent.createEmptyMovieClip("mask_mc", 150);
			if (_root.layoutType == 3) {
				_parent.drawRectangle(_parent.mask_mc, "0x000000", 0, "0x000000", 650, 10, 790, 450);
			} else if (_root.layoutType == 4) {
				_parent.drawRectangle(_parent.mask_mc, "0x000000", 0, "0x000000", 10, 10, 150, 450);
			}
			this.setMask(_parent.mask_mc);
			this.onEnterFrame = function() {
				if (this._height>420) {
					var yMouse = _root._ymouse;
					if (yMouse>440) {
						yMouse = 440;
					} else if (yMouse<20) {
						yMouse = 20;
					}
					yMouse;
					this._y += ((Math.round((420-this._height)*((yMouse-20)/4.2)/100)-this._y)/10)+2.5;
				}
			};
		}
		this.btn1_mc.createEmptyMovieClip("area_mc", 1);
		this.btn1_mc.createEmptyMovieClip("arrow1_mc", 2);
		this.btn1_mc.createEmptyMovieClip("arrow2_mc", 3);
		this.btn2_mc.createEmptyMovieClip("area_mc", 1);
		this.btn2_mc.createEmptyMovieClip("arrow1_mc", 2);
		this.btn2_mc.createEmptyMovieClip("arrow2_mc", 3);
		_parent.drawInvisibleRectangle(this.btn1_mc.area_mc, "0xffffff", 0, "0xffffff", 0, 0, 10, 20);
		_parent.drawInvisibleRectangle(this.btn2_mc.area_mc, "0xffffff", 0, "0xffffff", 0, 0, 10, 20);
		drawTriangle(this.btn1_mc.arrow1_mc);
		drawTriangle(this.btn1_mc.arrow2_mc);
		drawTriangle(this.btn2_mc.arrow1_mc);
		drawTriangle(this.btn2_mc.arrow2_mc);
		if (_root.smoothScroll != 1) {
			this.btn1_mc.arrow2_mc._x = 10;
			this.btn2_mc.arrow2_mc._x = 10;
			this.btn1_mc._xscale = -100;
			this.btn1_mc._x = 50;
			this.btn2_mc._x = 35;
			this.btn1_mc._y = 390;
			this.btn2_mc._y = 0;
			this.btn1_mc.arrow1_mc._alpha = 35;
			this.btn1_mc.arrow2_mc._alpha = 35;
			if (_root.imageArray.length<=4) {
				this.btn2_mc.gotoAndStop(6);
			} else {
				this.btn2_mc.onRollOver = pageButtonRollOver;
				this.btn2_mc.onRollOut = this.btn2_mc.onReleaseOutside=pageButtonRollOut;
				this.btn2_mc.gotoAndStop(1);
				this.btn2_mc.onPress = function() {
					_parent.showNextPage();
				};
			}
		}
		var amount:Number;
		if (_root.smoothScroll == 1) {
			amount = _root.imageArray.length-1;
		} else {
			amount = 3;
		}
		for (var i = 0; i<=amount; i++) {
			this.createEmptyMovieClip("thumb"+i, i+5);
			this["thumb"+i].thumbNumber = i;
			this["thumb"+i].createEmptyMovieClip("shadow_mc", 1);
			this["thumb"+i].createEmptyMovieClip("bg_mc", 2);
			if (_root.drawShadows == 1) {
				_parent.blurredRect(this["thumb"+i].shadow_mc, -1*_root.shadowWidth, -1*_root.shadowWidth, 80+(2*_root.shadowWidth), 80+(2*_root.shadowWidth), 10, _root.shadowColor, _root.shadowAlpha);
			}
			if (_root.roundRect == 1) {
				_parent.drawRoundedRectangle(this["thumb"+i].bg_mc, _root.picBgColor, 1, _root.picBgColor, 0, 0, 80, 80, _root.roundPix);
			} else {
				_parent.drawRectangle(this["thumb"+i].bg_mc, _root.picBgColor, 1, _root.picBgColor, 0, 0, 80, 80);
			}
			this["thumb"+i]._x = columns*90;
			if (_root.smoothScroll != 1) {
				this["thumb"+i]._y = 30+(rows*90);
			} else {
				this["thumb"+i]._y = rows*90;
			}
			if (_root.smoothScroll != 1) {
				this["thumb"+i]._visible = false;
			}
			rows++;
		}
		if (_root.loadThumbsAtOnce == 1) {
			loadThumbsAtOnce(0);
		} else {
			loadThumb(0, 0, true);
		}
		//loadThumbImages(0);
	}
	private function loadThumb() {
		clearInterval(this.thumbLoadInterval);
		var wichThumbViewer = arguments[0];
		var currentThumb = arguments[1];
		this["thumb"+wichThumbViewer]._visible = true;
		this["thumb"+wichThumbViewer].createEmptyMovieClip("imageHolder", 5);
		this["thumb"+wichThumbViewer].imageHolder._x = 5;
		this["thumb"+wichThumbViewer].imageHolder._y = 5;
		this["thumb"+wichThumbViewer].imageHolder.createEmptyMovieClip("image", 5);
		this["thumb"+wichThumbViewer].imageHolder.image.loadMovie(_root.imageArray[currentThumb][0]);
		this["thumb"+wichThumbViewer].imageHolder.createEmptyMovieClip("mask", 6);
		this["thumb"+wichThumbViewer].imageHolder.attachMovie("mc_preloadBar", "preloader_mc", 4);
		if (_root.roundRect == 1) {
			_parent.drawRoundedRectangle(this["thumb"+wichThumbViewer].imageHolder.preloader_mc.bar_mc, _root.loadBarBgColor, 1, _root.loadBarBgColor, 0, 0, 50, 10, _root.roundPix);
		} else {
			_parent.drawRectangle(this["thumb"+wichThumbViewer].imageHolder.preloader_mc.bar_mc, _root.loadBarBgColor, 1, _root.loadBarBgColor, 0, 0, 50, 10);
		}
		this["thumb"+wichThumbViewer].imageHolder.preloader_mc._x = 10;
		this["thumb"+wichThumbViewer].imageHolder.preloader_mc._y = 25;
		if (_root.roundRect == 1) {
			_parent.drawRoundedRectangle(this["thumb"+wichThumbViewer].imageHolder.mask, _root.picBgColor, 1, _root.picBgColor, 0, 0, 70, 70, _root.roundPix);
		} else {
			_parent.drawRectangle(this["thumb"+wichThumbViewer].imageHolder.mask, _root.picBgColor, 1, _root.picBgColor, 0, 0, 70, 70);
		}
		this["thumb"+wichThumbViewer].imageHolder.setMask(this["thumb"+wichThumbViewer].imageHolder.mask);
		this["thumb"+wichThumbViewer].imageNumber = currentThumb;
		this["thumb"+wichThumbViewer].brightness = 100;
		this["thumb"+wichThumbViewer].imageHolder.preloader_mc._visible = false;
		delete this["thumb"+wichThumbViewer].onPress;
		delete this["thumb"+wichThumbViewer].onRollOver;
		delete this["thumb"+wichThumbViewer].onReleaseOutside;
		delete this["thumb"+wichThumbViewer].onRollOut;
		this["thumb"+wichThumbViewer].loadNext = arguments[2];
		this["thumb"+wichThumbViewer].onEnterFrame = function() {
			var percentage = (this.imageHolder.image.getBytesLoaded()/this.imageHolder.image.getBytesTotal())*100;
			this.imageHolder.preloader_mc.bar_mc._width = Math.round(percentage/2);
			if (percentage == 100) {
				if (this.imageNumber<_root.imageArray.length-1) {
					if (this.loadNext) {
						_parent.setLoadInterval(this.thumbNumber+1, currentThumb+1, true);
					}
					//_parent.loadThumb(this.thumbNumber+1, currentThumb+1);
				}
				delete this.onEnterFrame;
				this.onPress = function() {
					if (_root.showSelected == 1) {
						_parent.showSelection(this);
					}
					_parent._parent.loadImage(_root.imageArray[this.imageNumber][1], _root.imageArray[this.imageNumber][2], _root.imageArray[this.imageNumber][3], _root.imageArray[this.imageNumber][4], _root.imageArray[this.imageNumber][5]);
				};
				this.onRollOver = _parent.rollOverEffect1;
				this.onRollOut = this.onReleaseOutside=_parent.rollOutEffect1;
				this.onEnterFrame = _parent.rollOutEffect1;
			} else {
				this.imageHolder.preloader_mc._visible = true;
			}
		};
	}
	private function removeSelections() {
		var amount;
		if (_root.smoothScroll == 1) {
			amount = _root.imageArray.length-1;
		} else {
			amount = 3;
		}
		for (var i = 0; i<=amount; i++) {
			this["thumb"+i].selectionRect.removeMovieClip();
		}
	}
	private function showSelection(target_mc:MovieClip) {
		removeSelections();
		target_mc.createEmptyMovieClip("selectionRect", 8);
		if (_root.roundRect == 1) {
			_parent.drawRoundedRectangle(target_mc.selectionRect, _root.selectionColor, 1, _root.selectionColor, 5, 5, 75, 75, _root.roundPix);
		} else {
			_parent.drawRectangle(target_mc.selectionRect, _root.selectionColor, 1, _root.selectionColor, 5, 5, 75, 75);
		}
		target_mc.selectionRect._alpha = 0;
		target_mc.selectionRect.onEnterFrame = _parent.fadeIn25Function;
	}
	private function setLoadInterval(thumbNumber, thumb, loadNext) {
		thumbLoadInterval = setInterval(this, "loadThumb", _root.thumbLoadDelay, thumbNumber, thumb, loadNext);
	}
	function rollOverEffect1() {
		this.onEnterFrame = function() {
			var my_color;
			var myColorTransform;
			this.brightness += 10;
			my_color = new Color(this.imageHolder);
			myColorTransform = new Object();
			myColorTransform = {ra:'100', rb:this.brightness, ga:'100', gb:this.brightness, ba:'100', bb:this.brightness, aa:'100', ab:'0'};
			my_color.setTransform(myColorTransform);
			if (this.brightness>=60) {
				delete this.onEnterFrame;
			}
		};
	}
	function rollOutEffect1() {
		this.onEnterFrame = function() {
			var my_color;
			var myColorTransform;
			this.brightness -= 10;
			my_color = new Color(this.imageHolder);
			myColorTransform = new Object();
			myColorTransform = {ra:'100', rb:this.brightness, ga:'100', gb:this.brightness, ba:'100', bb:this.brightness, aa:'100', ab:'0'};
			my_color.setTransform(myColorTransform);
			if (this.brightness<=0) {
				delete this.onEnterFrame;
			}
		};
	}
}
