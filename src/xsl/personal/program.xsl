<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
    <xsl:template match="/Metadata/Program">
        <MetaData>
            <Program>
                <Title>
                    <ProperTitle>
                        <xsl:value-of select="Title/ProperTitle"></xsl:value-of>
                    </ProperTitle>
                </Title>
                <Subject>
                    <xsl:for-each select="Subject/Keyword">
                        <Keyword>
                            <xsl:value-of select="current()"></xsl:value-of>
                        </Keyword>
                    </xsl:for-each>
                </Subject>
                <Date>
                    <ProducedDate>
                        <xsl:value-of select="Date/ProducedDate"></xsl:value-of>
                    </ProducedDate>
                </Date>
                <Format>
                    <Duration>
                        <xsl:value-of select="Format/Duration"></xsl:value-of>
                    </Duration>
                    <StartingPoint>
                        <xsl:value-of select="Format/StartingPoint"></xsl:value-of>
                    </StartingPoint>
                    <FileFormat>
                        <xsl:value-of select="Format/FileFormat"></xsl:value-of>
                    </FileFormat>
                </Format>
                <Description>
                    <DescriptionofContent>
                        <xsl:value-of select="Description/DescriptionofContent"></xsl:value-of>
                    </DescriptionofContent>
                </Description>
            </Program>
        </MetaData>
    </xsl:template>
    <xsl:template match="text()"/>
</xsl:stylesheet>
