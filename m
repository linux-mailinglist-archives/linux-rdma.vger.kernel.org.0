Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D352D3112BD
	for <lists+linux-rdma@lfdr.de>; Fri,  5 Feb 2021 21:46:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233376AbhBETBi (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 5 Feb 2021 14:01:38 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:33836 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233310AbhBETA1 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 5 Feb 2021 14:00:27 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 115Kdh9D135318;
        Fri, 5 Feb 2021 20:42:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2020-01-29;
 bh=a9tp19DS2rCWvHsMe2G8y7YH/MyxjrAldbxEbqGAl5Y=;
 b=PvbFuz2bHCpUU7dEbSNp82D2nqYJ6DY20YnlnZwsyGRIafF/RP7bf3w3wjWBgCam5DzZ
 Z0E9hbz7yxGuca0+xmQzfKnh0zLzJkBRk5apXvPLrcahE8r+lAQjaFK9hzhX1rrWuMCR
 QUV0t2wB6UvA1wxNqkPIw+Rj6JUI2t+4WwV+OaoBFmVaSosiyfF2gLxL7yvkAHnGh4s1
 ywh84t9MnHO1xS1XKVHONGSTR9aNuEhyK0xn3jYrQwOA1H7CxpCxVsxExZD4f/84U3qn
 X+5NQl+26WjUFZT+XiebmxV9gV1DJ8W6KclJp6v4XgSwhJtl76FLEDO9yzKo2DukkSVq 8Q== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2130.oracle.com with ESMTP id 36cvybb8ed-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 Feb 2021 20:42:01 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 115KfBFT034011;
        Fri, 5 Feb 2021 20:42:00 GMT
Received: from nam04-sn1-obe.outbound.protection.outlook.com (mail-sn1nam04lp2057.outbound.protection.outlook.com [104.47.44.57])
        by aserp3020.oracle.com with ESMTP id 36dhc4p4mx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 Feb 2021 20:42:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HuWYtTHJOUTiiGKKbyrXPRbuFaJfTC7PYcjPxZ5A5Vk6PSz7OEaSuhwjlMkkiAet+l/2TPNfyMbrLm8DIt+21vsHPxOmMYVQg813Bxu9ACmn9I+dVZDC8KAQ+XX4Fc5fXu74bJPa4jraVEsiKASQVbIci4455/CFwB3yGjKVz0/9R6jbibDQFb0zDBZGav9B+lrK9J0malg/56UdXTr2/KAbgZNmzLyifKCT8X34Tu2vVDLMunuAY+QllCpzUxasDH6jYxbXfiN3pDpRKbAgr7CWKCFPzwq+A99y4j34onv+h8WeyrmmBpyTjJVJ04CmPijUkKUJtsKmqrNmwjQh+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a9tp19DS2rCWvHsMe2G8y7YH/MyxjrAldbxEbqGAl5Y=;
 b=AE1bkXmahpLQvLZSQ7CCRIz06TsrLGYaQvPbSbflDHmF8qOHS2cvzAXiel9f8shKsglnsveKkl2gYA46E7Cg96rzkd3yljQkIEAAFhDGnp0kpYfzZqSO2O/tzNuhPuUgvVhUr5p8wtOUSxjYJtdv8cQ2+vO5gVScNCcRDnHrIezkM0qgyZNCLMyqO1RG1f0/2iAL4vKHXXgndhoyQi7XzGiLhZ8O1dE3gg7ZeVvSH7hLr9/Z0YZOcx5pR3NFnSieaVii73luX15AjK7iypQyJMwVfi5usNUBrOO8GwDZgW7zz218dRrpNiJ6RluoT2I6o92+ZhBoV+0qJEsE2laReA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a9tp19DS2rCWvHsMe2G8y7YH/MyxjrAldbxEbqGAl5Y=;
 b=LK2OI58KNajJcqrOiGjuJouQAVmGMZWqB9MNrXqLYzoAS3zVetfl7SY7/ZXsbS70GY41e4FoQTETZ0o9bYKoHqZRhGtAFc3yDrvgHYI0g669cLJ7LEJNtq3nHDRgOof+nB0CcsuqbKv+4j1pyEyGTN/ZPP8BZdJA5BhNAvgEgW4=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=oracle.com;
Received: from BYAPR10MB3077.namprd10.prod.outlook.com (2603:10b6:a03:8c::12)
 by SJ0PR10MB4432.namprd10.prod.outlook.com (2603:10b6:a03:2df::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.21; Fri, 5 Feb
 2021 20:41:58 +0000
Received: from BYAPR10MB3077.namprd10.prod.outlook.com
 ([fe80::74a8:8649:e20b:d571]) by BYAPR10MB3077.namprd10.prod.outlook.com
 ([fe80::74a8:8649:e20b:d571%7]) with mapi id 15.20.3805.024; Fri, 5 Feb 2021
 20:41:58 +0000
From:   Joao Martins <joao.m.martins@oracle.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Doug Ledford <dledford@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Matthew Wilcox <willy@infradead.org>,
        Joao Martins <joao.m.martins@oracle.com>
Subject: [PATCH v3 3/4] mm/gup: add a range variant of unpin_user_pages_dirty_lock()
Date:   Fri,  5 Feb 2021 20:41:26 +0000
Message-Id: <20210205204127.29441-4-joao.m.martins@oracle.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20210205204127.29441-1-joao.m.martins@oracle.com>
References: <20210205204127.29441-1-joao.m.martins@oracle.com>
Content-Type: text/plain
X-Originating-IP: [94.61.1.144]
X-ClientProxiedBy: AM3PR03CA0058.eurprd03.prod.outlook.com
 (2603:10a6:207:5::16) To BYAPR10MB3077.namprd10.prod.outlook.com
 (2603:10b6:a03:8c::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from paddy.uk.oracle.com (94.61.1.144) by AM3PR03CA0058.eurprd03.prod.outlook.com (2603:10a6:207:5::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3825.19 via Frontend Transport; Fri, 5 Feb 2021 20:41:56 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9cba35e6-5db7-49e6-4f46-08d8ca167bac
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4432:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SJ0PR10MB4432BF9DF64319707840A87BBBB29@SJ0PR10MB4432.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BZUu4ZCwwvlmhjN2S2y0rFWjhMJtpAtPA+ih/YHSVRHfdPCdLpZm5MwR//+vkWQ9kDL97onlVxR/VUvamHgrokJ+fhiHQ1TPB9hVluTWgpi6e5dSfZhia3jef6ddDDlVxGazghFUZwp//Zd+CTWiP3QUPNIH2MYre52OX1QC1gxNyQmUPxycBZFb2Lx3qlq7ievfmfVwEc6LA2oS25NqgSVwkPDXyGXfcDROlco9PQx/DeSOT9fNPbIsNO09D4Bjg4FtQODyJeaz8gr+qneGXgrVbx9H7/Mtw71pU3smBA/1N3wr3acifO9tE/odcwW4oYLYXHDbbmDHdlAc6UwTYuLDQVJIzigX10UErWdDsIT7Oai4v90VyRJPFsv2CdI0AbPK5kXm10JFwFX47Gw520s7FOD1G0Vr+NBN7LjaE6NU55it6z57yMwSUfm0PIB/K9qxEThHSPwkZGnqd9njX5apRHtvWsU719L2hbdKh9KFhi0MEcwz+850WnaSs+tmfzz/PEljmnBdz8NDdlm7T2fkxI58sdgV5whcLfqlUoE8Y3pTXc4mohZ+QyKQV5xA
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3077.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(396003)(366004)(136003)(376002)(39860400002)(6916009)(1076003)(5660300002)(186003)(26005)(54906003)(52116002)(103116003)(4326008)(8676002)(83380400001)(66946007)(2906002)(36756003)(6486002)(478600001)(6666004)(66476007)(8936002)(107886003)(66556008)(16526019)(2616005)(7696005)(86362001)(316002)(956004)(14143004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?XBQAUJyu17fN9Hnz2ymhLZO+HCpnZOJoXjmm0JL2c1CW4abnsCs0tERZWhzp?=
 =?us-ascii?Q?zYAgbBuQ2X7bfF4FjIxrynNEPL9wT12TE4otP/qepYhJN3A4Bh9l0KLCr99P?=
 =?us-ascii?Q?3xwKjJ6+xsoCzZwaoch2qKmJP3JIWiY6fHkB3R670uvctYE9OH+pLqdseP8o?=
 =?us-ascii?Q?drtpw1V0Q4ITxJKLS14nFqbdJb8n4dS0mHab+oZvZZcUwMxUICw45oZQ6UGp?=
 =?us-ascii?Q?F/EV7SgYRyWQe58QzIfSbGldcSmW3xb4jFG16l9LPIjjSUq6TRgUlrf3triR?=
 =?us-ascii?Q?GvDvj+OEgVI3tBt0MeAvYFaWJE1akaJZiNwa6kJrexK2ZBl1ffId5i80sx6U?=
 =?us-ascii?Q?uFUNVWFvoSsH3W6Jou+BSGfAwARROjajPBsqtbxRSkla0Vg77AaTo9JjJ3wy?=
 =?us-ascii?Q?NeQe9qGetLE/lUgEbcf/tnfPhUFyxlWkFqmX1oS7ZDb29lQBbIOeoQH3m9et?=
 =?us-ascii?Q?3voGx2TRlIaqIS7vwl9MSNeAGy/uYh+O9rF+v+7t9kFhiy8SpEpA7jjD2X7T?=
 =?us-ascii?Q?anRizLRB5sFlvK0SL+xwVfEhM2Q57H9j/4q/r1X1A4Bt/VUT7yNpU+y4yrwR?=
 =?us-ascii?Q?Y+ajMNP66osYYNehDqHsjx8MVvh/sMF3bX4PysOOgPluh2y4OnGrtcmrwOpL?=
 =?us-ascii?Q?ipYA9rn9q4p0fhCXcEHbIsUnnLw1NTZxHYenZocDdxfvurT8dBG95fhkG2L6?=
 =?us-ascii?Q?LOW0lV5NaRu7gdXhN76SwwFe+6vCfG9htagYwo8ch80mk5gc4LIXR53tJw37?=
 =?us-ascii?Q?X9Epiwp/fxWgbArpB8fnyATRhaCx4FyXLOxxD/G3i3W/cNjz7pCaAVJ9kYn3?=
 =?us-ascii?Q?26BY4dsGBSNFXbRGsAL4FwWQcS3fYu5XFhYkaJ6/tHfbu7I6uXewPdoduTZl?=
 =?us-ascii?Q?sOl2rHs0Eb/Y6/xt6GR0ggTVLJW2XV9IKV+Zt/T/kDQByc9OEZzEn2ADVk7j?=
 =?us-ascii?Q?79k4zMEXxXmek+5h5TIX543lKCI2t4jFR/1jjOWgGjy25fjSv1O388U0mTec?=
 =?us-ascii?Q?0qN0ld+tgKg+t5IbXCKAh61fxxEGyYsHSTBuWvt9MEi7AKCBufPzPf4VJf6k?=
 =?us-ascii?Q?DGX2RWXDtL7khDMozlU5622BDA+FAybXTT+WITwbP7rBiex0kskhGI8NTBfB?=
 =?us-ascii?Q?ypvjiyEHYdosGOkrZHw7uBRxHuOtBqhRvodwM9c7/Efe6ky66TQszsAVy/ru?=
 =?us-ascii?Q?P8lS/TD5JqrSWRLbHoHkihl+zXYS/MTvAfQuktuzOVMwwt5cTBI58QgwgIsA?=
 =?us-ascii?Q?R/mNHMbRWrGsfz7/5n63wB/+rS+//wZBFX30IJUTbCnP60++j3JTs4l17TVF?=
 =?us-ascii?Q?JV2d259Idgzn0xpB+VmDJHGX?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cba35e6-5db7-49e6-4f46-08d8ca167bac
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3077.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2021 20:41:58.7755
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mTC6KoNfMbfY2UEbQ5IPfSh+7TFzPEOclSgLcpVw9O0oLs1gzR5XnWfTJcgZy4jYPlVRwru0VnvsCHWGhtXYqm8yjJZ3/FYeVA8VoWRIViQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4432
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9886 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 suspectscore=0
 spamscore=0 mlxscore=0 malwarescore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102050129
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9886 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 impostorscore=0
 mlxscore=0 spamscore=0 bulkscore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 malwarescore=0 phishscore=0 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102050129
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Add a unpin_user_page_range_dirty_lock() API which takes a starting page
and how many consecutive pages we want to unpin and optionally dirty.

To that end, define another iterator for_each_compound_range()
that operates in page ranges as opposed to page array.

For users (like RDMA mr_dereg) where each sg represents a
contiguous set of pages, we're able to more efficiently unpin
pages without having to supply an array of pages much of what
happens today with unpin_user_pages().

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
---
 include/linux/mm.h |  2 ++
 mm/gup.c           | 62 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 64 insertions(+)

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
index 467a11df216d..938964d31494 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -215,6 +215,32 @@ void unpin_user_page(struct page *page)
 }
 EXPORT_SYMBOL(unpin_user_page);
 
+static inline void compound_range_next(unsigned long i, unsigned long npages,
+				       struct page **list, struct page **head,
+				       unsigned int *ntails)
+{
+	struct page *next, *page;
+	unsigned int nr = 1;
+
+	if (i >= npages)
+		return;
+
+	next = *list + i;
+	page = compound_head(next);
+	if (PageCompound(page) && compound_order(page) >= 1)
+		nr = min_t(unsigned int,
+			   page + compound_nr(page) - next, npages - i);
+
+	*head = page;
+	*ntails = nr;
+}
+
+#define for_each_compound_range(__i, __list, __npages, __head, __ntails) \
+	for (__i = 0, \
+	     compound_range_next(__i, __npages, __list, &(__head), &(__ntails)); \
+	     __i < __npages; __i += __ntails, \
+	     compound_range_next(__i, __npages, __list, &(__head), &(__ntails)))
+
 static inline void compound_next(unsigned long i, unsigned long npages,
 				 struct page **list, struct page **head,
 				 unsigned int *ntails)
@@ -303,6 +329,42 @@ void unpin_user_pages_dirty_lock(struct page **pages, unsigned long npages,
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

