<?xml version="1.0"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:template match="/RECORD">
        <Metadata>
            <Program>
                <Title>
                    <ProperTitle>
                        <xsl:value-of select="Name"/>
                    </ProperTitle>
                    <xsl:for-each select="Alias">
                        <ParallelProperTitle>
                            <xsl:value-of select="current()"></xsl:value-of>
                        </ParallelProperTitle>
                    </xsl:for-each>
                </Title>
                <Subject>
                    <xsl:for-each
                            select="SndClass">
                        <SubjectTerm>
                            <xsl:value-of select="current()"/>
                        </SubjectTerm>
                    </xsl:for-each>
                    <Keyword>
                        <xsl:value-of select="Keyword"/>
                    </Keyword>
                </Subject>
                <Description>
                    <DescriptionofContent>
                        <xsl:value-of select="Description"/>
                    </DescriptionofContent>
                    <DateofEvent>
                        <xsl:value-of
                                select="ProgramTime"/>
                    </DateofEvent>
                </Description>
                <Language>
                    <xsl:for-each
                            select="Language">
                        <AudioChannel>
                            <AudioChannelLanguage>
                                <xsl:value-of select="current()"/>
                            </AudioChannelLanguage>
                        </AudioChannel>
                    </xsl:for-each>
                </Language>
                <Format>
                    <Duration>
                        <xsl:value-of select="Duration"/>
                    </Duration>
                </Format>
            </Program>
        </Metadata>
    </xsl:template>
    <xsl:template match="text()"/>
</xsl:stylesheet>