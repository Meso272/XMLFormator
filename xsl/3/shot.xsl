<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:template match="/ObjectData/Object[@CCID='新闻节目类']/Object[@CCID='场景子类']">
        <MetaData>
            <xsl:for-each select="Object[@CCID='镜头子类']/MetaData">
                <Shot>
                    <Title>
                        <ShotTitle>
                            <xsl:value-of select="sAttribute[@strName='镜头名']"></xsl:value-of>
                        </ShotTitle>
                    </Title>
                    <Subject>
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
                        <ShootingPlace>
                            <xsl:value-of select="sAttribute[@strName='拍摄地点']"></xsl:value-of>
                        </ShootingPlace>
                        <xsl:for-each select="sAttribute[@strName='拍摄方式']">
                            <CameraMotion>
                                <xsl:value-of select="."></xsl:value-of>
                            </CameraMotion>
                        </xsl:for-each>
                        <xsl:for-each select="sAttribute[@strName='景别']">
                            <CameraMotion>
                                <xsl:value-of select="."></xsl:value-of>
                            </CameraMotion>
                        </xsl:for-each>
                        <xsl:for-each select="sAttribute[@strName='拍摄角度']">
                            <CameraMotion>
                                <xsl:value-of select="."></xsl:value-of>
                            </CameraMotion>
                        </xsl:for-each>
                        <NaturalSound>
                            <xsl:value-of select="sAttribute[@strName='现场同期声']"></xsl:value-of>
                        </NaturalSound>
                    </Description>
                    <Date>
                        <xsl:value-of select="sAttribute[@strName='拍摄日期']"></xsl:value-of>
                    </Date>
                    <Format>
                        <Duration>
                            <xsl:value-of select="sAttribute[@strName='实长']"></xsl:value-of>
                        </Duration>
                        <StartingPoint>
                            <xsl:value-of select="sAttribute[@strName='入点']"></xsl:value-of>
                        </StartingPoint>
                    </Format>
                </Shot>
            </xsl:for-each>
        </MetaData>
    </xsl:template>
    <xsl:template match="text()"/>
</xsl:stylesheet>
