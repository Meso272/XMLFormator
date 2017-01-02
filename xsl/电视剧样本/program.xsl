<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:template match="/CMS/MetaData/Description/Program">
        <MetaData>
        <Program>
            <Title>
                <ProperTitle> <xsl:value-of select="Title/ProperTitle"></xsl:value-of> </ProperTitle>
                <xsl:for-each select="Title/ParallelProperTitle">
                    <ParallelProperTitle> <xsl:value-of select="current()"></xsl:value-of> </ParallelProperTitle>
                </xsl:for-each>
                <SubordinateTitle> <xsl:value-of select="Title/SubordinateTitle"></xsl:value-of> </SubordinateTitle>
                <xsl:for-each select="Title/AlternativeTitle">
                    <AlternativeTitle> <xsl:value-of select="current()"></xsl:value-of> </AlternativeTitle>
                </xsl:for-each>
                <TitleDescription> <xsl:value-of select="Title/TitleDescription"></xsl:value-of> </TitleDescription>
                <Series>
                    <SeriesTitle> <xsl:value-of select="Title/Series/SeriesTitle"></xsl:value-of> </SeriesTitle>
                    <xsl:for-each select="Title/Series/ParallelSeriesTitle">
                        <ParallelSeriesTitle> <xsl:value-of select="current()"></xsl:value-of> </ParallelSeriesTitle>
                    </xsl:for-each>
                    <TotalNumberofEpisodes> <xsl:value-of select="Title/Series/TotalNumberofEpisodes"></xsl:value-of> </TotalNumberofEpisodes>
                    <EpisodesNumber> <xsl:value-of select="Title/Series/EpisodesNumber"></xsl:value-of> </EpisodesNumber>
                </Series>
            </Title>
            <Subject>
                <xsl:for-each select="Subject/Class">
                    <Class>
                        <Classification> <xsl:value-of select="Classification"></xsl:value-of> </Classification>
                        <ClassNumber> <xsl:value-of select="ClassNumber"></xsl:value-of> </ClassNumber>
                    </Class>
                </xsl:for-each>
                <xsl:for-each select="Subject/SubjectTerm">
                    <SubjectTerm> <xsl:value-of select="current()"></xsl:value-of> </SubjectTerm>
                </xsl:for-each>
                <xsl:for-each select="Subject/Keyword">
                    <Keyword> <xsl:value-of select="current()"></xsl:value-of> </Keyword>
                </xsl:for-each>
            </Subject>
            <Description>
                <DescriptionofContent> <xsl:value-of select="Description/DescriptionofContent"></xsl:value-of> </DescriptionofContent>
                <xsl:for-each select="Description/character">
                    <Character> <xsl:value-of select="current()"></xsl:value-of> </Character>
                </xsl:for-each>
                <DateofEvent> <xsl:value-of select="Description/DateofEvent"></xsl:value-of> </DateofEvent>
                <xsl:for-each select="Description/VersionDescription">
                    <VersionDescription> <xsl:value-of select="current()"></xsl:value-of> </VersionDescription>
                </xsl:for-each>
                <xsl:for-each select="Description/Awards">
                    <Awards>
                        <NameofAwards> <xsl:value-of select="NameofAwards"></xsl:value-of> </NameofAwards>
                        <ItemofAwards> <xsl:value-of select="ItemofAwards"></xsl:value-of> </ItemofAwards>
                        <xsl:for-each select="WinnersofAwards">
                            <WinnersofAwards> <xsl:value-of select="current()"></xsl:value-of> </WinnersofAwards>
                        </xsl:for-each>
                        <YearorTimeofAwards> <xsl:value-of select="YearorTimeofAwards"></xsl:value-of> </YearorTimeofAwards>
                        <DateofAwards> <xsl:value-of select="DateofAwards"></xsl:value-of> </DateofAwards>
                    </Awards>
                </xsl:for-each>
                <xsl:for-each select="Description/Column">
                    <Column>
                        <ColumnName> <xsl:value-of select="ColumnName"></xsl:value-of> </ColumnName>
                        <IssueNumber> <xsl:value-of select="IssueNumber"></xsl:value-of> </IssueNumber>
                        <IssueYear> <xsl:value-of select="IssueYear"></xsl:value-of> </IssueYear>
                    </Column>
                </xsl:for-each>
                <Audience> <xsl:value-of select="Description/Audience"></xsl:value-of> </Audience>
                <AdditionalLogo> <xsl:value-of select="Description/AdditionalLogo"></xsl:value-of> </AdditionalLogo>
                <xsl:for-each select="Description/AudioChannel">
                    <AudioChannel>
                        <AudioChannelNumber> <xsl:value-of select="AudioChannelNumber"></xsl:value-of> </AudioChannelNumber>
                        <AudioChannelDescription> <xsl:value-of select="AudioChannelDescription"></xsl:value-of> </AudioChannelDescription>
                    </AudioChannel>
                </xsl:for-each>
                <xsl:for-each select="Description/Attachment">
                    <Attachment> <xsl:value-of select="current()"></xsl:value-of> </Attachment>
                </xsl:for-each>
            </Description>
            <Creator>
                <xsl:for-each select="Creator/DescriptionofCreator">
                    <DescriptionofCreator>
                        <NameofCreator> <xsl:value-of select="NameofCreator"></xsl:value-of> </NameofCreator>
                        <xsl:for-each select="ParallelNameofCreator">
                            <ParallelNameofCreator> <xsl:value-of select="current()"></xsl:value-of> </ParallelNameofCreator>
                        </xsl:for-each>
                        <Role> <xsl:value-of select="Role"></xsl:value-of> </Role>
                        <OtherInformation> <xsl:value-of select="OtherInformation"></xsl:value-of> </OtherInformation>
                    </DescriptionofCreator>
                </xsl:for-each>
            </Creator>
            <Contributor>
                <xsl:for-each select="Contributor/DescriptionofContributor">
                    <DescriptionofContributor>
                        <NameofContributor> <xsl:value-of select="NameofContributor"></xsl:value-of> </NameofContributor>
                        <xsl:for-each select="ParallelNameofContributor">
                            <ParallelNameofContributor> <xsl:value-of select="current()"></xsl:value-of> </ParallelNameofContributor>
                        </xsl:for-each>
                        <Role> <xsl:value-of select="Role"></xsl:value-of> </Role>
                        <OtherInformation> <xsl:value-of select="OtherInformation"></xsl:value-of> </OtherInformation>
                    </DescriptionofContributor>
                </xsl:for-each>
            </Contributor>
            <Publisher>
                <xsl:for-each select="Publisher/DescriptionofPublisher">
                    <DescriptionofPublisher>
                        <NameofPublisher> <xsl:value-of select="NameofPublisher"></xsl:value-of> </NameofPublisher>
                        <PlaceofPublication> <xsl:value-of select="PlaceofPublication"></xsl:value-of> </PlaceofPublication>
                    </DescriptionofPublisher>
                </xsl:for-each>
                <xsl:for-each select="Publisher/DescriptionofProducer">
                    <DescriptionofProducer>
                        <NameofProducer> <xsl:value-of select="NameofProducer"></xsl:value-of> </NameofProducer>
                        <PlaceofProduction> <xsl:value-of select="PlaceofProduction"></xsl:value-of> </PlaceofProduction>
                    </DescriptionofProducer>
                </xsl:for-each>
            </Publisher>
            <Copyright>
                <xsl:for-each select="Copyright/NameofCopyrightOwner">
                    <NameofCopyrightOwner> <xsl:value-of select="current()"></xsl:value-of> </NameofCopyrightOwner>
                </xsl:for-each>
                <CopyrightStatement> <xsl:value-of select="Copyright/CopyrightStatement"></xsl:value-of> </CopyrightStatement>
                <xsl:for-each select="Copyright/DescriptionofAuthorizedUse">
                    <DescriptionofAuthorizedUse>
                        <NameofAuthorizedUser> <xsl:value-of select="NameofAuthorizedUser"></xsl:value-of> </NameofAuthorizedUser>
                        <AuthorizedWayofUsage> <xsl:value-of select="AuthorizedWayofUsage"></xsl:value-of> </AuthorizedWayofUsage>
                        <AuthorizedDateofStart> <xsl:value-of select="AuthorizedDateofStart"></xsl:value-of> </AuthorizedDateofStart>
                        <AuthorizedDeadline> <xsl:value-of select="AuthorizedDeadline"></xsl:value-of> </AuthorizedDeadline>
                        <AuthorizedGeographicArea> <xsl:value-of select="AuthorizedGeographicArea"></xsl:value-of> </AuthorizedGeographicArea>
                        <TimesofAuthorizedUsage> <xsl:value-of select="TimesofAuthorizedUsage"></xsl:value-of> </TimesofAuthorizedUsage>
                        <OtherInformation> <xsl:value-of select="OtherInformation"></xsl:value-of> </OtherInformation>
                    </DescriptionofAuthorizedUse>
                </xsl:for-each>
            </Copyright>
            <Language>
                <xsl:for-each select="Language/AudioChannel">
                    <AudioChannel>
                        <AudioChannelNumber> <xsl:value-of select="AudioChannelNumber"></xsl:value-of> </AudioChannelNumber>
                        <AudioChannelLanguage> <xsl:value-of select="AudioChannelLanguage"></xsl:value-of> </AudioChannelLanguage>
                    </AudioChannel>
                </xsl:for-each>
                <xsl:for-each select="Language/Subtitle">
                    <Subtitle>
                        <SubtitleNumber> <xsl:value-of select="SubtitleNumber"></xsl:value-of> </SubtitleNumber>
                        <SubtitleLanguage> <xsl:value-of select="SubtitleLanguage"></xsl:value-of> </SubtitleLanguage>
                    </Subtitle>
                </xsl:for-each>
            </Language>
            <Date>
                <ProducedDate> <xsl:value-of select="Date/ProducedDate"></xsl:value-of> </ProducedDate>
                <DateofDebut> <xsl:value-of select="Date/Debut/DateofDebut"></xsl:value-of> </DateofDebut>
                <PublishedDate> <xsl:value-of select="Date/PublishedDate"></xsl:value-of> </PublishedDate>
            </Date>
            <Type>
                <xsl:for-each select="Type/ProgramType">
                    <ProgramType> <xsl:value-of select="current()"></xsl:value-of> </ProgramType>
                </xsl:for-each>
                <xsl:for-each select="Type/ProgramForm">
                    <ProgramForm> <xsl:value-of select="current()"></xsl:value-of> </ProgramForm>
                </xsl:for-each>
            </Type>
            <Format>
                <Duration><xsl:value-of select="Format/Duration"></xsl:value-of></Duration>
                <StartingPoint><xsl:value-of select="Format/StartingPoint"></xsl:value-of></StartingPoint>
                <Color><xsl:value-of select="Format/Color"></xsl:value-of></Color>
                <SubtitleForm><xsl:value-of select="Format/SubtitleForm"></xsl:value-of></SubtitleForm>
                <AudioChannelFormat><xsl:value-of select="Format/AudioChannelFormat"></xsl:value-of></AudioChannelFormat>
                <AudioQuality><xsl:value-of select="Format/AudioQuality"></xsl:value-of></AudioQuality>
                <VideoQuality><xsl:value-of select="Format/VideoQuality"></xsl:value-of></VideoQuality>
                <AspectRatio><xsl:value-of select="Format/AspectRatio"></xsl:value-of></AspectRatio>
                <PhysicalMediaType><xsl:value-of select="Format/PhysicalMediaType"></xsl:value-of></PhysicalMediaType>
                <System><xsl:value-of select="Format/System"></xsl:value-of></System>
                <AudioDataRate><xsl:value-of select="Format/AudioDataRate"></xsl:value-of></AudioDataRate>
                <AudioCodingFormat><xsl:value-of select="Format/AudioCodingFormat"></xsl:value-of></AudioCodingFormat>
                <AudioSamplingFrequency><xsl:value-of select="Format/AudioSamplingFrequency"></xsl:value-of></AudioSamplingFrequency>
                <AudioBitDepth><xsl:value-of select="Format/AudioBitDepth"></xsl:value-of></AudioBitDepth>
                <VideoBitrate><xsl:value-of select="Format/VideoBitRate"></xsl:value-of></VideoBitrate>
                <VideoCodingFormat><xsl:value-of select="Format/VideoCodingFormat"></xsl:value-of></VideoCodingFormat>
                <VideoSamplingType><xsl:value-of select="Format/VideoSamplingType"></xsl:value-of></VideoSamplingType>
                <FileFormat><xsl:value-of select="FileFormat"></xsl:value-of></FileFormat>
            </Format>
            <Identifier>
                <ISRC><xsl:value-of select="Identifier/ISRC"></xsl:value-of></ISRC>
                <RelationsID><xsl:value-of select="Identifier/RelationsID"></xsl:value-of></RelationsID>
            </Identifier>
            <Coverage>
                <xsl:for-each select="Coverage/YearsCovered">
                    <YearofStart><xsl:for-each select="YearofStart"></xsl:for-each></YearofStart>
                    <YearofEnd><xsl:for-each select="YearofEnd"></xsl:for-each></YearofEnd>
                    <DescriptionofYeasCovered><xsl:for-each select="DescriptionofYearsCovered"></xsl:for-each></DescriptionofYeasCovered>
                </xsl:for-each>
                <xsl:for-each select="Coverage/Spatial">
                    <Spatial><xsl:value-of select="current()"></xsl:value-of></Spatial>
                </xsl:for-each>
            </Coverage>
            <Source>
                <AcquiringMethodofSource><xsl:value-of select="Source/AcquiringMethodofSource"></xsl:value-of></AcquiringMethodofSource>
                <SourceProvider><xsl:value-of select="Source/SourceProvider"></xsl:value-of></SourceProvider>
            </Source>
            <Relation>
                <PartofSeries><xsl:value-of select="Relation/PartofSeries"></xsl:value-of></PartofSeries>
                <IsPartof><xsl:value-of select="Relation/IsPartof"></xsl:value-of></IsPartof>
                <xsl:for-each select="Relation/HasPart">
                    <HasPart><xsl:value-of select="current()"></xsl:value-of></HasPart>
                </xsl:for-each>
                <xsl:for-each select="Relation/References">
                    <References><xsl:value-of select="current()"></xsl:value-of></References>
                </xsl:for-each>
                <xsl:for-each select="Relation/IsReferencedby">
                    <IsReferencedby><xsl:value-of select="current()"></xsl:value-of></IsReferencedby>
                </xsl:for-each>
                <Replaces><xsl:value-of select="Relation/Replaces"></xsl:value-of></Replaces>
                <IsReplacedby><xsl:value-of select="Relation/IsRepalcedby"></xsl:value-of></IsReplacedby>
                <xsl:for-each select="Relation/Requires">
                    <Requires><xsl:value-of select="current()"></xsl:value-of></Requires>
                </xsl:for-each>
                <xsl:for-each select="Relation/IsRequiredby">
                    <IsRequiredby><xsl:value-of select="current()"></xsl:value-of></IsRequiredby>
                </xsl:for-each>
                <IsVersionof><xsl:value-of select="Relation/IsVersionof"></xsl:value-of></IsVersionof>
                <xsl:for-each select="Relation/HasVersionof">
                    <HasVersionof><xsl:value-of select="current()"></xsl:value-of></HasVersionof>
                </xsl:for-each>
            </Relation>
        </Program>
        </MetaData>
    </xsl:template>
    <xsl:template match="text()"/>
</xsl:stylesheet>
