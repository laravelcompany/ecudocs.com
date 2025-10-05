
/* ------------------------- user script ------------------------- */
var RENAULT_NET_SERVER = "https://gco.intra.renault.fr:14053/gco/ctrl/login"

var COLOR_ERROR   = "color:red;";
var COLOR_WARNING = "color:#800000;";
var COLOR_NORMAL  = "color:black;";

var INDEX_FINISH = 254;
var INDEX_CANCEL = 255;

var ecuIsInDiagSession       = false;

var usePhysicalTesterPresent = true;
var testerPresentTimeCounter = 0;
var testerPresentProgressBar = "";
var TESTER_PRESENT_PERIOD    = 2000; /* ms */

var BCM_IS_BLANK_S  = false;
/*var Idents          = new Array();*/

var MAX_BLANK_CARDS = 2;
var nbBlankCards    = 0;
var nbPresentedCards= 0;
var nbValetCards    = 0;
var nbPairedCards   = 0;
var isBlankCard     = false;

var counter = 0;

var szLastErrorMessage = "";

function userStartScript() {
/*	initGraphs(); */
	hideRefreshArea();
	if (diagInitScript() == true) {
/*		showWarning('Cliquer sur le bouton [ Commencer ] ci-dessous lancer la procédure.', COLOR_WARNING); */
		startScheduler();
	}
	else {
		buttonHide("btnStart");
	}

/* -------------- */
/*    for debug   */
/*
	action	= ACTION_SHOW_SCREEN;
	setCurrentIndex(3);
	startScheduler();
*/
/* -------------- */
}

function scheduler() { /* do not change the function name */

/*
window.status = action + ", " + getCurrentIndex();
*/
	switch(action) {
		case ACTION_IDLE: /* Manage physical TesterPresent request */
			if (ecuIsInDiagSession) {
				if (getRefreshDataStatus()) {
				/* to do */
					diagRefreshData();
				}
				else {
					if (usePhysicalTesterPresent) {
						testerPresentTimeCounter += SHEDULER_PERIOD;
						if (testerPresentTimeCounter >= TESTER_PRESENT_PERIOD) {
							diagPhysicalTesterPresent();
							testerPresentProgressBar += ".";
							if (testerPresentProgressBar.length > 10) {
								testerPresentProgressBar = ".";
							}
							showExtraInfo('-&gt; Physical Tester Present sent ' + testerPresentProgressBar);
							resetTesterPresentCounter();
						}
					}
				}
			}
			if (indexExists(getCurrentIndex()) != undefined) {
				switch (getCurrentIndex()) {
					case 13:
						setCurrentIndex(10);
						break;
					case 18:
						var result;
						result = diagRoutineCardPairingStatus();
						showWarning("Wait for end of routine");
						if (result == STATUS_OK) {
							nbPairedCards++;
							setCurrentIndex(19);
							action = ACTION_NEXT;
						}
						else {
							if (result != STATUS_IN_PROGRESS) {
								setInnerHTML("pairingErrorData", szLastErrorMessage);
								objectShow("pairingError");
								setCurrentIndex(19);
								action = ACTION_SHOW_SCREEN;
							}
							else {
								action = ACTION_IDLE;
							}
						}
						break;
				}
			}
			startScheduler();
			break;
		case ACTION_START: /* start button clicked */
			if (indexExists(getCurrentIndex()) != undefined) {
			    buttonsHide();
			    objectHide("languageSelectionArea");
			    objectHide("buttonsInfo");
				if (diagInitScript() == true) {
					if (BCM_IS_BLANK_S == true) {
						setCurrentIndex(2);
						action = ACTION_SHOW_SCREEN;
						resetTesterPresentCounter();
						startScheduler();
					}
					else {
						/* initialize vars */
						nbBlankCards     = 0;
						nbPresentedCards = 0;
						nbValetCards     = 0;
						nbPairedCards    = 0;
						for (var i=0; i<=MAX_BLANK_CARDS;i++) {
							Idents[i] = "00000000";
						}
						SERVERdata.value = "";
						/* enter diagnostic session */
						ecuIsInDiagSession = diagStartDiagSession();
						if (ecuIsInDiagSession == true) {
							enableRefreshData();
							setCurrentIndex(3);
							action = ACTION_SHOW_SCREEN;
							resetTesterPresentCounter();
							startScheduler();
						}
						else {
							action = ACTION_IDLE;
							startScheduler();
						}
					}
				}
				else {
					showWarning("Script initialization failed",COLOR_ERROR);
					action = ACTION_IDLE;
					startScheduler();
				}
			}
		    objectShow("buttonsInfo");
			break;
		case ACTION_SHOW_SCREEN:
			manageScreens();
			if (indexExists(getCurrentIndex()) != undefined) {
				switch (getCurrentIndex()) {
					default:
						break;
				}
			}
			action = ACTION_IDLE;
			startScheduler();
			break;
		case ACTION_NEXT:  /* next button clicked */
			if (indexExists(getCurrentIndex()) != undefined) {
				manageScreens();
			    buttonsHide();
				switch (getCurrentIndex()) {
					case 2:
						setCurrentIndex(INDEX_FINISH);
						break;
					case 3:
						if (diagRoutineCardAnalyzing()) {
							nbPresentedCards++;
							if (diagIsBlankCard()) {
								nbBlankCards++;
								if (nbBlankCards < 3) {
									/* Lecture IDENT */
									diagReadCardIdentification();
									setCurrentIndex(6);									
								}
								else {
									setCurrentIndex(5);
								}
							}
							else {
								setCurrentIndex(6);
							}
						}
						else {
							if (diagCardPresent()) {
								setCurrentIndex(7);
							}
							else {
								setCurrentIndex(3);
							}
						}
/*						voltageGraph.changeTargetId ("voltageBar" ,false);*/
						break;
					case 4:
						setCurrentIndex(7);
						break;
					case 5:
						setCurrentIndex(10);
						break;
					case 6:
						setCurrentIndex(7);
						break;
					case 7:
						/* this screen is a Yes/No message, so */
						/* see Yes/No action                   */
						break;
					case 8:
						setCurrentIndex(10);
						break;
					case 9:
						/* this screen is a Yes/No message, so */
						/* see Yes/No action                   */
						break;
					case 10:
						if (diagAPCoff()) {
							if (diagSendSA11()) {
								setCurrentIndex(14);
							}
							else {
								/* action = ACTION_SHOW_SCREEN; */
								setCurrentIndex(13);
							}
						}
						else {
							setCurrentIndex(10);
						}
						break;
					case 13:
						/* see ACTION_IDLE */
						break;
					case 14:
						/* check user input (16 bytes, so 32 characters */
						/* alert(SERVERdata.value); */
						if (!checkSERVERdata()) {
							/* stay on current screen */
							objectShow("screen14error");
							setCurrentIndex(14);
						}
						else {
							if (diagSendSA12()) {
								setCurrentIndex(16);
							}
							else {
								setCurrentIndex(15);
								setInnerHTML ("screen15_error" , szLastErrorMessage);
							}
						}
						break;
					case 15:
						/* This is an error screen (BCM still protected) */
						break;
					case 16:
						setCurrentIndex(17);
						break;
					case 17:
						var result = 0;
						objectHide("pairingError");
						if (document.formCardOption.cardOption[1].checked) {
							result = diagRoutineValetCardPairingStart();
						}
						else {
							result = diagRoutineCardPairingStart();
						}
						if (result == STATUS_IN_PROGRESS) {
							setCurrentIndex(18);
/*alert("result=" + result);*/
						}
						else {
							if (result == STATUS_OK) {
								nbPairedCards++;
								setCurrentIndex(19);
							}
							else {
								setInnerHTML("pairingErrorData", szLastErrorMessage);
								objectShow("pairingError");
								setCurrentIndex(19);
							}
						}
						break;
					case 18:
						/* see read status in ACTION_IDLE */
						break;
					case 19:
/* alert("etape 19"); */
						if (nbPairedCards >= nbPresentedCards) {
							usePhysicalTesterPresent = false;
							setCurrentIndex(INDEX_FINISH);
						}
						else {
							setInnerHTML("div_nbCardsPaired"   , nbPairedCards);
							setInnerHTML("div_nbCardsPresented", nbPresentedCards);
							setCurrentIndex(20);
						}
						break;
					case 20:
						setCurrentIndex(16);
						break;
					case 21:
						break;
					default:
						break;
				}
			}
			resetTesterPresentCounter();
			action = ACTION_SHOW_SCREEN;
			startScheduler();
			break;
		case ACTION_YES:  /* Yes button clicked */
			if (indexExists(getCurrentIndex()) != undefined) {
				manageScreens();
				switch (getCurrentIndex()) {
					case 7:
						buttonsHide();
						if (nbPresentedCards >= 4) {
							setCurrentIndex(8);
						}
						else {
							setCurrentIndex(3);
						}
						break;
					case 9:
						setCurrentIndex(INDEX_FINISH);
						break;
				}
			}
			action = ACTION_SHOW_SCREEN;
			startScheduler();
			break;
		case ACTION_NO:  /* No button clicked */
			if (indexExists(getCurrentIndex()) != undefined) {
				manageScreens();
				switch (getCurrentIndex()) {
					case 7:
						buttonsHide();
						setCurrentIndex(10);
						break;
					case 9:
						setCurrentIndex(8);
						break;
				}
			}
			action = ACTION_SHOW_SCREEN;
			startScheduler();
			break;
		case ACTION_FINISH: /* finish button clicked */
			if (indexExists(getCurrentIndex()) != undefined) {
				usePhysicalTesterPresent = false;
				disableRefreshData();
				manageScreens();
				hideRefreshArea();
				setCurrentIndex(INDEX_FINISH);
				manageScreens();
			}
			break;
		case ACTION_CANCEL: /* cancel button clicked */
			if (indexExists(getCurrentIndex()) != undefined) {
				usePhysicalTesterPresent = false;
				disableRefreshData();
				manageScreens();
				hideRefreshArea();
				setCurrentIndex(INDEX_CANCEL);
				manageScreens();
			}
			break;
	}

}

function manageScreens() {
	screenHide(getPreviousIndex());
	screenShow(getCurrentIndex());
	showWarning('&nbsp;');
	showExtraInfo('&nbsp;');
    buttonsHide();
	if (indexExists(getCurrentIndex()) != undefined) {
		switch (getCurrentIndex()) {
			case 1:
				buttonShow("btnNext");
				buttonShow("btnFinish");
				break;
			case 2:
				buttonShow("btnFinish");
				break;
			case 3:
				setInnerHTML("screen3_presentedCards", nbPresentedCards + (lang=='en'?' presented card(s)':' carte(s) présentée(s)') );
				buttonShow("btnNext");
				buttonShow("btnCancel");
				break;
			case 4:
				buttonShow("btnNext");
				buttonShow("btnCancel");
				break;
			case 5:
				setInnerHTML("screen5_presentedCards", nbPresentedCards + (lang=='en'?' presented card(s)':' carte(s) présentée(s)') );
				buttonShow("btnNext");
				buttonShow("btnCancel");
				break;
			case 6:
				setInnerHTML("screen6_presentedCards", nbPresentedCards + (lang=='en'?' presented card(s)':' carte(s) présentée(s)') );
				buttonShow("btnNext");
				buttonShow("btnCancel");
				break;
			case 7:
				setInnerHTML("screen7_presentedCards", nbPresentedCards + (lang=='en'?' presented card(s)':' carte(s) présentée(s)') );
				buttonShow("btnYes");
				buttonShow("btnNo");
				break;
			case 8:
				buttonShow("btnNext");
				buttonShow("btnCancel");
				break;
			case 9:
				setInnerHTML("screen9_presentedCards", nbPresentedCards + (lang=='en'?' presented card(s)':' carte(s) présentée(s)') );
				buttonShow("btnYes");
				buttonShow("btnNo");
				break;
			case 10:
				setInnerHTML("screen10_presentedCards", nbPresentedCards + (lang=='en'?' presented card(s)':' carte(s) présentée(s)') );
				buttonShow("btnNext");
				buttonShow("btnCancel");
				break;
			case 11:
				buttonShow("btnNext");
				buttonShow("btnCancel");
				break;
			case 12:
				buttonShow("btnYes");
				buttonShow("btnNo");
				break;
			case 13:
				buttonShow("btnNext");
				buttonShow("btnCancel");
				break;
			case 14:
				buttonShow("btnNext");
				buttonShow("btnCancel");
				break;
			case 15:
				buttonShow("btnNext");
				buttonShow("btnCancel");
				break;
			case 16:
				buttonShow("btnNext");
				buttonShow("btnCancel");
				break;
			case 17:
				buttonShow("btnNext");
				buttonShow("btnCancel");
				break;
			case 18:
				buttonShow("btnCancel");
				break;
			case 19:
				buttonShow("btnNext");
				buttonShow("btnFinish");
				break;
			case 20:
				buttonShow("btnNext");
				buttonShow("btnFinish");
				break;
			case 21:
				buttonShow("btnFinish");
				break;
			case INDEX_CANCEL:
			case INDEX_FINISH:
				setInnerHTML("screen254_pairedCards"   , nbPairedCards);
				setInnerHTML("screen254_presentedCards", nbPresentedCards);
				usePhysicalTesterPresent = false;
				disableRefreshData();
				hideRefreshArea();
				objectHide("buttonsInfo");
				break;
			default:
				break;
		}
	}
}

function resetTesterPresentCounter() {
	testerPresentTimeCounter = 0;
}

function checkSERVERdata() {
  var VALID_HEX_CHARS = "0123456789ABCDEFabcdef";
  var sData = SERVERdata.value;
  var ch = "";
  /* check length */
  if (sData.length == 32) {
    /* check characters - only A-F, 0-9 allowed */
    for (var i=0;i<sData.length;i++) {
      ch = sData.charAt(i);
      if (VALID_HEX_CHARS.indexOf(ch) == -1) {
        return false;
      }
    }
    return true;
  }
  else {
    return false;
  }
}

function openServerWindow() {
	window.open(RENAULT_NET_SERVER, "renaultNetServer");
}
/* ---------------------- end of user script --------------------- */
