<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:template match="/ObjectData/Object[@CCID='新闻节目类']">
        <MetaData>
            <xsl:for-each select="Object[@CCID='片段子类']/MetaData">
                <Sequence>
            <Title>
                <ProperTitle>
                    <xsl:value-of select="sAttribute[@strName='正题名']"></xsl:value-of>
                </ProperTitle>
                <xsl:for-each select="sAttribute[@strName='并列正题名']">
                    <ParallelProperTitle>
                        <xsl:value-of select="current()"></xsl:value-of>
                    </ParallelProperTitle>
                </xsl:for-each>
                <SeriesTitle>
                    <xsl:value-of select="sAttribute[@strName='系列题名']"></xsl:value-of>
                </SeriesTitle>
            </Title>
            <Subject>
                <xsl:for-each select="sAttribute[@strName='分类名']">
                    <Class>
                        <Classification>未知</Classification>
                        <ClassNumber>
                            <xsl:value-of select="current()"></xsl:value-of>
                        </ClassNumber>
                    </Class>
                </xsl:for-each>
                <xsl:for-each select="sAttribute[@strName='主题词']">
                    <SubjectTerm>
                        <xsl:value-of select="current()"></xsl:value-of>
                    </SubjectTerm>
                </xsl:for-each>
                <xsl:for-each select="sAttribute[@strName='关键词']">
                    <Keyword>
                        <xsl:value-of select="current()"></xsl:value-of>
                    </Keyword>
                </xsl:for-each>
            </Subject>
            <Description>
                <DescriptionofContent>
                    <xsl:value-of select="sAttribute[@strName='内容描述']"></xsl:value-of>
                </DescriptionofContent>
                <DateofEvent>
                    <xsl:value-of select="sAttribute[@strName='事件发生日期']"></xsl:value-of>
                </DateofEvent>
                <xsl:for-each select="sAttributeGroups/sAttributeGroup[@Name='获奖']">
                    <xsl:for-each select="MetaData">
                        <Awards>
                            <NameofAwards>
                                <xsl:value-of select="sAttribute[@strName='奖名']"></xsl:value-of>
                            </NameofAwards>
                            <ItemofAwards>
                                <xsl:value-of select="sAttribute[@strName='奖项']"></xsl:value-of>
                            </ItemofAwards>
                            <xsl:for-each select="sAttribute[@strName='获奖者']">
                                <WinnersofAwards>
                                    <xsl:value-of select="current()"></xsl:value-of>
                                </WinnersofAwards>
                            </xsl:for-each>
                            <YearorTimeofAwards>
                                <xsl:value-of select="sAttribute[@strName='获奖年度']"></xsl:value-of>
                            </YearorTimeofAwards>
                            <DateofAwards>
                                <xsl:value-of select="sAttribute[@strName='获奖日期']"></xsl:value-of>
                            </DateofAwards>
                        </Awards>
                    </xsl:for-each>
                </xsl:for-each>
                <NaturalSound>
                    <xsl:value-of select="sAttribute[@strName='现场同期声']"></xsl:value-of>
                </NaturalSound>
            </Description>
            <Creator>
                <xsl:for-each select="sAttributeGroups/sAttributeGroup[@Name='创建者']">
                    <xsl:for-each select="MetaData">
                        <DescriptionofCreator>
                            <NameofCreator>
                                <xsl:value-of select="sAttribute[@strName='创建者名称']"></xsl:value-of>
                            </NameofCreator>
                            <xsl:for-each select="sAttribute[@strName='创建者并列名']">
                                <ParallelNameofCreator>
                                    <xsl:value-of select="current()"></xsl:value-of>
                                </ParallelNameofCreator>
                            </xsl:for-each>
                            <Role>
                                <xsl:value-of select="sAttribute[@strName='责任方式']"></xsl:value-of>
                            </Role>
                            <OtherInformation>
                                <xsl:value-of select="sAttribute[@strName='其他信息']"></xsl:value-of>
                            </OtherInformation>
                        </DescriptionofCreator>
                    </xsl:for-each>
                </xsl:for-each>
            </Creator>
            <Contributor>
                <xsl:for-each select="sAttributeGroups/sAttributeGroup[@Name='责任者描述（片段）']">
                    <xsl:for-each select="MetaData">
                        <DescriptionofContributor>
                            <NameofContributor>
                                <xsl:value-of select="sAttribute[@strName='责任者名称']"></xsl:value-of>
                            </NameofContributor>
                            <xsl:for-each select="sAttribute[@strName='责任者并列名']">
                                <ParallelNameofContributor>
                                    <xsl:value-of select="current()"></xsl:value-of>
                                </ParallelNameofContributor>
                            </xsl:for-each>
                            <Role>
                                <xsl:value-of select="sAttribute[@strName='责任方式（片段）']"></xsl:value-of>
                            </Role>
                            <OtherInformation>
                                <xsl:value-of select="其他信息"></xsl:value-of>
                            </OtherInformation>
                        </DescriptionofContributor>
                    </xsl:for-each>
                </xsl:for-each>
            </Contributor>
            <Copyright>
                <xsl:for-each select="Copyright/DescriptionofAuthorizedUse">
                    <DescriptionofAuthorizedUse>
                        <TimesofAuthorizedUsage>
                            <xsl:value-of select="sAttribute[@strName='授权使用次数']"></xsl:value-of>
                        </TimesofAuthorizedUsage>
                    </DescriptionofAuthorizedUse>
                </xsl:for-each>
            </Copyright>
            <Language>
                <xsl:for-each select="sAttributeGroups/sAttributeGroup[@Name='声道语种描述']">
                    <xsl:for-each select="MetaData">
                        <AudioChannel>
                            <AudioChannelNumber>
                                <xsl:value-of select="sAttribute[@strName='声道号']"></xsl:value-of>
                            </AudioChannelNumber>
                            <AudioChannelLanguage>
                                <xsl:value-of select="sAttribute[@strName='声道语种']"></xsl:value-of>
                            </AudioChannelLanguage>
                        </AudioChannel>
                    </xsl:for-each>

                </xsl:for-each>
                <xsl:for-each select="sAttributeGroups/sAttributeGroup[@Name='字幕语种描述']">
                    <xsl:for-each select="MetaData">
                        <Subtitle>
                            <SubtitleNumber>
                                <xsl:value-of select="sAttribute[@strName='字幕号']"></xsl:value-of>
                            </SubtitleNumber>
                            <SubtitleLanguage>
                                <xsl:value-of select="sAttribute[@strName='字幕语种']"></xsl:value-of>
                            </SubtitleLanguage>
                        </Subtitle>
                    </xsl:for-each>
                </xsl:for-each>
            </Language>
            <Type>
                <xsl:for-each select="sAttribute[@strName='节目形态']">
                    <ProgramForm>
                        <xsl:value-of select="current()"></xsl:value-of>
                    </ProgramForm>
                </xsl:for-each>
            </Type>
            <Format>
                <Duration>
                    <xsl:value-of select="sAttribute[@strName='实长']"></xsl:value-of>
                </Duration>
                <StartingPoint>
                    <xsl:value-of select="sAttribute[@strName='入点']"></xsl:value-of>
                </StartingPoint>
                <SubtitleForm>
                    <xsl:value-of select="sAttribute[@strName='字幕形式']"></xsl:value-of>
                </SubtitleForm>
            </Format>
            <Coverage>
                <xsl:for-each select="sAttributeGroups/sAttributeGroup[@Name='时间范围']">
                    <xsl:for-each select="MetaData">
                        <YearofStart>
                            <xsl:value-of select="sAttribute[@strName='开始年份']"></xsl:value-of>
                        </YearofStart>
                        <YearofEnd>
                            <xsl:value-of select="sAttribute[@strName='结束年份']"></xsl:value-of>
                        </YearofEnd>
                        <DescriptionofYearsCovered>
                            <xsl:value-of select="sAttribute[@strName='年代描述']"></xsl:value-of>
                        </DescriptionofYearsCovered>
                    </xsl:for-each>
                </xsl:for-each>
                <xsl:for-each select="sAttribute[@strName='空间范围']">
                    <Spatial>
                        <xsl:value-of select="current()"></xsl:value-of>
                    </Spatial>
                </xsl:for-each>
            </Coverage>
        </Sequence>
            </xsl:for-each>
        </MetaData>
    </xsl:template>
    <xsl:template match="text()"/>
</xsl:stylesheet>
