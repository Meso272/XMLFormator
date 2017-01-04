<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:template match="/DCMCatalogueResult/List">
        <Metadata>
            <Program>
                <!-- 题名 -->
                <Title>
                    <!-- 正题名 -->
                    <ProperTitle>
                        <!-- <xsl:value-of select="*/TopUnit/Attributes/*/*/AttributeItem[ItemName='正题名']/Value"/> -->
                        <xsl:value-of select="descendant::TopUnit//AttributeItem[ItemName='正题名']/Value"/>
                    </ProperTitle>
                    <!-- 并列正题名 -->
                    <xsl:for-each select="*/TopUnit/Attributes/*/*/AttributeItem[ItemName='并列正题名']">
                        <ParallelProperTitle>
                            <xsl:value-of select="Value"></xsl:value-of>
                        </ParallelProperTitle>
                    </xsl:for-each>
                    <!-- 副题名 -->
                    <SubordinateTitle>
                        <xsl:value-of select="*/TopUnit/Attributes/*/*/AttributeItem[ItemName='副题名']/Value"/>
                    </SubordinateTitle>
                    <!-- 交替题名 -->
                    <xsl:for-each select="*/TopUnit/Attributes/*/*/AttributeItem[ItemName='交替题名']">
                        <AlternativeTitle>
                            <xsl:value-of select="Value"></xsl:value-of>
                        </AlternativeTitle>
                    </xsl:for-each>
                    <!-- 题名说明 -->
                    <TitleDescription>
                        <xsl:value-of select="*/TopUnit/Attributes/*/*/AttributeItem[ItemName='题名说明']/Value"/>
                    </TitleDescription>
                    <!-- 系列 -->
                    <Series>
                        <SeriesTitle>
                            <xsl:value-of
                                    select="*/TopUnit/Attributes/*/*/AttributeItem[ItemName='系列']/AttributeItem[ItemName='系列题名']/Value"/>
                        </SeriesTitle>
                        <TotalNumberofEpisodes>
                            <xsl:value-of
                                    select="*/TopUnit/Attributes/*/*/AttributeItem[ItemName='系列']/AttributeItem[ItemName='分集总数']/Value"/>
                        </TotalNumberofEpisodes>
                        <EpisodesNumber>
                            <xsl:value-of
                                    select="*/TopUnit/Attributes/*/*/AttributeItem[ItemName='系列']/AttributeItem[ItemName='分集次']/Value"/>
                        </EpisodesNumber>
                        <xsl:for-each
                                select="*/TopUnit/Attributes/*/*/AttributeItem[ItemName='系列']/AttributeItem[ItemName='并列系列题名']">
                            <ParallelSeriesTitle>
                                <xsl:value-of select="Value"/>
                            </ParallelSeriesTitle>
                        </xsl:for-each>
                    </Series>
                </Title>

                <!-- 主题 -->
                <Subject>
                    <!-- 分类 -->
                    <xsl:for-each select="*/TopUnit/Attributes/*/*/AttributeItem[ItemName='分类']">
                        <Class>
                            <Classification>
                                <xsl:value-of select="AttributeItem[ItemName='分类法']/Value"/>
                            </Classification>
                            <ClassNumber>
                                <xsl:value-of select="AttributeItem[ItemName='分类号']/Value"/>
                            </ClassNumber>
                        </Class>
                    </xsl:for-each>
                    <!-- 主题词 -->
                    <xsl:for-each
                            select="*/TopUnit/Attributes/*/AttributeItem[ItemName='主题']/AttributeItem[ItemName='主题词']">
                        <SubjectTerm>
                            <xsl:value-of select="Value"/>
                        </SubjectTerm>
                    </xsl:for-each>
                    <!-- 关键词 -->
                    <xsl:for-each
                            select="*/TopUnit/Attributes/*/AttributeItem[ItemName='主题']/AttributeItem[ItemName='关键词']">
                        <Keyword>
                            <xsl:value-of select="Value"/>
                        </Keyword>
                    </xsl:for-each>
                </Subject>

                <!-- 描述 -->
                <Description>
                    <!-- 内容描述 -->
                    <DescriptionofContent>
                        <xsl:value-of
                                select="*/TopUnit/Attributes/*/AttributeItem[ItemName='描述']/AttributeItem[ItemName='内容描述']/Value"/>
                    </DescriptionofContent>
                    <!-- 主题人物 -->
                    <xsl:for-each
                            select="*/TopUnit/Attributes/*/AttributeItem[ItemName='描述']/AttributeItem[ItemName='主题人物']">
                        <Character>
                            <xsl:value-of select="Value"/>
                        </Character>
                    </xsl:for-each>
                    <!-- 事件发生日期 -->
                    <DateofEvent>
                        <xsl:value-of
                                select="*/TopUnit/Attributes/*/AttributeItem[ItemName='描述']/AttributeItem[ItemName='事件发生日期']/Value"/>
                    </DateofEvent>
                    <!-- 版本说明 -->
                    <xsl:for-each
                            select="*/TopUnit/Attributes/*/AttributeItem[ItemName='描述']/AttributeItem[ItemName='版本说明']">
                        <VersionDescription>
                            <xsl:value-of select="Value"/>
                        </VersionDescription>
                    </xsl:for-each>
                    <!-- 获奖 -->
                    <xsl:for-each
                            select="*/TopUnit/Attributes/*/AttributeItem[ItemName='描述']/AttributeItem[ItemName='获奖']">
                        <Awards>
                            <NameofAwards>
                                <xsl:value-of select="AttributeItem[ItemName='奖名']/Value"/>
                            </NameofAwards>
                            <ItemofAwards>
                                <xsl:value-of select="AttributeItem[ItemName='奖项']/Value"/>
                            </ItemofAwards>
                            <xsl:for-each select="AttributeItem[ItemName='获奖者']">
                                <WinnersofAwards>
                                    <xsl:value-of select="Value"/>
                                </WinnersofAwards>
                            </xsl:for-each>
                            <YearorTimeofAwards>
                                <xsl:value-of select="AttributeItem[ItemName='获奖年度或届次']/Value"/>
                            </YearorTimeofAwards>
                            <DateofAwards>
                                <xsl:value-of select="AttributeItem[ItemName='颁奖日期']/Value"/>
                            </DateofAwards>
                        </Awards>
                    </xsl:for-each>
                    <!-- 栏目 -->
                    <xsl:for-each
                            select="*/TopUnit/Attributes/*/AttributeItem[ItemName='描述']/AttributeItem[ItemName='栏目']">
                        <Column>
                            <ColumnName>
                                <xsl:value-of select="AttributeItem[ItemName='栏目名称']/Value"/>
                            </ColumnName>
                            <IssueNumber>
                                <xsl:value-of select="AttributeItem[ItemName='期次']/Value"/>
                            </IssueNumber>
                            <IssueYear>
                                <xsl:value-of select="AttributeItem[ItemName='年度']/Value"/>
                            </IssueYear>
                        </Column>
                    </xsl:for-each>
                    <!-- 受众 -->
                    <Audience>
                        <xsl:value-of
                                select="*/TopUnit/Attributes/*/AttributeItem[ItemName='描述']/AttributeItem[ItemName='受众']/Value"/>
                    </Audience>
                    <!-- 附加标志 -->
                    <AdditionalLogo>
                        <xsl:value-of
                                select="*/TopUnit/Attributes/*/AttributeItem[ItemName='描述']/AttributeItem[ItemName='附加标志']/Value"/>
                    </AdditionalLogo>
                    <!-- 声道 -->
                    <xsl:for-each
                            select="*/TopUnit/Attributes/*/AttributeItem[ItemName='描述']/AttributeItem[ItemName='声道']">
                        <AudioChannel>
                            <AudioChannelNumber>
                                <xsl:value-of select="AttributeItem[ItemName='声道编号']/Value"/>
                            </AudioChannelNumber>
                            <AudioChannelDescription>
                                <xsl:value-of select="AttributeItem[ItemName='声道内容']/Value"/>
                            </AudioChannelDescription>
                        </AudioChannel>
                    </xsl:for-each>
                    <!-- 附件 -->
                    <xsl:for-each
                            select="*/TopUnit/Attributes/*/AttributeItem[ItemName='描述']/AttributeItem[ItemName='附件']">
                        <Attachment>
                            <xsl:value-of select="Value"/>
                        </Attachment>
                    </xsl:for-each>
                </Description>

                <!-- 创建者 -->
                <Creator>
                    <xsl:for-each
                            select="*/TopUnit/Attributes/*/AttributeItem[ItemName='创建者']/AttributeItem[ItemName='创建者描述']">
                        <DescriptionofCreator>
                            <NameofCreator>
                                <xsl:value-of select="AttributeItem[ItemName='创建者名称']/Value"/>
                            </NameofCreator>
                            <xsl:for-each select="AttributeItem[ItemName='创建者并列名']">
                                <ParallelNameofCreator>
                                    <xsl:value-of select="Value"/>
                                </ParallelNameofCreator>
                            </xsl:for-each>
                            <Role>
                                <xsl:value-of select="AttributeItem[ItemName='责任方式']/Value"/>
                            </Role>
                            <OtherInformation>
                                <xsl:value-of select="AttributeItem[ItemName='其他信息']/Value"/>
                            </OtherInformation>
                        </DescriptionofCreator>
                    </xsl:for-each>
                </Creator>

                <!-- 其他责任者 -->
                <Contributor>
                    <xsl:for-each select="*/TopUnit/Attributes/*/AttributeItem[ItemName='其他责任者']/AttributeItem[ItemName='其他责任者描述']">
                        <DescriptionofContributor>
                            <NameofContributor>
                                <xsl:value-of select="AttributeItem[ItemName='其他责任者名称']/Value"/>
                            </NameofContributor>
                            <xsl:for-each select="AttributeItem[ItemName='其他责任者并列名']">
                                <ParallelNameofContributor>
                                    <xsl:value-of select="Value"/>
                                </ParallelNameofContributor>
                            </xsl:for-each>
                            <Role>
                                <xsl:value-of select="AttributeItem[ItemName='责任方式']/Value"/>
                            </Role>
                            <OtherInformation>
                                <xsl:value-of select="AttributeItem[ItemName='其他信息']/Value"/>
                            </OtherInformation>
                        </DescriptionofContributor>
                    </xsl:for-each>
                </Contributor>

                <!-- 出版者 -->
                <Publisher>
                    <!-- 出版者描述 -->
                    <xsl:for-each
                            select="*/TopUnit/Attributes/*/AttributeItem[ItemName='出版者']/AttributeItem[ItemName='出版者描述']">
                        <DescriptionofPublisher>
                            <NameofPublisher>
                                <xsl:value-of select="AttributeItem[ItemName='出版者名称']/Value"/>
                            </NameofPublisher>
                            <PlaceofPublication>
                                <xsl:value-of select="AttributeItem[ItemName='出版者地']/Value"/>
                            </PlaceofPublication>
                        </DescriptionofPublisher>
                    </xsl:for-each>
                    <!-- 出品者描述 -->
                    <xsl:for-each
                            select="*/TopUnit/Attributes/*/AttributeItem[ItemName='出版者']/AttributeItem[ItemName='出品者描述']">
                        <DescriptionofProducer>
                            <NameofProducer>
                                <xsl:value-of select="AttributeItem[ItemName='出品者名称']/Value"/>
                            </NameofProducer>
                            <PlaceofProduction>
                                <xsl:value-of select="AttributeItem[ItemName='出品地']/Value"/>
                            </PlaceofProduction>
                        </DescriptionofProducer>
                    </xsl:for-each>
                </Publisher>

                <!-- 版权 -->
                <Copyright>
                    <!-- 版权所有者名称 -->
                    <xsl:for-each
                            select="*/TopUnit/Attributes/*/AttributeItem[ItemName='版权']/AttributeItem[ItemName='版权所有者名称']">
                        <NameofCopyrightOwner>
                            <xsl:value-of select="Value"/>
                        </NameofCopyrightOwner>
                    </xsl:for-each>
                    <!-- 版权声明 -->
                    <CopyrightStatement>
                        <xsl:value-of
                                select="*/TopUnit/Attributes/*/AttributeItem[ItemName='版权']/AttributeItem[ItemName='版权声明']/Value"/>
                    </CopyrightStatement>
                    <!-- 授权使用描述 -->
                    <xsl:for-each
                            select="*/TopUnit/Attributes/*/AttributeItem[ItemName='版权']/AttributeItem[ItemName='授权使用描述']">
                        <DescriptionofAuthorizedUse>
                            <NameofAuthorizedUser>
                                <xsl:value-of select="AttributeItem[ItemName='授权使用者名称']/Value"/>
                            </NameofAuthorizedUser>
                            <AuthorizedWayofUsage>
                                <xsl:value-of select="AttributeItem[ItemName='授权使用方式']/Value"/>
                            </AuthorizedWayofUsage>
                            <AuthorizedDateofStart>
                                <xsl:value-of select="AttributeItem[ItemName='授权起始日期']/Value"/>
                            </AuthorizedDateofStart>
                            <AuthorizedDeadline>
                                <xsl:value-of select="AttributeItem[ItemName='授权使用期限']/Value"/>
                            </AuthorizedDeadline>
                            <AuthorizedGeographicArea>
                                <xsl:value-of select="AttributeItem[ItemName='授权使用地域']/Value"/>
                            </AuthorizedGeographicArea>
                            <TimesofAuthorizedUsage>
                                <xsl:value-of select="AttributeItem[ItemName='授权使用次数']/Value"/>
                            </TimesofAuthorizedUsage>
                            <OtherInformation>
                                <xsl:value-of select="AttributeItem[ItemName='其他信息']/Value"/>
                            </OtherInformation>
                        </DescriptionofAuthorizedUse>
                    </xsl:for-each>
                </Copyright>

                <!-- 语种 -->
                <Language>
                    <!-- 声道 -->
                    <xsl:for-each
                            select="*/TopUnit/Attributes/*/AttributeItem[ItemName='语种']/AttributeItem[ItemName='声道']">
                        <AudioChannel>
                            <AudioChannelNumber>
                                <xsl:value-of select="AttributeItem[ItemName='声道编号']/Value"/>
                            </AudioChannelNumber>
                            <AudioChannelLanguage>
                                <xsl:value-of select="AttributeItem[ItemName='声道语种']/Value"/>
                            </AudioChannelLanguage>
                        </AudioChannel>
                    </xsl:for-each>
                    <!-- 字幕 -->
                    <xsl:for-each
                            select="*/TopUnit/Attributes/*/AttributeItem[ItemName='语种']/AttributeItem[ItemName='字幕']">
                        <Subtitle>
                            <SubtitleNumber>
                                <xsl:value-of select="AttributeItem[ItemName='字幕编号']/Value"/>
                            </SubtitleNumber>
                            <SubtitleLanguage>
                                <xsl:value-of select="AttributeItem[ItemName='字幕语种']/Value"/>
                            </SubtitleLanguage>
                        </Subtitle>
                    </xsl:for-each>
                </Language>

                <!-- 日期 -->
                <Date>
                    <ProducedDate>
                        <xsl:value-of select="descendant::TopUnit//AttributeItem[ItemName='制作完成日期']/Value"/>
                    </ProducedDate>
                    <DateofDebut>
                        <xsl:value-of select="descendant::TopUnit//AttributeItem[ItemName='首播日期']/Value"/>
                    </DateofDebut>
                    <PublishedDate>
                        <xsl:value-of select="descendant::TopUnit//AttributeItem[ItemName='出版日期']/Value"/>
                    </PublishedDate>
                </Date>

                <!-- 类型 -->
                <Type>
                    <xsl:for-each
                            select="*/TopUnit/Attributes/*/AttributeItem[ItemName='类型']/AttributeItem[ItemName='节目类型']">
                        <ProgramType>
                            <xsl:value-of select="Value"/>
                        </ProgramType>
                    </xsl:for-each>
                    <xsl:for-each
                            select="*/TopUnit/Attributes/*/AttributeItem[ItemName='类型']/AttributeItem[ItemName='节目形态']">
                        <ProgramForm>
                            <xsl:value-of select="Value"/>
                        </ProgramForm>
                    </xsl:for-each>
                </Type>

                <!-- 格式 -->
                <Format>
                    <!-- 实长 -->
                    <Duration>
                        <xsl:value-of
                                select="*/TopUnit/Attributes/*/AttributeItem[ItemName='格式']/AttributeItem[ItemName='实长']/Value * 0.04"/>
                    </Duration>
                    <!-- 入点 -->
                    <StartingPoint>
                        <xsl:value-of
                                select="*/TopUnit/Attributes/*/AttributeItem[ItemName='格式']/AttributeItem[ItemName='入点']/Value * 0.04"/>
                    </StartingPoint>
                    <!-- 色彩 -->
                    <Color>
                        <xsl:value-of
                                select="*/TopUnit/Attributes/*/AttributeItem[ItemName='格式']/AttributeItem[ItemName='色彩']/Value"/>
                    </Color>
                    <!-- 字幕形式 -->
                    <SubtitleForm>
                        <xsl:value-of
                                select="*/TopUnit/Attributes/*/AttributeItem[ItemName='格式']/AttributeItem[ItemName='字幕形式']/Value"/>
                    </SubtitleForm>
                    <!-- 声道格式 -->
                    <AudioChannelFormat>
                        <xsl:value-of
                                select="*/TopUnit/Attributes/*/AttributeItem[ItemName='格式']/AttributeItem[ItemName='声道格式']/Value"/>
                    </AudioChannelFormat>
                    <!-- 声音质量 -->
                    <AudioQuality>
                        <xsl:value-of
                                select="*/TopUnit/Attributes/*/AttributeItem[ItemName='格式']/AttributeItem[ItemName='声音质量']/Value"/>
                    </AudioQuality>
                    <!-- 画面质量 -->
                    <VideoQuality>
                        <xsl:value-of
                                select="*/TopUnit/Attributes/*/AttributeItem[ItemName='格式']/AttributeItem[ItemName='画面质量']/Value"/>
                    </VideoQuality>
                    <!-- 画面宽高比 -->
                    <AspectRatio>
                        <xsl:value-of
                                select="*/TopUnit/Attributes/*/AttributeItem[ItemName='格式']/AttributeItem[ItemCode='Aspect Ratio']/Value"/>
                    </AspectRatio>
                    <!-- 载体类型 -->
                    <PhysicalMediaType>
                        <xsl:value-of
                                select="*/TopUnit/Attributes/*/AttributeItem[ItemName='格式']/AttributeItem[ItemName='载体类型']/Value"/>
                    </PhysicalMediaType>
                    <!-- 制式 -->
                    <System>
                        <xsl:value-of
                                select="*/TopUnit/Attributes/*/AttributeItem[ItemName='格式']/AttributeItem[ItemName='制式']/Value"/>
                    </System>
                    <!-- 音频数据码率 -->
                    <AudioDataRate>
                        <xsl:value-of
                                select="*/TopUnit/Attributes/*/AttributeItem[ItemName='格式']/AttributeItem[ItemCode='Audio Data Rate']/Value"/>
                    </AudioDataRate>
                    <!-- 音频编码格式 -->
                    <AudioCodingFormat>
                        <xsl:value-of
                                select="*/TopUnit/Attributes/*/AttributeItem[ItemName='格式']/AttributeItem[ItemName='音频编码格式']/Value"/>
                    </AudioCodingFormat>
                    <!-- 音频采样频率 -->
                    <AudioSamplingFrequency>
                        <xsl:value-of
                                select="*/TopUnit/Attributes/*/AttributeItem[ItemName='格式']/AttributeItem[ItemName='音频采样频率']/Value"/>
                    </AudioSamplingFrequency>
                    <!-- 音频位深度 -->
                    <AudioBitDepth>
                        <xsl:value-of
                                select="*/TopUnit/Attributes/*/AttributeItem[ItemName='格式']/AttributeItem[ItemName='音频位深度']/Value"/>
                    </AudioBitDepth>
                    <!-- 视频数据码率 -->
                    <VideoBitrate>
                        <xsl:value-of
                                select="*/TopUnit/Attributes/*/AttributeItem[ItemName='格式']/AttributeItem[ItemCode='Vedio Data Rate']/Value"/>
                    </VideoBitrate>
                    <!-- 视频编码格式 -->
                    <VideoCodingFormat>
                        <xsl:value-of
                                select="*/TopUnit/Attributes/*/AttributeItem[ItemName='格式']/AttributeItem[ItemName='视频编码格式']/Value"/>
                    </VideoCodingFormat>
                    <!-- 视频取样格式 -->
                    <VideoSamplingType>
                        <xsl:value-of
                                select="*/TopUnit/Attributes/*/AttributeItem[ItemName='格式']/AttributeItem[ItemName='视频取样格式']/Value"/>
                    </VideoSamplingType>
                    <!-- 文件格式 -->
                    <FileFormat>
                        <xsl:value-of
                                select="*/TopUnit/Attributes/*/AttributeItem[ItemName='格式']/AttributeItem[ItemName='文件格式']/Value"/>
                    </FileFormat>
                </Format>

                <!-- 标识符 -->
                <Identifier>
                    <InternationalStandardRecordingCode>
                        <xsl:value-of
                                select="*/TopUnit/Attributes/*/AttributeItem[ItemName='标识符']/AttributeItem[ItemName='国际标准音像制品编码']/Value"/>
                    </InternationalStandardRecordingCode>
                    <RelationsID>
                        <xsl:value-of
                                select="*/TopUnit/Attributes/*/AttributeItem[ItemName='标识符']/AttributeItem[ItemName='标识代码']/Value"/>
                    </RelationsID>
                </Identifier>

                <!-- 时空覆盖范围 -->
                <Coverage>
                    <xsl:for-each select="*/TopUnit/Attributes/*/AttributeItem[ItemName='时空覆盖范围']">
                        <YearsCovered>
                            <YearofStart>
                                <xsl:value-of select="AttributeItem[ItemName='开始年份']/Value"/>
                            </YearofStart>
                            <YearofEnd>
                                <xsl:value-of select="AttributeItem[ItemName='结束年份']/Value"/>
                            </YearofEnd>
                            <DescriptionofYearsCovered>
                                <xsl:value-of select="AttributeItem[ItemName='年代描述']/Value"/>
                            </DescriptionofYearsCovered>
                        </YearsCovered>
                    </xsl:for-each>
                    <xsl:for-each
                            select="*/TopUnit/Attributes/*/AttributeItem[ItemName='时空覆盖范围']/AttributeItem[ItemName='空间范围']">
                        <Spatial>
                            <xsl:value-of select="Value"/>
                        </Spatial>
                    </xsl:for-each>
                </Coverage>

                <!-- 来源 -->
                <Source>
                    <AcquiringMethodofSource>
                        <xsl:value-of
                                select="*/TopUnit/Attributes/*/AttributeItem[ItemName='来源']/AttributeItem[ItemName='资料获取方式']/Value"/>
                    </AcquiringMethodofSource>
                    <SourceProvider>
                        <xsl:value-of
                                select="*/TopUnit/Attributes/*/AttributeItem[ItemName='来源']/AttributeItem[ItemName='资料提供者']/Value"/>
                    </SourceProvider>
                </Source>

                <!-- 关联 -->
                <Relation>
                    <PartofSeries>
                        <xsl:value-of
                                select="*/TopUnit/Attributes/*/AttributeItem[ItemName='关联']/AttributeItem[ItemCode='Part of Series']/Value"/>
                    </PartofSeries>
                    <IsPartof>
                        <xsl:value-of
                                select="*/TopUnit/Attributes/*/AttributeItem[ItemName='关联']/AttributeItem[ItemName='组成部分']/Value"/>
                    </IsPartof>
                    <xsl:for-each
                            select="*/TopUnit/Attributes/*/AttributeItem[ItemName='关联']/AttributeItem[ItemName='部分为']">
                        <HasPart>
                            <xsl:value-of select="Value"/>
                        </HasPart>
                    </xsl:for-each>
                    <xsl:for-each
                            select="*/TopUnit/Attributes/*/AttributeItem[ItemName='关联']/AttributeItem[ItemName='参考']">
                        <References>
                            <xsl:value-of select="Value"/>
                        </References>
                    </xsl:for-each>
                    <xsl:for-each
                            select="*/TopUnit/Attributes/*/AttributeItem[ItemName='关联']/AttributeItem[ItemName='被参考']">
                        <IsReferencedby>
                            <xsl:value-of select="Value"/>
                        </IsReferencedby>
                    </xsl:for-each>
                    <Replaces>
                        <xsl:value-of
                                select="*/TopUnit/Attributes/*/AttributeItem[ItemName='关联']/AttributeItem[ItemName='替代']/Value"/>
                    </Replaces>
                    <IsReplacedby>
                        <xsl:value-of
                                select="*/TopUnit/Attributes/*/AttributeItem[ItemName='关联']/AttributeItem[ItemName='被替代']/Value"/>
                    </IsReplacedby>
                    <xsl:for-each
                            select="*/TopUnit/Attributes/*/AttributeItem[ItemName='关联']/AttributeItem[ItemName='需求']">
                        <Requires>
                            <xsl:value-of select="Value"/>
                        </Requires>
                    </xsl:for-each>
                    <xsl:for-each
                            select="*/TopUnit/Attributes/*/AttributeItem[ItemName='关联']/AttributeItem[ItemName='被需求']">
                        <IsRequiredby>
                            <xsl:value-of select="Value"/>
                        </IsRequiredby>
                    </xsl:for-each>
                    <IsVersionof>
                        <xsl:value-of
                                select="*/TopUnit/Attributes/*/AttributeItem[ItemName='关联']/AttributeItem[ItemName='版本继承']/Value"/>
                    </IsVersionof>
                    <xsl:for-each
                            select="*/TopUnit/Attributes/*/AttributeItem[ItemName='关联']/AttributeItem[ItemName='版本关联']">
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