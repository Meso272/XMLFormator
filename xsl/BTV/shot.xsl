<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:template match="List">
        <!-- 镜头层 -->
        <Metadata>
            <xsl:for-each select="CatalogueMetaData/TopUnit/SubUnit/SubUnit/Attributes[TypeName='镜头层']/Attributes">
                <Shot>
                    <!-- 题名 -->
                    <Title>
                        <ShotTitle>
                            <xsl:value-of
                                    select="AttributeItem[ItemCode='Title']/AttributeItem[ItemCode='ShotTitle']/Value"></xsl:value-of>
                        </ShotTitle>
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
                        <ShootingPlace>
                            <xsl:value-of select="AttributeItem[ItemCode='Description']/AttributeItem[ItemCode='ShootingPlace']/Value"/>
                        </ShootingPlace>
                        <xsl:for-each select="AttributeItem[ItemCode='Description']/AttributeItem[ItemCode='CameraMotion']">
                            <CameraMotion>
                                <xsl:value-of select="Value"/>
                            </CameraMotion>
                        </xsl:for-each>
                        <xsl:for-each select="AttributeItem[ItemCode='Description']/AttributeItem[ItemCode='SceneRange']">
                            <SceneRange>
                                <xsl:value-of select="Value"/>
                            </SceneRange>
                        </xsl:for-each>
                        <xsl:for-each select="AttributeItem[ItemCode='Description']/AttributeItem[ItemCode='CameraAngle']">
                            <CameraAngle>
                                <xsl:value-of select="Value"/>
                            </CameraAngle>
                        </xsl:for-each>
                        <NaturalSound>
                            <xsl:value-of select="AttributeItem[ItemCode='Description']/AttributeItem[ItemCode='NaturalSound']/Value"/>
                        </NaturalSound>
                    </Description>

                    <!-- 日期 -->
                    <Date>
                        <ShootingDate>
                            <xsl:value-of select="AttributeItem[ItemCode='Date']/AttributeItem[ItemCode='ShootingDate']/Value"/>
                        </ShootingDate>
                    </Date>

                    <!-- 格式 -->
                    <Format>
                        <Duration>
                            <xsl:value-of select="AttributeItem[ItemCode='Format']/AttributeItem[ItemCode='Duration']/Value * 0.04"/>
                        </Duration>
                        <StartingPoint>
                            <xsl:value-of select="AttributeItem[ItemCode='Format']/AttributeItem[ItemCode='StartingPoint']/Value * 0.04"/>
                        </StartingPoint>
                    </Format>

                    <!-- 关联 -->
                    <Relation>
                        <IsPartof>
                            <xsl:value-of select="AttributeItem[ItemCode='Relation']/AttributeItem[ItemCode='IsPartof']/Value"/>
                        </IsPartof>
                        <xsl:for-each select="AttributeItem[ItemCode='Relation']/AttributeItem[ItemCode='References']">
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