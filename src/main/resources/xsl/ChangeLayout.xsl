<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output omit-xml-declaration="yes"/>
    <xsl:strip-space elements="*"/>
    
    <xsl:template match="@*|node()" name="identity">
        <xsl:copy>
            <xsl:apply-templates select="@*|node()" />
        </xsl:copy>
    </xsl:template>
    
    <!-- <xsl:template match="VIEW_41100|/*">
        <xsl:apply-templates/>
    </xsl:template> -->
    
    <xsl:template match="TEST">
        <xsl:call-template name="identity"/>
        <xsl:text>&#xA;</xsl:text>
    </xsl:template>
    
    <!-- Start and End tag but space between -->
	<xsl:template match="*[name() != 'PP_EXPDAT']">
		<xsl:choose>
			<xsl:when test="string-length(.) &gt; 0">
				<xsl:element name="{local-name()}">
					<xsl:apply-templates />
				</xsl:element>
			</xsl:when>
			<xsl:otherwise>
				<xsl:element name="{local-name()}">
					<xsl:text> </xsl:text>
				</xsl:element>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

</xsl:stylesheet>