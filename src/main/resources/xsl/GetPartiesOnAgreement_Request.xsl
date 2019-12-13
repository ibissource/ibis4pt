<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0" xmlns="http://nn.nl/XSD/CustomerAdministration/Party/1/GetPartiesOnAgreement/6">
	<xsl:output method="xml" indent="yes" omit-xml-declaration="yes"/>
	<xsl:param name="PolNum"/>
	<xsl:param name="timestamp"/>
	<xsl:template match="/">
		<GetPartiesOnAgreement_Request>
			<PolicyNumber>
				<xsl:value-of select="$PolNum"/>
			</PolicyNumber>
			<VTAID>SOLI</VTAID>
		</GetPartiesOnAgreement_Request>
	</xsl:template>	
</xsl:stylesheet>