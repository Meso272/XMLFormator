from lxml import etree


def transform(xmlPath, xslPath):
    # read xsl file
    xslRoot = etree.parse(open(xslPath, encoding='utf-8'))
    transformer = etree.XSLT(xslRoot)
    # read xml
    xmlRoot = etree.parse(open(xmlPath, encoding='utf-8'))
    # transform xml with xslt
    transRoot = transformer(xmlRoot)
    return etree.tostring(transRoot, encoding='utf-8')


if __name__ == '__main__':
    ans = transform('2.xml', '2.xsl')
    with open('out.xml', 'w', encoding='utf-8') as outFile:
        outFile.write(ans.decode("utf-8"))
