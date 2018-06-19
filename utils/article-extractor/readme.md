## Article extraction utility

The utility extracts an article content from a web-page. The utility reads input from an Excel document named 
`CryptoJournalists.xls` with the following pre-defined structure:

| Column index | Type of data | example |
| ------------ | ------------ | ------- |
| 0 | Author name | Aaron Hankin |
| 1 | Publication name | Investopedia |
| 6 | Article URL | https://www.investopedia.com/news/us-government-loses-2-billion-early-bitcoin-trade/ |

Every URL is then crawled and the retrieved page content is scrapped using the 
[Boilerplate](https://github.com/kohlschutter/boilerpipe) library which filters all the garbage and extracts only the
article content. Since the scrapping algorithm is heuristic the results are not 100% precise. Invalid or inaccessible URLs
printed out to console adn stored to the `failed.out` file.

The extracted article is then saved as text to a file in the /articles directory with the following file name pattern:

```
(Author name)-(Publication name).txt
```

Example:

### How to build

```mvn clean install```

### How to run

* Run the `ArticleExtractorUtilRunner` class from your IDE, or
* Run `mvn exec:java -Dexec.mainClass="org.chainmap.util.ArticleExtractorUtilRunner"`

### Utility configuration

Both pre-defined input Excel file name `CryptoJournalists.xls` and the output directories can be configured in the 
`ArticlesExtractorUtilRunner` java class.