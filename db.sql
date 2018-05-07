/**Loging Info:
mysql -uroot (password: the famous one)
use rsdb
mysql> show tables;
+----------------+
| Tables_in_rsdb |
+----------------+
| challenges     |
| materials      |
| users          |
+----------------+
3 rows in set (0.00 sec)

/*

 CREATE TABLE `users` (
    `id` int(11) NOT NULL AUTO_INCREMENT,
    `email` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
    `password` varchar(40) COLLATE utf8_unicode_ci NOT NULL,
    `primarycat` varchar(40) COLLATE utf8_unicode_ci NOT NULL,  
    `partneryes` varchar(10) COLLATE utf8_unicode_ci NOT NULL,
    `teamneeds` varchar(300) COLLATE utf8_unicode_ci NOT NULL,
    `location` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
    `created` datetime NOT NULL,
    `modified` datetime NOT NULL,
    PRIMARY KEY (`id`)
   ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
    
    
CREATE TABLE `materials` (
          `id` int(11) NOT NULL AUTO_INCREMENT,
          `type` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
        `description` varchar(300) COLLATE utf8_unicode_ci NOT NULL,
        `link` varchar(500) COLLATE utf8_unicode_ci NOT NULL,
        `name` varchar(150) COLLATE utf8_unicode_ci NOT NULL,       
        `created` datetime NOT NULL,
       PRIMARY KEY (`id`)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `challenges` (
          `id` int(11) NOT NULL AUTO_INCREMENT,
          `type` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
        `description` varchar(2000) COLLATE utf8_unicode_ci NOT NULL,
        `eventlink` varchar(500) COLLATE utf8_unicode_ci NOT NULL,
        `learninginfo` varchar(500) COLLATE utf8_unicode_ci NOT NULL,
        `name` varchar(150) COLLATE utf8_unicode_ci NOT NULL,
        `git` varchar(300) COLLATE utf8_unicode_ci NOT NULL,
        `created` datetime NOT NULL,
       PRIMARY KEY (`id`)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
*/


/*----Challenge Table Loading---*/
INSERT INTO challenges (type, name, description, eventlink, learninginfo, git, created) VALUES('coding', 'Nebulas Incentive Program Q1', "Nebulas officially announced the start of the Nebulas Incentive Program on April 27, 2018. From 00:00 on May 7th, 2018 to 00:00 on July 2nd, 2018, Beijing time, all developers and their referrers who successfully submit DApps on the Nebulas mainnet can receive NAS coin rewards.For developers, the Weekly Excellent Application rewards 10,000 NAS, and the Monthlyreward, 20,000 NAS. The total reward of this program amounts to 460,000 NAS (according to the price on May 1, it is more than $4.5 million).", 'https://incentive.nebulas.io/signup.html?invite=37J5U', 'https://www.reddit.com/r/nebulas/comments/8fi47r/nebulas_developers_questions_and_support_resources/','https://github.com/nebulasio',NOW());

INSERT INTO challenges (type, name, description, eventlink, learninginfo, git, created) VALUES('coding', 'Exchange Union', 'Check our White Paper (Overview) to get a general idea of what Exchange Union is about, how it functions along with examples of use cases. Dive into our Technical Paper to learn about the technological innovations which power Exchange Union.', 'https://www.exchangeunion.com/developer', 'https://github.com/ExchangeUnion/Docs/blob/master/How-to-contribute.md','https://github.com/ExchangeUnion',NOW());

/*----Material Table Loading---*/
INSERT INTO materials (type, name, description, link, created) VALUES('training','Ethereum Homestead Documentation','This documentation is the result of an ongoing collaborative effort by volunteers from the Ethereum Community. Although it has not been authorized by the The Ethereum Foundation, we hope you will find it useful. We Welcome new Contrubtion','http://www.ethdocs.org/en/latest/index.html',NOW());
INSERT INTO materials (type, name, description, link, created) VALUES('training','Solidity','Solidity is a contract-oriented, high-level language for implementing smart contracts. It was influenced by C++, Python and Javascript and is designed to target the Ethereum Virtual Machine','https://solidity.readthedocs.io/en/v0.4.23/',NOW());
INSERT INTO materials (type, name, description, link, created) VALUES('training','Ethereum Org','Ethereum Foundation main website. Learn what Ethereum is and how it works. There is also video and training material on the website.','https://www.ethereum.org',NOW());
INSERT INTO materials (type, name, description, link, created) VALUES('training','Consensus Academy','We have curated a selection of the best resources on Ethereum and blockchain to get you up to speed.','https://consensys.net/academy/resources/',NOW());
INSERT INTO materials (type, name, description, link, created) VALUES('training','Blockchain at Berkley - Resources','Resources and presentations that where created by Berkley Students and faculty.','https://blockchain.berkeley.edu/resources/ ',NOW());
INSERT INTO materials (type, name, description, link, created) VALUES('training','Blockchain at Berkley - Workshops','Workshops with a wide variety of Blockchain education.','https://blockchain.berkeley.edu/workshops/ ',NOW());
INSERT INTO materials (type, name, description, link, created) VALUES('training','Bitcoin Developer Guide','Find detailed information about the Bitcoin protocol and related specification','https://bitcoin.org/en/developer-guide',NOW());
INSERT INTO materials (type, name, description, link, created) VALUES('training','Blockchain At Berkley','Presentation on white papers for different blockchain projects.','https://blockchain.berkeley.edu/whitepapercircle/',NOW());
INSERT INTO materials (type, name, description, link, created) VALUES('training','Blockgeeks how to','Different do it yourself guides to get you started on programming your own Blockchain project','https://blockgeeks.com/guides/',NOW());
INSERT INTO materials (type, name, description, link, created) VALUES('training','IBM - Blockchain for Dummies','Blockchain Technology presents opportunities for disruptive innovation. It enables global business transactions with less friction and more trust.','https://www.ibm.com/blockchain/what-is-blockchain.html?S_PKG=CoG&cm_mmc=Search_Google-_-Blockchain_Blockchain-_-WW_NA-_-+Blockchain_Broad_CoG&cm_mmca1=000020YK&cm_mmca2=10005804&cm_mmca7=9031942&cm_mmca8=aud-365774027721:kwd-305134168301&cm_mmca9=af72a335-a407-4819-a78f-b185d2733864&cm_mmca10=218843303200&cm_mmca11=b&mkwid=af72a335-a407-4819-a78f-b185d2733864%7C1298%7C243&cvosrc=ppc.google.%2Bblockchain&cvo_campaign=000020YK&cvo_crid=218843303200&Matchtype=b',NOW());
INSERT INTO materials (type, name, description, link, created) VALUES('training','Bitcoin GitHub','Start to contribute by going to git hub and tackling some of the projects!','https://github.com/bitcoin/bitcoin ',NOW());
INSERT INTO materials (type, name, description, link, created) VALUES('training','Bitcoin and Cryptocurrency Technologies','Princenton recorded presentations on the Basics of Blockchain','https://www.youtube.com/channel/UCNcSSleedtfyDuhBvOQzFzQ',NOW());

  
