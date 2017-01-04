<?xml version="1.0"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:template match="List">
    <!-- 片段层 -->
    <Metadata>
    <xsl:for-each select="CatalogueMetaData/TopUnit/SubUnit/Attributes[TypeName='片段层']/Attributes">
        <Sequence>
            <!-- 题名 -->
            <Title>
                <ProperTitle>
                    <xsl:value-of select="AttributeItem[ItemName='题名']/AttributeItem[ItemName='正题名']/Value"/>
                </ProperTitle>
                <xsl:for-each select="AttributeItem[ItemName='题名']/AttributeItem[ItemName='并列正题名']">
                    <ParallelProperTitle><xsl:value-of select="Value"/></ParallelProperTitle>
                </xsl:for-each>
                <SeriesTitle>
                    <xsl:value-of select="AttributeItem[ItemName='题名']/AttributeItem[ItemName='系列题名']/Value"/>
                </SeriesTitle>
            </Title>
            
            <!-- 主题 -->
            <Subject>
                <xsl:for-each select="AttributeItem[ItemName='主题']/AttributeItem[ItemName='分类']">
                    <Class>
                        <Classification><xsl:value-of select="AttributeItem[ItemName='分类法']/Value"/></Classification>
                        <ClassNumber><xsl:value-of select="AttributeItem[ItemName='分类号']/Value"/></ClassNumber>
                    </Class>
                </xsl:for-each>
                <xsl:for-each select="AttributeItem[ItemName='主题']/AttributeItem[ItemName='主题词']">
                    <SubjectTerm><xsl:value-of select="Value"/></SubjectTerm>
                </xsl:for-each>
                <xsl:for-each select="AttributeItem[ItemName='主题']/AttributeItem[ItemName='关键词']">
                    <Keyword><xsl:value-of select="Value"/></Keyword>
                </xsl:for-each>
            </Subject>
            
            <!-- 描述 -->
            <Description>
                <DescriptionofContent>
                    <xsl:value-of select="AttributeItem[ItemName='描述']/AttributeItem[ItemName='内容描述']/Value"/>
                </DescriptionofContent>
                <DateofEvent>
                    <xsl:value-of select="AttributeItem[ItemName='描述']/AttributeItem[ItemName='事件发生日期']/Value"/>
                </DateofEvent>
                <xsl:for-each select="AttributeItem[ItemName='描述']/AttributeItem[ItemName='获奖']">
                    <Awards>
                        <NameofAwards><xsl:value-of select="AttributeItem[ItemName='奖名']/Value"/></NameofAwards>
                        <ItemofAwards><xsl:value-of select="AttributeItem[ItemName='奖项']/Value"/></ItemofAwards>
                        <xsl:for-each select="AttributeItem[ItemName='获奖者']">
                            <WinnersofAwards><xsl:value-of select="Value"/></WinnersofAwards>
                        </xsl:for-each>
                        <YearorTimeofAwards><xsl:value-of select="AttributeItem[ItemName='获奖年度或届次']/Value"/></YearorTimeofAwards>
                        <DateofAwards><xsl:value-of select="AttributeItem[ItemName='颁奖日期']/Value"/></DateofAwards>
                    </Awards>
                </xsl:for-each>
                <NaturalSound>
                    <xsl:value-of select="AttributeItem[ItemName='描述']/AttributeItem[ItemName='现场同期声']/Value"/>
                </NaturalSound>
            </Description>
            
            <!-- 创建者 -->
            <Creator>
                <xsl:for-each select="AttributeItem[ItemName='创建者']/AttributeItem[ItemName='创建者描述']">
                    <DescriptionofCreator>
                        <NameofCreator>
                            <xsl:value-of select="AttributeItem[ItemName='创建者名称']/Value"/>
                        </NameofCreator>
                        <xsl:for-each select="AttributeItem[ItemName='创建者并列名']">
                            <ParallelNameofCreator><xsl:value-of select="Value"/></ParallelNameofCreator>
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
                <xsl:for-each select="AttributeItem[ItemName='其他责任者']/AttributeItem[ItemName='其他责任者描述']">
                    <DescriptionofContributor>
                        <NameofContributor>
                            <xsl:value-of select="AttributeItem[ItemName='其他责任者名称']/Value"/>
                        </NameofContributor>
                        <xsl:for-each select="AttributeItem[ItemCode='Parallel Name of Contributor']">
                            <ParallelNameofContributor><xsl:value-of select="Value"/></ParallelNameofContributor>
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
                <xsl:for-each select="AttributeItem[ItemName='出版者']/AttributeItem[ItemName='出版者描述']">
                    <DescriptionofPublisher>
                        <NameofPublisher>
                            <xsl:value-of select="AttributeItem[ItemName='出版者名称']/Value"/>
                        </NameofPublisher>
                        <PlaceofPublication>
                            <xsl:value-of select="AttributeItem[ItemName='出版地']/Value"/>
                        </PlaceofPublication>
                    </DescriptionofPublisher>
                </xsl:for-each>
                <xsl:for-each select="AttributeItem[ItemName='出版者']/AttributeItem[ItemName='出品者描述']">
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
                <xsl:for-each select="AttributeItem[ItemName='版权']/AttributeItem[ItemName='版权所有者名称']">
                    <NameofCopyrightOwner><xsl:value-of select="Value"/></NameofCopyrightOwner>
                </xsl:for-each>
                <CopyrightStatement>
                    <xsl:value-of select="AttributeItem[ItemName='版权']/AttributeItem[ItemName='版权声明']/Value"/>
                </CopyrightStatement>
                <xsl:for-each select="AttributeItem[ItemName='版权']/AttributeItem[ItemName='授权使用描述']">
                    <DescriptionofAuthorizedUse>
                        <NameofAuthorizedUse>
                            <xsl:value-of select="AttributeItem[ItemName='授权使用者名称']/Value"/>
                        </NameofAuthorizedUse>
                        <AuthorizedWayofUsage>
                            <xsl:value-of select="AttributeItem[ItemName='授权使用者方式']/Value"/>
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
                <xsl:for-each select="AttributeItem[ItemName='语种']/AttributeItem[ItemName='声道']">
                    <AudioChannel>
                        <AudioChannelNumber>
                            <xsl:value-of select="AttributeItem[ItemName='声道编号']/Value"/>
                        </AudioChannelNumber>
                        <AudioChannelLanguage>
                            <xsl:value-of select="AttributeItem[ItemName='声道语种']/Value"/>
                        </AudioChannelLanguage>
                    </AudioChannel>
                </xsl:for-each>
                <xsl:for-each select="AttributeItem[ItemName='语种']/AttributeItem[ItemName='字幕']">
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
            
            <!-- 类型 -->
            <Type>
                <xsl:for-each select="AttributeItem[ItemName='类型']/AttributeItem[ItemName='节目形态']">
                    <ProgramForm><xsl:value-of select="Value"/></ProgramForm>
                </xsl:for-each>
            </Type>
            
            <!-- 格式 -->
            <Format>
                <Duration>
                    <xsl:value-of select="AttributeItem[ItemName='格式']/AttributeItem[ItemName='实长']/Value * 0.04"/>
                </Duration>
                <StartingPoint>
                    <xsl:value-of select="AttributeItem[ItemName='格式']/AttributeItem[ItemName='入点']/Value * 0.04"/>
                </StartingPoint>
                <SubtitleForm>
                    <xsl:value-of select="AttributeItem[ItemName='格式']/AttributeItem[ItemName='字幕形式']/Value"/>
                </SubtitleForm>
            </Format>
            
            <!-- 标识符 -->
            <Identifier>
                <InternationalStandardRecordingCode>
                    <xsl:value-of select="AttributeItem[ItemName='标识符']/AttributeItem[ItemName='国际标准音像制品编码']/Value"/>
                </InternationalStandardRecordingCode>
                <RelationsID>
                    <xsl:value-of select="AttributeItem[ItemName='标识符']/AttributeItem[ItemName='标识代码']/Value"/>
                </RelationsID>
            </Identifier>
            
            <!-- 时空覆盖范围 -->
            <Coverage>
                <xsl:for-each select="AttributeItem[ItemName='时空覆盖范围']/AttributeItem[ItemName='时间范围']">
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
                <xsl:for-each select="AttributeItem[ItemName='时空覆盖范围']/AttributeItem[ItemName='空间范围']">
                    <Spatial><xsl:value-of select="Value"/></Spatial>
                </xsl:for-each>
            </Coverage>
            
            <!-- 来源 -->
            <Source>
                <SourceAcquiredMethod>
                    <xsl:value-of select="AttributeItem[ItemName='来源']/AttributeItem[ItemName='资料获取方式']/Value"/>
                </SourceAcquiredMethod>
                <SourceProvider>
                    <xsl:value-of select="AttributeItem[ItemName='来源']/AttributeItem[ItemName='资料提供者']/Value"/>
                </SourceProvider>
            </Source>
            
            <!-- 关联 -->
            <xsl:for-each select="AttributeItem[ItemName='关联']">
                <Ralation>
                    <IsPartof><xsl:value-of select="AttributeItem[ItemName='组成成分']/Value"/></IsPartof>
                    <xsl:for-each select="AttributeItem[ItemName='参考']">
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