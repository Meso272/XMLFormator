from lxml import etree


def transform(xmlPath, xslPath, xmlencoding='utf-8', xslencoding='utf-8'):
    # read xsl file
    xslRoot = etree.parse(open(xslPath, encoding=xslencoding))
    transformer = etree.XSLT(xslRoot)
    # read xml
    xmlRoot = etree.parse(open(xmlPath, encoding=xmlencoding))
    # transform xml with xslt
    transRoot = transformer(xmlRoot)
    return etree.tostring(transRoot, encoding='utf-8')


if __name__ == '__main__':
    ans = transform('3.xml', '3.xsl', 'utf-16', 'utf-8')
    with open('out.xml', 'w', encoding='utf-8') as outFile:
        outFile.write(ans.decode("utf-8"))
