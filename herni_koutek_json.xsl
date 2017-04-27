<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:output method="text"/>                               <!-- definuje se o jaký výstup se jedná, může být i html -->
  <xsl:template match="/">
      [
	  <!--Vypsání základních informací o aplikaci--> 
      <xsl:for-each select="hryvse/konfigurace">
        {
        "Kódování": "<xsl:value-of select="coding"/>",
        "Verze aplikace": "<xsl:value-of select="aplication_version"/>",
	"Název aplikace": "<xsl:value-of select="aplication_name"/>",
	"Autor aplikace": "<xsl:value-of select="autor_aplikace"/>",
	"Kontakt": "<xsl:value-of select="kontakt_mail"/>"
        }</xsl:for-each>,
	  
      <xsl:for-each select="hryvse/hra">
        {                                                    <!-- tyto závorky říkají, že se jedná o JSON, kdyby se jednalo o html tak by se místo toho mohlo dát třeba <p> -->
            "ID": "<xsl:value-of select="@id"/>",               <!-- @ znamená se že jedná o atribut -->
            "Typ hry": "<xsl:value-of select="@druh"/>",
            "Název hry": "<xsl:value-of select="nazev_hry"/>",
            "Rok vydání": "<xsl:value-of select="rok_vydani"/>",
            "Stav zboží": "<xsl:value-of select="stav"/>"
        }<xsl:if test="position() != last()">,</xsl:if>      <!-- řeší problém s  čárkou -->
      </xsl:for-each>,
      
	  <!--Vypsání názvů knih seřazených dle ceny-->
          <xsl:for-each select="hryvse/hra">
            <xsl:sort select="cena" order ="descending"/>     <!-- řazení dle ceny -->
            {                                                               
                "ID": "<xsl:value-of select="@id"/>",      
                "Jazyk": "<xsl:value-of select="jazyk_hry"/>",
                "Cena": "<xsl:value-of select="cena"/>",         
                "Název hry": "<xsl:value-of select="nazev_hry"/>"
            }<xsl:if test="position() != last()">,</xsl:if>     
          </xsl:for-each>,
      
	  
                <!--Vypsání her, které jsou napsány v českém jazyce-->
            <xsl:for-each select="hryvse/hra [jazyk_hry = 'cs']">   <!-- Vložená podmínka -->
            {                                                               
                    "ID": "<xsl:value-of select="@id"/>",
                    "Název hry": "<xsl:value-of select="nazev_hry"/>",
                    "Jazyk": "<xsl:value-of select="jazyk_hry"/>",
                    "Cena": "<xsl:value-of select="cena"/>",  
                    "Stav zboží": "<xsl:value-of select="stav"/>"      
            }<xsl:if test="position() != last()">,</xsl:if>    
          </xsl:for-each>,

              <xsl:for-each select="hryvse/hra [vydavatelstvi = 'XBoX Games']">   <!-- Vložená podmínka -->
                {                                                               
                        "ID": "<xsl:value-of select="@id"/>",
                        "Název hry": "<xsl:value-of select="nazev_hry"/>",
                        "Platforma": "<xsl:value-of select="vydavatelstvi"/>"    
                }<xsl:if test="position() != last()">,</xsl:if>    
              </xsl:for-each>
      ]
      
  </xsl:template>
</xsl:stylesheet>
