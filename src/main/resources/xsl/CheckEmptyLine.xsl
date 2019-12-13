<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">
	<xsl:output method="text" />
	
	<xsl:param name="FileLine"/>
	
	<xsl:template match="/">
		<xsl:choose>
			<xsl:when test="string(number(substring($FileLine, 1,1))) = 'NaN'">READY</xsl:when>
			<xsl:when test="string-length(normalize-space($FileLine)) = 0">READY</xsl:when>
			<xsl:otherwise>process</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	
</xsl:stylesheet>
