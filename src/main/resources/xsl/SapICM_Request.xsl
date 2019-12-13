<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">
	<xsl:output method="xml" indent="yes" omit-xml-declaration="yes" />
	<xsl:param name="str"/>
	<xsl:template match="/">
		<xsl:variable name="SapICM">
			<xsl:for-each select="tokenize($str,';')">
				<Data>
					<xsl:value-of select="." />
				</Data>
			</xsl:for-each>
		</xsl:variable>
		<root>
			<TRANSACTION_EFFECTIVE_DATE>
				<xsl:value-of select="$SapICM/Data[1]"/>
			</TRANSACTION_EFFECTIVE_DATE>
			<BUSOBJ_VERSDATE>
				<xsl:value-of select="$SapICM/Data[2]"/>
			</BUSOBJ_VERSDATE>
			<POLICY_REFERENCE>
				<xsl:value-of select="$SapICM/Data[3]"/>
			</POLICY_REFERENCE>
			<TRIG_TRANS_ID>
				<xsl:value-of select="$SapICM/Data[4]"/>
			</TRIG_TRANS_ID>
			<BUS_TRANS_ID>
				<xsl:value-of select="$SapICM/Data[5]"/>
			</BUS_TRANS_ID>
			<POLICY_CURRENCY>
				<xsl:value-of select="$SapICM/Data[6]"/>
			</POLICY_CURRENCY>
			<AGENT_REFERENCE>
				<xsl:value-of select="$SapICM/Data[7]"/>
			</AGENT_REFERENCE>
			<ZZPRODUCT_NAAM>
				<xsl:value-of select="$SapICM/Data[8]"/>
			</ZZPRODUCT_NAAM>
			<ZZPOLIS_START>
				<xsl:value-of select="$SapICM/Data[9]"/>
			</ZZPOLIS_START>
			<ZZPOLIS_EIND>
				<xsl:value-of select="$SapICM/Data[10]"/>
			</ZZPOLIS_EIND>
			<ZZPREMIE_TYPE>
				<xsl:value-of select="$SapICM/Data[11]"/>
			</ZZPREMIE_TYPE>
			<ZZPREMIE_EIND>
				<xsl:value-of select="$SapICM/Data[12]"/>
			</ZZPREMIE_EIND>
			<ZZPREMIE_BEDRAG>
				<xsl:value-of select="$SapICM/Data[13]"/>
			</ZZPREMIE_BEDRAG>
			<ZZPROVSIE_PERCENTAGE>
				<xsl:value-of select="$SapICM/Data[14]"/>
			</ZZPROVSIE_PERCENTAGE>
			<ZZPREM_FREQ>
				<xsl:value-of select="$SapICM/Data[15]"/>
			</ZZPREM_FREQ>
			<ZZVERZEKNEMER>
				<xsl:value-of select="$SapICM/Data[16]"/>
			</ZZVERZEKNEMER>
			<ZZUSER_ID>
				<xsl:value-of select="$SapICM/Data[17]"/>
			</ZZUSER_ID>
			<ZZFARCODE>
				<xsl:value-of select="$SapICM/Data[18]"/>
			</ZZFARCODE>
			<COPY_OBJ_TYPE>
				<xsl:value-of select="$SapICM/Data[19]"/>
			</COPY_OBJ_TYPE>
			<ZZDEELN_NR>
				<xsl:value-of select="$SapICM/Data[20]"/>
			</ZZDEELN_NR>
			<ZZADN_ADRES>
				<xsl:value-of select="$SapICM/Data[21]"/>
			</ZZADN_ADRES>
			<ZZINCASSOCODE>
				<xsl:value-of select="$SapICM/Data[22]"/>
			</ZZINCASSOCODE>
		</root>

	</xsl:template>


</xsl:stylesheet>