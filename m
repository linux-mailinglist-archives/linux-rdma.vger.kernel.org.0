Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A2E630FE3D
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Feb 2021 21:28:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239728AbhBDU11 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 4 Feb 2021 15:27:27 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:33968 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239662AbhBDU0L (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 4 Feb 2021 15:26:11 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 114KJ5j1094495;
        Thu, 4 Feb 2021 20:25:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2020-01-29;
 bh=L73QegqCirJmIv8GBpj0D/m45kMeBZWUda7V5m2UH3s=;
 b=vyrygB76xZbSzlbBxFpHaT8F8PsaDfE9CFagkqUU3LhuoVnd+Hf8CbMhHMw31JjwfIKc
 QKoWpybPg7s21uEtnXtIHEpgGMzZiuRQwY+y9IyqnR9dvr10Sm8AENTebraSizzuWIXl
 MsQSvNDwJcqCk7ybcYpfyghU5TrzJKlYIza57TK9bXw4A2K5SrJK2WIPjFOes+MQUbau
 8wwHtFjVlhqZugCdbsYcARamkSNBVXcCpDK6qIKzdNqgUimkPD0y3hueJEIpGmLtmAAF
 054QtLUAoFVINVl/TY/853McBYdbstkvsbceDGPdsCi7Z6Pv1ZJ5d20rUQw3yhbYhQq7 bA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 36cydm71y7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 Feb 2021 20:25:21 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 114KGL7N070865;
        Thu, 4 Feb 2021 20:25:20 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2170.outbound.protection.outlook.com [104.47.57.170])
        by userp3020.oracle.com with ESMTP id 36dh7vpbhv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 Feb 2021 20:25:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jmi0vpnJ52HKtYL5sZJZU5VEEasO1DjejyVfl8GCyRIkTE3XQiwVr44X+M1xEeF6i88IiKnycvfmJvowhpZkl6/VKzPI7wCEz8qzXVOC+83lGeZmLEFOMD7gMADFjXj9zRZVmQI3QWAWjlaXlK52AdoxOqULrBhzAC7BzXgh9buqjFzfHHgKmixEkQmOeSbdwdr6/PrscWWenn5M2Irqv1B3abk5tiaVN/dCq/DByhWmAUWLE2c4LEdreqJ2efJQCvQuIploBuBbBRkXDMi3ub8QiZhWy8jFLMFablmfZLFsPkMZZzELGFxCwdo0yBzEYedeoGbgPvtjc/RGwxWPrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L73QegqCirJmIv8GBpj0D/m45kMeBZWUda7V5m2UH3s=;
 b=G6wI4gskMdaj21Jyxrwl8hyovb5Gp6rFkJIb42m6MOO0cvnNJ/yp5xEpHBGjhSJe2B27GylCPcCzU3vqSwmqQTeQ4DnenYgem+/oI/ayX9mPtTyPZnsv+C0EK4TFn0CT5naSjw+cdDF4+lrTxGnYRNsLWRvQFRKDdHl9vpdIrz9Rtj1deGhvN5dR+WPjvl7WJ7A1FqhqefZtYQ8Lt6yUernT39uLD/hk7GXsVuAvO39S7l8TXF70cqY3i09FuWmMKU9uj7AiijZAR592KwimBPUC1bvaaN3KidMGieMVuBJeUWqm8puY4ygn5bBPsFI4WmKqh2B/zjuDLcPa/o/t1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L73QegqCirJmIv8GBpj0D/m45kMeBZWUda7V5m2UH3s=;
 b=rlcvQqP5i5mwY/52PLdjHAsMRZpR9yf0mzxZYJ8PcdBPlxz/m6Zccqnw7+ZhW7xuavwdgSlOk6DdxyT6Ue/bqC2MjwWQ0vMqrFwvviJrll/MyN9sz7m6o+a3ROznzeoU7IoZms2omuFInD3I7raZI2kRpjHYlbJ3tMw+GP8fqPI=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=oracle.com;
Received: from BYAPR10MB3077.namprd10.prod.outlook.com (2603:10b6:a03:8c::12)
 by SJ0PR10MB4590.namprd10.prod.outlook.com (2603:10b6:a03:2d1::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.20; Thu, 4 Feb
 2021 20:25:18 +0000
Received: from BYAPR10MB3077.namprd10.prod.outlook.com
 ([fe80::74a8:8649:e20b:d571]) by BYAPR10MB3077.namprd10.prod.outlook.com
 ([fe80::74a8:8649:e20b:d571%7]) with mapi id 15.20.3805.024; Thu, 4 Feb 2021
 20:25:18 +0000
From:   Joao Martins <joao.m.martins@oracle.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Doug Ledford <dledford@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Matthew Wilcox <willy@infradead.org>,
        Joao Martins <joao.m.martins@oracle.com>
Subject: [PATCH v2 3/4] mm/gup: add a range variant of unpin_user_pages_dirty_lock()
Date:   Thu,  4 Feb 2021 20:24:59 +0000
Message-Id: <20210204202500.26474-4-joao.m.martins@oracle.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20210204202500.26474-1-joao.m.martins@oracle.com>
References: <20210204202500.26474-1-joao.m.martins@oracle.com>
Content-Type: text/plain
X-Originating-IP: [94.61.1.144]
X-ClientProxiedBy: LO2P123CA0104.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:139::19) To BYAPR10MB3077.namprd10.prod.outlook.com
 (2603:10b6:a03:8c::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from paddy.uk.oracle.com (94.61.1.144) by LO2P123CA0104.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:139::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3825.21 via Frontend Transport; Thu, 4 Feb 2021 20:25:15 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 885d7fdd-0ca6-4133-0e4e-08d8c94afcb1
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4590:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SJ0PR10MB45902977B8C847756AF36CB4BBB39@SJ0PR10MB4590.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8ShhH/MNCHevEnDXSWg3LOdLowZ5VY0yd8supePvsYZfpldT6eYKGyi/8N0vl0VwfWmsjXngG0JAolXSeZGYfK1QdnP1l8o9Wbo5JT996bfSD0kUbcdAHSx+xvVIUH03jNyn6NUeKVuiJd66EpssH37GrWQ5haLjS9/gqASv92IAxN1EGs7rmcl5pYhXn9UEKdSqEkmKbWuon5NEIo70ZzdO1eNnp2SCJEWoSEHt4r2kdyBAg51lN/QATBEERsN4EoRDUBbMgh6hE6tNN7Q3cFjJtQouhUJpSWc+v0A0zL+lMz22wUF3Vinxb7OHO02poxjRGgXOO9bIa8e+F6ZxCVuJ/m4/pR6DC2NCx6G0qyapZZ2Rs119zunvdu4LTOVS7CLF/ZYyjLvcWw2TE11dU9ongdJzQmNSETHLmAI6JNionz27V0F1UzUkOBor8M92PgDK65EbzLfaHViN9PK2g47qObvWnsbGZ4vhCiWmHevNSdMXft6hJcULe+ZgfS9ByE9hyOz1Uee4oCW2NvXF420gtjwcq2ZBXRwp23Q0gldyB02XCmSG3pBq7U2QOcby
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3077.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(346002)(396003)(366004)(376002)(136003)(52116002)(7696005)(26005)(2906002)(16526019)(66476007)(186003)(66556008)(478600001)(103116003)(316002)(6486002)(66946007)(956004)(54906003)(86362001)(5660300002)(1076003)(8936002)(83380400001)(107886003)(36756003)(4326008)(6666004)(2616005)(6916009)(8676002)(14143004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?11kB88qnn7+T/jNZ0rm45s+J3e652MReUpzw1aCa4ZAfCVCua1WRgJdndNw0?=
 =?us-ascii?Q?GVvHp7A4BFn7BHzgxOpHBZThGQcrMi9kXnkwS6321F8P32znpqzw64YkiE6b?=
 =?us-ascii?Q?4UshQ0Og3iVslX2zE/tMEy3KgL4S+2PVcTfhn+Vd1PoEXezBPN2Xqgue1Raq?=
 =?us-ascii?Q?5P1Ast+YVrKOUMf498jq8GRprzDqa+4jFeaZLb43A2vZbqACO36F9WJ6xLpu?=
 =?us-ascii?Q?PbkTUY7bXNVCYC5IXaOIMT1i+jJLvmW3/74xxLU4HKzFVs7YUhcI5iMVXIcx?=
 =?us-ascii?Q?vrj1zGtbfmsHJssigdsmGT5Blns/p+uh1EHSDqLHPbyvLOIDOsui31hrW7se?=
 =?us-ascii?Q?L0J9vcljZNmiBPudnQSDeclepBRWZ6+9E5dHR6F6kLuW6GTWwPZPxyMRZ3nH?=
 =?us-ascii?Q?ZnKhS7ONbY8C8Dx47jYqmBnEzQDlZgWqDwEkn9rBdxs5ighBSxi/oA2qH05h?=
 =?us-ascii?Q?hinZKNuupV1Y1WAymWH+mBal3F33/Q74GHm1SOH92dezKA62AZaNuHwaf4Ab?=
 =?us-ascii?Q?DeqqgIR5o0iTvMeblEsl91JeKWAWeyulpbH3CPdVYcaoAUwhJypxwuOW/BjB?=
 =?us-ascii?Q?ElcFQz/8GCJrx4YnyP8tAB4qzlqvlGQwcn6U3o7nFJ1O/+uOSgKzjInO01q5?=
 =?us-ascii?Q?emzGzHNCMkv6saTn4yLELghjsjJpxBPUzWqt2AT8d1nqRKIYolw8KmhGlUfZ?=
 =?us-ascii?Q?Q6kBPQdZs9haSNAqJKA38EwSeNMVMMowi1wH7VqauyVLylwxWniVMURQ+Pe1?=
 =?us-ascii?Q?4nAxXvmF7BXoLZietWxUkGBiaEYGJaTW/RydfuMf1ad/2o761UoMDM73TvvZ?=
 =?us-ascii?Q?bBydD2YwDcJ9ZdURpcFhqyMBCaWPB2ACXSym24c3fSUm+s/FcclbI8XUkAAC?=
 =?us-ascii?Q?38HAkoGiURMLyWprJ9kaNzQoNKXvSI+uEj8n/l6KAOdNbketsuxUisQCL+mr?=
 =?us-ascii?Q?z8HID7GASAsWM+6oldAH2Bdz37hoJKJ/jNrHspMN0MsFBJVfD8qFv64yBGsG?=
 =?us-ascii?Q?C9yp0g/cn+tRv8YbLZ8f/2N4H/YTL486Kj+rPdwFgLysAjKSzImwRhTPYm/1?=
 =?us-ascii?Q?JVpQqoLE?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 885d7fdd-0ca6-4133-0e4e-08d8c94afcb1
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3077.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2021 20:25:17.9968
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Nv+fOJ0ROcUO7INnPD5Q9PVLb0KphqtlrschaahOHUIzH/ZpM7WcKwORaVEu9N2H2jOCloIGPZUMg4tTQczDpgnwilVEvndwE0pMCRgVwd8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4590
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9885 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0
 suspectscore=0 spamscore=0 mlxlogscore=999 phishscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102040124
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9885 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 clxscore=1015
 spamscore=0 lowpriorityscore=0 phishscore=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102040124
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Add a unpin_user_page_range_dirty_lock() API which takes a starting page
and how many consecutive pages we want to unpin and optionally dirty.

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
 mm/gup.c           | 64 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 66 insertions(+)

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
index 5a3dd235017a..3426736a01b2 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -215,6 +215,34 @@ void unpin_user_page(struct page *page)
 }
 EXPORT_SYMBOL(unpin_user_page);
 
+static inline void range_next(unsigned long i, unsigned long npages,
+			      struct page **list, struct page **head,
+			      unsigned int *ntails)
+{
+	struct page *next, *page;
+	unsigned int nr = 1;
+
+	if (i >= npages)
+		return;
+
+	npages -= i;
+	next = *list + i;
+
+	page = compound_head(next);
+	if (PageCompound(page) && compound_order(page) > 1)
+		nr = min_t(unsigned int,
+			   page + compound_nr(page) - next, npages);
+
+	*head = page;
+	*ntails = nr;
+}
+
+#define for_each_compound_range(__i, __list, __npages, __head, __ntails) \
+	for (__i = 0, \
+	     range_next(__i, __npages, __list, &(__head), &(__ntails)); \
+	     __i < __npages; __i += __ntails, \
+	     range_next(__i, __npages, __list, &(__head), &(__ntails)))
+
 static inline void compound_next(unsigned long i, unsigned long npages,
 				 struct page **list, struct page **head,
 				 unsigned int *ntails)
@@ -306,6 +334,42 @@ void unpin_user_pages_dirty_lock(struct page **pages, unsigned long npages,
 }
 EXPORT_SYMBOL(unpin_user_pages_dirty_lock);
 
+/**
+ * unpin_user_page_range_dirty_lock() - release and optionally dirty
+ * gup-pinned page range
+ *
+ * @page:  the starting page of a range maybe marked dirty, and definitely released.
+ * @npages: number of consecutive pages to release.
+ * @make_dirty: whether to mark the pages dirty
+ *
+ * "gup-pinned page range" refers to a range of pages that has had one of the
+ * get_user_pages() variants called on that page.
+ *
+ * For the page ranges defined by [page .. page+npages], make that range (or
+ * its head pages, if a compound page) dirty, if @make_dirty is true, and if the
+ * page range was previously listed as clean.
+ *
+ * set_page_dirty_lock() is used internally. If instead, set_page_dirty() is
+ * required, then the caller should a) verify that this is really correct,
+ * because _lock() is usually required, and b) hand code it:
+ * set_page_dirty_lock(), unpin_user_page().
+ *
+ */
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

