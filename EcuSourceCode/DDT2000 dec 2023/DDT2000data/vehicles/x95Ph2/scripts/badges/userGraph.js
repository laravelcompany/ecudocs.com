// ---------------------------------------------
// Bargraphe de tension batterie
// ---------------------------------------------
var voltageGraph;
var batteryIndicator;

function initGraphs() {

	voltageGraph                  = new barIndicator();
	voltageGraph.divID            = 'voltageBar';
	voltageGraph.title            = 'Batterie (V)';
	voltageGraph.value            =  0;
	voltageGraph.graduationStep   =  2;
	voltageGraph.graduationMin    =  0;
	voltageGraph.graduationMax    = 16;
	voltageGraph.showMinMaxValues = false;
	voltageGraph.lowLimit         =  7.5;
	voltageGraph.highLimit        = 14.5;
	voltageGraph.width            = 200;
	voltageGraph.height           = 32;
	voltageGraph.color            = '#00A0A0';
	voltageGraph.lowLimitColor    = '#A0A000';
	voltageGraph.highLimitColor   = '#ff0000';
	voltageGraph.horizontal       = true;
	voltageGraph.backgroundColor  = '#bbeeff';
	voltageGraph.className        = 'graph';
	
	voltageGraph.draw();
	
	// ---------------------------------------------
	// Charge batterie
	// ---------------------------------------------
	batteryIndicator           = new roundIndicator();
	batteryIndicator.divID     = 'batteryIndicator';
	batteryIndicator.orgX      = parseInt(document.getElementById("voltageBar1").style.left) + voltageGraph.width + 20;  /* position de l'image */
	batteryIndicator.orgY      = parseInt(document.getElementById("voltageBar1").style.top);

	batteryIndicator.indX      =    50;  /* centre (relatif) pour départ de l'aiguille */
	batteryIndicator.indY      =    76;  /*                                            */
	batteryIndicator.indRadius =    48;  /* longueur de l'aiguille (rayon) */
	batteryIndicator.title     = 'VBat'; /* titre */
	batteryIndicator.titleX    =     0;
	batteryIndicator.titleY    =   105;
	/* batteryIndicator.titleStyle= 'border:1px solid black;'; */

	batteryIndicator.minValue  =    11; /* en unité de mesure */
	batteryIndicator.maxValue  =    13; /* en unité de mesure */
	batteryIndicator.minAngle  =   225; /* en unité d'angle (°) */
	batteryIndicator.maxAngle  =   310; /* en unité d'angle (°) */
	batteryIndicator.value     = batteryIndicator.minValue;

	batteryIndicator.bgImage   = 'images/battery_background.gif';
	batteryIndicator.bgImageX  = batteryIndicator.orgX;
	batteryIndicator.bgImageY  = batteryIndicator.orgY;
	batteryIndicator.bgImageW  =   103; /* taille de l'image de fond */
	batteryIndicator.bgImageH  =   103; /*                           */
	
	batteryIndicator.draw();
}

