<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">
	<xsl:output method="xml" indent="no" omit-xml-declaration="yes" />
	
	<xsl:param name="PolNum" />
	<xsl:param name="timestamp" />
	<xsl:param name="GPDLI_Response"/>
	<xsl:param name="GPOA_Response" />
	<xsl:param name="SapICM_Request" />
	
	<xsl:template match="/">
		<xsl:variable name="HEKJE_Q_PFUNK">
			<xsl:choose>
				<xsl:when test="$SapICM_Request/root/COPY_OBJ_TYPE = '1PR'">001</xsl:when>
				<xsl:when test="$SapICM_Request/root/COPY_OBJ_TYPE = '1SU'">101</xsl:when>
				<xsl:when test="$SapICM_Request/root/COPY_OBJ_TYPE = '1DC'">101</xsl:when>
				<xsl:when test="$SapICM_Request/root/COPY_OBJ_TYPE = '1EP'">101</xsl:when>
				<xsl:when test="$SapICM_Request/root/COPY_OBJ_TYPE = 'R'">106</xsl:when>
				<xsl:when test="$SapICM_Request/root/COPY_OBJ_TYPE = '1MU'">105</xsl:when>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="ZZPREMIE_BEDRAG" select="$SapICM_Request/root/ZZPREMIE_BEDRAG" />
		<xsl:variable name="MU">
			<xsl:choose>
				<xsl:when test="substring-after($SapICM_Request/root/TRIG_TRANS_ID, '/') = '1MU'">true</xsl:when>
				<xsl:otherwise>false</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="PP_STANBEG">
			<xsl:choose>
				<xsl:when test="$GPDLI_Response/GetPolicyDetailsLifeInsuranceResponse/aggregatedPolicyDetails/clauses/TradLifeClause/clause/clauseTypeCodeId = 'MANUAL_BEN'">N</xsl:when>
				<xsl:otherwise>J</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="ZZPREMIE_BEDRAG">
			<xsl:choose>
				<xsl:when test="contains($SapICM_Request/root/ZZPREMIE_BEDRAG, '-')">
					<xsl:value-of select="number(translate($SapICM_Request/root/ZZPREMIE_BEDRAG, '-','')) *-1" />
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="$SapICM_Request/root/ZZPREMIE_BEDRAG" />
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="ZZPREMIE_PROCESSED" select="format-number($ZZPREMIE_BEDRAG,'#0.00')" />

		<VIEW_41100>
			<HEKJE_T>
				<HEKJE_T_RECCRT>
					<xsl:value-of select="number($SapICM_Request/root/AGENT_REFERENCE)" />
				</HEKJE_T_RECCRT>
				<xsl:choose>
					<xsl:when test="string-length($SapICM_Request/root/ZZADN_ADRES) = 0">
						<HEKJE_T_ADNPBNR> </HEKJE_T_ADNPBNR>
					</xsl:when>
					<xsl:otherwise>
						<HEKJE_T_ADNPBNR>
							<xsl:call-template name="padding">
								<xsl:with-param name="cent" select="$SapICM_Request/root/ZZADN_ADRES" />
								<xsl:with-param name="length" select="string-length($SapICM_Request/root/ZZADN_ADRES)" />
								<xsl:with-param name="maxLen" select="16" />
							</xsl:call-template>
						</HEKJE_T_ADNPBNR>
					</xsl:otherwise>
				</xsl:choose>				
				<HEKJE_T_AARDTP>1</HEKJE_T_AARDTP>
			</HEKJE_T>
			<HEKJE_V>
				<HEKJE_V_ADMNR>300</HEKJE_V_ADMNR>
			</HEKJE_V>
			<HEKJE_Q>
				<HEKJE_Q_TIMSTMP>
					<xsl:value-of select="$timestamp" />
				</HEKJE_Q_TIMSTMP>
				<HEKJE_Q_MEDIUM>ADN</HEKJE_Q_MEDIUM>
				<HEKJE_Q_TPAAND>
					<xsl:value-of select="$SapICM_Request/root/ZZDEELN_NR" />
				</HEKJE_Q_TPAAND>
				<HEKJE_Q_PFUNK>
					<xsl:value-of select="$HEKJE_Q_PFUNK" />
				</HEKJE_Q_PFUNK>
			</HEKJE_Q>
			<BIJKANT>
				<AL>
					<AL_VIEWCOD>41100</AL_VIEWCOD>
					<AL_PFUNK>
						<xsl:value-of select="$HEKJE_Q_PFUNK" />
					</AL_PFUNK>
					<AL_TPAAND>
						<xsl:value-of select="$SapICM_Request/root/ZZDEELN_NR" />
					</AL_TPAAND>
					<AL_BERRFNR>
						<xsl:value-of select="$SapICM_Request/root/BUS_TRANS_ID" />
					</AL_BERRFNR>
					<AL_BRONNM>
						<xsl:value-of select="'NNS-FELIX-HandlePViewsLI-SAP ICM'" />
					</AL_BRONNM>
					<AL_DATACAT>13</AL_DATACAT>
				</AL>
				<PP>
					<PP_BRANCHE>100</PP_BRANCHE>
					<PP_MYAAND>N007</PP_MYAAND>				
					<xsl:choose>
							<xsl:when test="number($SapICM_Request/root/ZZPREM_FREQ) = 1"><PP_BETTERM>12</PP_BETTERM></xsl:when>
							<xsl:when test="number($SapICM_Request/root/ZZPREM_FREQ) = 2"><PP_BETTERM>6</PP_BETTERM></xsl:when>
							<xsl:when test="number($SapICM_Request/root/ZZPREM_FREQ) = 4"><PP_BETTERM>3</PP_BETTERM></xsl:when>
							<xsl:when test="number($SapICM_Request/root/ZZPREM_FREQ) = 12"><PP_BETTERM>1</PP_BETTERM></xsl:when>
					</xsl:choose>					
					<PP_BETWIJZ>
						<xsl:value-of select="$SapICM_Request/root/ZZINCASSOCODE" />
					</PP_BETWIJZ>
					<xsl:variable name="trans_eff_date" select="concat(substring($SapICM_Request/root/TRANSACTION_EFFECTIVE_DATE, 1, 4), '-', substring($SapICM_Request/root/TRANSACTION_EFFECTIVE_DATE, 5, 2),'-',substring($SapICM_Request/root/TRANSACTION_EFFECTIVE_DATE, 7, 2))" />
					<xsl:variable name="issueDate" select="$GPDLI_Response/GetPolicyDetailsLifeInsuranceResponse/aggregatedPolicyDetails/generalInformation/generalInformation/issueDate" />
					<xsl:variable name="date_var">
						<xsl:choose>
							<xsl:when test="string-length($issueDate) > 0 and number($issueDate) &lt;= number($trans_eff_date)">
								<xsl:value-of select="number(substring($trans_eff_date, 1, 4)) - number(substring($issueDate, 1, 4)) + 1" />
							</xsl:when>
							<xsl:otherwise>0</xsl:otherwise>
						</xsl:choose>
					</xsl:variable>
					<PP_ENDDTP>
						<xsl:value-of select="$SapICM_Request/root/ZZPREMIE_EIND" />
					</PP_ENDDTP>
					<xsl:choose>
						<xsl:when test="$GPDLI_Response//GetPolicyDetailsLifeInsuranceResponse/aggregatedPolicyDetails/generalInformation/generalInformation/productId = 'RIS-UITV'">
							<PP_EXPDAT />
						</xsl:when>
						<xsl:otherwise>
							<PP_EXPDAT>
								<xsl:value-of select="$SapICM_Request/root/ZZPOLIS_EIND" />
							</PP_EXPDAT>
						</xsl:otherwise>
					</xsl:choose>
					<PP_INGDAT>
						<xsl:value-of select="$SapICM_Request/root/ZZPOLIS_START" />
					</PP_INGDAT>
					<PP_KEWC>
						<xsl:variable name="var_cf_fiscalRegimeCode" select="$GPDLI_Response//GetPolicyDetailsLifeInsuranceResponse/aggregatedPolicyDetails/generalInformation/generalInformation/CustomFieldList/CustomField[@name = 'cf_fiscalRegimeCode']/value/simpleValueList/simpleValue" />
						<xsl:choose>
							<xsl:when test="$var_cf_fiscalRegimeCode = 15 or $var_cf_fiscalRegimeCode = 16 or $var_cf_fiscalRegimeCode = 25 or $var_cf_fiscalRegimeCode = 26 or $var_cf_fiscalRegimeCode = 34">J</xsl:when>
							<xsl:otherwise>N</xsl:otherwise>
						</xsl:choose>
					</PP_KEWC>					
					<xsl:variable name="PP_INGDTW" select="$GPDLI_Response/GetPolicyDetailsLifeInsuranceResponse/aggregatedPolicyDetails/endorsements/EndorsementShortDescription[operationId = max($GPDLI_Response//GetPolicyDetailsLifeInsuranceResponse/aggregatedPolicyDetails/endorsements/EndorsementShortDescription/operationId)]/effectiveDate"/>
					<xsl:choose>
						<xsl:when test="$PP_INGDTW !=''">
							<PP_INGDTW>
								<xsl:value-of select="format-date($PP_INGDTW, '[Y0001][M01][D01]')" />
							</PP_INGDTW>
						</xsl:when>
						<xsl:otherwise>
							<PP_INGDTW> </PP_INGDTW>
						</xsl:otherwise>						
					</xsl:choose>
					<PP_NUMMER>
						<xsl:value-of select="$SapICM_Request/root/POLICY_REFERENCE" />
					</PP_NUMMER>
					<PP_PRMSPL>
						<xsl:choose>
							<xsl:when test="exists($GPDLI_Response/GetPolicyDetailsLifeInsuranceResponse/aggregatedPolicyDetails/generalInformation/generalInformation/CustomFieldList/CustomField[@name = 'cf_premieSplitsingBetaler1']/value/complexValueList/complexValue)  or  
             								exists($GPDLI_Response/GetPolicyDetailsLifeInsuranceResponse/aggregatedPolicyDetails/generalInformation/generalInformation/CustomFieldList/CustomField[@name = 'cf_premieSplitsingBetaler2']/value/complexValueList/complexValue)">J</xsl:when>
							<xsl:otherwise>N</xsl:otherwise>
						</xsl:choose>
					</PP_PRMSPL>
					<xsl:variable name="PP_PRODUCT" select="$GPDLI_Response/GetPolicyDetailsLifeInsuranceResponse/aggregatedPolicyDetails/generalInformation/generalInformation/productId"/>
					<xsl:if test="$PP_PRODUCT !=''">
						<PP_PRODUCT>
							<xsl:value-of select="$GPDLI_Response/GetPolicyDetailsLifeInsuranceResponse/aggregatedPolicyDetails/generalInformation/generalInformation/productId" />
						</PP_PRODUCT>
					</xsl:if>
					<PP_STANBEG>
						<xsl:value-of select="$PP_STANBEG" />
					</PP_STANBEG>
					<PP_VERZORG>
						<xsl:choose>
							<xsl:when test="$GPDLI_Response/GetPolicyDetailsLifeInsuranceResponse/aggregatedPolicyDetails/coveragePricing/parameterizedCoverages/coverage/identifier = 'NN1_VERZORGING'">J</xsl:when>
							<xsl:otherwise>N</xsl:otherwise>
						</xsl:choose>
					</PP_VERZORG>			
					<xsl:choose>
						<xsl:when test="$GPDLI_Response/GetPolicyDetailsLifeInsuranceResponse/aggregatedPolicyDetails/coveragePricing/parameterizedCoverages/coverage/coverageOptionList/option/identifier = 'WinstbedragBijLeven' or
										$GPDLI_Response/GetPolicyDetailsLifeInsuranceResponse/aggregatedPolicyDetails/coveragePricing/parameterizedCoverages/coverage/coverageOptionList/option/identifier = 'WinstBijLevenLeOV'">
								<PP_WINSTV><xsl:value-of select="'wnstbdrlev'"/></PP_WINSTV>	
						</xsl:when>
						<xsl:when test="$GPDLI_Response/GetPolicyDetailsLifeInsuranceResponse/aggregatedPolicyDetails/coveragePricing/parameterizedCoverages/coverage/coverageOptionList/option/identifier = 'WinstbedragBijLevenOverlijden'">
								<PP_WINSTV><xsl:value-of select="'wnstbdrleov'"/></PP_WINSTV>	
						</xsl:when>
						<xsl:when test="$GPDLI_Response/GetPolicyDetailsLifeInsuranceResponse/aggregatedPolicyDetails/coveragePricing/parameterizedCoverages/coverage/coverageOptionList/option/identifier = 'WinstbedragBijOverlijden'">
								<PP_WINSTV><xsl:value-of select="'wnstbdrov'"/></PP_WINSTV>		
						</xsl:when>
						<xsl:otherwise/>
					</xsl:choose>					
					<xsl:if test="exists($SapICM_Request/root/ZZPREMIE_BEDRAG)">
						<PP_BTP>
							<xsl:value-of select="$ZZPREMIE_PROCESSED" />
						</PP_BTP>
					</xsl:if>
					<xsl:if test="exists($SapICM_Request/root/ZZPROVSIE_PERCENTAGE) and exists($SapICM_Request/root/ZZPREMIE_BEDRAG)">
						<PP_TPP>
							<xsl:value-of select="format-number((($ZZPREMIE_BEDRAG * $SapICM_Request/root/ZZPROVSIE_PERCENTAGE ) div 100), '#0.00')" />
						</PP_TPP>
					</xsl:if>
					<PP_TKST>0</PP_TKST>
					<PP_TTSL>0</PP_TTSL>
					<PP_TASS>0</PP_TASS>
					<PP_TKRT>0</PP_TKRT>
					<PP_TINV>0</PP_TINV>
					<xsl:if test="exists($SapICM_Request/root/ZZPREMIE_BEDRAG)">
						<PP_TTOT>
							<xsl:value-of select="$ZZPREMIE_PROCESSED" />
						</PP_TTOT>
					</xsl:if>
					<PP_PVADAT>
						<xsl:value-of select="$SapICM_Request/root/TRANSACTION_EFFECTIVE_DATE" />
					</PP_PVADAT>
					<xsl:variable name="PP_VVDAT" select="$GPDLI_Response/GetPolicyDetailsLifeInsuranceResponse/aggregatedPolicyDetails/generalInformation/nextIssueDate"/>
					<xsl:if test="$PP_VVDAT !=''">
						<PP_VVDAT>
							<xsl:value-of select="translate($GPDLI_Response/GetPolicyDetailsLifeInsuranceResponse/aggregatedPolicyDetails/generalInformation/nextIssueDate,'-','')" />
						</PP_VVDAT>
					</xsl:if>
					<xsl:if test="exists($SapICM_Request/root/ZZPROVSIE_PERCENTAGE)">
						<PP_PPRC>
							<xsl:value-of select="format-number(( ceiling( $SapICM_Request/root/ZZPROVSIE_PERCENTAGE * 1000 ) div 1000), '0.##')" />
						</PP_PPRC>
					</xsl:if>
					<PP_VWPVAO>
						<xsl:choose>
							<xsl:when test="$GPDLI_Response/GetPolicyDetailsLifeInsuranceResponse/aggregatedPolicyDetails/coveragePricing/parameterizedCoverages/coverage/identifier = 'NN1_AO_AS' or 
										 $GPDLI_Response/GetPolicyDetailsLifeInsuranceResponse/aggregatedPolicyDetails/coveragePricing/parameterizedCoverages/coverage/identifier = 'NN1_AO_IS'">J</xsl:when>
							<xsl:otherwise>N</xsl:otherwise>
						</xsl:choose>
					</PP_VWPVAO>
					<xsl:if test="$GPOA_Response/GetPartiesOnAgreement_Response/Result/Status = 'OK'">
						<xsl:for-each select="$GPOA_Response/GetPartiesOnAgreement_Response/Roles[RoleID = 'VN']">
							<xsl:variable name="Volgnummer_VP" select="position()" />
							<xsl:if test="$Volgnummer_VP = 1">
								<VP>
									<VP_VRWRKCD>1</VP_VRWRKCD>
									<xsl:choose>
										<xsl:when test="BusinessPartner/BusinessPartnerType = '1'">
											<VP_VOORL>
												<xsl:value-of select="BusinessPartner/Person/Initials" />
											</VP_VOORL>
											<xsl:if test="(BusinessPartner/Person/Prefix) != ''">
												<VP_VOORV>
													<xsl:value-of select="BusinessPartner/Person/Prefix" />
												</VP_VOORV>
											</xsl:if>
											<VP_ANAAM>
												<xsl:value-of select="BusinessPartner/Person/LastName" />
											</VP_ANAAM>
											<xsl:if test="(BusinessPartner/Person/BirthDate) != ''">
												<VP_GEBDAT>
													<xsl:value-of select="translate(BusinessPartner/Person/BirthDate,'-','')" />
												</VP_GEBDAT>
											</xsl:if>
											<xsl:choose>
												<xsl:when test="BusinessPartner/Person/Gender = '1'">
													<VP_GESLACH>V</VP_GESLACH>
												</xsl:when>
												<xsl:when test="BusinessPartner/Person/Gender = '2'">
													<VP_GESLACH>M</VP_GESLACH>
												</xsl:when>
												<xsl:otherwise />
											</xsl:choose>
										</xsl:when>
										<xsl:when test="BusinessPartner/BusinessPartnerType = '2'">
											<VP_ANAAM>
												<xsl:value-of select="BusinessPartner/Organisation/OrganisationName" />
											</VP_ANAAM>
											<VP_GESLACH>R</VP_GESLACH>
										</xsl:when>
									</xsl:choose>
									<xsl:choose>
										<xsl:when test="translate(BusinessPartner/Addresses/Street, ' ', '') = ''">
											<VP_STRAAT>Postbus</VP_STRAAT>
											<xsl:if test="(BusinessPartner/Addresses/POBox) != ''">
												<VP_HUISNR>
													<xsl:value-of select="BusinessPartner/Addresses/POBox" />
												</VP_HUISNR>
											</xsl:if>
										</xsl:when>
										<xsl:otherwise>
											<VP_STRAAT>
												<xsl:value-of select="BusinessPartner/Addresses/Street" />
											</VP_STRAAT>
											<xsl:if test="(BusinessPartner/Addresses/HouseNumber) != ''">
												<VP_HUISNR>
													<xsl:value-of select="BusinessPartner/Addresses/HouseNumber" />
												</VP_HUISNR>
											</xsl:if>
										</xsl:otherwise>
									</xsl:choose>
									<xsl:if test="(BusinessPartner/Addresses/HouseNumberAddition) != ''">
										<VP_TOEVOEG>
											<xsl:value-of select="BusinessPartner/Addresses/HouseNumberAddition" />
										</VP_TOEVOEG>
									</xsl:if>
									<VP_PCODE>
										<xsl:value-of select="BusinessPartner/Addresses/Postalcode" />
									</VP_PCODE>
									<VP_PLAATS>
										<xsl:value-of select="BusinessPartner/Addresses/City" />
									</VP_PLAATS>
									<VP_LAND>
										<xsl:value-of select="BusinessPartner/Addresses/CountryCode" />
									</VP_LAND>
									<xsl:if test="(BusinessPartner/BankAccountPolicyRole/IBAN) != ''">
										<VP_IBAN>
											<xsl:value-of select="BusinessPartner/BankAccountPolicyRole/IBAN" />
										</VP_IBAN>
									</xsl:if>
									<VP_VOLGNUM>
										<xsl:value-of select="RoleSequenceNumber" />
									</VP_VOLGNUM>
								</VP>
							</xsl:if>
						</xsl:for-each>
					</xsl:if>
					<xsl:if test="$MU = 'true' and $GPOA_Response/GetPartiesOnAgreement_Response/Result/Status = 'OK'">
						<xsl:for-each select="$GPOA_Response/GetPartiesOnAgreement_Response/Roles[RoleID = 'VZ']">
							<xsl:variable name="Volgnummer_VZ" select="position()" />
							<xsl:if test="$Volgnummer_VZ = 1 or $Volgnummer_VZ = 2">
								<VZ>
									<xsl:choose>
										<xsl:when test="BusinessPartner/BusinessPartnerType = '1'">
											<VZ_VOORL>
												<xsl:value-of select="BusinessPartner/Person/Initials" />
											</VZ_VOORL>
											<xsl:if test="(BusinessPartner/Person/Prefix) != ''">
												<VZ_VOORV>
													<xsl:value-of select="BusinessPartner/Person/Prefix" />
												</VZ_VOORV>
											</xsl:if>
											<VZ_ANAAM>
												<xsl:value-of select="BusinessPartner/Person/LastName" />
											</VZ_ANAAM>
											<xsl:if test="(BusinessPartner/Person/BirthDate) != ''">
												<VZ_GEBDAT>
													<xsl:value-of select="translate(BusinessPartner/Person/BirthDate,'-','')" />
												</VZ_GEBDAT>
											</xsl:if>
											<VZ_GESLACH>
												<xsl:choose>
													<xsl:when test="BusinessPartner/Person/Gender = '1'">V</xsl:when>
													<xsl:when test="BusinessPartner/Person/Gender = '2'">M</xsl:when>
													<xsl:otherwise/>
												</xsl:choose>
											</VZ_GESLACH>
										</xsl:when>
										<xsl:when test="BusinessPartner/BusinessPartnerType = '2'">
											<VZ_ANAAM>
												<xsl:value-of select="BusinessPartner/Organisation/OrganisationName" />
											</VZ_ANAAM>
											<VZ_GESLACH>R</VZ_GESLACH>
										</xsl:when>
									</xsl:choose>
									<xsl:choose>
										<xsl:when test="translate(BusinessPartner/Addresses/Street, ' ', '') = ''">
											<VZ_STRAAT>
												<xsl:value-of select="'Postbus'" />
											</VZ_STRAAT>
											<xsl:if test="(BusinessPartner/Addresses/POBox) != ''">
												<VZ_HUISNR>
													<xsl:value-of select="BusinessPartner/Addresses/POBox" />
												</VZ_HUISNR>
											</xsl:if>
										</xsl:when>
										<xsl:otherwise>
											<VZ_STRAAT>
												<xsl:value-of select="BusinessPartner/Addresses/Street" />
											</VZ_STRAAT>
											<xsl:if test="(BusinessPartner/Addresses/HouseNumber) != ''">
												<VZ_HUISNR>
													<xsl:value-of select="BusinessPartner/Addresses/HouseNumber" />
												</VZ_HUISNR>
											</xsl:if>
										</xsl:otherwise>
									</xsl:choose>
									<xsl:if test="(BusinessPartner/Addresses/HouseNumberAddition) != ''">
										<VZ_TOEVOEG>
											<xsl:value-of select="BusinessPartner/Addresses/HouseNumberAddition" />
										</VZ_TOEVOEG>
									</xsl:if>
									<VZ_PCODE>
										<xsl:value-of select="BusinessPartner/Addresses/Postalcode" />
									</VZ_PCODE>
									<VZ_PLAATS>
										<xsl:value-of select="BusinessPartner/Addresses/City" />
									</VZ_PLAATS>
									<VZ_LAND>
										<xsl:value-of select="BusinessPartner/Addresses/CountryCode" />
									</VZ_LAND>
									<xsl:if test="(BusinessPartner/BankAccountPolicyRole/IBAN) != ''">
										<VZ_IBAN>
											<xsl:value-of select="BusinessPartner/BankAccountPolicyRole/IBAN" />
										</VZ_IBAN>
									</xsl:if>
									<VZ_VOLGNUM>
										<xsl:value-of select="RoleSequenceNumber" />
									</VZ_VOLGNUM>
								</VZ>
							</xsl:if>
						</xsl:for-each>
					</xsl:if>
					<xsl:if test="$GPDLI_Response/GetPolicyDetailsLifeInsuranceResponse/aggregatedPolicyDetails/generalInformation/generalInformation/productId = 'OPB-LeOv' or 
								$GPDLI_Response/GetPolicyDetailsLifeInsuranceResponse/aggregatedPolicyDetails/generalInformation/generalInformation/productId = 'RIS-ORV' or 
								$GPDLI_Response/GetPolicyDetailsLifeInsuranceResponse/aggregatedPolicyDetails/generalInformation/generalInformation/productId = 'RIS-UITV'">
						<DO>
							<DO_CODE>10201</DO_CODE>
							<xsl:if test="(($GPDLI_Response/GetPolicyDetailsLifeInsuranceResponse/aggregatedPolicyDetails/generalInformation/generalInformation/productId = 'OPB-LeOv' or 
											$GPDLI_Response/GetPolicyDetailsLifeInsuranceResponse/aggregatedPolicyDetails/generalInformation/generalInformation/productId = 'RIS-ORV' or 
											$GPDLI_Response/GetPolicyDetailsLifeInsuranceResponse/aggregatedPolicyDetails/generalInformation/generalInformation/productId = 'RIS-UITV') and 
											exists($GPDLI_Response/GetPolicyDetailsLifeInsuranceResponse/aggregatedPolicyDetails/generalInformation/deathCapital))">
								<DO_VERZSOM>
									<xsl:value-of select="format-number( (ceiling($GPDLI_Response/GetPolicyDetailsLifeInsuranceResponse/aggregatedPolicyDetails/generalInformation/deathCapital *100) div 100) , '#0.##')" />
								</DO_VERZSOM>
							</xsl:if>
							<DO_STK>E</DO_STK>
							<DO_CONTRAV>N</DO_CONTRAV>
							<xsl:if test="(($GPDLI_Response/GetPolicyDetailsLifeInsuranceResponse/aggregatedPolicyDetails/generalInformation/generalInformation/productId = 'OPB-LeOv' or
										 $GPDLI_Response/GetPolicyDetailsLifeInsuranceResponse/aggregatedPolicyDetails/generalInformation/generalInformation/productId = 'RIS-ORV' or 
										 $GPDLI_Response/GetPolicyDetailsLifeInsuranceResponse/aggregatedPolicyDetails/generalInformation/generalInformation/productId = 'RIS-UITV') and
										 exists($GPDLI_Response/GetPolicyDetailsLifeInsuranceResponse/aggregatedPolicyDetails/coveragePricing/parameterizedCoverages/coverage[identifier = 'NN1_Ongevaldekking']/coverageParameterList/parameter[parameterId= 'c_deathCapital']/parameterValue/simpleValueList/simpleValue))">
								<DO_VSBYOVL>
									<xsl:value-of select="format-number((ceiling($GPDLI_Response/GetPolicyDetailsLifeInsuranceResponse/aggregatedPolicyDetails/coveragePricing/parameterizedCoverages/coverage[identifier = 'NN1_Ongevaldekking']/coverageParameterList/parameter[parameterId= 'c_deathCapital']/parameterValue/simpleValueList/simpleValue *100) div 100) , '#0.0')" />
								</DO_VSBYOVL>
							</xsl:if>
						</DO>
					</xsl:if>
					<xsl:if test="$GPDLI_Response/GetPolicyDetailsLifeInsuranceResponse/aggregatedPolicyDetails/generalInformation/generalInformation/productId = 'OPB-LeOv' or
								 $GPDLI_Response/GetPolicyDetailsLifeInsuranceResponse/aggregatedPolicyDetails/generalInformation/generalInformation/productId = 'OPB-Lev'">
						<IL>
							<IL_CODE>10101</IL_CODE>
							<xsl:if test="(($GPDLI_Response/GetPolicyDetailsLifeInsuranceResponse/aggregatedPolicyDetails/generalInformation/generalInformation/productId = 'OPB-Lev' or 
									$GPDLI_Response/GetPolicyDetailsLifeInsuranceResponse/aggregatedPolicyDetails/generalInformation/generalInformation/productId = 'OPB-LeOv') and 
									exists($GPDLI_Response/GetPolicyDetailsLifeInsuranceResponse/aggregatedPolicyDetails/generalInformation/lifeCapital))">
								<IL_VERZSOM>
									<xsl:value-of select="format-number( (ceiling($GPDLI_Response/GetPolicyDetailsLifeInsuranceResponse/aggregatedPolicyDetails/generalInformation/lifeCapital *100) div 100) , '#0.##')" />
								</IL_VERZSOM>
							</xsl:if>
						</IL>
					</xsl:if>
					<xsl:if test="$GPDLI_Response/GetPolicyDetailsLifeInsuranceResponse/aggregatedPolicyDetails/coveragePricing/parameterizedCoverages/coverage/identifier = 'NN1_AO_AS' or 
								$GPDLI_Response/GetPolicyDetailsLifeInsuranceResponse/aggregatedPolicyDetails/coveragePricing/parameterizedCoverages/coverage/identifier = 'NN1_AO_IS'">
						<PL>
							<PL_CODE>10800</PL_CODE>
							<xsl:choose>
								<xsl:when test="$GPDLI_Response/GetPolicyDetailsLifeInsuranceResponse/aggregatedPolicyDetails/coveragePricing/parameterizedCoverages/coverage/identifier = 'NN1_AO_AS'">
									<PL_AOKLAS>6</PL_AOKLAS>
								</xsl:when>
								<xsl:when test="$GPDLI_Response/GetPolicyDetailsLifeInsuranceResponse/aggregatedPolicyDetails/coveragePricing/parameterizedCoverages/coverage/identifier = 'NN1_AO_IS'">
									<PL_AOKLAS>2</PL_AOKLAS>
								</xsl:when>
							</xsl:choose>
						</PL>
					</xsl:if>
					<xsl:if test="$MU = 'true' and $GPOA_Response/GetPartiesOnAgreement_Response/Result/Status = 'OK'">
						<xsl:for-each select="$GPOA_Response/GetPartiesOnAgreement_Response/Roles[RoleID = 'PS']">
							<xsl:variable name="Volgnummer_PW" select="position()" />
							<xsl:if test="$Volgnummer_PW = 1 or $Volgnummer_PW = 2">
								<PW>
									<xsl:choose>
										<xsl:when test="BusinessPartner/BusinessPartnerType = '1'">
											<PW_VOORL>
												<xsl:value-of select="BusinessPartner/Person/Initials" />
											</PW_VOORL>
											<xsl:if test="(BusinessPartner/Person/Prefix) != ''">
												<PW_VOORV>
													<xsl:value-of select="BusinessPartner/Person/Prefix" />
												</PW_VOORV>
											</xsl:if>
											<PW_ANAAM>
												<xsl:value-of select="BusinessPartner/Person/LastName" />
											</PW_ANAAM>
											<xsl:if test="(BusinessPartner/Person/BirthDate) != ''">
												<PW_GEBDAT>
													<xsl:value-of select="translate(BusinessPartner/Person/BirthDate,'-','')" />
												</PW_GEBDAT>
											</xsl:if>
											<xsl:choose>
												<xsl:when test="BusinessPartner/Person/Gender = '1'">
													<PW_GESLACH>V</PW_GESLACH>
												</xsl:when>
												<xsl:when test="BusinessPartner/Person/Gender = '2'">
													<PW_GESLACH>M</PW_GESLACH>
												</xsl:when>
												<xsl:otherwise>
													<PW_GESLACH/>
												</xsl:otherwise>
											</xsl:choose>
										</xsl:when>
										<xsl:when test="BusinessPartner/BusinessPartnerType = '2'">
											<PW_ANAAM>
												<xsl:value-of select="BusinessPartner/Organisation/OrganisationName" />
											</PW_ANAAM>
											<PW_GESLACH>R</PW_GESLACH>
										</xsl:when>
									</xsl:choose>
									<xsl:choose>
										<xsl:when
											test="translate(BusinessPartner/Addresses/Street, ' ', '') = ''">
											<PW_STRAAT>
												<xsl:value-of select="'Postbus'" />
											</PW_STRAAT>
											<xsl:if test="(BusinessPartner/Addresses/POBox) != ''">
												<PW_HUISNR>
													<xsl:value-of select="BusinessPartner/Addresses/POBox" />
												</PW_HUISNR>
											</xsl:if>
										</xsl:when>
										<xsl:otherwise>
											<PW_STRAAT>
												<xsl:value-of select="BusinessPartner/Addresses/Street" />
											</PW_STRAAT>
											<xsl:if test="(BusinessPartner/Addresses/HouseNumber) != ''">
												<PW_HUISNR>
													<xsl:value-of select="BusinessPartner/Addresses/HouseNumber" />
												</PW_HUISNR>
											</xsl:if>
										</xsl:otherwise>
									</xsl:choose>
									<xsl:if test="(BusinessPartner/Addresses/HouseNumberAddition) != ''">
										<PW_TOEVOEG>
											<xsl:value-of select="BusinessPartner/Addresses/HouseNumberAddition" />
										</PW_TOEVOEG>
									</xsl:if>
									<PW_PCODE>
										<xsl:value-of select="BusinessPartner/Addresses/Postalcode" />
									</PW_PCODE>
									<PW_PLAATS>
										<xsl:value-of select="BusinessPartner/Addresses/City" />
									</PW_PLAATS>
									<PW_LAND>
										<xsl:value-of select="BusinessPartner/Addresses/CountryCode" />
									</PW_LAND>
									<xsl:if test="(BusinessPartner/BankAccountPolicyRole/IBAN) != ''">
										<PW_IBAN>
											<xsl:value-of select="BusinessPartner/BankAccountPolicyRole/IBAN" />
										</PW_IBAN>
									</xsl:if>
									<PW_VOLGNUM>
										<xsl:value-of select="RoleSequenceNumber" />
									</PW_VOLGNUM>
								</PW>
							</xsl:if>
						</xsl:for-each>
					</xsl:if>
					<xsl:if test="$MU = 'true' and $GPOA_Response/GetPartiesOnAgreement_Response/Result/Status = 'OK'">
						<xsl:for-each select="$GPOA_Response/GetPartiesOnAgreement_Response/Roles[RoleID = 'VG']">
							<xsl:variable name="Volgnummer_VG" select="position()" />
							<xsl:if test="$Volgnummer_VG = 1">
								<VG>
									<xsl:choose>
										<xsl:when test="BusinessPartner/BusinessPartnerType = '1'">
											<VG_VOORL>
												<xsl:value-of select="BusinessPartner/Person/Initials" />
											</VG_VOORL>
											<xsl:if test="(BusinessPartner/Person/Prefix) != ''">
												<VG_VOORV>
													<xsl:value-of select="BusinessPartner/Person/Prefix" />
												</VG_VOORV>
											</xsl:if>
											<VG_ANAAM>
												<xsl:value-of select="BusinessPartner/Person/LastName" />
											</VG_ANAAM>
											<xsl:if test="(BusinessPartner/Person/BirthDate) != ''">
												<VG_GEBDAT>
													<xsl:value-of select="translate(BusinessPartner/Person/BirthDate,'-','')" />
												</VG_GEBDAT>
											</xsl:if>
											<xsl:choose>
												<xsl:when test="BusinessPartner/Person/Gender = '1'">
													<VG_GESLACH>V</VG_GESLACH>
												</xsl:when>
												<xsl:when test="BusinessPartner/Person/Gender = '2'">
													<VG_GESLACH>M</VG_GESLACH>
												</xsl:when>
												<xsl:otherwise>
													<VG_GESLACH/>
												</xsl:otherwise>
											</xsl:choose>
										</xsl:when>
										<xsl:when test="BusinessPartner/BusinessPartnerType = '2'">
											<VG_ANAAM>
												<xsl:value-of select="BusinessPartner/Organisation/OrganisationName" />
											</VG_ANAAM>
											<VG_GESLACH>R</VG_GESLACH>
										</xsl:when>
									</xsl:choose>
									<xsl:choose>
										<xsl:when test="translate(BusinessPartner/Addresses/Street, ' ', '') = ''">
											<VG_STRAAT>
												<xsl:value-of select="'Postbus'" />
											</VG_STRAAT>
											<xsl:if test="(BusinessPartner/Addresses/POBox) != ''">
												<VG_HUISNR>
													<xsl:value-of select="BusinessPartner/Addresses/POBox" />
												</VG_HUISNR>
											</xsl:if>
										</xsl:when>
										<xsl:otherwise>
											<VG_STRAAT>
												<xsl:value-of select="BusinessPartner/Addresses/Street" />
											</VG_STRAAT>
											<xsl:if test="(BusinessPartner/Addresses/HouseNumber) != ''">
												<VG_HUISNR>
													<xsl:value-of select="BusinessPartner/Addresses/HouseNumber" />
												</VG_HUISNR>
											</xsl:if>
										</xsl:otherwise>
									</xsl:choose>
									<xsl:if test="(BusinessPartner/Addresses/HouseNumberAddition) != ''">
										<VG_TOEVOEG>
											<xsl:value-of select="BusinessPartner/Addresses/HouseNumberAddition" />
										</VG_TOEVOEG>
									</xsl:if>
									<VG_PCODE>
										<xsl:value-of select="BusinessPartner/Addresses/Postalcode" />
									</VG_PCODE>
									<VG_PLAATS>
										<xsl:value-of select="BusinessPartner/Addresses/City" />
									</VG_PLAATS>
									<VG_LAND>
										<xsl:value-of select="BusinessPartner/Addresses/CountryCode" />
									</VG_LAND>
									<xsl:if test="(BusinessPartner/BankAccountPolicyRole/IBAN) != ''">
										<VG_IBAN>
											<xsl:value-of select="BusinessPartner/BankAccountPolicyRole/IBAN" />
										</VG_IBAN>
									</xsl:if>
									<VG_VOLGNUM>
										<xsl:value-of select="RoleSequenceNumber" />
									</VG_VOLGNUM>
								</VG>
							</xsl:if>
						</xsl:for-each>
					</xsl:if>
					<xsl:if test="$MU = 'true' and $PP_STANBEG = 'N' and $GPOA_Response/GetPartiesOnAgreement_Response/Result/Status = 'OK'">
						<xsl:for-each
							select="$GPOA_Response/GetPartiesOnAgreement_Response/Roles[RoleID = 'BG']">
							<xsl:variable name="Volgnummer_BG" select="position()" />
							<xsl:if test="$Volgnummer_BG = 1 or $Volgnummer_BG = 2 or $Volgnummer_BG = 3 or $Volgnummer_BG = 4">
								<BG>
									<xsl:choose>
										<xsl:when test="BusinessPartner/BusinessPartnerType = '1'">
											<BG_VOORL>
												<xsl:value-of select="BusinessPartner/Person/Initials" />
											</BG_VOORL>
											<xsl:if test="(BusinessPartner/Person/Prefix) != ''">
												<BG_VOORV>
													<xsl:value-of select="BusinessPartner/Person/Prefix" />
												</BG_VOORV>
											</xsl:if>
											<BG_ANAAM>
												<xsl:value-of select="BusinessPartner/Person/LastName" />
											</BG_ANAAM>
											<xsl:if test="(BusinessPartner/Person/BirthDate) != ''">
												<BG_GEBDAT>
													<xsl:value-of select="translate(BusinessPartner/Person/BirthDate,'-','')" />
												</BG_GEBDAT>
											</xsl:if>
											<xsl:choose>
												<xsl:when test="BusinessPartner/Person/Gender = '1'">
													<BG_GESLACH>V</BG_GESLACH>
												</xsl:when>
												<xsl:when test="BusinessPartner/Person/Gender = '2'">
													<BG_GESLACH>M</BG_GESLACH>
												</xsl:when>
												<xsl:otherwise>
													<BG_GESLACH/>
												</xsl:otherwise>
											</xsl:choose>
										</xsl:when>
										<xsl:when test="BusinessPartner/BusinessPartnerType = '2'">
											<BG_ANAAM>
												<xsl:value-of select="BusinessPartner/Organisation/OrganisationName" />
											</BG_ANAAM>
											<BG_GESLACH>R</BG_GESLACH>
										</xsl:when>
									</xsl:choose>
									<xsl:choose>
										<xsl:when test="translate(BusinessPartner/Addresses/Street, ' ', '') = ''">
											<BG_STRAAT>
												<xsl:value-of select="'Postbus'" />
											</BG_STRAAT>
											<xsl:if test="(BusinessPartner/Addresses/POBox) != ''">
												<BG_HUISNR>
													<xsl:value-of select="BusinessPartner/Addresses/POBox" />
												</BG_HUISNR>
											</xsl:if>
										</xsl:when>
										<xsl:otherwise>
											<BG_STRAAT>
												<xsl:value-of select="BusinessPartner/Addresses/Street" />
											</BG_STRAAT>
											<xsl:if test="(BusinessPartner/Addresses/HouseNumber) != ''">
												<BG_HUISNR>
													<xsl:value-of select="BusinessPartner/Addresses/HouseNumber" />
												</BG_HUISNR>
											</xsl:if>
										</xsl:otherwise>
									</xsl:choose>
									<xsl:if test="(BusinessPartner/Addresses/HouseNumberAddition) != ''">
										<BG_TOEVOEG>
											<xsl:value-of select="BusinessPartner/Addresses/HouseNumberAddition" />
										</BG_TOEVOEG>
									</xsl:if>
									<BG_PCODE>
										<xsl:value-of select="BusinessPartner/Addresses/Postalcode" />
									</BG_PCODE>
									<BG_PLAATS>
										<xsl:value-of select="BusinessPartner/Addresses/City" />
									</BG_PLAATS>
									<BG_LAND>
										<xsl:value-of select="BusinessPartner/Addresses/CountryCode" />
									</BG_LAND>
									<xsl:if test="(BusinessPartner/BankAccountPolicyRole/IBAN) != ''">
										<BG_IBAN>
											<xsl:value-of select="BusinessPartner/BankAccountPolicyRole/IBAN" />
										</BG_IBAN>
									</xsl:if>
									<BG_VOLGNUM>
										<xsl:value-of select="RoleSequenceNumber" />
									</BG_VOLGNUM>
								</BG>
							</xsl:if>
						</xsl:for-each>
					</xsl:if>
					<xsl:if test="$MU = 'true' and $GPOA_Response/GetPartiesOnAgreement_Response/Result/Status = 'OK'">
						<xsl:for-each select="$GPOA_Response/GetPartiesOnAgreement_Response/Roles[RoleID = 'PB' and BusinessPartner/BusinessPartnerID != $GPOA_Response/GetPartiesOnAgreement_Response/Roles[RoleID = 'VN']/BusinessPartner/BusinessPartnerID]">
							<xsl:variable name="Volgnummer_PB" select="position()" />
							<xsl:if test="$Volgnummer_PB = 1 or $Volgnummer_PB = 2">
								<PB>
									<xsl:choose>
										<xsl:when test="BusinessPartner/BusinessPartnerType = '1'">
											<PB_VOORL>
												<xsl:value-of select="BusinessPartner/Person/Initials" />
											</PB_VOORL>
											<xsl:if test="(BusinessPartner/Person/Prefix) != ''">
												<PB_VOORV>
													<xsl:value-of select="BusinessPartner/Person/Prefix" />
												</PB_VOORV>
											</xsl:if>
											<PB_ANAAM>
												<xsl:value-of select="BusinessPartner/Person/LastName" />
											</PB_ANAAM>
											<xsl:if test="(BusinessPartner/Person/BirthDate) != ''">
												<PB_GEBDAT>
													<xsl:value-of select="translate(BusinessPartner/Person/BirthDate,'-','')" />
												</PB_GEBDAT>
											</xsl:if>
											<xsl:choose>
												<xsl:when test="BusinessPartner/Person/Gender = '1'">
													<PB_GESLACH>V</PB_GESLACH>
												</xsl:when>
												<xsl:when test="BusinessPartner/Person/Gender = '2'">
													<PB_GESLACH>M</PB_GESLACH>
												</xsl:when>
												<xsl:otherwise>
													<PB_GESLACH/>
												</xsl:otherwise>
											</xsl:choose>
										</xsl:when>
										<xsl:when test="BusinessPartner/BusinessPartnerType = '2'">
											<PB_ANAAM>
												<xsl:value-of select="BusinessPartner/Organisation/OrganisationName" />
											</PB_ANAAM>
											<PB_GESLACH>R</PB_GESLACH>
										</xsl:when>
									</xsl:choose>
									<xsl:choose>
										<xsl:when test="translate(BusinessPartner/Addresses/Street, ' ', '') = ''">
											<PB_STRAAT>
												<xsl:value-of select="'Postbus'" />
											</PB_STRAAT>
											<xsl:if test="(BusinessPartner/Addresses/POBox) != ''">
												<PB_HUISNR>
													<xsl:value-of select="BusinessPartner/Addresses/POBox" />
												</PB_HUISNR>
											</xsl:if>
										</xsl:when>
										<xsl:otherwise>
											<PB_STRAAT>
												<xsl:value-of select="BusinessPartner/Addresses/Street" />
											</PB_STRAAT>
											<xsl:if test="(BusinessPartner/Addresses/HouseNumber) != ''">
												<PB_HUISNR>
													<xsl:value-of select="BusinessPartner/Addresses/HouseNumber" />
												</PB_HUISNR>
											</xsl:if>
										</xsl:otherwise>
									</xsl:choose>
									<xsl:if test="(BusinessPartner/Addresses/HouseNumberAddition) != ''">
										<PB_TOEVOEG>
											<xsl:value-of select="BusinessPartner/Addresses/HouseNumberAddition" />
										</PB_TOEVOEG>
									</xsl:if>
									<PB_PCODE>
										<xsl:value-of select="BusinessPartner/Addresses/Postalcode" />
									</PB_PCODE>
									<PB_PLAATS>
										<xsl:value-of select="BusinessPartner/Addresses/City" />
									</PB_PLAATS>
									<PB_LAND>
										<xsl:value-of select="BusinessPartner/Addresses/CountryCode" />
									</PB_LAND>
									<xsl:if test="(BusinessPartner/BankAccountPolicyRole/IBAN) != ''">
										<PB_IBAN>
											<xsl:value-of select="BusinessPartner/BankAccountPolicyRole/IBAN" />
										</PB_IBAN>
									</xsl:if>
									<PB_VOLGNUM>
										<xsl:value-of select="RoleSequenceNumber" />
									</PB_VOLGNUM>
								</PB>
							</xsl:if>
						</xsl:for-each>
					</xsl:if>
					<BO>
						<BO_BETWIJZ>
							<xsl:value-of select="$SapICM_Request/root/ZZINCASSOCODE" />
						</BO_BETWIJZ>
						<BO_BOEKDAT>
							<xsl:value-of select="$SapICM_Request/root/TRANSACTION_EFFECTIVE_DATE" />
						</BO_BOEKDAT>
						<BO_RCMND>
							<xsl:value-of select="substring($SapICM_Request/root/TRANSACTION_EFFECTIVE_DATE,1,6)" />
						</BO_RCMND>
						<xsl:if test="exists($SapICM_Request/root/ZZPREMIE_BEDRAG)">
							<BO_BRPRM>
								<xsl:value-of select="$ZZPREMIE_PROCESSED" />
							</BO_BRPRM>
						</xsl:if>
						<BO_KRT>0</BO_KRT>
						<BO_TSL>0</BO_TSL>
						<BO_KST>0</BO_KST>
						<BO_ASSBEL>0</BO_ASSBEL>
						<xsl:if test="exists($SapICM_Request/root/ZZPREMIE_BEDRAG)">
							<BO_INCASSO>
								<xsl:value-of select="$ZZPREMIE_PROCESSED" />
							</BO_INCASSO>
						</xsl:if>
						<BO_AFSLPRV>0</BO_AFSLPRV>
						<xsl:if test="exists($SapICM_Request/root/ZZPROVSIE_PERCENTAGE) and exists($SapICM_Request/root/ZZPREMIE_BEDRAG)">
							<BO_PROLPRV>
								<xsl:value-of select="format-number(((($ZZPREMIE_BEDRAG * $SapICM_Request/root/ZZPROVSIE_PERCENTAGE) div 100 ) * -1), '#0.00')" />
							</BO_PROLPRV>
						</xsl:if>
						<BO_OVRPRV>0</BO_OVRPRV>
						<BO_INCVERG>0</BO_INCVERG>
						<xsl:if test="exists($SapICM_Request/root/TRIG_TRANS_ID)">
							<BO_BKS>
								<xsl:choose>
									<xsl:when test="$HEKJE_Q_PFUNK = '001'">03</xsl:when>
									<xsl:otherwise>02</xsl:otherwise>
								</xsl:choose>
							</BO_BKS>
						</xsl:if>
						<xsl:if test="string-length($SapICM_Request/root/ZZPROVSIE_PERCENTAGE) > 0 and string-length($SapICM_Request/root/ZZPREMIE_BEDRAG) > 0 and string-length($SapICM_Request/root/ZZINCASSOCODE) > 0">
							<BO_RCBEDR>
								<xsl:choose>
									<xsl:when test="$SapICM_Request/root/ZZINCASSOCODE = 'T'">
										<xsl:value-of select="format-number($ZZPREMIE_BEDRAG - (($ZZPREMIE_BEDRAG * $SapICM_Request/root/ZZPROVSIE_PERCENTAGE) div 100), '#0.00')" />
									</xsl:when>
									<xsl:otherwise>
										<xsl:value-of select="format-number(((($ZZPREMIE_BEDRAG * $SapICM_Request/root/ZZPROVSIE_PERCENTAGE) div 100) * -1), '#0.00')" />
									</xsl:otherwise>
								</xsl:choose>
							</BO_RCBEDR>
						</xsl:if>
					</BO>
				</PP>
			</BIJKANT>
		</VIEW_41100>

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