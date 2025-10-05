function barIndicator() {

	this.roundMinMaxValues = false;
	this.value            =   0;
	this.title            =  '';
	this.unit             =  '';
	this.graduationStep   =  20;
	this.graduationMin    =   0;
	this.graduationMax    = 100;
	this.showMinMaxValues = true;
	this.minValue         = this.graduationMax;
	this.maxValue         = this.graduationMin;
	this.useLowHighLimit  = true;
	this.lowLimit         =  10;
	this.highLimit        =  90;
	this.width            = 400;
	this.height           =  50;
	this.color            = '#0000A0';
	this.backgroundColor  = '#FFFFFF';
	this.lowLimitColor    = '#A0A000';
	this.highLimitColor   = '#FF0000';
	this.minColor         = '#00A000';
	this.maxColor         = '#A00000';
	this.horizontal       = true;
	this.className        = 'mwjgraph';
	
	this.resetMinMaxValues = function (redrawGraph) {
		this.minValue = this.graduationMax;
		this.maxValue = this.graduationMin;
		if (redrawGraph) {
			this.draw();
		}
	}
	this.draw = function () {
		var newValue       = parseFloat(this.value);
		var highLimitValue = parseFloat(this.highLimit);
		var lowLimitValue  = parseFloat(this.lowLimit);

		var currentMinValue= parseFloat(this.minValue);
		var currentMaxValue= parseFloat(this.maxValue);

		var graphColor     = this.color;
		var aValue         = 0;

		var g = new MWJ_graph(this.width, this.height, MWJ_bar, false, this.horizontal, this.backgroundColor);
		g.className = this.className;
		g.addDataSet(this.backgroundColor,'',[parseFloat(this.graduationMax)]);
		if (this.showMinMaxValues) {
			if (newValue < currentMinValue) {
				if (this.roundMinMaxValues) {
					this.minValue = Math.round(newValue);
				}
				else {
					this.minValue = newValue;
				}
				aValue        = this.minValue ;
			}
			else {
				aValue        = currentMinValue;
				if (this.roundMinMaxValues) aValue = Math.round(aValue);
			}
			g.addDataSet(this.minColor,'min',[aValue]);
		}

		if (this.useLowHighLimit) {
			if (newValue > highLimitValue) {
				graphColor = this.highLimitColor;
			}
			if (newValue < lowLimitValue) {
				graphColor = this.lowLimitColor;
			}
		}
		g.addDataSet(graphColor, this.unit, [newValue]);

		if (this.showMinMaxValues) {
			if (newValue > currentMaxValue) {
				if (this.roundMinMaxValues) {
					this.maxValue = Math.round(newValue);
				}
				else {
					this.maxValue = newValue;
				}
				aValue = this.maxValue;
				g.addDataSet(this.maxColor,'max',[aValue]);
			}
			else {
				g.addDataSet(this.maxColor,'max',[currentMaxValue]);
			}
		}
		g.addDataSet(this.backgroundColor,'',[parseFloat(this.graduationMin)]);
		g.setYAxis(parseInt(this.graduationStep));
		g.setTitles(this.title, '', this.unit);
		document.getElementById(this.divID).innerHTML = g.buildGraphString();
	}
	
	this.changeTargetId = function (targetID, clearSourceId) {
		if (document.getElementById(this.divID) != undefined) {
			if (clearSourceId == true) {
				document.getElementById(this.divID).innerHTML = "";
			}
		}
		this.divID = targetID;
	}
	
}

function roundIndicator() {
  this.divID  =    ''; // div ID pour dessiner l'aiguille
  
  this.orgX   =    50; // position de l'image
  this.orgY   =    50; //
  this.indX   =    25; // centre (relatif) pour départ de l'aiguille
  this.indY   =    25; //
  this.indRadius = 20; // longueur de l'aiguille (rayon)

  this.minValue =   0; // en unité de mesure
  this.maxValue = 100; // en unité de mesure
  this.minAngle = 225; // en unité d'angle degré
  this.maxAngle = 315; // en unité d'angle degré
  this.value    = this.minValue; // valeur courante

  this.bgImage  = ''; // image de fond
  this.bgImageX = this.orgX; // position et taille de l'image
  this.bgImageY = this.orgY; //
  this.bgImageW = 2 * this.indRadius;
  this.bgImageH = 2 * this.indRadius;

  this.title    =  '';
  this.titleX   =   0; // position du titre (relatif)
  this.titleY   = this.bgImageH; // position du titre (relatif)
  this.titleFontFamily = 'arial';
  this.titleFontSize   = '16px';
  this.titleFontStyle  =  Font.BOLD;
  this.titleFontColor  = 'black';
  this.titleStyle      = ''; // optional style
  
  this.color    = '#ff0000'; // couleur de l'aiguille
  this.stroke   =   3;       // largeur de l'aiguille
  this.graph    = new jsGraphics(this.divID);

  this.draw = function () {
	  var cAngle  = 0;
	  var dtAngle = 0;
	  var cValue  = this.value;
	  if (cValue < this.minValue) cValue = this.minValue;
	  if (cValue > this.maxValue) cValue = this.maxValue;
	  dtAngle = (this.maxAngle - this.minAngle) / (this.maxValue - this.minValue); // degré par unité de valeur
	  cAngle  = this.minAngle + (cValue - this.minValue) * dtAngle;
	  var dx  = (this.orgX + this.indX) + this.indRadius * Math.cos(cAngle * (Math.PI / 180));
	  var dy  = (this.orgY + this.indY) + this.indRadius * Math.sin(cAngle * (Math.PI / 180));
      if (typeof (this.divID) == "string") {
      	  this.graph.clear();
		  this.graph = new jsGraphics(this.divID);
		  if (this.title != '') {
			this.graph.setColor(this.titleFontColor);
			this.graph.setFont(this.titleFontFamily, this.titleFontSize, this.titleFontStyle);
			/*this.graph.drawString(this.title, this.orgX + this.titleX, this.orgY + this.titleY);*/
			this.graph.drawString(this.title, this.orgX, this.orgY + this.titleY, this.bgImageW, this.titleStyle);
		  }
		  this.graph.setColor(this.color);
		  this.graph.setStroke(this.stroke);
		  if (this.bgImage != '') {
	  		this.graph.drawImage(this.bgImage, this.bgImageX, this.bgImageY, this.bgImageW, this.bgImageH);
		  }
		  this.graph.drawLine(this.orgX + this.indX, this.orgY + this.indY, dx, dy); // dessin aiguille
		  this.graph.paint();
	  }
  }

	this.changeTargetId = function (targetID, clearSourceId) {
		if (document.getElementById(this.divID) != undefined) {
			if (clearSourceId == true) {
				document.getElementById(this.divID).innerHTML = "";
			}
		}
		this.divID = targetID;
	}
	
	this.changePosition = function (newX, newY) {
		this.orgX  = newX;
		this.orgY  = newY;
		this.bgImageX = newX; // position et taille de l'image
		this.bgImageY = newY; //
	}
}
