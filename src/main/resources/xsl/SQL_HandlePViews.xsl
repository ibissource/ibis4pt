<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">
<xsl:output method="text"/>

<xsl:param name="RecordType"/>
<xsl:param name="flag"/>
	<xsl:template match="/">
	
		SELECT <xsl:choose>
		<xsl:when test="$flag = 'count'">COUNT(1) AS CNT </xsl:when>
		<xsl:when test="$flag = 'mutation' or $flag = 'renewal'">RECORDID,POLICYNO,RECORDTYPE,REQUEST </xsl:when></xsl:choose>FROM RECORDSTORE 
			WHERE STATUS in (<xsl:choose><xsl:when test="SendTrigger_Action/TriggerDetails/Jobname = 'VTA-049'">0</xsl:when><xsl:otherwise>4,5</xsl:otherwise> </xsl:choose>) 
				<xsl:if test="SendTrigger_Action/TriggerDetails/Jobname = 'VTA-049'"> AND PRC_TYDST IS NULL </xsl:if>
				AND RECORDTYPE ='<xsl:value-of select="$RecordType"/>' 
				AND TYPE = 'VTA-049' ORDER BY RECORDID
		
	</xsl:template>


</xsl:stylesheet>
