<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:template match="/ObjectData/Object[@CCID='新闻节目类']/MetaData">
        <MetaData>
            <Program>
                <Title>
                    <ProperTitle>
                        <xsl:value-of select="sAttribute[@strName='正题名']"></xsl:value-of>
                    </ProperTitle>
                    <xsl:for-each select="sAttribute[@strName='并列正题名']">
                        <ParallelProperTitle>
                            <xsl:value-of select="current()"></xsl:value-of>
                        </ParallelProperTitle>
                    </xsl:for-each>
                    <SubordinateTitle>
                        <xsl:value-of select="sAttribute[@strName='副题名']"></xsl:value-of>
                    </SubordinateTitle>
                    <xsl:for-each select="sAttribute[@strName='交替题名']">
                        <AlternativeTitle>
                            <xsl:value-of select="current()"></xsl:value-of>
                        </AlternativeTitle>
                    </xsl:for-each>
                    <TitleDescription>
                        <xsl:value-of select="sAttribute[@strName='题名说明']"></xsl:value-of>
                    </TitleDescription>
                    <Series>
                        <SeriesTitle>
                            <xsl:value-of select="sAttribute[@strName='系列题名']"></xsl:value-of>
                        </SeriesTitle>
                        <xsl:for-each select="sAttribute[@strName='并列系列题名']">
                            <ParallelSeriesTitle>
                                <xsl:value-of select="current()"></xsl:value-of>
                            </ParallelSeriesTitle>
                        </xsl:for-each>
                        <TotalNumberofEpisodes>
                            <xsl:value-of select="sAttribute[@strName='分集总数']"></xsl:value-of>
                        </TotalNumberofEpisodes>
                        <EpisodesNumber>
                            <xsl:value-of select="sAttribute[@strName='分集次']"></xsl:value-of>
                        </EpisodesNumber>
                    </Series>
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
                    <xsl:for-each select="sAttribute[@strName='主题人物']">
                        <Character>
                            <xsl:value-of select="current()"></xsl:value-of>
                        </Character>
                    </xsl:for-each>
                    <DateofEvent>
                        <xsl:value-of select="sAttribute[@strName='事件发生日期']"></xsl:value-of>
                    </DateofEvent>
                    <xsl:for-each select="sAttribute[@strName='版本说明']">
                        <VersionDescription>
                            <xsl:value-of select="current()"></xsl:value-of>
                        </VersionDescription>
                    </xsl:for-each>
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

                    <xsl:for-each select="sAttributeGroups/sAttributeGroup[@Name='栏目']">
                        <xsl:for-each select="MetaData">
                            <Column>
                                <ColumnName>
                                    <xsl:value-of select="sAttribute[@strName='栏目名称']"></xsl:value-of>
                                </ColumnName>
                                <IssueNumber>
                                    <xsl:value-of select="sAttribute[@strName='栏目期次']"></xsl:value-of>
                                </IssueNumber>
                                <IssueYear>
                                    <xsl:value-of select="sAttribute[@strName='栏目年度']"></xsl:value-of>
                                </IssueYear>
                            </Column>
                        </xsl:for-each>
                    </xsl:for-each>
                    <Audience>
                        <xsl:value-of select="sAttribute[@strName='受众']"></xsl:value-of>
                    </Audience>
                    <AdditionalLogo>
                        <xsl:value-of select="sAttribute[@strName='附加标志']"></xsl:value-of>
                    </AdditionalLogo>
                    <xsl:for-each select="sAttributeGroups/sAttributeGroup[@Name='声道描述']">
                        <xsl:for-each select="MetaDate">
                            <AudioChannel>
                                <AudioChannelNumber>
                                    <xsl:value-of select="sAttribute[@strName='声道号']"></xsl:value-of>
                                </AudioChannelNumber>
                                <AudioChannelDescription>
                                    <xsl:value-of select="sAttribute[@strName='声道内容']"></xsl:value-of>
                                </AudioChannelDescription>
                            </AudioChannel>
                        </xsl:for-each>
                    </xsl:for-each>
                    <xsl:for-each select="sAttribute[@strName='附件']">
                        <Attachment>
                            <xsl:value-of select="current()"></xsl:value-of>
                        </Attachment>
                    </xsl:for-each>
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
                    <xsl:for-each select="sAttributeGroups/sAttributeGroup[@Name='责任者描述（节目）']">
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
                                    <xsl:value-of select="sAttribute[@strName='责任方式（节目）']"></xsl:value-of>
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
                <Date>
                    <ProducedDate>
                        <xsl:value-of select="sAttribute[@strName='制作完成日期']"></xsl:value-of>
                    </ProducedDate>
                    <DateofDebut>
                        <xsl:value-of select="sAttribute[@strName='首播日期']"></xsl:value-of>
                    </DateofDebut>
                    <PublishedDate>
                        <xsl:value-of select="sAttribute[@strName='出版日期']"></xsl:value-of>
                    </PublishedDate>
                </Date>
                <Type>
                    <xsl:for-each select="sAttribute[@strName='节目类型']">
                        <ProgramType>
                            <xsl:value-of select="current()"></xsl:value-of>
                        </ProgramType>
                    </xsl:for-each>
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
                    <Color>
                        <xsl:value-of select="sAttribute[@strName='色彩']"></xsl:value-of>
                    </Color>
                    <SubtitleForm>
                        <xsl:value-of select="sAttribute[@strName='字幕形式']"></xsl:value-of>
                    </SubtitleForm>
                    <AudioChannelFormat>
                        <xsl:value-of select="sAttribute[@strName='声道格式']"></xsl:value-of>
                    </AudioChannelFormat>
                    <AudioQuality>
                        <xsl:value-of select="sAttribute[@strName='声道质量']"></xsl:value-of>
                    </AudioQuality>
                    <VideoQuality>
                        <xsl:value-of select="sAttribute[@strName='画面质量']"></xsl:value-of>
                    </VideoQuality>
                    <AspectRatio>
                        <xsl:value-of select="sAttribute[@strName='画面宽高比']"></xsl:value-of>
                    </AspectRatio>
                    <PhysicalMediaType>
                        <xsl:value-of select="sAttribute[@strName='载体类型']"></xsl:value-of>
                    </PhysicalMediaType>
                    <System>
                        <xsl:value-of select="sAttribute[@strName='制式']"></xsl:value-of>
                    </System>
                    <AudioDataRate>
                        <xsl:value-of select="sAttribute[@strName='音频数据码率']"></xsl:value-of>
                    </AudioDataRate>
                    <AudioCodingFormat>
                        <xsl:value-of select="sAttribute[@strName='音频编码格式']"></xsl:value-of>
                    </AudioCodingFormat>
                    <AudioSamplingFrequency>
                        <xsl:value-of select="sAttribute[@strName='音频采样频率']"></xsl:value-of>
                    </AudioSamplingFrequency>
                    <AudioBitDepth>
                        <xsl:value-of select="sAttribute[@strName='音频位深度']"></xsl:value-of>
                    </AudioBitDepth>
                    <VideoBitrate>
                        <xsl:value-of select="sAttribute[@strName='视频数据码率']"></xsl:value-of>
                    </VideoBitrate>
                    <VideoCodingFormat>
                        <xsl:value-of select="sAttribute[@strName='视频编码格式']"></xsl:value-of>
                    </VideoCodingFormat>
                    <VideoSamplingType>
                        <xsl:value-of select="sAttribute[@strName='视频取样格式']"></xsl:value-of>
                    </VideoSamplingType>
                    <FileFormat>
                        <xsl:value-of select="sAttribute[@strName='文件格式']"></xsl:value-of>
                    </FileFormat>
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
                        </xsl:for-each>
                    </xsl:for-each>
                    <xsl:for-each select="sAttribute[@strName='空间范围']">
                        <Spatial>
                            <xsl:value-of select="current()"></xsl:value-of>
                        </Spatial>
                    </xsl:for-each>
                </Coverage>
            </Program>
        </MetaData>
    </xsl:template>
    <xsl:template match="text()"/>
</xsl:stylesheet>
