<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">
	<xsl:output method="text" encoding="UTF-8" indent="yes"/>

	<xsl:param name="clientFilename"/>
	<xsl:template match="/">
		<xsl:call-template name="fileName">
			<xsl:with-param name="path">
				<xsl:value-of select="$clientFilename"/>
			</xsl:with-param>
		</xsl:call-template>
	</xsl:template>

	<xsl:template name="fileName">
	  <xsl:param name="path" />
	  <xsl:choose>
	    <xsl:when test="contains($path,'\')">
	      <xsl:call-template name="fileName">
	        <xsl:with-param name="path" select="substring-after($path,'\')" />
	      </xsl:call-template>
	    </xsl:when>
	    <xsl:when test="contains($path,'/')">
	      <xsl:call-template name="fileName">
	        <xsl:with-param name="path" select="substring-after($path,'/')" />
	      </xsl:call-template>
	    </xsl:when>
	    <xsl:otherwise>
	      <xsl:value-of select="$path" />
	    </xsl:otherwise>
	  </xsl:choose>
	</xsl:template>

</xsl:stylesheet>
