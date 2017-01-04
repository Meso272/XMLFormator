<?xml version="1.0"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:template match="WorkList">
        <!-- 场景层 -->
        <Metadata>

            <xsl:for-each select="CatalogueMetaData/TopUnit/SubUnit/SubUnit/Attributes[TypeName='场景层']/Attributes">
                <Scene>
                    <!-- 题名 -->
                    <Title>
                        <SceneTitle>
                            <xsl:value-of select="AttributeItem[ItemCode='Title']/AttributeItem[ItemCode='SceneTitle']/Value"/>
                        </SceneTitle>
                    </Title>

                    <!-- 主题 -->
                    <Subject>
                        <xsl:for-each select="AttributeItem[ItemCode='Subject']/AttributeItem[ItemCode='SubjectTerm']">
                            <SubjectTerm>
                                <xsl:value-of select="Value"/>
                            </SubjectTerm>
                        </xsl:for-each>
                        <xsl:for-each select="AttributeItem[ItemCode='Subject']/AttributeItem[ItemCode='Keyword']">
                            <Keyword>
                                <xsl:value-of select="Value"/>
                            </Keyword>
                        </xsl:for-each>
                    </Subject>

                    <!-- 描述 -->
                    <Description>
                        <DescriptionofContent>
                            <xsl:value-of select="AttributeItem[ItemCode='Description']/AttributeItem[ItemCode='DescriptionofContent']/Value"/>
                        </DescriptionofContent>
                        <DateofEvent>
                            <xsl:value-of select="AttributeItem[ItemCode='Description']/AttributeItem[ItemCode='DateofEvent']/Value"/>
                        </DateofEvent>
                        <NaturalSound>
                            <xsl:value-of select="AttributeItem[ItemCode='Description']/AttributeItem[ItemCode='NaturalSound']/Value"/>
                        </NaturalSound>
                    </Description>

                    <!-- 格式 -->
                    <xsl:for-each select="AttributeItem[ItemCode='Format']">
                        <Format>
                            <Duration>
                                <xsl:value-of select="AttributeItem[ItemCode='Duration']/Value * 0.04"/>
                            </Duration>
                            <StartingPoint>
                                <xsl:value-of select="AttributeItem[ItemCode='StartingPoint']/Value * 0.04"/>
                            </StartingPoint>
                            <SubtitleForm>
                                <xsl:value-of select="AttributeItem[ItemCode='SubtitleForm']/Value"/>
                            </SubtitleForm>
                        </Format>
                    </xsl:for-each>

                    <!-- 关联 -->
                    <xsl:for-each select="AttributeItem[ItemCode='Relation']">
                        <Relation>
                            <IsPartof>
                                <xsl:value-of select="AttributeItem[ItemCode='IsPartof']/Value"/>
                            </IsPartof>
                            <xsl:for-each select="AttributeItem[ItemCode='References']">
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