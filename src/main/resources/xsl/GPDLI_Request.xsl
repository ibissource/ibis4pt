<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0" xmlns:ns5="http://www.bsb.com/is/xml/aggregation/model/traditionallife/policy/detail" xmlns:pfx="http://nn.nl/XSD/LifeRetailCB/Policy/LifeRetailCBPolicy/3/GetPolicyDetailsLifeInsurance/1">
	<xsl:output method="xml" indent="yes" omit-xml-declaration="yes"/>
	<xsl:param name="PolNum"/>
	
	<xsl:template match="/">
		 <pfx:GetPolicyDetailsLifeInsuranceRequest>
	        <pfx:Services>
	            <pfx:getPolicyClauses>0</pfx:getPolicyClauses>
	        </pfx:Services>
	        <pfx:policyNumber>
	        	<xsl:variable name="pol">
       				<xsl:call-template name="padding">
						<xsl:with-param name="cent" select="translate($PolNum,'LV','')" />
						<xsl:with-param name="length" select="string-length(translate($PolNum,'LV',''))" />
						<xsl:with-param name="maxLen" select="8" />
					</xsl:call-template>
       			</xsl:variable>
	        	<xsl:value-of select="concat('LV', $pol)"/>
	        </pfx:policyNumber>
	        <pfx:detailFilter>
	            <ns5:detailTypeList>
	                <ns5:detailType>CLAUSES</ns5:detailType>
	                <ns5:detailType>GENERAL_INFORMATION</ns5:detailType>
	                <ns5:detailType>OPERATIONS</ns5:detailType>
	                <ns5:detailType>BILLING</ns5:detailType>
	                <ns5:detailType>COVERAGE</ns5:detailType>
	                <ns5:detailType>COVERAGE_PRICING</ns5:detailType>
	            </ns5:detailTypeList>
	        </pfx:detailFilter>
	    </pfx:GetPolicyDetailsLifeInsuranceRequest>
	</xsl:template>
	
	<xsl:template name="padding">
		<xsl:param name="cent" />
		<xsl:param name="length" />
		<xsl:param name="maxLen" />

		<xsl:choose>
			<xsl:when test="$length &lt; $maxLen">
				<xsl:call-template name="padding">
					<xsl:with-param name="cent" select="concat('0',$cent)" />
					<xsl:with-param name="length" select="string-length($cent) + 1" />
					<xsl:with-param name="maxLen" select="$maxLen" />
				</xsl:call-template>
			</xsl:when>
			<xsl:when test="$length &gt; $maxLen">
				<xsl:value-of select="substring($cent,1,$maxLen)" />
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$cent" />
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	
</xsl:stylesheet>