from lxml import etree


def transform(xmlPath, xslPath):
    # read xsl file
    xslRoot = etree.fromstring(open(xslPath).read())

    transform = etree.XSLT(xslRoot)

    # read xml
    xmlRoot = etree.fromstring(open(xmlPath).read())

    # transform xml with xslt
    transRoot = transform(xmlRoot)

    # return transformation result
    return etree.tostring(transRoot)


if __name__ == '__main__':
    ans = transform('sample.xml', 'sample.xsl')
    with open('out.xml', 'w') as outFile:
        outFile.write(ans.decode("utf-8"))
