/** Copyright 2004 - 05 TUFaT.com, All Rights Reserved. **/

class gallery extends MovieClip {
	private var imageArray = new Array();
	private var background_mc:MovieClip;
	private var thumbs_mc:MovieClip;
	private var title_mc:MovieClip;
	private var image_mc:MovieClip;
	private var img_mc:MovieClip;
	private var pnl_mc:MovieClip;
	private var shadow_mc:MovieClip;
	private var targetPositionX:Number;
	private var targetPositionY:Number;
	private var targetWidth:Number;
	private var targetHeight:Number;
	private var currentWidth:Number;
	private var currentHeight:Number;
	private var message_mc:MovieClip;
	private var zoomFactor:Number;
	private var finalWidth:Number;
	private var finalHeight:Number;
	public var currentImage:Number;	//for slideshow
	
	private var stageWidth:Number;
	private var stageHeight:Number;
	private var maxImageWidth:Number;
	private var maxImageHeight:Number;
	
	public function gallery() {
		this.stageWidth = Stage.width ? Stage.width : 778 ;
		this.stageHeight = Stage.height ? Stage.height : 460;
	}
	public function initCanvas() {
		var sw10 = this.stageWidth - 10;
		var sh10 = this.stageHeight - 10;
		var sw5 = this.stageWidth - 5;
		var sh5 = this.stageHeight - 5;
		
		this.zoomFactor = 1;
		this.currentImage = 0;
		this.createEmptyMovieClip("background_mc", 1);
		this.createEmptyMovieClip("shadow_mc", 2);
		this.createEmptyMovieClip("pnl_mc", 3);
		if (_root.roundRect == 1) {
			if (_root.drawShadows == 1) {
				this.blurredRect(this.background_mc, 5+(-1*_root.shadowWidth), 5+(-1*_root.shadowWidth), sw10+(2*_root.shadowWidth), sh10+(2*_root.shadowWidth), 10, _root.shadowColor, _root.shadowAlpha);
			}
			this.drawRoundedRectangle(this.background_mc, _root.bgColor, 1, _root.bgColor, 5, 5, sw5, sh5, _root.roundPix);
			this.drawRoundedRectangle(this.pnl_mc, _root.pnlColor, 1, _root.pnlColor, 10, 10, sw10, sh10, _root.roundPix);
		} else {
			if (_root.drawShadows == 1) {
				this.blurredRect(this.shadow_mc, 5+(-1*_root.shadowWidth), 5+(-1*_root.shadowWidth), sw10+(2*_root.shadowWidth), sh10+(2*_root.shadowWidth), 10, _root.shadowColor, _root.shadowAlpha);
			}
			this.drawRectangle(this.background_mc, _root.bgColor, 1, _root.bgColor, 5, 5, sw5, sh5);
			this.drawRectangle(this.pnl_mc, _root.pnlColor, 1, _root.pnlColor, 10, 10, sw10, sh10);
		}
		var thumbsMovie:String;
		switch(_root.layoutType) {
			case 1:
			case 2:
				thumbsMovie = "mc_thumbsSquare";
				break;
			case 3:
			case 4:
				thumbsMovie = "mc_thumbsVertical";
				break;
			case 5:
			case 6:
				thumbsMovie = "mc_thumbsHorizontal";
				break;
		}
		
		this.attachMovie(thumbsMovie, "thumbs_mc", 4, {images:_root.imageArray});
		
		this.createEmptyMovieClip("image_mc", 5);
		if (_root.layoutType == 1 || _root.layoutType == 2) {
			this.createEmptyMovieClip("title_mc", 6);
			this.title_mc.createTextField("Newfield_txt", 5, 0, 0, 780, 50);
			this.title_mc.Newfield_txt.embedFonts = true;
			this.title_mc.Newfield_txt.text = _root.gTitle;
			this.title_mc.Newfield_txt.selectable = false;
			var fmtEmphasis;
			
			fmtEmphasis = new TextFormat();
			fmtEmphasis.size = 36;
			fmtEmphasis.font = "Accidental Presidency";
			fmtEmphasis.color = _root.titleColor;
			this.title_mc.Newfield_txt.setTextFormat(fmtEmphasis);
			this.title_mc._y = 10;
		}
		if (_root.layoutType == 1) {
			this.thumbs_mc._x = this.stageWidth - 280;
			this.title_mc._x = sw5-this.title_mc.Newfield_txt.textWidth;
			this.thumbs_mc._y = this.stageHeight - 310;
		} else if (_root.layoutType == 2) {
			this.thumbs_mc._x = 20;
			this.title_mc._x = 15;
			this.thumbs_mc._y = this.stageHeight - 310;
		} else if (_root.layoutType == 3) {
			this.thumbs_mc._x = this.stageWidth - 100;
			this.thumbs_mc._y = this.stageHeight - 435;
		} else if (_root.layoutType == 4) {
			this.thumbs_mc._x = 20;
			this.thumbs_mc._y = this.stageHeight - 435;
		} else if (_root.layoutType == 5) {
			this.thumbs_mc._x = 20;
			this.thumbs_mc._y = 20;
		} else if (_root.layoutType == 6) {
			this.thumbs_mc._x = 20;
			this.thumbs_mc._y = this.stageHeight - 100;
		}
		//loadImage(, _root.imageArray[0][2], _root.imageArray[0][3], _root.imageArray[0][4], _root.imageArray[0][5]);
		loadImage(0);
	}
	
	private function doImageConstraints(ic:Object) {
		switch(_root.layoutType) {
		case 1:
			ic.imgAreaX = 20;
			ic.imgAreaY = 20;
			ic.imgAreaW = this.stageWidth - 320;
			ic.imgAreaH = this.stageHeight - 50;
			break;
		case 2:
			ic.imgAreaX = 300;
			ic.imgAreaY = 20;
			ic.imgAreaW = this.stageWidth - 320;
			ic.imgAreaH = this.stageHeight - 50;
			break;
		case 3:
			ic.imgAreaX = 20;
			ic.imgAreaY = 20;
			ic.imgAreaW = this.stageWidth - 150;
			ic.imgAreaH = this.stageHeight - 50;
			break;
		case 4:
			ic.imgAreaX = 130;
			ic.imgAreaY = 20;
			ic.imgAreaW = this.stageWidth - 160;
			ic.imgAreaH = this.stageHeight - 50;
			break;
		case 5:
			ic.imgAreaX = 20;
			ic.imgAreaY = 110;
			ic.imgAreaW = this.stageWidth - 50;
			ic.imgAreaH = this.stageHeight - 140;
			break;
		case 6:
			ic.imgAreaX = 20;
			ic.imgAreaY = 20;
			ic.imgAreaW = this.stageWidth - 50;
			ic.imgAreaH = this.stageHeight - 140;
			break;
		}
		switch(_root.hAlign) {
			case "left":
				ic.imgAreaX+=_root.hMargin;
				ic.imgAreaW-=_root.hMargin;
				break;
			case "right":
				ic.imgAreaW-=_root.hMargin;
				break;
		}
		switch(_root.vAlign) {
			case "top":
				ic.imgAreaY+=_root.vMargin;
				ic.imgAreaH-=_root.vMargin;
				break;
			case "bottom":
				ic.imgAreaH-=_root.vMargin;
				break;
		}
		
		ic.initImgX = ic.imgAreaX + ic.imgAreaW/2 - 35;
		ic.initImgY = ic.imgAreaY + ic.imgAreaH/2 - 15;
		
	}
	
	private function loadImage(img:Number) {
		var imagePath:String = _root.imageArray[img][1];
		var captionText:String = _root.imageArray[img][2];
		var imgURL:String = _root.imageArray[img][3];
		var popWidth:Number = _root.imageArray[img][4];
		var popHeight:Number = _root.imageArray[img][5];
		var ic:Object = new Object();
		
		this.doImageConstraints(ic);
		
		this.currentImage = img;
		
		this.image_mc.removeMovieClip();
		this.createEmptyMovieClip("image_mc", 7);
		this.image_mc.createEmptyMovieClip("shadow_mc", 1);
		this.image_mc.createEmptyMovieClip("bg_mc", 2);
		this.image_mc.attachMovie("mc_preloadBar", "preloader_mc", 3);
		if (_root.roundRect == 1) {
			drawRoundedRectangle(this.image_mc.preloader_mc.bar_mc, _root.loadBarBgColor, 1, _root.loadBarBgColor, 0, 0, 50, 10, _root.roundPix);
		} else {
			drawRectangle(this.image_mc.preloader_mc.bar_mc, _root.loadBarBgColor, 1, _root.loadBarBgColor, 0, 0, 50, 10);
		}
		this.image_mc.preloader_mc._x = 10;
		this.image_mc.preloader_mc._y = 10;
		this.image_mc.createEmptyMovieClip("img_mc", 4);
		this.image_mc.captionText = captionText;
		this.image_mc.img_mc._visible = false;
		if (_root.drawShadows == 1) {
			blurredRect(this.image_mc.shadow_mc, -1*_root.shadowWidth, -1*_root.shadowWidth, 70+(2*_root.shadowWidth), 30+(2*_root.shadowWidth), 10, _root.shadowColor, _root.shadowAlpha);
		}
		if (_root.roundRect == 1) {
			drawRoundedRectangle(this.image_mc.bg_mc, _root.picBgColor, 1, _root.picBgColor, 0, 0, 70, 30, _root.roundPix);
		} else {
			drawRectangle(this.image_mc.bg_mc, _root.picBgColor, 1, _root.picBgColor, 0, 0, 70, 30);
		}
		
		this.image_mc._x = ic.initImgX;
		this.image_mc._y = ic.initImgY;
		
		this.image_mc.img_mc._x = 5;
		this.image_mc.img_mc._y = 5;
		this.image_mc.img_mc.createEmptyMovieClip("image", 2);
		this.image_mc.img_mc.createEmptyMovieClip("caption_mc", 3);
		if (_root.showPrintBtn == 1) {
			this.image_mc.img_mc.attachMovie("mc_printButton", "printButton_mc", 8);
			this.image_mc.img_mc.printButton_mc._y = 1;
			this.image_mc.img_mc.printButton_mc.visible = false;
		}
		if (_root.showZoomBtns == 1) {
			this.image_mc.img_mc.attachMovie("mc_zoomButtons", "zoomButtons_mc", 9);
			this.image_mc.img_mc.printButton_mc._x = 33;
			this.image_mc.img_mc.zoomButtons_mc.visible = false;
		}
		this.image_mc.createEmptyMovieClip("mask", 5);
		this.image_mc.img_mc.image.loadMovie(imagePath);
		this.image_mc.img_mc.src = imagePath;
		this.image_mc.mask._x = 5;
		this.image_mc.mask._y = 5;
		this.image_mc.imageURL = imgURL;
		this.image_mc.popupWidth = popWidth;
		this.image_mc.popupHeight = popHeight;
		this.image_mc.ic = ic;
		this.image_mc.onEnterFrame = function() {
			var percentage = (this.img_mc.image.getBytesLoaded()/this.img_mc.image.getBytesTotal())*100;
			this.preloader_mc.bar_mc._width = Math.round(percentage/2);
			if (percentage == 100) {
				this.preloader_mc._visible = false;
				
				//we find the final width and height of the image
				
				var maxWidth, maxHeight;
				
				maxWidth = Math.min(this.img_mc.image._width,this.ic.imgAreaW);
				
				maxHeight = Math.min(this.img_mc.image._height,this.ic.imgAreaH);
				
				if (_root.autoResize) {
					var ratio, wRatio, hRatio;
					
					wRatio = this.img_mc._width / maxWidth;
					hRatio = this.img_mc._height / maxHeight;
					
					if (wRatio > 1 || hRatio > 1) {
						ratio = Math.max(wRatio, hRatio);
						
						this.img_mc.image._width /= ratio;
						this.img_mc.image._height /= ratio;
						
					}
				}
				
				this.targetWidth = Math.min(maxWidth, this.img_mc.image._width);
				this.targetHeight = Math.min(maxHeight, this.img_mc.image._height);
				
				this._parent.finalWidth = this.img_mc.image._width;
				this._parent.finalHeight = this.img_mc.image._height;
				
				if (_root.roundRect == 1) {
					this._parent.drawRoundedRectangle(this.mask, 0xff0000, 1, 0xff0000, 0, 0, this.targetWidth, this.targetHeight, _root.roundPix);
				} else {
					this._parent.drawRectangle(this.mask, 0xff0000, 1, 0xff0000, 0, 0, this.targetWidth, this.targetHeight);
				}
				this.img_mc.setMask(this.mask);
				
				//we find the final position of the image
				
				switch(_root.hAlign) {
					case "center":
						this.targetPositionX = Math.round((this.ic.imgAreaW-targetWidth)/2)+this.ic.imgAreaX;
						break;
					case "left":
						this.targetPositionX = this.ic.imgAreaX;
						break;
					case "right":
						this.targetPositionX = this.ic.imgAreaX + this.ic.imgAreaW - targetWidth;
						break;
				}
				switch(_root.vAlign) {
					case "center":
						this.targetPositionY = Math.round((this.ic.imgAreaH-targetHeight)/2)+this.ic.imgAreaY;
						break;
					case "top":
						this.targetPositionY = this.ic.imgAreaY;
						break;
					case "bottom":
						this.targetPositionY = this.ic.imgAreaY + this.ic.imgAreaH - targetHeight;
						break;
				}
				//go on
				
				this.currentWidth = 70;
				this.currentHeight = 30;
				this.onEnterFrame = function() {
					var difX = (this._x-this.targetPositionX)/2;
					var difY = (this._y-this.targetPositionY)/2;
					var difWidth = (this.currentWidth-(this.targetWidth+10))/2;
					var difHeight = (this.currentHeight-(this.targetHeight+10))/2;
					
					if (Math.abs(difX) < 0.0005) difX = 0;
					if (Math.abs(difY) < 0.0005) difY = 0;
					
					if (Math.abs(difWidth) < 0.0005) difWidth = 0;
					if (Math.abs(difHeight) < 0.0005) difHeight = 0;
					
					this.currentWidth -= difWidth;
					this.currentHeight -= difHeight;
					this.bg_mc.clear();
					this.shadow_mc.clear();
					if (_root.drawShadows == 1) {
						_parent.blurredRect(this.shadow_mc, -1*_root.shadowWidth, -1*_root.shadowWidth, currentWidth+(2*_root.shadowWidth), currentHeight+(2*_root.shadowWidth), 10, _root.shadowColor, _root.shadowAlpha);
					}
					if (_root.roundRect == 1) {
						_parent.drawRoundedRectangle(this.bg_mc, _root.picBgColor, 1, _root.picBgColor, 0, 0, currentWidth, currentHeight, _root.roundPix);
					} else {
						_parent.drawRectangle(this.bg_mc, _root.picBgColor, 1, _root.picBgColor, 0, 0, currentWidth, currentHeight);
					}
					this._x -= difX;
					this._y -= difY;
					
					
					if (difX<=0 && difY<=0 && difWidth>=-0.05 && difHeight>=-0.05) {
						this.bg_mc.clear();
						this._x = Math.round(this.targetPositionX);
						this._y = Math.round(this.targetPositionY);
						if (_root.roundRect == 1) {
							_parent.drawRoundedRectangle(this.bg_mc, _root.picBgColor, 1, _root.picBgColor, 0, 0, this.targetWidth+10, this.targetHeight+10, _root.roundPix);
						} else {
							_parent.drawRectangle(this.bg_mc, _root.picBgColor, 1, _root.picBgColor, 0, 0, this.targetWidth+10, this.targetHeight+10);
						}
						this.img_mc._visible = true;
						this.img_mc._alpha = 0;
						if (_root.showCaption == 1) {
							this.img_mc.caption_mc._alpha = 0;
							_parent.drawRectangle(this.img_mc.caption_mc, _root.captionBgColor, 1, _root.captionBgColor, 0, 0, this.targetWidth, 20);
							if (_root.showPrintBtn == 1) {
								this.img_mc.printButton_mc.visible = true;
								this.img_mc.printButton_mc._y = 5;
								this.img_mc.printButton_mc._x = this.targetWidth-20;
								this.img_mc.printButton_mc.onRollOver = function() {
									this.gotoAndStop(2);
								};
								this.img_mc.printButton_mc.onRollOut = this.img_mc.printButton_mc.onReleaseOutside=function () {
									this.gotoAndStop(1);
								};
								this.img_mc.printButton_mc.onRelease = function() {
									printNum(this._parent.image, "bmax");
								};
								this.img_mc.caption_mc.createTextField("Newfield_txt", 5, 5, 0, this.targetWidth-25, 20);
							} else {
								this.img_mc.caption_mc.createTextField("Newfield_txt", 5, 5, 0, this.targetWidth-5, 20);
							}
							if (_root.showZoomBtns == 1) {
								this._parent.zoomFactor = 1;
								this.img_mc.zoomButtons_mc.visible = true;
								
								var btnIn = this.img_mc.zoomButtons_mc.mc_zoomInBtn;
								var btnOut = this.img_mc.zoomButtons_mc.mc_zoomOutBtn;
								
								this.img_mc.zoomButtons_mc._y = 4;
								this.img_mc.zoomButtons_mc._x = this.targetWidth-54;
								
								btnIn.onRollOver = btnOut.onRollOver = function() {
									this.gotoAndStop(2);
								};
								btnIn.onRollOut = btnOut.onRollOut = btnIn.onReleaseOutside=btnOut.onReleaseOutside=function () {
									this.gotoAndStop(1);
								};
								btnIn.onRelease = function() {
									this._parent._parent._parent._parent.zoomIn();
								};
								btnOut.onRelease = function() {
									this._parent._parent._parent._parent.zoomOut();
								};
								this.img_mc.caption_mc.createTextField("Newfield_txt", 5, 5, 0, this.targetWidth-25, 20);
								this._parent.refreshZoomButtons();
							} else {
								this.img_mc.caption_mc.createTextField("Newfield_txt", 5, 5, 0, this.targetWidth-5, 20);
							}
							this.img_mc.caption_mc.Newfield_txt.html = true;
							this.img_mc.caption_mc.Newfield_txt.htmlText = this.captionText;
							this.img_mc.caption_mc.Newfield_txt.selectable = false;
							var fmtEmphasis;
							fmtEmphasis = new TextFormat();
							fmtEmphasis.size = 12;
							fmtEmphasis.font = "Arial";
							fmtEmphasis.color = _root.captionColor;
							this.img_mc.caption_mc.Newfield_txt.setTextFormat(fmtEmphasis);
							this.img_mc.caption_mc.onEnterFrame = _parent.fadeInHalfFunction;
						}
						if (_root.popupLink == 1) {
							this.img_mc.createEmptyMovieClip("linkArea_mc", 0);
							_parent.drawRectangle(this.img_mc.linkArea_mc, 0xffffff, 1, 0xffffff, 0, 0, this._width, this._height);
							
							this.createEmptyMovieClip("message_mc", 25);
							this.message_mc.createTextField("text_txt", 5, 0, 0, 200, 25);
							this.message_mc.text_txt.selectable = false;
							this.message_mc.text_txt.autoSize = true;
							this.message_mc.text_txt.text = _root.popUpLinkText;
							var tf:TextFormat = this.message_mc.text_txt.getTextFormat();
							tf.font = _root.popUpLinkFont;
							this.message_mc.text_txt.setTextFormat(tf);
							this.message_mc.createEmptyMovieClip("bg_mc", 4);
							_parent.drawRectangle(this.message_mc.bg_mc, 0xffffff, 1, 0xffffff, 0, 0, this.message_mc.text_txt.textWidth+3, this.message_mc.text_txt.textHeight+3);
							this.message_mc.bg_mc._alpha = 65;
							this.message_mc._visible = false;
							this.img_mc.linkArea_mc.onRollOver = function() {
								this._parent._parent.message_mc._visible = true;
								this._parent._parent.message_mc.onEnterFrame = function() {
									var difX = (_parent._xmouse-(this._x+(this.text_txt.textWidth/2)))/10;
									var difY = ((_parent._ymouse-20)-this._y)/10;
									this._x += difX;
									this._y += difY;
								};
							};
							this.img_mc.linkArea_mc.onRollOut = function() {
								this._parent._parent.message_mc._visible = false;
								delete this._parent._parent.message_mc.onEnterFrame;
							};
							this.img_mc.linkArea_mc.onPress = function() {
								if (this._parent._parent.popupWidth != undefined && this._parent._parent.popupHeight != undefined) {
									getURL("javascript:window.open('"+this._parent._parent.imageURL+"','image','toolbar=no,location=no,status=no,menubar=no,scrollbars=no,resizable=yes,width="+this.popupWidth+", height="+this.popupHeight+"');void(0);");
								} else {
									getURL("javascript:window.open('"+this._parent._parent.imageURL+"','image','');void(0);");
								}
							};
						}
						this.img_mc.onEnterFrame = _parent.fadeInFunction;
						delete this.onEnterFrame;
					}
				};
				
				if (_root.slideShow) {
					clearInterval(_root.slideShowInterval);
					_root.slideShowInterval = setInterval(_parent.nextImg, _root.slideShowDelay * 1000, _parent);
				}
				
				//this.img_mc._visible = true;
			}
		};
	}
	
	private function nextImg(owner) {
		clearInterval(_root.slideShowInterval);
		
		var i=0;
		var thumbs_mc = owner.thumbs_mc;
		var thumb = thumbs_mc["thumb" + i];
		
		if (owner.currentImage < _root.imageArray.length - 1) owner.currentImage++;
		else owner.currentImage = 0;
		
		if (_root.showSelected == 1) {
			thumbs_mc.removeSelections();
			while (thumb) {
				if (thumb.imageNumber == owner.currentImage) {
					thumbs_mc.showSelection(thumb);
					break;
				}
				
				i++;
				thumb = thumbs_mc["thumb" + i];
			}
		}
		
		owner.loadImage(owner.currentImage);
	}
	
	private function zoomIn() {
		
		this.zoomFactor += (_root.zoomIncrement/100);
		this.doZoom();
		
	}
	
	private function zoomOut() {
		
		this.zoomFactor -= (_root.zoomIncrement/100);
		this.doZoom();
		
	}

	private function doZoom() {
		
		this.image_mc.img_mc.image.w = this.finalWidth * this.zoomFactor;
		this.image_mc.img_mc.image.h = this.finalHeight * this.zoomFactor;
		
		var maxX = -this.image_mc.img_mc.image.w + this.image_mc.mask._width;
		var maxY = -this.image_mc.img_mc.image.h + this.image_mc.mask._height;
		maxX = Math.min(maxX, 0);
		maxY = Math.min(maxY, 0);
		this.image_mc.img_mc.image.x = Math.max(maxX, this.image_mc.img_mc.image._x);
		this.image_mc.img_mc.image.y = Math.max(maxY, this.image_mc.img_mc.image._y);
		
		this.image_mc.img_mc.image.enabled = false;
		this.image_mc.img_mc.image.onEnterFrame = function() {
			var done = true;
			
			if (Math.abs(this._x - this.x) > 0.5) {
				this._x += (this.x - this._x) / 4;
				done = false;
			} else done = done && true;
			
			if (Math.abs(this._y - this.y) > 0.5) {
				this._y += (this.y - this._y) / 4;
				done = false;
			} else done = done && true;
			
			if (Math.abs(this._width - this.w) > 0.5) {
				this._width += (this.w - this._width) / 4;
				done = false;
			} else done = done && true;
			
			if (Math.abs(this._height - this.h) > 0.5) {
				this._height += (this.h - this._height) / 4;
				done = false;
			} else done = done && true;
			
			if (done) {
				this._x = this.x;
				this._y = this.y;
				this._width = this.width;
				this._height = this.height;
				
				this.enabled = true;
				
				delete this.onEnterFrame;
			}
		}
		
		this.refreshZoomButtons();
		
		if (this.zoomFactor > 1) {
			this.image_mc.img_mc.image.onPress = function() {
				var left, top, right, bottom;
				
				left= -this._width + this._parent._parent.mask._width;
				top= -this._height + this._parent._parent.mask._height;
				
				right = 0;
				bottom = 0;
				
				this.startDrag(false, left, top, right, bottom);
			}
			this.image_mc.img_mc.image.onRelease = this.image_mc.img_mc.image.onReleaseOutside = function() {
				stopDrag();
			}
		} else {
			delete this.image_mc.img_mc.image.onPress;
			delete this.image_mc.img_mc.image.onRelease;
			delete this.image_mc.img_mc.image.onReleaseOutside;
		}
	}
	
	private function refreshZoomButtons() {
		var btnIn = this.image_mc.img_mc.zoomButtons_mc.mc_zoomInBtn;
		var btnOut = this.image_mc.img_mc.zoomButtons_mc.mc_zoomOutBtn;
		
		if (this.zoomFactor <= 1) {
			btnOut.enabled = false;
			btnOut._alpha = 50;
		} else {
			btnOut.enabled = true;
			btnOut._alpha = 100;
		}
		if (this.zoomFactor >= _root.maxZoom) {
			btnIn.enabled = false;
			btnIn._alpha = 50;
		} else {
			btnIn.enabled = true;
			btnIn._alpha = 100;
		}
	}
	
	private function fadeInFunction() {
		this._alpha += 10;
		if (this._alpha>=100) {
			delete this.onEnterFrame;
		}
	} 
	private function fadeInHalfFunction() {
		this._alpha += 10;
		if (this._alpha>=50) {
			delete this.onEnterFrame;
		}
	}
	private function fadeIn25Function() {
		this._alpha += 2;
		if (this._alpha>=25) {
			delete this.onEnterFrame;
		}
	}
	private function drawRectangle(target_mc:MovieClip, lineColor, lineThickness:Number, fillColor, topX:Number, topY:Number, bottomX:Number, bottomY:Number) {
		target_mc.moveTo(topX, topY);
		target_mc.lineStyle(lineThickness, lineColor, 100);
		target_mc.beginFill(fillColor, 100);
		target_mc.lineTo(bottomX, topY);
		target_mc.lineTo(bottomX, bottomY);
		target_mc.lineTo(topX, bottomY);
		target_mc.lineTo(topX, topY);
		target_mc.endFill();
	}
	private function drawInvisibleRectangle(target_mc:MovieClip, lineColor, lineThickness:Number, fillColor, topX:Number, topY:Number, bottomX:Number, bottomY:Number) {
		target_mc.moveTo(topX, topY);
		target_mc.lineStyle(lineThickness, lineColor, 0);
		target_mc.beginFill(fillColor, 0);
		target_mc.lineTo(bottomX, topY);
		target_mc.lineTo(bottomX, bottomY);
		target_mc.lineTo(topX, bottomY);
		target_mc.lineTo(topX, topY);
		target_mc.endFill();
	}
	private function drawRoundedRectangle(target_mc:MovieClip, lineColor, lineThickness:Number, fillColor, topX:Number, topY:Number, bottomX:Number, bottomY:Number, pixels:Number) {
		target_mc.moveTo(topX, topY);
		target_mc.lineStyle(lineThickness, lineColor, 100);
		target_mc.beginFill(fillColor, 100);
		roundRect(target_mc, topX, topY, bottomX, bottomY, pixels);
		target_mc.endFill();
	}
	private function blurredRect(target_mc, x, y, width, height, blur, color, alpha) {
		this.lineStyle();
		var f = [];
		var sum = 0;
		for (var i = 1; i<blur+1; i++) {
			f[i-1] = i*i;
			sum += f[i-1];
		}
		var newfactor = 2;
		var counter = 40;
		var factor;
		do {
			factor = newfactor;
			var b = 0;
			for (var i = 0; i<=blur; i++) {
				var ftemp = (f[i]*(factor*alpha)/sum)/100;
				b = b*(1-ftemp)+ftemp;
			}
			counter--;
			newfactor *= alpha/(100*b);
		} while ((counter>0) && (Math.abs(100*b-alpha)>.5));
		for (var i = 0; i<=blur; i++) {
			f[i] *= (factor*alpha)/sum;
		}
		for (var i = 0; i<=blur; i++) {
			target_mc.beginFill(color, f[i]);
			roundRect(target_mc, 1+(x+i)-blur/2, 1+(y+i)-blur/2, x+width-i+blur/2-1, y+height-i+blur/2-1, blur-(i*2/3));
			target_mc.endFill();
		}
	}
	private function roundRect(target_mc, x1, y1, x2, y2, r) {
		r = Math.min(Math.abs(r), Math.min(Math.abs(x1-x2), Math.abs(y1-y2))/2);
		var f = 0.707106781186548*r;
		var a = 0.588186525863094*r;
		var b = 0.00579432557070009*r;
		var ux = Math.min(x1, x2);
		var uy = Math.min(y1, y2);
		var lx = Math.max(x1, x2);
		var ly = Math.max(y1, y2);
		target_mc.moveTo(ux+r, uy);
		var cx = lx-r;
		var cy = uy+r;
		target_mc.lineTo(cx, uy);
		target_mc.curveTo(lx-a, uy+b, cx+f, cy-f);
		target_mc.curveTo(lx-b, uy+a, lx, uy+r);
		cy = ly-r;
		target_mc.lineTo(lx, cy);
		target_mc.curveTo(lx-b, ly-a, cx+f, cy+f);
		target_mc.curveTo(lx-a, ly-b, lx-r, ly);
		cx = ux+r;
		target_mc.lineTo(cx, ly);
		target_mc.curveTo(ux+a, ly-b, cx-f, cy+f);
		target_mc.curveTo(ux-b, ly-a, ux, ly-r);
		cy = uy+r;
		target_mc.lineTo(ux, cy);
		target_mc.curveTo(ux+b, uy+a, cx-f, cy-f);
		target_mc.curveTo(ux+a, uy+b, ux+r, uy);
	}
}
