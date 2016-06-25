<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:template match="/ObjectData/Object[@CCID='新闻节目类']">
        <MetaData>
            <xsl:for-each select="Object[@CCID='场景子类']/MetaData">
                <Scene>
                    <Title>
                        <SceneTitle>
                            <xsl:value-of select="sAttribute[@strName='场景名']"></xsl:value-of>
                        </SceneTitle>
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
                        <DateofEvent>
                            <xsl:value-of select="sAttribute[@strName='事件发生日期']"></xsl:value-of>
                        </DateofEvent>
                        <NaturalSound>
                            <xsl:value-of select="sAttribute[@strName='现场同期声']"></xsl:value-of>
                        </NaturalSound>
                    </Description>

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
                </Scene>
            </xsl:for-each>
        </MetaData>
    </xsl:template>
</xsl:stylesheet>
