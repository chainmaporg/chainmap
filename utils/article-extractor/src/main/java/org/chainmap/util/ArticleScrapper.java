package org.chainmap.util;

import de.l3s.boilerpipe.document.TextDocument;
import de.l3s.boilerpipe.extractors.CommonExtractors;
import de.l3s.boilerpipe.sax.BoilerpipeSAXInput;
import de.l3s.boilerpipe.sax.HTMLDocument;

import java.nio.charset.Charset;

import static org.chainmap.util.ArticleExtractorUtil.DEFAULT_ENCODING;

public class ArticleScrapper {
    private byte[] content;

    public ArticleScrapper(byte[] content) {
        this.content = content;
    }

    public String scrap() throws Exception {
        HTMLDocument htmlDoc = new HTMLDocument(content, Charset.forName(DEFAULT_ENCODING));
        TextDocument doc = new BoilerpipeSAXInput(htmlDoc.toInputSource()).getTextDocument();

        return CommonExtractors.ARTICLE_EXTRACTOR.getText(doc);
    }
}
