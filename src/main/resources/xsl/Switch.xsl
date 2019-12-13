<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">
<xsl:output method="text" />
	
	
	<xsl:template match="/">
		<xsl:choose>
			<xsl:when test="GetPartiesOnAgreement_Response/Result/Status = 'OK'">
				<xsl:choose>
					<xsl:when test="GetPartiesOnAgreement_Response/Roles[RoleID = 'VZ' and string-length(BusinessPartner/Person/DeathDate) > 0]">Proceed</xsl:when>
					<xsl:otherwise>
						<xsl:choose>
							<xsl:when test="count(GetPartiesOnAgreement_Response/Roles[RoleID = 'VN']) = 1">Proceed</xsl:when>
							<xsl:when test="count(GetPartiesOnAgreement_Response/Roles[RoleID = 'VN']) = 2 and 
											(GetPartiesOnAgreement_Response/Roles[RoleID = 'VN']/RoleSequenceNumber)[1] = (GetPartiesOnAgreement_Response/Roles[RoleID = 'VN']/RoleSequenceNumber)[2]">Proceed</xsl:when>
							<xsl:otherwise>ERROR-E2</xsl:otherwise>
						</xsl:choose>
					</xsl:otherwise>
				</xsl:choose>
				
							
			</xsl:when>
			<xsl:otherwise>ERROR-E3</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
</xsl:stylesheet>