package org.chainmap.util;

import org.apache.commons.io.IOUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.net.HttpURLConnection;
import java.net.URL;

import static org.apache.commons.lang3.StringUtils.isBlank;
import static org.chainmap.util.ArticleExtractorUtil.DEFAULT_ENCODING;

public class WebPageCrawler {
    private static final Logger LOG = LoggerFactory.getLogger(WebPageCrawler.class);
    private static final String USER_AGENT_VALUE =
            "Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.11 (KHTML, like Gecko) Chrome/23.0.1271.95 Safari/537.11";

    private HttpURLConnection connection;

    public WebPageCrawler(String url) throws Exception {
        connection = newConnection(url);
    }

    private HttpURLConnection newConnection(String url) throws Exception {
        HttpURLConnection connection = (HttpURLConnection) new URL(url).openConnection();

        connection.setRequestMethod("GET");
        connection.setReadTimeout(15_000);
        connection.setRequestProperty("User-Agent", USER_AGENT_VALUE);

        return connection;
    }

    public String crawl() throws Exception {
        boolean redirectDetected = false;

        int statusCode = connection.getResponseCode();

        if (statusCode != HttpURLConnection.HTTP_OK) {
            if (statusCode == HttpURLConnection.HTTP_MOVED_TEMP ||
                    statusCode == HttpURLConnection.HTTP_MOVED_PERM ||
                    statusCode == HttpURLConnection.HTTP_SEE_OTHER ||
                    statusCode == 308)

                redirectDetected = true;
        }

        if (redirectDetected) {
            connection = newConnection(connection.getHeaderField("Location"));
        }

        String content = IOUtils.toString(connection.getInputStream(), DEFAULT_ENCODING);
        connection.getInputStream().close();

        if (isBlank(content)) {
            LOG.warn("Crawled a blank page from  {}. Status code: {}", connection.getURL(), connection.getResponseCode());
        }

        return content;
    }
}
