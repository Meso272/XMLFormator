<?xml version="1.0"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:template match="/DCMCatalogueResult/List">
        <!-- 镜头层 -->
        <Metadata>
            <xsl:for-each select="CatalogueMetaData/TopUnit/SubUnit/SubUnit/Attributes[TypeName='镜头层']/Attributes">
                <Shot>
                    <!-- 题名 -->
                    <Title>
                        <ShotTitle>
                            <xsl:value-of
                                    select="AttributeItem[ItemName='题名']/AttributeItem[ItemName='镜头名']/Value"></xsl:value-of>
                        </ShotTitle>
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
                        <ShootingPlace>
                            <xsl:value-of select="AttributeItem[ItemName='描述']/AttributeItem[ItemName='拍摄地点']/Value"/>
                        </ShootingPlace>
                        <xsl:for-each select="AttributeItem[ItemName='描述']/AttributeItem[ItemName='拍摄方式']">
                            <CameraMotion>
                                <xsl:value-of select="Value"/>
                            </CameraMotion>
                        </xsl:for-each>
                        <xsl:for-each select="AttributeItem[ItemName='描述']/AttributeItem[ItemName='景别']">
                            <SceneRange>
                                <xsl:value-of select="Value"/>
                            </SceneRange>
                        </xsl:for-each>
                        <xsl:for-each select="AttributeItem[ItemName='描述']/AttributeItem[ItemName='拍摄角度']">
                            <CameraAngle>
                                <xsl:value-of select="Value"/>
                            </CameraAngle>
                        </xsl:for-each>
                        <NaturalSound>
                            <xsl:value-of select="AttributeItem[ItemName='描述']/AttributeItem[ItemName='现场同期声']/Value"/>
                        </NaturalSound>
                    </Description>

                    <!-- 日期 -->
                    <Date>
                        <ShootingDate>
                            <xsl:value-of select="AttributeItem[ItemName='日期']/AttributeItem[ItemName='拍摄日期']/Value"/>
                        </ShootingDate>
                    </Date>

                    <!-- 格式 -->
                    <Format>
                        <Duration>
                            <xsl:value-of select="AttributeItem[ItemName='格式']/AttributeItem[ItemName='实长']/Value * 0.04"/>
                        </Duration>
                        <StartingPoint>
                            <xsl:value-of select="AttributeItem[ItemName='格式']/AttributeItem[ItemName='入点']/Value * 0.04"/>
                        </StartingPoint>
                    </Format>

                    <!-- 关联 -->
                    <Relation>
                        <IsPartof>
                            <xsl:value-of select="AttributeItem[ItemName='关联']/AttributeItem[ItemName='组成成分']/Value"/>
                        </IsPartof>
                        <xsl:for-each select="AttributeItem[ItemName='关联']/AttributeItem[ItemName='参考']">
                            <References>
                                <xsl:value-of select="Value"/>
                            </References>
                        </xsl:for-each>
                    </Relation>
                </Shot>
            </xsl:for-each>
        </Metadata>
    </xsl:template>
    <xsl:template match="text()"/>
</xsl:stylesheet>