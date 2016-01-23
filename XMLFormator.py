from lxml import etree


def transform(xmlPath, xslPath):
    # read xsl file
    xslRoot = etree.fromstring(open(xslPath, encoding='utf-8').read())

    transform = etree.XSLT(xslRoot)

    # read xml
    xmlRoot = etree.fromstring(open(xmlPath, encoding='utf-8').read())

    # transform xml with xslt
    transRoot = transform(xmlRoot)

    # return transformation result
    return etree.tostring(transRoot, encoding='utf-8')


if __name__ == '__main__':
    ans = transform('2.xml', '2.xsl')
    with open('out.xml', 'w', encoding='utf-8') as outFile:
        outFile.write(ans.decode("utf-8"))
