<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">
<xsl:output method="text" />
	
	<xsl:param name="recordTypeForFile"/>
	<xsl:template match="/">
		<xsl:choose>
			<xsl:when test="$recordTypeForFile='monthly' or $recordTypeForFile='renewal'">monthly</xsl:when>
			<xsl:otherwise>daily</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
</xsl:stylesheet>