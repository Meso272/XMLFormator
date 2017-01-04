<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:template match="/DCMCatalogueWork/WorkList">
        <Metadata>
            <Program>
                <!-- 题名 -->
                <Title>
                    <!-- 正题名 -->
                    <ProperTitle>
                        <!-- <xsl:value-of select="*/TopUnit/Attributes/*/*/AttributeItem[ItemCode='正题名']/Value"/> -->
                        <xsl:value-of select="descendant::TopUnit//AttributeItem[ItemCode='Proper Title']/Value"/>
                    </ProperTitle>
                    <!-- 并列正题名 -->
                    <xsl:for-each select="*/TopUnit/Attributes/*/*/AttributeItem[ItemCode='Parallel Proper Title']">
                        <ParallelProperTitle>
                            <xsl:value-of select="Value"></xsl:value-of>
                        </ParallelProperTitle>
                    </xsl:for-each>
                    <!-- 副题名 -->
                    <SubordinateTitle>
                        <xsl:value-of select="*/TopUnit/Attributes/*/*/AttributeItem[ItemCode='Subordinate Title']/Value"/>
                    </SubordinateTitle>
                    <!-- 交替题名 -->
                    <xsl:for-each select="*/TopUnit/Attributes/*/*/AttributeItem[ItemCode='Alternative Title']">
                        <AlternativeTitle>
                            <xsl:value-of select="Value"></xsl:value-of>
                        </AlternativeTitle>
                    </xsl:for-each>
                    <!-- 题名说明 -->
                    <TitleDescription>
                        <xsl:value-of select="*/TopUnit/Attributes/*/*/AttributeItem[ItemCode='Title Description']/Value"/>
                    </TitleDescription>
                    <!-- 系列 -->
                    <Series>
                        <SeriesTitle>
                            <xsl:value-of
                                    select="*/TopUnit/Attributes/*/*/AttributeItem[ItemCode='Series']/AttributeItem[ItemCode='Series Title']/Value"/>
                        </SeriesTitle>
                        <TotalNumberofEpisodes>
                            <xsl:value-of
                                    select="*/TopUnit/Attributes/*/*/AttributeItem[ItemCode='Series']/AttributeItem[ItemCode='Total Number of Episodes']/Value"/>
                        </TotalNumberofEpisodes>
                        <EpisodesNumber>
                            <xsl:value-of
                                    select="*/TopUnit/Attributes/*/*/AttributeItem[ItemCode='Series']/AttributeItem[ItemCode='Episodes Number']/Value"/>
                        </EpisodesNumber>
                        <xsl:for-each
                                select="*/TopUnit/Attributes/*/*/AttributeItem[ItemCode='Series']/AttributeItem[ItemCode='Parallel Series Title']">
                            <ParallelSeriesTitle>
                                <xsl:value-of select="Value"/>
                            </ParallelSeriesTitle>
                        </xsl:for-each>
                    </Series>
                </Title>

                <!-- 主题 -->
                <Subject>
                    <!-- 分类 -->
                    <xsl:for-each select="*/TopUnit/Attributes/*/*/AttributeItem[ItemCode='Class']">
                        <Class>
                            <Classification>
                                <xsl:value-of select="AttributeItem[ItemCode='Classification']/Value"/>
                            </Classification>
                            <ClassNumber>
                                <xsl:value-of select="AttributeItem[ItemCode='Class Number']/Value"/>
                            </ClassNumber>
                        </Class>
                    </xsl:for-each>
                    <!-- 主题词 -->
                    <xsl:for-each
                            select="*/TopUnit/Attributes/*/AttributeItem[ItemCode='Subject']/AttributeItem[ItemCode='Subject Term']">
                        <SubjectTerm>
                            <xsl:value-of select="Value"/>
                        </SubjectTerm>
                    </xsl:for-each>
                    <!-- 关键词 -->
                    <xsl:for-each
                            select="*/TopUnit/Attributes/*/AttributeItem[ItemCode='Subject']/AttributeItem[ItemCode='Keyword']">
                        <Keyword>
                            <xsl:value-of select="Value"/>
                        </Keyword>
                    </xsl:for-each>
                </Subject>

                <!-- Description -->
                <Description>
                    <!-- 内容Description -->
                    <DescriptionofContent>
                        <xsl:value-of
                                select="*/TopUnit/Attributes/*/AttributeItem[ItemCode='Description']/AttributeItem[ItemCode='Description of Content']/Value"/>
                    </DescriptionofContent>
                    <!-- 主题人物 -->
                    <xsl:for-each
                            select="*/TopUnit/Attributes/*/AttributeItem[ItemCode='Description']/AttributeItem[ItemCode='Character']">
                        <Character>
                            <xsl:value-of select="Value"/>
                        </Character>
                    </xsl:for-each>
                    <!-- 事件发生日期 -->
                    <DateofEvent>
                        <xsl:value-of
                                select="*/TopUnit/Attributes/*/AttributeItem[ItemCode='Description']/AttributeItem[ItemCode='Date of Event']/Value"/>
                    </DateofEvent>
                    <!-- 版本说明 -->
                    <xsl:for-each
                            select="*/TopUnit/Attributes/*/AttributeItem[ItemCode='Description']/AttributeItem[ItemCode='Version Description']">
                        <VersionDescription>
                            <xsl:value-of select="Value"/>
                        </VersionDescription>
                    </xsl:for-each>
                    <!-- 获奖 -->
                    <xsl:for-each
                            select="*/TopUnit/Attributes/*/AttributeItem[ItemCode='Description']/AttributeItem[ItemCode='Awards']">
                        <Awards>
                            <NameofAwards>
                                <xsl:value-of select="AttributeItem[ItemCode='Name of Awards']/Value"/>
                            </NameofAwards>
                            <ItemofAwards>
                                <xsl:value-of select="AttributeItem[ItemCode='Item of Awards']/Value"/>
                            </ItemofAwards>
                            <xsl:for-each select="AttributeItem[ItemCode='Winners of Awards']">
                                <WinnersofAwards>
                                    <xsl:value-of select="Value"/>
                                </WinnersofAwards>
                            </xsl:for-each>
                            <YearorTimeofAwards>
                                <xsl:value-of select="AttributeItem[ItemCode='Yearor Time of Awards']/Value"/>
                            </YearorTimeofAwards>
                            <DateofAwards>
                                <xsl:value-of select="AttributeItem[ItemCode='Date of Awards']/Value"/>
                            </DateofAwards>
                        </Awards>
                    </xsl:for-each>
                    <!-- 栏目 -->
                    <xsl:for-each
                            select="*/TopUnit/Attributes/*/AttributeItem[ItemCode='Description']/AttributeItem[ItemCode='Column']">
                        <Column>
                            <ColumnName>
                                <xsl:value-of select="AttributeItem[ItemCode='Column Name']/Value"/>
                            </ColumnName>
                            <IssueNumber>
                                <xsl:value-of select="AttributeItem[ItemCode='Issue Number']/Value"/>
                            </IssueNumber>
                            <IssueYear>
                                <xsl:value-of select="AttributeItem[ItemCode='Issue Year']/Value"/>
                            </IssueYear>
                        </Column>
                    </xsl:for-each>
                    <!-- 受众 -->
                    <Audience>
                        <xsl:value-of
                                select="*/TopUnit/Attributes/*/AttributeItem[ItemCode='Description']/AttributeItem[ItemCode='Audience']/Value"/>
                    </Audience>
                    <!-- 附加标志 -->
                    <AdditionalLogo>
                        <xsl:value-of
                                select="*/TopUnit/Attributes/*/AttributeItem[ItemCode='Description']/AttributeItem[ItemCode='Additional Logo']/Value"/>
                    </AdditionalLogo>
                    <!-- 声道 -->
                    <xsl:for-each
                            select="*/TopUnit/Attributes/*/AttributeItem[ItemCode='Description']/AttributeItem[ItemCode='Audio Channel']">
                        <AudioChannel>
                            <AudioChannelNumber>
                                <xsl:value-of select="AttributeItem[ItemCode='Audio Channel Number']/Value"/>
                            </AudioChannelNumber>
                            <AudioChannelDescription>
                                <xsl:value-of select="AttributeItem[ItemCode='Audio Channel Description']/Value"/>
                            </AudioChannelDescription>
                        </AudioChannel>
                    </xsl:for-each>
                    <!-- 附件 -->
                    <xsl:for-each
                            select="*/TopUnit/Attributes/*/AttributeItem[ItemCode='Description']/AttributeItem[ItemCode='Attachment']">
                        <Attachment>
                            <xsl:value-of select="Value"/>
                        </Attachment>
                    </xsl:for-each>
                </Description>

                <!-- 创建者 -->
                <Creator>
                    <xsl:for-each
                            select="*/TopUnit/Attributes/*/AttributeItem[ItemCode='Creator']/AttributeItem[ItemCode='Description of Creator']">
                        <DescriptionofCreator>
                            <NameofCreator>
                                <xsl:value-of select="AttributeItem[ItemCode='Name of Creator']/Value"/>
                            </NameofCreator>
                            <xsl:for-each select="AttributeItem[ItemCode='Parallel Name of Creator']">
                                <ParallelNameofCreator>
                                    <xsl:value-of select="Value"/>
                                </ParallelNameofCreator>
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
                    <xsl:for-each
                            select="*/TopUnit/Attributes/*/AttributeItem[ItemCode='Contributor']/AttributeItem[ItemCode='Description of Creator']">
                        <NameofContributor>
                            <xsl:value-of select="AttributeItem[ItemCode='Name of Contributor']/Value"/>
                        </NameofContributor>
                        <xsl:for-each select="AttributeItem[ItemCode='Parallel Name of Contributor']">
                            <ParallelNameofContributor>
                                <xsl:value-of select="Value"/>
                            </ParallelNameofContributor>
                        </xsl:for-each>
                        <Role>
                            <xsl:value-of select="AttributeItem[ItemCode='Role']/Value"/>
                        </Role>
                        <OtherInformation>
                            <xsl:value-of select="AttributeItem[ItemCode='Other Information']/Value"/>
                        </OtherInformation>
                    </xsl:for-each>
                </Contributor>

                 出版者
                <Publisher>
                    <!-- 出版者Description -->
                    <xsl:for-each
                            select="*/TopUnit/Attributes/*/AttributeItem[ItemCode='Publisher']/AttributeItem[ItemCode='Description of Publisher']">
                        <DescriptionofPublisher>
                            <NameofPublisher>
                                <xsl:value-of select="AttributeItem[ItemCode='Name of Publisher']/Value"/>
                            </NameofPublisher>
                            <PlaceofPublication>
                                <xsl:value-of select="AttributeItem[ItemCode='Place of Publication']/Value"/>
                            </PlaceofPublication>
                        </DescriptionofPublisher>
                    </xsl:for-each>
                    <!-- 出品者Description -->
                    <xsl:for-each
                            select="*/TopUnit/Attributes/*/AttributeItem[ItemCode='Publisher']/AttributeItem[ItemCode='Description of Producer']">
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
                    <!-- 版权所有者名称 -->
                    <xsl:for-each
                            select="*/TopUnit/Attributes/*/AttributeItem[ItemCode='Copyright']/AttributeItem[ItemCode='Name of Copyright Owner']">
                        <NameofCopyrightOwner>
                            <xsl:value-of select="Value"/>
                        </NameofCopyrightOwner>
                    </xsl:for-each>
                    <!-- 版权声明 -->
                    <CopyrightStatement>
                        <xsl:value-of
                                select="*/TopUnit/Attributes/*/AttributeItem[ItemCode='Copyright']/AttributeItem[ItemCode='Copyright Statement']/Value"/>
                    </CopyrightStatement>
                    <!-- 授权使用Description -->
                    <xsl:for-each
                            select="*/TopUnit/Attributes/*/AttributeItem[ItemCode='Copyright']/AttributeItem[ItemCode='Description of Authorized Use']">
                        <DescriptionofAuthorizedUse>
                            <NameofAuthorizedUser>
                                <xsl:value-of select="AttributeItem[ItemCode='Name of Authorized User']/Value"/>
                            </NameofAuthorizedUser>
                            <AuthorizedWayofUsage>
                                <xsl:value-of select="AttributeItem[ItemCode='Authorized Way of Usage']/Value"/>
                            </AuthorizedWayofUsage>
                            <AuthorizedDateofStart>
                                <xsl:value-of select="AttributeItem[ItemCode='Authorized Date of Start']/Value"/>
                            </AuthorizedDateofStart>
                            <AuthorizedDeadline>
                                <xsl:value-of select="AttributeItem[ItemCode='Authorized Deadline']/Value"/>
                            </AuthorizedDeadline>
                            <AuthorizedGeographicArea>
                                <xsl:value-of select="AttributeItem[ItemCode='Authorized Geographic Area']/Value"/>
                            </AuthorizedGeographicArea>
                            <TimesofAuthorizedUsage>
                                <xsl:value-of select="AttributeItem[ItemCode='Times of Authorized Usage']/Value"/>
                            </TimesofAuthorizedUsage>
                            <OtherInformation>
                                <xsl:value-of select="AttributeItem[ItemCode='Other Information']/Value"/>
                            </OtherInformation>
                        </DescriptionofAuthorizedUse>
                    </xsl:for-each>
                </Copyright>

                <Language>
                    <!-- 声道 -->
                    <xsl:for-each
                            select="*/TopUnit/Attributes/*/AttributeItem[ItemCode='Language']/AttributeItem[ItemCode='Audio Channel']">
                        <AudioChannel>
                            <AudioChannelNumber>
                                <xsl:value-of select="AttributeItem[ItemCode='Audio Channel Number']/Value"/>
                            </AudioChannelNumber>
                            <AudioChannelLanguage>
                                <xsl:value-of select="AttributeItem[ItemCode='Audio Channel Language']/Value"/>
                            </AudioChannelLanguage>
                        </AudioChannel>
                    </xsl:for-each>
                    <!-- 字幕 -->
                    <xsl:for-each
                            select="*/TopUnit/Attributes/*/AttributeItem[ItemCode='Language']/AttributeItem[ItemCode='Subtitle']">
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

                <!-- 日期 -->
                <Date>
                    <ProducedDate>
                        <xsl:value-of select="descendant::TopUnit//AttributeItem[ItemCode='Produced Date']/Value"/>
                    </ProducedDate>
                    <DateofDebut>
                        <xsl:value-of select="descendant::TopUnit//AttributeItem[ItemCode='Date of Debut']/Value"/>
                    </DateofDebut>
                    <PublishedDate>
                        <xsl:value-of select="descendant::TopUnit//AttributeItem[ItemCode='Published Date']/Value"/>
                    </PublishedDate>
                </Date>

                <!-- 类型 -->
                <Type>
                    <xsl:for-each
                            select="*/TopUnit/Attributes/*/AttributeItem[ItemCode='Type']/AttributeItem[ItemCode='Program Type']">
                        <ProgramType>
                            <xsl:value-of select="Value"/>
                        </ProgramType>
                    </xsl:for-each>
                    <xsl:for-each
                            select="*/TopUnit/Attributes/*/AttributeItem[ItemCode='Type']/AttributeItem[ItemCode='Program Form']">
                        <ProgramForm>
                            <xsl:value-of select="Value"/>
                        </ProgramForm>
                    </xsl:for-each>
                </Type>

                <!-- Format -->
                <Format>
                    <!-- 实长 -->
                    <Duration>
                        <xsl:value-of
                                select="*/TopUnit/Attributes/*/AttributeItem[ItemCode='Fromat']/AttributeItem[ItemCode='Duration']/Value * 0.04"/>
                    </Duration>
                    <!-- 入点 -->
                    <StartingPoint>
                        <xsl:value-of
                                select="*/TopUnit/Attributes/*/AttributeItem[ItemCode='Fromat']/AttributeItem[ItemCode='Starting Point']/Value * 0.04"/>
                    </StartingPoint>
                    <!-- 色彩 -->
                    <Color>
                        <xsl:value-of
                                select="*/TopUnit/Attributes/*/AttributeItem[ItemCode='Fromat']/AttributeItem[ItemCode='Color']/Value"/>
                    </Color>
                    <!-- 字幕形式 -->
                    <SubtitleForm>
                        <xsl:value-of
                                select="*/TopUnit/Attributes/*/AttributeItem[ItemCode='Fromat']/AttributeItem[ItemCode='Subtitle Form']/Value"/>
                    </SubtitleForm>
                    <!-- 声道Format -->
                    <AudioChannelFormat>
                        <xsl:value-of
                                select="*/TopUnit/Attributes/*/AttributeItem[ItemCode='Fromat']/AttributeItem[ItemCode='Audio Channel Format']/Value"/>
                    </AudioChannelFormat>
                    <!-- 声音质量 -->
                    <AudioQuality>
                        <xsl:value-of
                                select="*/TopUnit/Attributes/*/AttributeItem[ItemCode='Fromat']/AttributeItem[ItemCode='Audio Quality']/Value"/>
                    </AudioQuality>
                    <!-- 画面质量 -->
                    <VideoQuality>
                        <xsl:value-of
                                select="*/TopUnit/Attributes/*/AttributeItem[ItemCode='Fromat']/AttributeItem[ItemCode='Video Quality']/Value"/>
                    </VideoQuality>
                    <!-- 画面宽高比 -->
                    <AspectRatio>
                        <xsl:value-of
                                select="*/TopUnit/Attributes/*/AttributeItem[ItemCode='Fromat']/AttributeItem[ItemCode='Aspect Ratio']/Value"/>
                    </AspectRatio>
                    <!-- 载体类型 -->
                    <PhysicalMediaType>
                        <xsl:value-of
                                select="*/TopUnit/Attributes/*/AttributeItem[ItemCode='Fromat']/AttributeItem[ItemCode='Physical Media Type']/Value"/>
                    </PhysicalMediaType>
                    <!-- 制式 -->
                    <System>
                        <xsl:value-of
                                select="*/TopUnit/Attributes/*/AttributeItem[ItemCode='Fromat']/AttributeItem[ItemCode='System']/Value"/>
                    </System>
                    <!-- 音频数据码率 -->
                    <AudioDataRate>
                        <xsl:value-of
                                select="*/TopUnit/Attributes/*/AttributeItem[ItemCode='Fromat']/AttributeItem[ItemCode='Audio Data Rate']/Value"/>
                    </AudioDataRate>
                    <!-- 音频编码Format -->
                    <AudioCodingFormat>
                        <xsl:value-of
                                select="*/TopUnit/Attributes/*/AttributeItem[ItemCode='Fromat']/AttributeItem[ItemCode='Audio Coding Format']/Value"/>
                    </AudioCodingFormat>
                    <!-- 音频采样频率 -->
                    <AudioSamplingFrequency>
                        <xsl:value-of
                                select="*/TopUnit/Attributes/*/AttributeItem[ItemCode='Fromat']/AttributeItem[ItemCode='Audio Sampling Frequency']/Value"/>
                    </AudioSamplingFrequency>
                    <!-- 音频位深度 -->
                    <AudioBitDepth>
                        <xsl:value-of
                                select="*/TopUnit/Attributes/*/AttributeItem[ItemCode='Fromat']/AttributeItem[ItemCode='Audio Bit Depth']/Value"/>
                    </AudioBitDepth>
                    <!-- 视频数据码率 -->
                    <VideoBitrate>
                        <xsl:value-of
                                select="*/TopUnit/Attributes/*/AttributeItem[ItemCode='Fromat']/AttributeItem[ItemCode='Vedio Data Rate']/Value"/>
                    </VideoBitrate>
                    <!-- 视频编码Format -->
                    <VideoCodingFormat>
                        <xsl:value-of
                                select="*/TopUnit/Attributes/*/AttributeItem[ItemCode='Fromat']/AttributeItem[ItemCode='Video Coding Format']/Value"/>
                    </VideoCodingFormat>
                    <!-- 视频取样Format -->
                    <VideoSamplingType>
                        <xsl:value-of
                                select="*/TopUnit/Attributes/*/AttributeItem[ItemCode='Fromat']/AttributeItem[ItemCode='Video Sampling Type']/Value"/>
                    </VideoSamplingType>
                    <!-- 文件Format -->
                    <FileFormat>
                        <xsl:value-of
                                select="*/TopUnit/Attributes/*/AttributeItem[ItemCode='Fromat']/AttributeItem[ItemCode='File Format']/Value"/>
                    </FileFormat>
                </Format>

                <!-- 标识符 -->
                <Identifier>
                    <InternationalStandardRecordingCode>
                        <xsl:value-of
                                select="*/TopUnit/Attributes/*/AttributeItem[ItemCode='Identifier']/AttributeItem[ItemCode='International Standard Recording Code']/Value"/>
                    </InternationalStandardRecordingCode>
                    <RelationsID>
                        <xsl:value-of
                                select="*/TopUnit/Attributes/*/AttributeItem[ItemCode='Identifier']/AttributeItem[ItemCode='Relations ID']/Value"/>
                    </RelationsID>
                </Identifier>

                <!-- 时空覆盖范围 -->
                <Coverage>
                    <xsl:for-each select="*/TopUnit/Attributes/*/AttributeItem[ItemCode='Coverage']">
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
                    <xsl:for-each
                            select="*/TopUnit/Attributes/*/AttributeItem[ItemCode='Coverage']/AttributeItem[ItemCode='Spatial']">
                        <Spatial>
                            <xsl:value-of select="Value"/>
                        </Spatial>
                    </xsl:for-each>
                </Coverage>

                <!-- 来源 -->
                <Source>
                    <AcquiringMethodofSource>
                        <xsl:value-of
                                select="*/TopUnit/Attributes/*/AttributeItem[ItemCode='Source']/AttributeItem[ItemCode='Acquiring Method of Source']/Value"/>
                    </AcquiringMethodofSource>
                    <SourceProvider>
                        <xsl:value-of
                                select="*/TopUnit/Attributes/*/AttributeItem[ItemCode='Source']/AttributeItem[ItemCode='Source Provider']/Value"/>
                    </SourceProvider>
                </Source>

                <!-- Relation -->
                <Relation>
                    <PartofSeries>
                        <xsl:value-of
                                select="*/TopUnit/Attributes/*/AttributeItem[ItemCode='Relation']/AttributeItem[ItemCode='Part of Series']/Value"/>
                    </PartofSeries>
                    <IsPartof>
                        <xsl:value-of
                                select="*/TopUnit/Attributes/*/AttributeItem[ItemCode='Relation']/AttributeItem[ItemCode='Is Part of']/Value"/>
                    </IsPartof>
                    <xsl:for-each
                            select="*/TopUnit/Attributes/*/AttributeItem[ItemCode='Relation']/AttributeItem[ItemCode='Has Part']">
                        <HasPart>
                            <xsl:value-of select="Value"/>
                        </HasPart>
                    </xsl:for-each>
                    <xsl:for-each
                            select="*/TopUnit/Attributes/*/AttributeItem[ItemCode='Relation']/AttributeItem[ItemCode='References']">
                        <References>
                            <xsl:value-of select="Value"/>
                        </References>
                    </xsl:for-each>
                    <xsl:for-each
                            select="*/TopUnit/Attributes/*/AttributeItem[ItemCode='Relation']/AttributeItem[ItemCode='Is Referenced by']">
                        <IsReferencedby>
                            <xsl:value-of select="Value"/>
                        </IsReferencedby>
                    </xsl:for-each>
                    <Replaces>
                        <xsl:value-of
                                select="*/TopUnit/Attributes/*/AttributeItem[ItemCode='Relation']/AttributeItem[ItemCode='Replaces']/Value"/>
                    </Replaces>
                    <IsReplacedby>
                        <xsl:value-of
                                select="*/TopUnit/Attributes/*/AttributeItem[ItemCode='Relation']/AttributeItem[ItemCode='Is Replaced by']/Value"/>
                    </IsReplacedby>
                    <xsl:for-each
                            select="*/TopUnit/Attributes/*/AttributeItem[ItemCode='Relation']/AttributeItem[ItemCode='Requires']">
                        <Requires>
                            <xsl:value-of select="Value"/>
                        </Requires>
                    </xsl:for-each>
                    <xsl:for-each
                            select="*/TopUnit/Attributes/*/AttributeItem[ItemCode='Relation']/AttributeItem[ItemCode='Is Required by']">
                        <IsRequiredby>
                            <xsl:value-of select="Value"/>
                        </IsRequiredby>
                    </xsl:for-each>
                    <IsVersionof>
                        <xsl:value-of
                                select="*/TopUnit/Attributes/*/AttributeItem[ItemCode='Relation']/AttributeItem[ItemCode='Is Version of']/Value"/>
                    </IsVersionof>
                    <xsl:for-each
                            select="*/TopUnit/Attributes/*/AttributeItem[ItemCode='Relation']/AttributeItem[ItemCode='Has Version of']">
                        <HasVersionof>
                            <xsl:value-of select="Value"/>
                        </HasVersionof>
                    </xsl:for-each>
                </Relation>
            </Program>
        </Metadata>
    </xsl:template>
    <xsl:template match="text()"/>
</xsl:stylesheet>