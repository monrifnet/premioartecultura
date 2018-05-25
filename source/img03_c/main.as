/** Copyright 2004 - 05 TUFaT.com, All Rights Reserved. **/

Stage.scaleMode = "noScale";
Stage.align = "TL";
var imageArray = new Array();
imageXML = new XML();
imageXML.onLoad = function() {
	var i;
	var level1Child;
	level1Child = this.firstChild;
	_root.loadThumbsAtOnce = parseInt(level1Child.attributes.loadthumbsatonce);
	_root.gTitle = level1Child.attributes.galleryname;
	_root.bgColor = level1Child.attributes.bgcolor;
	_root.pnlColor = level1Child.attributes.pnlcolor;
	_root.picBgColor = level1Child.attributes.picbgcolor;
	_root.showCaption = parseInt(level1Child.attributes.showcaption);
	_root.captionBgColor = level1Child.attributes.captionbgcolor;
	_root.layoutType = parseInt(level1Child.attributes.layout);
	_root.loadBarBgColor = level1Child.attributes.thumbloadbarcolor;
	_root.thumbLoadDelay = parseInt(level1Child.attributes.thumbloaddelay);
	_root.roundRect = parseInt(level1Child.attributes.roundrect);
	_root.roundPix = parseInt(level1Child.attributes.roundpix);
	_root.captionColor = level1Child.attributes.captioncolor;
	_root.shadowWidth = parseInt(level1Child.attributes.shadowwidth);
	_root.drawShadows = parseInt(level1Child.attributes.drawshadows);
	_root.shadowAlpha = parseInt(level1Child.attributes.shadowalpha);
	_root.showSelected = parseInt(level1Child.attributes.showselected);
	_root.selectionColor = level1Child.attributes.selectioncolor;
	_root.shadowColor = level1Child.attributes.shadowcolor;
	_root.showPrintBtn = parseInt(level1Child.attributes.showprintbtn);
	_root.showZoomBtns = parseInt(level1Child.attributes.showzoombtns);
	_root.zoomIncrement = parseInt(level1Child.attributes.zoomincrement);
	_root.maxZoom = parseInt(level1Child.attributes.maxzoom);
	_root.animPageBtns = parseInt(level1Child.attributes.animpagebtns);
	_root.titleColor = level1Child.attributes.titlecolor;
	_root.pageBtnColor=level1Child.attributes.pagebtncolor;
	_root.popupLink=parseInt(level1Child.attributes.popuplink);
	_root.smoothScroll=parseInt(level1Child.attributes.smoothscroll);
	_root.autoResize=parseInt(level1Child.attributes.autoresize);
	_root.thumbResize=parseInt(level1Child.attributes.thumbresize);
	_root.slideShow=parseInt(level1Child.attributes.slideshow);
	_root.slideShowDelay=parseInt(level1Child.attributes.slideshowdelay);
	_root.hAlign=level1Child.attributes.halign;
	_root.vAlign=level1Child.attributes.valign;
	_root.hMargin=parseInt(level1Child.attributes.hmargin);
	_root.vMargin=parseInt(level1Child.attributes.vmargin);
	_root.popUpLinkText=level1Child.attributes.popuplinktext;
	_root.popUpLinkFont=level1Child.attributes.popuplinkfont;
	_root.thumbPadding1=parseInt(level1Child.attributes.thumbpadding1);
	_root.thumbPadding2=parseInt(level1Child.attributes.thumbpadding2);
	_root.scrollWhenClose=parseInt(level1Child.attributes.scrollwhenclose);
	_root.speedSmoothness=parseInt(level1Child.attributes.speedsmoothness);
	_root.maxSpeed=parseInt(level1Child.attributes.maxspeed);
	
	if (isNaN(_root.maxZoom)) _root.maxZoom = 5;
	if (isNaN(_root.hMargin)) _root.hMargin = 0;
	if (isNaN(_root.vMargin)) _root.vMargin = 0;
	if (isNaN(_root.thumbPadding1)) _root.thumbPadding1 = 0;
	if (isNaN(_root.thumbPadding2)) _root.thumbPadding2 = 0;
	if (isNaN(_root.scrollWhenClose)) _root.scrollWhenClose = 0;
	if (isNaN(_root.speedSmoothness)) _root.speedSmoothness = 5;
	if (_root.speedSmoothness<1) _root.speedSmoothness = 1;
	if (isNaN(_root.maxSpeed)) _root.maxSpeed = 99999;
	if (_root.maxSpeed < 1) _root.maxSpeed = 99999;
	if (!level1Child.attributes.popuplinktext) _root.popUpLinkText = "Click to view bigger version";
	if (!level1Child.attributes.popuplinkfont) _root.popUpLinkFont = "Arial";

	var layoutExists:Array = new Array();
	for (var i=1; i<=6; i++) layoutExists[i] = true;
	
	if (!layoutExists[_root.layoutType]) {
		_root.layoutType = 1;
	}

	var hAlignExists:Array = new Array();
	hAlignExists["left"] = true;
	hAlignExists["right"] = true;
	hAlignExists["center"] = true;

	var vAlignExists:Array = new Array();
	vAlignExists["top"] = true;
	vAlignExists["bottom"] = true;
	vAlignExists["center"] = true;

	if (!hAlignExists[_root.hAlign]) {
		_root.hAlign = "center";
	}
	
	if (!vAlignExists[_root.vAlign]) {
		_root.vAlign = "center";
	}
	
	var amountOfItems = level1Child.childNodes.length;
	for (i=0; i<amountOfItems; i++) {
		var imageAndThumb = new Array();
		imageAndThumb.push(level1Child.childNodes[i].attributes.thumb);
		imageAndThumb.push(level1Child.childNodes[i].firstChild.nodeValue);
		i++;
		imageAndThumb.push(level1Child.childNodes[i].firstChild.nodeValue);
		i++
		imageAndThumb.push(level1Child.childNodes[i].firstChild.nodeValue);
		imageAndThumb.push(level1Child.childNodes[i].attributes.popupwidth);
		imageAndThumb.push(level1Child.childNodes[i].attributes.popupheight);
		imageArray.push(imageAndThumb);
	}
	_root.attachMovie("mc_Gallery", "gallery_mc", -1);
	_root.gallery_mc.initCanvas();
};
imageXML.ignoreWhite = true;
if(_root.xmlFile==undefined){
	_root.xmlFile="img03_c/gallery.xml"
}
imageXML.load(_root.xmlFile);

_lockroot = true;
