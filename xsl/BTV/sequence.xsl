<?xml version="1.0"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:template match="WorkList">
    <!-- 片段层 -->
    <Metadata>
    <xsl:for-each select="CatalogueMetaData/TopUnit/SubUnit">
        <Sequence>
            <!-- 题名 -->
            <Title>
                <ProperTitle>
                    <xsl:value-of select="*/*/AttributeItem[ItemCode='Title']/AttributeItem[ItemCode='Proper Title']/Value"/>
                </ProperTitle>
                <xsl:for-each select="*/*/AttributeItem[ItemCode='Title']/AttributeItem[ItemCode='Parallel Proper Title']">
                    <ParallelProperTitle><xsl:value-of select="Value"/></ParallelProperTitle>
                </xsl:for-each>
                <SeriesTitle>
                    <xsl:value-of select="*/*/AttributeItem[ItemCode='Title']/AttributeItem[ItemCode='Series Title']/Value"/>
                </SeriesTitle>
            </Title>
            
            <!-- 主题 -->
            <Subject>
                <xsl:for-each select="*/*/AttributeItem[ItemCode='Subject']/AttributeItem[ItemCode='Class']">
                    <Class>
                        <Classification><xsl:value-of select="AttributeItem[ItemCode='Classification']/Value"/></Classification>
                        <ClassNumber><xsl:value-of select="AttributeItem[ItemCode='Class Number']/Value"/></ClassNumber>
                    </Class>
                </xsl:for-each>
                <xsl:for-each select="*/*/AttributeItem[ItemCode='Subject']/AttributeItem[ItemCode='Subject Term']">
                    <SubjectTerm><xsl:value-of select="Value"/></SubjectTerm>
                </xsl:for-each>
                <xsl:for-each select="*/*/AttributeItem[ItemCode='Subject']/AttributeItem[ItemCode='Keyword']">
                    <Keyword><xsl:value-of select="Value"/></Keyword>
                </xsl:for-each>
            </Subject>
            
            <!-- 描述 -->
            <Description>
                <DescriptionofContent>
                    <xsl:value-of select="*/*/AttributeItem[ItemCode='Description']/AttributeItem[ItemCode='Description of Content']/Value"/>
                </DescriptionofContent>
                <DateofEvent>
                    <xsl:value-of select="*/*/AttributeItem[ItemCode='Description']/AttributeItem[ItemCode='Date of Event']/Value"/>
                </DateofEvent>
                <xsl:for-each select="*/*/AttributeItem[ItemCode='Description']/AttributeItem[ItemCode='Awards']">
                    <Awards>
                        <NameofAwards><xsl:value-of select="AttributeItem[ItemCode='Name of Awards']/Value"/></NameofAwards>
                        <ItemofAwards><xsl:value-of select="AttributeItem[ItemCode='Item of Awards']/Value"/></ItemofAwards>
                        <xsl:for-each select="AttributeItem[ItemCode='Winners of Awards']">
                            <WinnersofAwards><xsl:value-of select="Value"/></WinnersofAwards>
                        </xsl:for-each>
                        <YearorTimeofAwards><xsl:value-of select="AttributeItem[ItemCode='Year or Time of Awards']/Value"/></YearorTimeofAwards>
                        <DateofAwards><xsl:value-of select="AttributeItem[ItemCode='Date of Awards']/Value"/></DateofAwards>
                    </Awards>
                </xsl:for-each>
                <NaturalSound>
                    <xsl:value-of select="*/*/AttributeItem[ItemCode='Description']/AttributeItem[ItemCode='Natural Sound']/Value"/>
                </NaturalSound>
            </Description>
            
            <!-- 创建者 -->
            <Creator>
                <xsl:for-each select="*/*/AttributeItem[ItemCode='Creator']/AttributeItem[ItemCode='Description of Creator']">
                    <DescriptionofCreator>
                        <NameofCreator>
                            <xsl:value-of select="AttributeItem[ItemCode='Name of Creator']/Value"/>
                        </NameofCreator>
                        <xsl:for-each select="AttributeItem[ItemCode='Parallel Name of Creator']">
                            <ParallelNameofCreator><xsl:value-of select="Value"/></ParallelNameofCreator>
                        </xsl:for-each>
                        <Role>
                            <xsl:value-of select="AttributeItem[ItemCode='Role']/Value"/>
                        </Role>
                        <OtherInformation>
                            <xsl:value-of select="AttributeItem[ItemCode='Other Information']/Value"/>
                        </OtherInformation>
                    </DescriptionofCreator>
                </xsl:for-each>
            </Creator>
            
            <!-- 其他责任者 -->
            <Contributor>
                <xsl:for-each select="*/*/AttributeItem[ItemCode='Contributor']/AttributeItem[ItemCode='Description of Contributor']">
                    <DescriptionofContributor>
                        <NameofContributor>
                            <xsl:value-of select="AttributeItem[ItemCode='Name of Contributor']/Value"/>
                        </NameofContributor>
                        <xsl:for-each select="AttributeItem[ItemCode='Parallel Name of Contributor']">
                            <ParallelNameofContributor><xsl:value-of select="Value"/></ParallelNameofContributor>
                        </xsl:for-each>
                        <Role>
                            <xsl:value-of select="AttributeItem[ItemCode='Role']/Value"/>
                        </Role>
                        <OtherInformation>
                            <xsl:value-of select="AttributeItem[ItemCode='Other Information']/Value"/>
                        </OtherInformation>
                    </DescriptionofContributor>
                </xsl:for-each>
            </Contributor>
            
            <!-- 出版者 -->
            <Publisher>
                <xsl:for-each select="*/*/AttributeItem[ItemCode='Publisher']/AttributeItem[ItemCode='Description of Publisher']">
                    <DescriptionofPublisher>
                        <NameofPublisher>
                            <xsl:value-of select="AttributeItem[ItemCode='Name of Publisher']/Value"/>
                        </NameofPublisher>
                        <PlaceofPublication>
                            <xsl:value-of select="AttributeItem[ItemCode='Place of Publication']/Value"/>
                        </PlaceofPublication>
                    </DescriptionofPublisher>
                </xsl:for-each>
                <xsl:for-each select="*/*/AttributeItem[ItemCode='Publisher']/AttributeItem[ItemCode='Description of Producer']">
                    <DescriptionofProducer>
                        <NameofProducer>
                            <xsl:value-of select="AttributeItem[ItemCode='Name of Producer']/Value"/>
                        </NameofProducer>
                        <PlaceofProduction>
                            <xsl:value-of select="AttributeItem[ItemCode='Place of Production']/Value"/>
                        </PlaceofProduction>
                    </DescriptionofProducer>
                </xsl:for-each>
            </Publisher>
            
            <!-- 版权 -->
            <Copyright>
                <xsl:for-each select="*/*/AttributeItem[ItemCode='Copyright']/AttributeItem[ItemCode='Name of Copyright Owner']">
                    <NameofCopyrightOwner><xsl:value-of select="Value"/></NameofCopyrightOwner>
                </xsl:for-each>
                <CopyrightStatement>
                    <xsl:value-of select="*/*/AttributeItem[ItemCode='Copyright']/AttributeItem[ItemCode='Copyright Statement']/Value"/>
                </CopyrightStatement>
                <xsl:for-each select="*/*/AttributeItem[ItemCode='Copyright']/AttributeItem[ItemCode='Description of Authorized Use']">
                    <DescriptionofAuthorizedUse>
                        <NameofAuthorizedUse>
                            <xsl:value-of select="AttributeItem[ItemCode='Name of Authorized Use']/Value"/>
                        </NameofAuthorizedUse>
                        <AuthorizedWayofUsage>
                            <xsl:value-of select="AttributeItem[ItemCode='Authorized Way of Usage']/Value"/>
                        </AuthorizedWayofUsage>
                        <AuthorizedDateofStart>
                            <xsl:value-of select="AttributeItem[ItemCode='Authorized Date of Start']/Value"/>
                        </AuthorizedDateofStart>
                        <AuthorizedDeadline>
                            <xsl:value-of select="AttributeItem[ItemCode='Authorized Dead line']/Value"/>
                        </AuthorizedDeadline>
                        <AuthorizedGeographic>
                            <xsl:value-of select="AttributeItem[ItemCode='Authorized Geographic']/Value"/>
                        </AuthorizedGeographic>
                        <TimesofAuthorizedUsage>
                            <xsl:value-of select="AttributeItem[ItemCode='Times of Authorized Usage']/Value"/>
                        </TimesofAuthorizedUsage>
                        <OtherInformation>
                            <xsl:value-of select="AttributeItem[ItemCode='Other Information']/Value"/>
                        </OtherInformation>
                    </DescriptionofAuthorizedUse>
                </xsl:for-each>
            </Copyright>
            
            <!-- 语种 -->
            <Language>
                <xsl:for-each select="*/*/AttributeItem[ItemCode='Language']/AttributeItem[ItemCode='Audio Channel']">
                    <AudioChannel>
                        <AudioChannelNumber>
                            <xsl:value-of select="AttributeItem[ItemCode='Audio Channel Number']/Value"/>
                        </AudioChannelNumber>
                        <AudioChannelLanguage>
                            <xsl:value-of select="AttributeItem[ItemCode='Audio Channel Language']/Value"/>
                        </AudioChannelLanguage>
                    </AudioChannel>
                </xsl:for-each>
                <xsl:for-each select="*/*/AttributeItem[ItemCode='Language']/AttributeItem[ItemCode='Subtitle']">
                    <Subtitle>
                        <SubtitleNumber>
                            <xsl:value-of select="AttributeItem[ItemCode='Subtitle Number']/Value"/>
                        </SubtitleNumber>
                        <SubtitleLanguage>
                            <xsl:value-of select="AttributeItem[ItemCode='Subtitle Language']/Value"/>
                        </SubtitleLanguage>
                    </Subtitle>
                </xsl:for-each>
            </Language>
            
            <!-- 类型 -->
            <Type>
                <xsl:for-each select="*/*/AttributeItem[ItemCode='Type']/AttributeItem[ItemCode='Program Form']">
                    <ProgramForm><xsl:value-of select="Value"/></ProgramForm>
                </xsl:for-each>
            </Type>
            
            <!-- 格式 -->
            <Format>
                <Duration>
                    <xsl:value-of select="*/*/AttributeItem[ItemCode='Format']/AttributeItem[ItemCode='Duration']/Value * 0.04"/>
                </Duration>
                <StartingPoint>
                    <xsl:value-of select="*/*/AttributeItem[ItemCode='Format']/AttributeItem[ItemCode='Starting Point']/Value * 0.04"/>
                </StartingPoint>
                <SubtitleForm>
                    <xsl:value-of select="*/*/AttributeItem[ItemCode='Format']/AttributeItem[ItemCode='Subtitle Form']/Value"/>
                </SubtitleForm>
            </Format>
            
            <!-- 标识符 -->
            <Identifier>
                <InternationalStandardRecordingCode>
                    <xsl:value-of select="*/*/AttributeItem[ItemCode='Identifier']/AttributeItem[ItemCode='International Standard Recording Code']/Value"/>
                </InternationalStandardRecordingCode>
                <RelationsID>
                    <xsl:value-of select="*/*/AttributeItem[ItemCode='Identifier']/AttributeItem[ItemCode='Relations ID']/Value"/>
                </RelationsID>
            </Identifier>
            
            <!-- 时空覆盖范围 -->
            <Coverage>
                <xsl:for-each select="*/*/AttributeItem[ItemCode='Coverage']/AttributeItem[ItemCode='Years Covered']">
                    <YearsCovered>
                        <YearofStart>
                            <xsl:value-of select="AttributeItem[ItemCode='Year of Start']/Value"/>
                        </YearofStart>
                        <YearofEnd>
                            <xsl:value-of select="AttributeItem[ItemCode='Year of End']/Value"/>
                        </YearofEnd>
                        <DescriptionofYearsCovered>
                            <xsl:value-of select="AttributeItem[ItemCode='Description of Years Covered']/Value"/>
                        </DescriptionofYearsCovered>
                    </YearsCovered>
                </xsl:for-each>
                <xsl:for-each select="*/*/AttributeItem[ItemCode='Coverage']/AttributeItem[ItemCode='Spatial']">
                    <Spatial><xsl:value-of select="Value"/></Spatial>
                </xsl:for-each>
            </Coverage>
            
            <!-- 来源 -->
            <Source>
                <SourceAcquiredMethod>
                    <xsl:value-of select="*/*/AttributeItem[ItemCode='Source']/AttributeItem[ItemCode='Source Acquired Method']/Value"/>
                </SourceAcquiredMethod>
                <SourceProvider>
                    <xsl:value-of select="*/*/AttributeItem[ItemCode='Source']/AttributeItem[ItemCode='Source Provider']/Value"/>
                </SourceProvider>
            </Source>
            
            <!-- 关联 -->
            <xsl:for-each select="*/*/AttributeItem[ItemCode='Ralation']">
                <Ralation>
                    <IsPartof><xsl:value-of select="AttributeItem[ItemCode='IsPartof']/Value"/></IsPartof>
                    <xsl:for-each select="AttributeItem[ItemCode='References']">
                        <References><xsl:value-of select="Value"/></References>
                    </xsl:for-each>
                </Ralation>
            </xsl:for-each>
        </Sequence>
    </xsl:for-each>
    </Metadata>
</xsl:template>
<xsl:template match="text()"/>
</xsl:stylesheet>