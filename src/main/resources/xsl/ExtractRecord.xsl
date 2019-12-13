<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0" >
<xsl:output method="xml" indent="yes" omit-xml-declaration="yes"/>
<xsl:param name="record" />
	<xsl:template match="row">
	  	<row>
	  		<xsl:copy-of select="*" />
	  	</row>
	</xsl:template>
</xsl:stylesheet>