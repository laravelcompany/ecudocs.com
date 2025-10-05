/* generic part - DO NOT MODIFY UNLESS YOU KNOW WHAT YOU DO! - */

/* scheduler initialization */
var SHEDULER_PERIOD = 100;   /* ms */
var timScheduler    = null;  /* timer handle */

/* initialization for automation */
var stepIDprefix       = "screen";
var buttonInfoIDprefix = "buttonInfo";

var currentIndex   = 1;
var previousIndex  = 1;

var STEP_START     = 1;

var ACTION_IDLE    = 'idle';
var ACTION_START   = 'start';
var ACTION_NEXT    = 'next';
var ACTION_PREV    = 'prev';
var ACTION_FINISH  = 'finish';
var ACTION_CANCEL  = 'cancel';
var ACTION_YES     = 'yes';
var ACTION_NO      = 'no';
var ACTION_SHOW_SCREEN = 'screen';
var action;

/* flag for refresh data layer */
var useRefreshData  = false;

/* constant for no style */
var STYLE_NONE     = ' ';

/* language initialization */
var lang = "en";

function startScript() {
	/* ========================================================== */
	/* Startup routine                                            */
	/* MUST BE CALLED IN THE onload EVENT OF THE HTML BODY TAG    */
	/* ========================================================== */

	action        = ACTION_IDLE;
	currentIndex  = STEP_START;
	previousIndex = currentIndex;

	screenShow(currentIndex);

	buttonsHide();

	lang = getCookie("lang");
	if (lang == null) {
		lang = "en";
	}
	setLanguage(lang, true);

	buttonShow("btnStart");
	userStartScript();

}

function startScheduler() {
	/* ========================================================== */
	/* Support function for starting scheduler timer              */
	/* ========================================================== */
	timScheduler = setTimeout("scheduler()", SHEDULER_PERIOD)
}

function stopScheduler() {
	/* ========================================================== */
	/* Support function for stopping scheduler timer              */
	/* ========================================================== */
	clearTimeout(timScheduler);
}

function getUserObject(elementNameOrId) {
	/* ========================================================== */
	/* Support function to get Html object by name or id          */
	/* ========================================================== */
	if (document.getElementsByName(elementNameOrId)[0] != undefined) {
		return (document.getElementsByName(elementNameOrId)[0]);
	}
	else {
		if (document.getElementById(elementNameOrId) != undefined) {
			return (document.getElementById(elementNameOrId));
		}
	}
}

function indexExists(indexToTest) {
	/* ========================================================== */
	/* Support function to test if an automation step exists      */
	/* ========================================================== */
	if (document.getElementById(stepIDprefix + indexToTest) != undefined) {
		return(true);
	}
	else {
		return(false);
	}
}

function getCurrentIndex() {
	/* ========================================================== */
	/* Support function to get current automation step            */
	/* ========================================================== */
	return(currentIndex);
}

function getPreviousIndex() {
	/* ========================================================== */
	/* Support function to get previous automation step           */
	/* ========================================================== */
	return(previousIndex);
}

function setCurrentIndex(newIndex) {
	/* ========================================================== */
	/* Support function to set new automation step                */
	/* ========================================================== */
	/* backup current index */
	previousIndex = getCurrentIndex();
	currentIndex  = newIndex;
}

function buttonsHide() {
	/* ========================================================== */
	/* Support function to hide all buttons                       */
	/* ========================================================== */
	buttonHide("btnStart" );
	buttonHide("btnPrev"  );
	buttonHide("btnNext"  );
	buttonHide("btnFinish");
	buttonHide("btnCancel");
	buttonHide("btnYes"   );
	buttonHide("btnNo"    );
}

function buttonShow(buttonId) {
	/* ========================================================== */
	/* Support function to show a button by its id                */
	/* ========================================================== */
	document.getElementById(buttonId).enabled = true;
	document.getElementById(buttonId+"Container").style.display    = "inline";
}

function buttonHide(buttonId) {
	/* ========================================================== */
	/* Support function to hide a button by its id                */
	/* ========================================================== */
	document.getElementById(buttonId).enabled = false;
	document.getElementById(buttonId+"Container").style.display    = "none";
}

function showWarning(content, optionalStyle){
	/* ========================================================== */
	/* Support function to display a text in the warning area     */
	/* ========================================================== */
	if ((optionalStyle == undefined) || (optionalStyle == "")) {
		setInnerHTML('warningArea', content);
	}
	else {
		setInnerHTML('warningArea', '<span style="' + optionalStyle + '">' + content + '</span>');
	}
}

function showExtraInfo(content, optionalStyle){
	/* ========================================================== */
	/* Support function to display a text in the extra info area  */
	/* ========================================================== */
	if ((optionalStyle == undefined) || (optionalStyle == "")) {
		setInnerHTML('extraInfoArea', content);
	}
	else {
		setInnerHTML('extraInfoArea', '<span style="' + optionalStyle + '">' + content + '</span>');
	}
}

function screenShow(stepIndex) {
	/* ========================================================== */
	/* Support function to show a user screen (a HTML div with id */
	/* prefixed with stepIDprefix value)                          */
	/* ========================================================== */
	if (document.getElementById(stepIDprefix + stepIndex) != undefined) {
		document.getElementById(stepIDprefix + stepIndex).style.display = "inline";
		document.getElementById(buttonInfoIDprefix + stepIndex).style.display = "inline";
	}
}

function screenHide(stepIndex) {
	/* ========================================================== */
	/* Support function to hide a user screen (a HTML div with id */
	/* prefixed with stepIDprefix value)                          */
	/* ========================================================== */
	if (document.getElementById(stepIDprefix + stepIndex) != undefined) {
		document.getElementById(stepIDprefix + stepIndex).style.display = "none";
		document.getElementById(buttonInfoIDprefix + stepIndex).style.display = "none";
	}
}

function setDisplayDataValue(elementID,content){
	/* ========================================================== */
	/* Wrapper for setInnerHTML function                          */
	/* ========================================================== */
	if (document.getElementById(elementID) != undefined) {
		setInnerHTML(elementID,content);
	}
}

function setInnerHTML(elementID,content){
	/* ========================================================== */
	/* Support function to change inner HTML of a HTML object     */
	/* ========================================================== */
	if (document.getElementById(elementID) != undefined) {
		if (document.getElementById && !document.all){
			var rng      = document.createRange();
			var el       = document.getElementById(elementID);
			rng.setStartBefore(el);
			var htmlFrag = rng.createContextualFragment(content);
			while (el.hasChildNodes()) {
				el.removeChild(el.lastChild);
			}
			el.appendChild(htmlFrag);
		}
		else {
			document.getElementById(elementID).innerHTML = content;
		}
	}
}

function setInnerHTMLEx(elementID,content,title){
	/* ========================================================== */
	/* Support function to change inner HTML of a HTML object     */
	/* ========================================================== */
	if (document.getElementById(elementID) != undefined) {
		if (document.getElementById && !document.all){
			var rng      = document.createRange();
			var el       = document.getElementById(elementID);
			rng.setStartBefore(el);
			var htmlFrag = rng.createContextualFragment(content);
			while (el.hasChildNodes()) {
				el.removeChild(el.lastChild);
			}
			el.appendChild(htmlFrag);
		}
		else {
			document.getElementById(elementID).innerHTML = content;
		}
		document.getElementById(elementID).title = title;
	}
}

function onClickStart() {
	/* ========================================================== */
	/* Event function for 'start' button click                    */
	/* ========================================================== */
	action = ACTION_START;
}

function onClickPrev() {
	/* ========================================================== */
	/* Event function for 'previous' button click                 */
	/* ========================================================== */
	action = ACTION_PREV;
}

function onClickNext() {
	/* ========================================================== */
	/* Event function for 'next' button click                     */
	/* ========================================================== */
	action = ACTION_NEXT;
}

function onClickFinish() {
	/* ========================================================== */
	/* Event function for 'finish' button click                   */
	/* ========================================================== */
	action = ACTION_FINISH;
}

function onClickCancel() {
	/* ========================================================== */
	/* Event function for 'cancel' button click                   */
	/* ========================================================== */
	action = ACTION_CANCEL;
}

function onClickYes() {
	/* ========================================================== */
	/* Event function for 'yes' button click                      */
	/* ========================================================== */
	action = ACTION_YES;
}

function onClickNo() {
	/* ========================================================== */
	/* Event function for 'no' button click                       */
	/* ========================================================== */
	action = ACTION_NO;
}

function viewRefreshArea() {
	/* ========================================================== */
	/* Support function to show the 'refresh data' area           */
	/* ========================================================== */
	var el = document.getElementById('refreshArea');
	if (el != undefined) {
		el.style.display = "inline";
		el.isMaximized = true;
		if (document.getElementById('refreshAreaToggleImage') != undefined) {
			document.getElementById('refreshAreaToggleImage').src = "./images/toggle_collapse.gif";
			document.getElementById('refreshAreaToggleImage').alt = "[-]";
		}
	}
}

function hideRefreshArea() {
	/* ========================================================== */
	/* Support function to hide the 'refresh data' area           */
	/* ========================================================== */
	var el = document.getElementById('refreshArea');
	if (el != undefined) {
		el.style.display = "none";
		el.isMaximized = false;
		if (document.getElementById('refreshAreaToggleImage') != undefined) {
			document.getElementById('refreshAreaToggleImage').src = "./images/toggle_expand.gif";
			document.getElementById('refreshAreaToggleImage').alt = "[+]";
		}
	}
}

function toggleRefreshArea() {
	/* ========================================================== */
	/* Support function to toggle the view of 'refresh data' area */
	/* ========================================================== */
	if (document.getElementById('refreshArea') != undefined) {
		var el = document.getElementById('refreshArea');
		if (el.isMaximized == undefined) {
			if (el.style.display == 'none') {
				el.isMaximized = true;
			}
			else {
				el.isMaximized = false;
			}
		}
		if (el.isMaximized) {
			hideRefreshArea();
		}
		else {
			viewRefreshArea();
		}
	}
}

function enableRefreshData() {
	/* ========================================================== */
	/* Support function to enable the 'refresh data' area instead */
	/* of the sending of TesterPresent request, when in idle      */
	/* state                                                      */
	/* ========================================================== */
	useRefreshData = true;

	var el = document.getElementById('chkRefreshData');
	if (el != undefined) {
		el.checked = useRefreshData;
	}
}

function disableRefreshData() {
	/* ========================================================== */
	/* Support function to disable the 'refresh data' area.       */
	/* TesterPresent request will be sent , when in idle state    */
	/* ========================================================== */
	useRefreshData = false;

	var el = document.getElementById('chkRefreshData');
	if (el != undefined) {
		el.checked = useRefreshData;
	}
}

function getRefreshDataStatus() {
	/* ========================================================== */
	/* Support function to get the 'refresh data' area state.     */
	/* ========================================================== */
	return(useRefreshData);
}

function setRefreshData() {
	/* ========================================================== */
	/* Support function to set or unset the 'refresh data' area   */
	/* state.                                                     */
	/* ========================================================== */
	var el = document.getElementById('chkRefreshData');
	if (el != undefined) {
		if (el.checked) {
			enableRefreshData();
		}
		else {
			disableRefreshData();
		}
	}
}

function changeLanguage(selectObject) {
	/* ========================================================== */
	/* Support function change language via the onchange event of */
	/* the HTML select list.                                      */
	/* ========================================================== */
	setLanguage(selectObject.options[selectObject.selectedIndex].value);
}

function setLanguage(langCode, resetLangList) {
	/* ========================================================== */
	/* Support function to set language                           */
	/* If resetLangList is true, the HTML select list             */
	/* 'languageSelection' is set to the correct item             */
	/* ========================================================== */
	var lcLangCode = langCode.toLowerCase();
	var elements = document.getElementsByTagName('div');
	changeVisibilityLanguage(elements, lcLangCode);

	elements = document.getElementsByTagName('span');
	changeVisibilityLanguage(elements, lcLangCode);

	var elements = document.getElementsByTagName('p');
	changeVisibilityLanguage(elements, lcLangCode);
	
	setCookie("lang", langCode.toLowerCase(), 3650);
	
	if (resetLangList == true) {
		var sel = document.getElementById('languageSelection');
		for(var i=0; i<sel.options.length; i++) {
			if (sel.options[i].value == lcLangCode) {
				sel.options[i].selected = true;
			}
			else {
				sel.options[i].selected = false;
			}
		}
	}
}

function changeVisibilityLanguage(elements, langCode) {
	/* ========================================================== */
	/* Support function to change visibility of HTML tag that     */
	/* 'lang' attribute matches the 'langCode' parameter (should  */
	/* be in lowercase)                                           */
	/* ========================================================== */
	var i = 0;
	var el;

	for(var i=0;i<elements.length;i++) {
		el = elements[i];
		if (el.lang != '') {
			if (el.lang.toLowerCase() == langCode) {
				el.style.display = 'inline';
			}
			else {
				el.style.display = 'none';
			}
		}
	}
}

function objectShow(objID) {
	/* ========================================================== */
	/* Support function to show a user object (a HTML tag with an */
	/* id value)                                                  */
	/* ========================================================== */
	if (document.getElementById(objID) != undefined) {
		document.getElementById(objID).style.display = "inline";
	}
}

function objectHide(objID) {
	/* ========================================================== */
	/* Support function to hide a user object (a HTML tag with an */
	/* id value)                                                  */
	/* ========================================================== */
	if (document.getElementById(objID) != undefined) {
		document.getElementById(objID).style.display = "none";
	}
}

function extractLocationPath(anUrl) {
	var sTemp = "";

	if (location.protocol.toLowerCase() == "file:") {
		/* replace / with \ */
		sTemp = anUrl.replace(/\//gi, "\\");
		/* remove leading \ if it's like \C:\xxx */
		if ((sTemp.charAt(0) == "\\") && (sTemp.charAt(2) == ":")) {
			sTemp = sTemp.substr(1,sTemp.length - 1);
		}
		/* remove file name part */
		sTemp = sTemp.substr(0,sTemp.lastIndexOf("\\")+1);
		return(sTemp);
	}
	else {
		/* remove file name part */
		sTemp = anUrl.substr(0,sTemp.lastIndexOf("/")+1);
		return(sTemp);
	}
}
