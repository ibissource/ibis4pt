<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0" >
	<xsl:output method="text" />
	
	<xsl:param name="originalMessage"/>
	<xsl:param name="mode"/>
	
	<xsl:template match="/">
		
		<xsl:choose>
			 <xsl:when test="$mode = 'PolNr'">
			 	<xsl:call-template name="ElementValue">
					<xsl:with-param name="ElementPos" select="3"/>
					<xsl:with-param name="CurrPos" select="1"/>
					<xsl:with-param name="str" select="$originalMessage"/>
				</xsl:call-template>
			 </xsl:when>
			 			 
		</xsl:choose>
		
	</xsl:template>
	
	<xsl:template name="ElementValue">
		<xsl:param name="ElementPos"/>
		<xsl:param name="CurrPos"/>
		<xsl:param name="str"/>
			<xsl:choose>
				<xsl:when test="$CurrPos &lt; $ElementPos">
					<xsl:call-template name="ElementValue">
						<xsl:with-param name="ElementPos" select="$ElementPos"/>
						<xsl:with-param name="CurrPos" select="$CurrPos + 1"/>
						<xsl:with-param name="str" select="substring-after($str, ';')"/>
					</xsl:call-template>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="substring-before($str,';')"/>
				</xsl:otherwise>
				
			</xsl:choose>
		
	</xsl:template>
	
	<xsl:template name="padding">
		<xsl:param name="cent"/>
		<xsl:param name="length"/>
		<xsl:param name="maxLen" />
					
		<xsl:choose>
			<xsl:when test="$length &lt; $maxLen">
				<xsl:call-template name="padding">
					<xsl:with-param name="cent" select="concat('0',$cent)"/>
					<xsl:with-param name="length" select="string-length($cent) + 1"/>
					<xsl:with-param name="maxLen" select="$maxLen"/>
				</xsl:call-template>				
			</xsl:when>
			<xsl:when test="$length &gt; $maxLen">
				<xsl:value-of select="substring($cent,1,$maxLen)" />
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$cent"/>
			</xsl:otherwise>
		</xsl:choose>		
	</xsl:template>
	
	<xsl:template name="paddingSpace">
		<xsl:param name="padlength"/>
		<xsl:param name="value"/>
		<xsl:param name="strLen" select="string-length($value)"/>
		<xsl:variable name="padlen" select="number($padlength)-$strLen"/>
		<xsl:variable name="padString" select="' '"/>
		<xsl:choose>
			<xsl:when test="$padlen &lt; 0">
				<xsl:value-of select="substring($value,1,$padlength)"/>
			</xsl:when>
			<xsl:when test="$padlen = 0">
				<xsl:value-of select="$value"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:variable name="newValue">
					<xsl:value-of select="concat($value,$padString)"/>
				</xsl:variable>
				<xsl:call-template name="paddingSpace">
					<xsl:with-param name="padlength" select="$padlength - 1"/>
					<xsl:with-param name="value" select="$newValue"/>
					<xsl:with-param name="strLen" select="$strLen"/>
				</xsl:call-template>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	
</xsl:stylesheet>