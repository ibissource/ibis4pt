<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">
	<xsl:output method="text" encoding="UTF-8" indent="yes"/>

	<xsl:param name="timestamp"/>
	<xsl:param name="Type"/>
	<xsl:param name="fileType"/>
	<xsl:param name="hostName"/>
	
	<xsl:template match="/">
		<xsl:choose>
			<xsl:when test="$fileType = 'final'">
				<xsl:choose>
					<xsl:when test="$Type = 'mutation'">
						<xsl:value-of select="concat('intddsmx_', $timestamp, '.xml')"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="concat('intddspx_', $timestamp, '.xml')"/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:otherwise>
				<xsl:variable name="var_hostName">
					<xsl:choose>
					<xsl:when test="contains($hostName,'.insim.biz')">
						<xsl:value-of select="substring-before($hostName,'.insim.biz')"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="$hostName"/>
					</xsl:otherwise>
					</xsl:choose>
				</xsl:variable>
				<xsl:choose>
					<xsl:when test="$Type = 'mutation'">
						<xsl:value-of select="concat('Daily_', $var_hostName, '.xml')"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="concat('Monthly_', $var_hostName, '.xml')"/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
</xsl:stylesheet>
