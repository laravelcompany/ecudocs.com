<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" exclude-result-prefixes="msxsl"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:msxsl="urn:schemas-microsoft-com:xslt"
>
<xsl:output method="xml" encoding="utf-8" indent="yes" omit-xml-declaration="yes" />

<xsl:param name="language">fr</xsl:param>

<!-- Définir la langue du rapport xml
     pour afficher le rapport (entêtes de colonne,...etc) dans la même langue
-->
<xsl:param name="reportLanguage">
<xsl:choose>
	<xsl:when test="//check/reportLanguage">
		<!-- le fichier xml contient la langue au moment où ont été réalisés
		     les tests. C'est cette langue qui servira à afficher le rapport,
		     indépendemment de la langue DDT au moment où on affiche le rapport.
		     ex: langue DDT au moment des tests = 'fr' ==> le rapport (.xml) est en 'fr' et contient dans la balise /reportLanguage 'fr'
		         langue DDT au moment où on affiche le rapport = 'en'
		                        ==> reportLanguage=//check/reportLanguage = 'fr'
		                        ==> affichage des entêtes,..etc et des tests en  'fr'
		-->
		<xsl:value-of select="//check/reportLanguage" />
	</xsl:when>
	<xsl:otherwise>
		<!-- le fichier xml ne contient pas la langue au moment où ont été réalisés
		     les tests. La langue qui servira à afficher le rapport sera la langue DDT
		     au moment où on affiche le rapport.
		     ex: langue DDT au moment des tests = 'fr' ==> le rapport (.xml) est en 'fr'
		         langue DDT au moment où on affiche le rapport = 'en'
		                  ==> reportLanguage=$language = 'en'
		                  ==>affichage : entêtes de colonne,...etc en 'en' et tests en 'fr'
		-->
		<xsl:value-of select="$language" />
	</xsl:otherwise>
</xsl:choose>
</xsl:param>


<xsl:template name="DoNotRemove">
<!-- ATTENTION ne pas toucher id="currentVersion" car builder cherche cette chaine de
     caractères pour afficher le version derrière le radio bouton local.
     Ne pas oublier de mettre aussi à jour la version dans le ficher rules_DisplayTemplates.xsl
     Ne pas oublier de mettre le V devant le n° de version. Ex :
     <span id="currentVersion">Vx.y</span>
-->
<span id="currentVersion">V1.11</span>
</xsl:template>

<xsl:include href="rules_DisplayTemplates.xsl" />

<xsl:template match="/">
	<html>
		<head>
			<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
			<xsl:call-template name="rules_CSS" />
			<xsl:call-template name="rules_Scripts" />
		</head>
		<body>
			<xsl:call-template name="rules_DisplayTemplates" />
		</body>
	</html>
</xsl:template>



</xsl:stylesheet>