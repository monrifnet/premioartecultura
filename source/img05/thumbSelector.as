/** Copyright 2004 - 05 TUFaT.com, All Rights Reserved. **/

class thumbSelector extends MovieClip {
	private var imgArray = new Array();
	private var btn1_mc:MovieClip;
	private var btn2_mc:MovieClip;
	private var pageNumber:Number;
	private var thumbsPerPage:Number;
	private var amount:Number;
	private var columns:Number;
	private var rows:Number;
	private var y:Number;
	
	public var thumbLoadInterval;
	
	public function thumbSelector(images:Array) {
		this.imgArray = images;
		this.thumbsPerPage = 4;
		createThumbs(0);
		loadThumbs();
	}
	private function hideThumbs() {
		var thumb:Object
		var i:Number = 0;
		
		while (thumb = this["thumb"+i]) {
			delete thumb.onEnterFrame;
			thumb._visible = false;
			i++;
		}
	}
	private function showNextPage() {
		removeSelections();
		hideThumbs();
		this.pageNumber++;
		
		if (_root.loadThumbsAtOnce == 1) {
			this.loadThumbsAtOnce(this.pageNumber*this.thumbsPerPage);
		} else {
			this.loadThumb(0, this.pageNumber*this.thumbsPerPage, true);
		}
		
		this.pageNavigationState();
	}
	private function showPreviousPage() {
		removeSelections();
		hideThumbs();
		this.pageNumber--;
		
		if (_root.loadThumbsAtOnce == 1) {
			this.loadThumbsAtOnce(this.pageNumber*this.thumbsPerPage);
		} else {
			this.loadThumb(0, this.pageNumber*this.thumbsPerPage, true);
		}
		
		this.pageNavigationState();
	}
	
	private function pageNavigationState() {
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
		
		if (_root.imageArray.length>(this.pageNumber+1)*this.thumbsPerPage) {
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
			while (startThumb<=_root.imageArray.length-1 && counter<this.thumbsPerPage) {
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
		this.columns = 0;
		this.rows = 0;
		this.pageNumber = 0;
		
		if (_root.smoothScroll != 1) {
			this.createEmptyMovieClip("btn1_mc", 2);
			this.createEmptyMovieClip("btn2_mc", 3);
			
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
		} else {
			_parent.createEmptyMovieClip("mask_mc", 150);
			
			var p1, p2;
			p1 = _root.thumbPadding1;
			p2 = _root.thumbPadding2;
			
			if (_root.layoutType == 3)
				_parent.drawRectangle(_parent.mask_mc, "0x000000", 0, "0x000000", _parent.stageWidth-150, 10 + p1, _parent.stageWidth, _parent.stageHeight - 10 - p2);
			else if (_root.layoutType == 4)
				_parent.drawRectangle(_parent.mask_mc, "0x000000", 0, "0x000000", 10, 10 + p1, 150, _parent.stageHeight - 10 - p2);
			else if (_root.layoutType == 5)
				_parent.drawRectangle(_parent.mask_mc, "0x000000", 0, "0x000000", 10 + p1, 10, _parent.stageWidth - 10 - p2, 120);
			else if (_root.layoutType == 6)
				_parent.drawRectangle(_parent.mask_mc, "0x000000", 0, "0x000000", 10 + p1, _parent.stageHeight - 150, _parent.stageWidth - 10 - p2, _parent.stageHeight);
			_parent.mask_mc._alpha = 50;
			this.setMask(_parent.mask_mc);
			
			_parent.mask_mc.target = this;
			_parent.mask_mc.y = 20 + p1;
			_parent.mask_mc.h = _parent.stageHeight - p2 - 40 - p1;
			
			this.onEnterFrame = function() {
				
				var maxH = _parent.mask_mc.h;
				if (this._height > maxH) {
					this.y = 0;
					this.h = this._height - 10 - _root.shadowWidth;
					
					_parent.mask_mc.onEnterFrame = function() {
						if (_root.scrollWhenClose == 1 && !this.hitTest(this._xmouse, this._ymouse)) {
							this.target.y = this.target._y;
							return;
						}
						
						var mouseY = this._ymouse;
						
						mouseY = Math.max(this.y, mouseY);
						mouseY = Math.min(this.y + this.h, mouseY);
						
						this.target.y = this.y - (mouseY-this.y)*((this.target.h - this.h)/this.h);
					}
					
					this.onEnterFrame = function() {
						var ds = (this.y - this._y)/_root.speedSmoothness;
						
						var sign = ds > 0 ? 1 : -1;
						
						ds = sign * Math.min(Math.abs(ds), _root.maxSpeed);
						
						this._y += ds;
					}
				}
			}
		}
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
			if (_root.imageArray.length<=this.thumbsPerPage) {
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
		if (_root.smoothScroll == 1) {
			this.amount = _root.imageArray.length-1;
		} else {
			this.amount = 3;
		}
		for (var i = 0; i<=this.amount; i++) {
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
	}
	private function loadThumbs() {
		if (_root.loadThumbsAtOnce == 1) {
			loadThumbsAtOnce(0);
		} else {
			loadThumb(0, 0, true);
		}
	}
	private function loadThumb() {
		clearInterval(this.thumbLoadInterval);
		var wichThumbViewer = arguments[0];
		var currentThumb = arguments[1];
		var thumb = this["thumb"+wichThumbViewer];
		
		thumb._visible = true;
		thumb.createEmptyMovieClip("imageHolder", 5);
		thumb.imageHolder._x = 5;
		thumb.imageHolder._y = 5;
		thumb.imageHolder.createEmptyMovieClip("image", 5);
		thumb.imageHolder.image.loadMovie(_root.imageArray[currentThumb][0]);
		thumb.imageHolder.createEmptyMovieClip("mask", 6);
		thumb.imageHolder.attachMovie("mc_preloadBar", "preloader_mc", 4);
		if (_root.roundRect == 1) {
			_parent.drawRoundedRectangle(thumb.imageHolder.preloader_mc.bar_mc, _root.loadBarBgColor, 1, _root.loadBarBgColor, 0, 0, 50, 10, _root.roundPix);
		} else {
			_parent.drawRectangle(thumb.imageHolder.preloader_mc.bar_mc, _root.loadBarBgColor, 1, _root.loadBarBgColor, 0, 0, 50, 10);
		}
		thumb.imageHolder.preloader_mc._x = 10;
		thumb.imageHolder.preloader_mc._y = 25;
		if (_root.roundRect == 1) {
			_parent.drawRoundedRectangle(thumb.imageHolder.mask, _root.picBgColor, 1, _root.picBgColor, 0, 0, 70, 70, _root.roundPix);
		} else {
			_parent.drawRectangle(thumb.imageHolder.mask, _root.picBgColor, 1, _root.picBgColor, 0, 0, 70, 70);
		}
		thumb.imageHolder.setMask(this["thumb"+wichThumbViewer].imageHolder.mask);
		thumb.imageNumber = currentThumb;
		thumb.brightness = 100;
		thumb.imageHolder.preloader_mc._visible = false;
		delete thumb.onPress;
		delete thumb.onRollOver;
		delete thumb.onReleaseOutside;
		delete thumb.onRollOut;
		thumb.loadNext = arguments[2];
		thumb.onEnterFrame = function() {
			var percentage = (this.imageHolder.image.getBytesLoaded()/this.imageHolder.image.getBytesTotal())*100;
			this.imageHolder.preloader_mc.bar_mc._width = Math.round(percentage/2);
			if (percentage == 100) {
				if (this.imageNumber<_root.imageArray.length-1) {
					if (this.loadNext) {
						if (_root.smoothScroll != 1) {
							if (this.thumbNumber < this._parent.thumbsPerPage - 1){
								_parent.setLoadInterval(this.thumbNumber+1, currentThumb+1, true);
							}
						} else {
							_parent.setLoadInterval(this.thumbNumber+1, currentThumb+1, true);
						}
					}
				}
				delete this.onEnterFrame;
				this.onPress = function() {
					if (_root.showSelected == 1) {
						_parent.showSelection(this);
					}
					_parent._parent.loadImage(this.imageNumber);
				};
				
				if (_root.thumbResize == 1) {
					var maxWidth = 70;
					var maxHeight = 70;
					var ratio, wRatio, hRatio;
					
					wRatio = this.imageHolder.image._width / maxWidth;
					hRatio = this.imageHolder.image._height / maxHeight;
					
					ratio = Math.max(wRatio, hRatio);
					
					this.imageHolder.image._width /= ratio;
					this.imageHolder.image._height /= ratio;
				}
				
				//adjust thumbnail position
				if (this.imageHolder.image._width < 70) {
					this.imageHolder.image._x = (70 - this.imageHolder.image._width) / 2;
				}
				
				if (this.imageHolder.image._height < 70) {
					this.imageHolder.image._y = (70 - this.imageHolder.image._height) / 2;
				}
				
				this.onRollOver = _parent.rollOverEffect1;
				this.onRollOut = this.onReleaseOutside=_parent.rollOutEffect1;
				this.onEnterFrame = _parent.rollOutEffect1;
				this.imageHolder.preloader_mc._visible = false;
				
				if (_parent._parent.currentImage == this.imageNumber) {
					_parent.showSelection(this);
				}
			} else {
				this.imageHolder.preloader_mc._visible = true;
			}
		}
	}
	public function removeSelections() {
		var thumb:Object
		var i:Number = 0;
		
		while (thumb = this["thumb"+i]) {
			thumb.selectionRect.removeMovieClip();
			i++;
		}
	}
	public function showSelection(target_mc:MovieClip) {
		if (_root.showSelected != 1) return;
		
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
