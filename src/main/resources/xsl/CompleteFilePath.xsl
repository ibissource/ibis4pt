<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">
	<xsl:output method="text" encoding="UTF-8" indent="yes"/>

	<xsl:param name="outputFileName"/>
	<xsl:param name="fxfDir"/>
	<xsl:param name="outputDir"/>
	<xsl:param name="transferRecordType"/>
	
	<xsl:template match="/">
		<xsl:choose>
			<xsl:when test="$transferRecordType = 'monthly'">
				<xsl:value-of select="concat($fxfDir,'/' ,$outputDir,'/' ,'out/', $outputFileName)"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="concat($fxfDir,'/' ,$outputDir,'/' ,'out/', $outputFileName)"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
</xsl:stylesheet>
