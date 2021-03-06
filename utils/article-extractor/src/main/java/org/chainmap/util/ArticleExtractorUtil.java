package org.chainmap.util;

import org.apache.commons.io.FileUtils;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.usermodel.WorkbookFactory;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.File;
import java.io.IOException;
import java.net.URL;
import java.nio.charset.Charset;
import java.util.*;

import static com.google.common.base.Preconditions.checkNotNull;
import static org.apache.commons.lang3.StringUtils.isBlank;

public class ArticleExtractorUtil {
    private static final Logger LOG = LoggerFactory.getLogger(ArticleExtractorUtil.class);
    public static final String DEFAULT_ENCODING = "UTF-8";
    private static final String LINE_SEPARATOR = System.getProperty("line.separator");
    private static File failedExtractionsFile;

    private String excelFileName;
    private String outputDir;

    public ArticleExtractorUtil(String excelFileName, String outputDir) {
        this.excelFileName = excelFileName;
        this.outputDir = outputDir;

        failedExtractionsFile = new File(outputDir + File.separator + "failed-extractions.out");
    }

    public void extract() throws Exception {
        extract(0);
    }

    public void extract(int skipRows) throws Exception {
        ClassLoader classLoader = ClassLoader.getSystemClassLoader();
        URL url = classLoader.getResource(excelFileName);

        checkNotNull(url, "Input file not found");

        File file = new File(url.getFile());

        Workbook wb = WorkbookFactory.create(file);
        Sheet sheet = wb.getSheetAt(0);
        Iterator<Row> rowIterator = sheet.rowIterator();

        skipHeaders(rowIterator);

        Set<InputInfo> failed = new HashSet<>();
        int rowIndex = 1 + skipRows;

        while (rowIterator.hasNext()) {
            InputInfo info = new InputInfo(rowIterator.next(), rowIndex);

            if (isBlank(info.getAuthorName()) || isBlank(info.getPublicationName())) {
                LOG.warn("Skip row [{}]: both author name and publication name must be provided.", rowIndex);
            } else {
                LOG.info("File name {}, articleUrl {}", info.getFileName(), info.getArticleUrl());

                try {
                    WebPageCrawler webPageCrawler = new WebPageCrawler(info.getArticleUrl());
                    String crawled = webPageCrawler.crawl();

                    if (!isBlank(crawled)) {
                        ArticleScrapper scrapper = new ArticleScrapper(crawled.getBytes());
                        String content = scrapper.scrap();

                        content += getFooter(info);

                        FileUtils.writeStringToFile(new File(outputDir + File.separator + info.getFileName()), content, Charset.forName("UTF-8"));
                    }
                } catch (Exception e) {
                    LOG.error("Failed to get article from {}", info.getArticleUrl(), e.getMessage());
                    reportFailedExtraction(info);
                    failed.add(info);
                }
            }

            rowIndex++;
        }

        if (!failed.isEmpty()) {
            LOG.info("{} articles were not crawled/scrapped.", failed.size());

            for (InputInfo info : failed) {
                LOG.info("Manual retrieval required from {} to file {}", info.getArticleUrl(), info.getFileName());
            }
        }
    }

    private void skipHeaders(Iterator<Row> rit) {
        if (rit.hasNext()) {
            rit.next();
        }
    }

    private String getFooter(InputInfo info) {
        StringBuilder sb = new StringBuilder();

        sb.append(LINE_SEPARATOR).
                append(LINE_SEPARATOR).
                append("Original link: ").
                append(info.getArticleUrl()).
                append(LINE_SEPARATOR);

        return sb.toString();
    }

    private void reportFailedExtraction(InputInfo info) throws IOException {
        StringBuilder failed = new StringBuilder();

        failed.
                append("Failed to retrieve ").
                append(info.getArticleUrl()).
                append(" to file ").
                append(info.getFileName()).
                append(LINE_SEPARATOR);

        FileUtils.writeStringToFile(
                failedExtractionsFile,
                failed.toString(),
                Charset.forName("UTF-8"),
                true
        );
    }

    static class InputInfo {
        private Row row;
        private int rowIndex;

        public InputInfo(Row row, int rowIndex) {
            this.row = row;
            this.rowIndex = rowIndex;
        }

        public String getAuthorName() {
            return this.row.getCell(0).getStringCellValue();
        }

        public String getPublicationName() {
            return this.row.getCell(1).getStringCellValue();
        }

        public String getArticleUrl() {
            return this.row.getCell(6).getStringCellValue();
        }

        public int getRowIndex() {
            return this.rowIndex;
        }

        public String getFileName() {
            StringBuilder sb = new StringBuilder();
            sb.
                    append(String.format("%03d", getRowIndex())).
                    append("-").
                    append(normalizeString(getAuthorName())).
                    append("-").
                    append(normalizeString(getPublicationName())).
                    append(".txt");

            return sb.toString();
        }

        private String normalizeString(String s) {
            s = s.toLowerCase().
                    trim().
                    replaceAll("[^A-Za-z0-9]", "-");
            return s;
        }
    }
}

