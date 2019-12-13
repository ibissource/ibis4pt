<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">
<xsl:output method="text"/>
<xsl:param name="RECORDID"/>
	<xsl:template match="/">
	  	UPDATE RECORDSTORE SET STATUS = 2, PRC_TYDST = SYSTIMESTAMP WHERE RECORDID ='<xsl:value-of select="$RECORDID"/>'
	</xsl:template>
</xsl:stylesheet>