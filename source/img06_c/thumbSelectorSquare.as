/** Copyright 2004 - 05 TUFaT.com, All Rights Reserved. **/

class thumbSelectorSquare extends thumbSelector {
	public function thumbSelectorSquare(images:Array) {
		_root.smoothScroll = 0;	//force pagination always
		this.thumbsPerPage = 9;
	}
	private function createThumbs() {
		var columns = 0;
		var rows = 0;
		this.pageNumber = 0;
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
		this.btn1_mc.arrow2_mc._x = 10;
		this.btn2_mc.arrow2_mc._x = 10;
		this.btn1_mc._xscale = -100;
		this.btn1_mc._x = 30;
		this.btn2_mc._x = 230;
		this.btn1_mc.arrow1_mc._alpha = 35;
		this.btn1_mc.arrow2_mc._alpha = 35;
		if (_root.imageArray.length<=9) {
			this.btn2_mc.gotoAndStop(6);
		} else {
			this.btn2_mc.onRollOver = pageButtonRollOver;
			this.btn2_mc.onRollOut = this.btn2_mc.onReleaseOutside=pageButtonRollOut;
			this.btn2_mc.gotoAndStop(1);
			this.btn2_mc.onPress = function() {
				_parent.showNextPage();
			};
		}
		for (var i = 0; i<=8; i++) {
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
			this["thumb"+i]._y = 30+(rows*90);
			this["thumb"+i]._visible = false;
			columns++;
			if (columns>2) {
				columns = 0;
				rows++;
			}
		}
		if (_root.loadThumbsAtOnce == 1) {
			loadThumbsAtOnce(0);
		} else {
			loadThumb(0, 0, true);
		}
		//loadThumbImages(0);
	}
}
