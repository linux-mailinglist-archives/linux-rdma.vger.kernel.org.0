Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B88D930E581
	for <lists+linux-rdma@lfdr.de>; Wed,  3 Feb 2021 23:04:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232270AbhBCWC0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 3 Feb 2021 17:02:26 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:34772 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232869AbhBCWCC (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 3 Feb 2021 17:02:02 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 113LxhRY193663;
        Wed, 3 Feb 2021 22:01:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2020-01-29;
 bh=X5ASRJoQeYxm6UfOnHd3bOScEfbBCULqmJMp0gLXSiI=;
 b=xfAxIolVIUxsqbdZBg1iljOtrYxFYje1H+fjcMSnJKnXVAkuUcm16H7pAhgmDOetvVzE
 YyZorZmq0PFe1oqdc3phv+DYDeYvJ/M81nlhcXcY9jYH5UX4XCQBpK/NJJQr4XHTsgMZ
 7fbNLx9CwF5QxvRlR1ZVupsUNa7iHe1oRzXjHJFF01GutN5dLW8bXsPin52aIfzgo4kE
 2+yXSOdzFaA596qIzCNNUkRrMghcr1lw4oAwCDmkILTko6FJbpsjW5f3iM0JKsVeUQxw
 9MHaGMFIJVAr6TgMg5ca+6ItfBc3PIZCcp7QF1xDgdlmID4CkrE8qBEFtwWd6uPd9gVZ WQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 36cydm2e44-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 Feb 2021 22:01:12 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 113M157f042797;
        Wed, 3 Feb 2021 22:01:11 GMT
Received: from nam02-bl2-obe.outbound.protection.outlook.com (mail-bl2nam02lp2058.outbound.protection.outlook.com [104.47.38.58])
        by aserp3020.oracle.com with ESMTP id 36dhc1t3e9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 Feb 2021 22:01:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BKz2QBtGVA5agCvQ48QQqDoUbbm03nK9pveYiXzsW6R4yMdyPGnCoV1PKVxNvmLaH31UcLgNQpf+pYfTXRNNdVVPLrOodYDFXigOmntdo5Quw22XGYJLPWF53d8ja/mirgwr9qPdK+L6bFkOpXuTZkVq+QpQFLXvoOydkJ8gfaW0LMFr1xVqU6Cu49bVKiLMiD6B/QXxBnQ+W4rhPiAkKni3H1u1kGm5T3oV//qEqe/6s+pu9u8Op7uxV8xiQMezbbbYigp2ZXKTFQrARw0y4hzlHEFtkifcNWIs/KchTPv3MHzTHjjZ1jaSryEdj3aKmDR5bp/QYOZLJuy9yE6dvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X5ASRJoQeYxm6UfOnHd3bOScEfbBCULqmJMp0gLXSiI=;
 b=DFaisX429Qy+hc1MT20H6JRa3CTiZsMlXs12QC3D7RcK7Ym4yCBIK6YReLL5S990POzM4jkQ/rBO7cmjBMguHIICencwQwNeYiqQkBU3AMyUU/RI9b/+oICDMvcHysbcuVxuo3D6ZS7ftfJ5tMVG0HnCw5UtorXE1DtC8qOIGKsMLHT4w156qje+vy0atZSX7H5UjC0z00IKA5DsybAfXCjRxXA/GpjSrp1fUotyzv4sBr5D86xlGiO+Ab4HAf+FV3nLbAay10VLZegadBgzxrdjvF2wa1t1YRFJGS63xlmnPkw1nI53kbQNUlIb0BjX7omkk7ce9TT6iegc9cgonQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X5ASRJoQeYxm6UfOnHd3bOScEfbBCULqmJMp0gLXSiI=;
 b=nu5OPkJlM6NCjSzOrDoacmAFmHcSR9bz5rx0V5yi3z4drs5yzs3OUXHWqWyMznCt6N5EFK3fxIDC/JMDV0lwBYPna1jAOvblhpw2ZiHw1FElTTkqyDn2sfbBCbeQ53zkQuyNw6uXgr/p6H3967WaiCrvUYLO712n7eXSsQ2wGyU=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=oracle.com;
Received: from BYAPR10MB3077.namprd10.prod.outlook.com (2603:10b6:a03:8c::12)
 by BYAPR10MB3735.namprd10.prod.outlook.com (2603:10b6:a03:11e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.23; Wed, 3 Feb
 2021 22:01:06 +0000
Received: from BYAPR10MB3077.namprd10.prod.outlook.com
 ([fe80::74a8:8649:e20b:d571]) by BYAPR10MB3077.namprd10.prod.outlook.com
 ([fe80::74a8:8649:e20b:d571%7]) with mapi id 15.20.3805.024; Wed, 3 Feb 2021
 22:01:06 +0000
From:   Joao Martins <joao.m.martins@oracle.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Doug Ledford <dledford@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Matthew Wilcox <willy@infradead.org>,
        Joao Martins <joao.m.martins@oracle.com>
Subject: [PATCH 3/4] mm/gup: add a range variant of unpin_user_pages_dirty_lock()
Date:   Wed,  3 Feb 2021 22:00:24 +0000
Message-Id: <20210203220025.8568-4-joao.m.martins@oracle.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20210203220025.8568-1-joao.m.martins@oracle.com>
References: <20210203220025.8568-1-joao.m.martins@oracle.com>
Content-Type: text/plain
X-Originating-IP: [94.61.1.144]
X-ClientProxiedBy: LO4P123CA0266.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:194::19) To BYAPR10MB3077.namprd10.prod.outlook.com
 (2603:10b6:a03:8c::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from paddy.uk.oracle.com (94.61.1.144) by LO4P123CA0266.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:194::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3825.17 via Frontend Transport; Wed, 3 Feb 2021 22:01:03 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 03284ce4-822e-4c91-5521-08d8c88f349e
X-MS-TrafficTypeDiagnostic: BYAPR10MB3735:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR10MB37352AC88347377AB202B544BBB49@BYAPR10MB3735.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2089;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l9yoZyJklCyqv3WH+QQmF04veckKe083WF6WAFZqFjniOFYzRsQd7r+DbN7Dzd1IWOYJTNIwTV1dQOpnIEAmwLune7WBZruLYe950TWJq8Jz+/X/12/jrz8m2QsRkaIaHfVoA6qvlIuCTe5TR7tBxjpAPQgG0XCs3K5XzzveHzM5EvoIQ1KsD3AUMgEBc0EBBvLFH889ubivut3MuDaJHmKXE42YORiQ7/y8ICsmiausXoIc7U4ZLLFre5/Bjwa5DZPE/IpFTp7b6JSUV/R3uq35CbCFb+eDBeDtbih3hIH23VJr2fk/639xzxQe0DwG7RhC980qeLpObFb0g8tj4Rmca5Ex9QfPYRLsbdIxqhditRwUB8qC4Zj+HFyP+P5MceXzbQM0BImLD/LVQxA9OHzOUZaKwKTUjjCccsA2fP9Zk6kf3F4GiJSc9BTFXQiOx+dXd7SjoW72QSadAycvKGbQrsirJCrjiJys4QGsEta4GKwwMl5tKxFF/1uxEL7jPbBMeRo7qoTaBeHUJ8i3kuDR9Mk6na0CfnuyVFUm+H+Y4CsXBVKZUnYEYsZwjlPE
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3077.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(39860400002)(366004)(136003)(346002)(396003)(66556008)(54906003)(6486002)(316002)(186003)(2616005)(956004)(16526019)(107886003)(4326008)(26005)(66476007)(66946007)(1076003)(103116003)(52116002)(7696005)(6666004)(86362001)(83380400001)(36756003)(8676002)(2906002)(478600001)(8936002)(5660300002)(6916009)(14143004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?tmYQZRB6+eJBZtAF1LH2gtG7aiR3Lkh1Q8hQWhrApI2xXzY8DHy2oVxHuz4o?=
 =?us-ascii?Q?MqD1td7rWZBu2LVFBbXH8K7PlOikq4w2FoT0bjdkF8O+sNHmZ42rTZRBtMnG?=
 =?us-ascii?Q?D1W9khXDOjH5GgO6/uU5rN1372wSdbtACStcmdxnMCJgnGAqL9PcSLgSVUM9?=
 =?us-ascii?Q?kllfrW3aVD5f9kSRehqP/nk9KgFphtoXFBfSm9JUKKY6kcFtKJnujTlHVr/f?=
 =?us-ascii?Q?MgEjgcXRiXPBy+xcwyhOoeArC/zYAiTu9TE9daJ6QzCqV8DOQYo0eNEa5l/r?=
 =?us-ascii?Q?k+posK3l+wWLQplFKCtLOnOk3dd3GW/wnLiFg2e2vHvKkiySJ3/X8hOF0WUD?=
 =?us-ascii?Q?cNgE8JltaV2eKHKydjHyt01yJ4iSW5YDD8DhUvvlmRGJQwtpC9B0IgjErotz?=
 =?us-ascii?Q?Skxpfo1PCBx61wEu2GBl5GqoYR64XDUlDwYn5fpJ+Ry1BNWPQL77uXWnEU3V?=
 =?us-ascii?Q?7pCysvn2jgie0vTgagBmcd+fZJcHb5lAHUWWgTxlt9SJ24Q3yJ+15SXdCbXp?=
 =?us-ascii?Q?jL69SK8A9LqUOaZi9ywJOYXRfsCT54YlUKkweFzC4dYFzqY0A3uj3x81orIS?=
 =?us-ascii?Q?YGsOY3c1i7NOIxt0SPFMm4zXwqrIqjxuqWPBlrklJBeaQ0U/7YJYaepOIJuF?=
 =?us-ascii?Q?wS5wRw0rX8Fnqc3/a2CauuMS8+yjiR3bHTwZ11qubOkcHCf7MiyVc7+DDYrg?=
 =?us-ascii?Q?eTLPajXEWTFBUx/umYVLFvRbkM7Nmms8uYe8WI+o8vsPSgLnU8N/3/83NLWn?=
 =?us-ascii?Q?YoqKuZWF3e9e8WFNMRsmVpz7ChTWuFe30uwGTjolxISX14IEYeF8OQyo6DbF?=
 =?us-ascii?Q?pXPJUpnx8eXYcuIbzMjtBkOcsUYkH5HgR3zFJsI+f+q1hID1t4kWulbGAml5?=
 =?us-ascii?Q?/Vw3W6yHlxpx+K0xTS87mzI+3mBSPAk74cbtSa046WOlt3qKG1OY8mHi1jCV?=
 =?us-ascii?Q?KrOEplXpOj9FUF6jjowcXwvbvpVevCDiNcDr9gG9D+pDPw6uZkmvkAiv9ji/?=
 =?us-ascii?Q?JU0HIj/Ji9j35UD41VJXDKgCLxtwKp9hhl18oM24AiPfFxvVVabOOdPRCTvd?=
 =?us-ascii?Q?sMyUdykI?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03284ce4-822e-4c91-5521-08d8c88f349e
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3077.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2021 22:01:06.3344
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 78mq/widpJGjBsTpGtAQZc6ec5bkp61BbOLxKK/hU73eO43V51+XvTt0oySKYXjJi3djGzUXVZGqpF+xiaCHc7IPPHeasA4lc95VoW35Tts=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3735
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9884 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 suspectscore=0
 spamscore=0 mlxscore=0 malwarescore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102030133
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9884 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 clxscore=1015
 spamscore=0 lowpriorityscore=0 phishscore=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102030133
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Add a unpin_user_page_range() API which takes a starting page
and how many consecutive pages we want to dirty.

Given that we won't be iterating on a list of changes, change
compound_next() to receive a bool, whether to calculate from the starting
page, or walk the page array. Finally add a separate iterator,
for_each_compound_range() that just operate in page ranges as opposed
to page array.

For users (like RDMA mr_dereg) where each sg represents a
contiguous set of pages, we're able to more efficiently unpin
pages without having to supply an array of pages much of what
happens today with unpin_user_pages().

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
---
 include/linux/mm.h |  2 ++
 mm/gup.c           | 48 ++++++++++++++++++++++++++++++++++++++--------
 2 files changed, 42 insertions(+), 8 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index a608feb0d42e..b76063f7f18a 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1265,6 +1265,8 @@ static inline void put_page(struct page *page)
 void unpin_user_page(struct page *page);
 void unpin_user_pages_dirty_lock(struct page **pages, unsigned long npages,
 				 bool make_dirty);
+void unpin_user_page_range_dirty_lock(struct page *page, unsigned long npages,
+				      bool make_dirty);
 void unpin_user_pages(struct page **pages, unsigned long npages);
 
 /**
diff --git a/mm/gup.c b/mm/gup.c
index 971a24b4b73f..1b57355d5033 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -215,11 +215,16 @@ void unpin_user_page(struct page *page)
 }
 EXPORT_SYMBOL(unpin_user_page);
 
-static inline unsigned int count_ntails(struct page **pages, unsigned long npages)
+static inline unsigned int count_ntails(struct page **pages,
+					unsigned long npages, bool range)
 {
-	struct page *head = compound_head(pages[0]);
+	struct page *page = pages[0], *head = compound_head(page);
 	unsigned int ntails;
 
+	if (range)
+		return (!PageCompound(head) || compound_order(head) <= 1) ? 1 :
+		   min_t(unsigned int, (head + compound_nr(head) - page), npages);
+
 	for (ntails = 1; ntails < npages; ntails++) {
 		if (compound_head(pages[ntails]) != head)
 			break;
@@ -229,20 +234,32 @@ static inline unsigned int count_ntails(struct page **pages, unsigned long npage
 }
 
 static inline void compound_next(unsigned long i, unsigned long npages,
-				 struct page **list, struct page **head,
-				 unsigned int *ntails)
+				 struct page **list, bool range,
+				 struct page **head, unsigned int *ntails)
 {
+	struct page *p, **next = &p;
+
 	if (i >= npages)
 		return;
 
-	*ntails = count_ntails(list + i, npages - i);
-	*head = compound_head(list[i]);
+	if (range)
+		*next = *list + i;
+	else
+		next = list + i;
+
+	*ntails = count_ntails(next, npages - i, range);
+	*head = compound_head(*next);
 }
 
+#define for_each_compound_range(i, list, npages, head, ntails) \
+	for (i = 0, compound_next(i, npages, list, true, &head, &ntails); \
+	     i < npages; i += ntails, \
+	     compound_next(i, npages, list, true,  &head, &ntails))
+
 #define for_each_compound_head(i, list, npages, head, ntails) \
-	for (i = 0, compound_next(i, npages, list, &head, &ntails); \
+	for (i = 0, compound_next(i, npages, list, false, &head, &ntails); \
 	     i < npages; i += ntails, \
-	     compound_next(i, npages, list, &head, &ntails))
+	     compound_next(i, npages, list, false,  &head, &ntails))
 
 /**
  * unpin_user_pages_dirty_lock() - release and optionally dirty gup-pinned pages
@@ -306,6 +323,21 @@ void unpin_user_pages_dirty_lock(struct page **pages, unsigned long npages,
 }
 EXPORT_SYMBOL(unpin_user_pages_dirty_lock);
 
+void unpin_user_page_range_dirty_lock(struct page *page, unsigned long npages,
+				      bool make_dirty)
+{
+	unsigned long index;
+	struct page *head;
+	unsigned int ntails;
+
+	for_each_compound_range(index, &page, npages, head, ntails) {
+		if (make_dirty && !PageDirty(head))
+			set_page_dirty_lock(head);
+		put_compound_head(head, ntails, FOLL_PIN);
+	}
+}
+EXPORT_SYMBOL(unpin_user_page_range_dirty_lock);
+
 /**
  * unpin_user_pages() - release an array of gup-pinned pages.
  * @pages:  array of pages to be marked dirty and released.
-- 
2.17.1

