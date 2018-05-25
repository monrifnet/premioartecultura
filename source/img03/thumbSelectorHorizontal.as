/** Copyright 2004 - 05 TUFaT.com, All Rights Reserved. **/

class thumbSelectorHorizontal extends thumbSelector {
	private function createThumbs() {
		super.createThumbs();
		
		for (var i = 0; i<=this.amount; i++) {
			this["thumb"+i]._y = 0;
			
			if (_root.smoothScroll != 1) {
				this["thumb"+i]._x = 35+(columns*90);
			} else {
				this["thumb"+i]._x = columns*90;
			}
			if (_root.smoothScroll != 1) {
				this["thumb"+i]._visible = false;
			}
			columns++;
		}
		if (_root.smoothScroll != 1) {
			this.btn1_mc._y = 20;
			this.btn2_mc._y = 20;
			this.btn1_mc._x = 20;
			this.btn2_mc._x = 400;
		} else {
			var p1, p2;
			p1 = _root.thumbPadding1;
			p2 = _root.thumbPadding2;
			
			_parent.mask_mc.target = this;
			_parent.mask_mc.x = 20 + p1;
			_parent.mask_mc.w = _parent.stageWidth - p2 - 40 - p1;
			
			this.onEnterFrame = function() {
				
				var maxW = _parent.mask_mc.w;
				if (this._width > maxW) {
					this.x = 0;
					this.w = this._width - 10 - _root.shadowWidth;
					
					_parent.mask_mc.onEnterFrame = function() {
						if (_root.scrollWhenClose == 1 && !this.hitTest(this._xmouse, this._ymouse)) {
							this.target.x = this.target._x;
							return;
						}
							
						var mouseX = this._xmouse;
						
						mouseX = Math.max(this.x, mouseX);
						mouseX = Math.min(this.x + this.w, mouseX);
						
						this.target.x = this.x - (mouseX-this.x)*((this.target.w - this.w)/this.w);
					}
					
					this.onEnterFrame = function() {
						var ds = (this.x - this._x)/_root.speedSmoothness;
						
						var sign = ds > 0 ? 1 : -1;
						
						ds = sign * Math.min(Math.abs(ds), _root.maxSpeed);
						
						this._x += ds;
					}
				}
			}
		}
		
	}
}
