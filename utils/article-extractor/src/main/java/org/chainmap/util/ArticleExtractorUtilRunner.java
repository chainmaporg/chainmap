package org.chainmap.util;

public class ArticleExtractorUtilRunner {
    private static final String INPUT_XLS_FILE_NAME = "CryptoJournalists.xlsx";
    private static final String OUTPUT_DIR = "articles";

    public static void main(String[] args) throws Exception {
        ArticleExtractorUtil util = new ArticleExtractorUtil(INPUT_XLS_FILE_NAME, OUTPUT_DIR);
        util.extract();
    }
}
