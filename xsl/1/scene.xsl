<?xml version="1.0"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:template match="List">
        <!-- 场景层 -->
        <Metadata>

            <xsl:for-each select="CatalogueMetaData/TopUnit/SubUnit/SubUnit/Attributes[TypeName='场景层']/Attributes">
                <Scene>
                    <!-- 题名 -->
                    <Title>
                        <SceneTitle>
                            <xsl:value-of select="AttributeItem[ItemName='题名']/AttributeItem[ItemName='场景名']/Value"/>
                        </SceneTitle>
                    </Title>

                    <!-- 主题 -->
                    <Subject>
                        <xsl:for-each select="AttributeItem[ItemName='主题']/AttributeItem[ItemName='主题词']">
                            <SubjectTerm>
                                <xsl:value-of select="Value"/>
                            </SubjectTerm>
                        </xsl:for-each>
                        <xsl:for-each select="AttributeItem[ItemName='主题']/AttributeItem[ItemName='关键词']">
                            <Keyword>
                                <xsl:value-of select="Value"/>
                            </Keyword>
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
                        <NaturalSound>
                            <xsl:value-of select="AttributeItem[ItemName='描述']/AttributeItem[ItemName='现场同期声']/Value"/>
                        </NaturalSound>
                    </Description>

                    <!-- 格式 -->
                    <xsl:for-each select="AttributeItem[ItemName='格式']">
                        <Format>
                            <Duration>
                                <xsl:value-of select="AttributeItem[ItemName='实长']/Value * 0.04"/>
                            </Duration>
                            <StartingPoint>
                                <xsl:value-of select="AttributeItem[ItemName='入点']/Value * 0.04"/>
                            </StartingPoint>
                            <SubtitleForm>
                                <xsl:value-of select="AttributeItem[ItemName='字幕形式']/Value"/>
                            </SubtitleForm>
                        </Format>
                    </xsl:for-each>

                    <!-- 关联 -->
                    <xsl:for-each select="AttributeItem[ItemName='关联']">
                        <Relation>
                            <IsPartof>
                                <xsl:value-of select="AttributeItem[ItemName='组成成分']/Value"/>
                            </IsPartof>
                            <xsl:for-each select="AttributeItem[ItemName='参考']">
                                <References>
                                    <xsl:value-of select="Value"/>
                                </References>
                            </xsl:for-each>
                        </Relation>
                    </xsl:for-each>

                </Scene>
            </xsl:for-each>

        </Metadata>
    </xsl:template>
    <xsl:template match="text()"/>
</xsl:stylesheet>