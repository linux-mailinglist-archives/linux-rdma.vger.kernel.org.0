Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07D5430E580
	for <lists+linux-rdma@lfdr.de>; Wed,  3 Feb 2021 23:04:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232638AbhBCWCX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 3 Feb 2021 17:02:23 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:58964 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232348AbhBCWCC (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 3 Feb 2021 17:02:02 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 113LxkTv136679;
        Wed, 3 Feb 2021 22:01:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2020-01-29;
 bh=vzB97g62e/yEZSWcUFQa5IU9s8oLQsgB8kq9NlEZFvQ=;
 b=HTwTbtXS1k1/mfdr473Is2ZLsSbpw/LW0mEedRvVryuhTCCFGziEH4Qp3NwdnFYo51Jf
 ymu554pdXMK7n6hQ9ILnWxhdd83/+554E5Cutztx8bpP2SA7VG8zMrzR7bNLxEk8wxt/
 r+eyAIVLYnLsUywv9N8LbSNnCRPQ0AlQ1myPmPdjI8n9XRE6gUVT18YtLn6VScoClIjN
 8k8p7mkO4NVtGMwcw6pwRG6MkNuYpYlnd0XQCtdrcQ6duqRkpRsjxUJdzY6LOTN8nqGM
 QQoELNJRbJqM9zLmZpAYVe4h/HYiaGpUVlFbnN0IHG9Px7AM1yuzT2sMnbAJZurx3M1s LA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2130.oracle.com with ESMTP id 36cvyb2mgj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 Feb 2021 22:01:07 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 113M14Fa042767;
        Wed, 3 Feb 2021 22:01:07 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2108.outbound.protection.outlook.com [104.47.70.108])
        by aserp3020.oracle.com with ESMTP id 36dhc1t3at-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 Feb 2021 22:01:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KiDOZUqstscJyHD8aol7jbL4c+vLI7Bm8FVkbxjzHPCC74frNMgj8QPVvs4zyoAvl10SK04/yLeZmb/wwewYSMqgl9RDSOMsc/Eo6dO1ZqQZgPK4AGQc23SJ2Yo2bPcJyMVQt+iIR4nHCVh5BQq3sWFO7o/enpqs6hT4RLtHOSziUz6m7HmksVskkv424HnwgkUQRy3kBZ9QJlG9NEVRiF2dQ/BbZfDxa7MDer5IRwfMClX0ANq8z+Z+F3tLAUeN+KNQKv1afNHHhVKSCPFyOTRFhtgqJtLWyC+yuwUJV4sxUXcs/g2E2mcpztQ5XnrW7hFIchEnIfcjTPQuOqvIgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vzB97g62e/yEZSWcUFQa5IU9s8oLQsgB8kq9NlEZFvQ=;
 b=m/2srNaU2hZZ3wbaUTVkhsW36vFNnCOBk3l+MTxPZazGu1rMayNKDuznz70O8v/iIQ3Ua87iCtgfqK2Qb6bTtDlXd+bHEZqhJjZOHDTnn0YEiVPEcUwTjwRoFYQNVRU0ZDOYNFtljxhVtEnvuGCibW1Y7JiFcFL+IcONXGZT1V5tk3MWucExXKRS0MR5i6BX1nBFyQjmEi/bkvzMnnVpDBVrtjteaDJTRifiGwpd/6qM6l/iSCb9a9aujDkMJiDKrP652rZ0g7DRk05sDodJzYca/IVqVuF2XLemKbR+XeUmfsSGFrxoABDXzMGL0pdyTlH+RgB6igmA6Qai1lkBVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vzB97g62e/yEZSWcUFQa5IU9s8oLQsgB8kq9NlEZFvQ=;
 b=ghh+uq6rACMp7VOHVnoQfbDndrUkS1D5VTO/X5Pxx7S8AHkjIEVuoHLr0h/heq16TbDNzJ1ne1yCB1M5yRr5rvucN1dfvPR7nWm+k8hABHvJZSu13xkjyACKoFLwJu8IXchaA81ZHwjllS3sKXEvqEb3KhVLMs1j/i77jV2o82M=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=oracle.com;
Received: from BYAPR10MB3077.namprd10.prod.outlook.com (2603:10b6:a03:8c::12)
 by BYAPR10MB3077.namprd10.prod.outlook.com (2603:10b6:a03:8c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.19; Wed, 3 Feb
 2021 22:01:03 +0000
Received: from BYAPR10MB3077.namprd10.prod.outlook.com
 ([fe80::74a8:8649:e20b:d571]) by BYAPR10MB3077.namprd10.prod.outlook.com
 ([fe80::74a8:8649:e20b:d571%7]) with mapi id 15.20.3805.024; Wed, 3 Feb 2021
 22:01:03 +0000
From:   Joao Martins <joao.m.martins@oracle.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Doug Ledford <dledford@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Matthew Wilcox <willy@infradead.org>,
        Joao Martins <joao.m.martins@oracle.com>
Subject: [PATCH 2/4] mm/gup: decrement head page once for group of subpages
Date:   Wed,  3 Feb 2021 22:00:23 +0000
Message-Id: <20210203220025.8568-3-joao.m.martins@oracle.com>
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
Received: from paddy.uk.oracle.com (94.61.1.144) by LO4P123CA0266.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:194::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3825.17 via Frontend Transport; Wed, 3 Feb 2021 22:01:00 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 526eac20-7b3b-42a2-49fb-08d8c88f32a1
X-MS-TrafficTypeDiagnostic: BYAPR10MB3077:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR10MB3077D6E69FC9C362DAD51D0ABBB49@BYAPR10MB3077.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eX2iuzmXIXVRUJFbsdpMidDqiatd4hW3Bfahrnni+d1zWcDfKJnjUf+Ix4XW9lIoYl5EIKSr6GA0IPSr3ixEsasf1k4oHeGIs94Lj5EiGrwQsiu9d+MTVF+uzdwEUtuGWtdBDefa8zWPGHIBVYRQrwm4ADI4rWfaU6QKLXFoTYE8rp6Tw4tEjS73syrJ2MjAnWtwgNqOAXWjMAHts3YA3PNAf5JGLVcvI6BA9NO1YKajSEIc57EEWnW4OYO7wk1RbyT92bERl1DkikagbxoTCn7nzWawxJw6vSD0LyBIyeS7hI4Pnf9o9zn6G64vYRuH1ogsPN7g49b/h4nBRUf8hh08cGZ1ZnyJ7JhMGQPe6WvVcuYgctrsnfnBTz3nGW8vAkxdpwDTUv/ex7D1UEF32Uw3J2JxTQgTPfpaS6Z2M/VO8Ixd5dI1ps+1doT9KbL4H+LJ0Nj7E3130AeZJ9ceo4Zwh59BLKnLtmIL1OWKA82XP3yaMAYX0YMaqgIKrsR1vyOjMePWtA8OQO85NivwFw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3077.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(346002)(366004)(376002)(396003)(136003)(6486002)(83380400001)(86362001)(52116002)(5660300002)(1076003)(478600001)(8676002)(107886003)(4326008)(26005)(36756003)(2906002)(103116003)(16526019)(66946007)(316002)(54906003)(186003)(66476007)(8936002)(66556008)(6916009)(7696005)(956004)(6666004)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?q3pdFOFTrzCakjbsQBZV6BEaENo+bkB8eob3CLGSk2Ay+ONqhVYfVkWG5ffR?=
 =?us-ascii?Q?0KNsDK78LP4V9ibSLvJku3ZWW6K69/hd3zAJZDAJUQ9lanTfSW7Ez0JX0BnA?=
 =?us-ascii?Q?3h9/clBQQ4JleDtfPiHDUpGJy1ciJHkEmUgRW6U9AxpTqbaQlH4nLXSGN6+4?=
 =?us-ascii?Q?kYEAFHKWuE7YTSYhK+PQI6lkRmkMtpSbgbDrxe0ylqHPZJaEiyt3iSSNCuOh?=
 =?us-ascii?Q?vouogQp78nOhPRpi0pfDWLlvvlneBeK/phnkeFVXf0eRAjZodHp1DY+T3RdB?=
 =?us-ascii?Q?0atpBvRHzvNlDT8kFwhc+wsGOqd6aP3vdak+cyGyWoVD1U9DhDxL0ARRd07E?=
 =?us-ascii?Q?CXr4Le4q7J0oPY50SC0Gt4ZgfAf07dhwPmzTVEUaMzFty1E4/5fQ0QTZnxnQ?=
 =?us-ascii?Q?l0reCWym9/6w2tYVR6Fkz2FRvGUtg0nY4rBZsxHOckpki9rWK9v0wn4sulks?=
 =?us-ascii?Q?LDJcL6Fueo4IDwLoIpm4bMyjxxV4P635yFUWzuZLzEfQPqtIXA4XmMvhKpXG?=
 =?us-ascii?Q?EvoRODxsjESzwLtvJGv8LIAU4SVl/ZN1C1iq3zM+beitEO7lomNrW1HuApMa?=
 =?us-ascii?Q?2sTyQJAQmvG5aCg7ro8yzgmmB6ZkXJAmwfR1lyMnK7pU4oJc8FDvtt3cGowK?=
 =?us-ascii?Q?GlrnX5E/3P+vOH3y/acP0m7uIuRhyN1ACMwOEjtsE+PinjZZc75v/LzVJcpn?=
 =?us-ascii?Q?jYeRqlQBwuubN5B6tSUg99IBHCBsNzKfT3e6wZHb3ALOtTiE25A0408keFZ8?=
 =?us-ascii?Q?x35ThNLR23bar0HzmFZXimS426Ju0gygDv0zazwLhVGd0/dZ3XocrwPSE9ED?=
 =?us-ascii?Q?RwbAvNi19xJmo7Md0pk80BKZlvoVZqbIGObEtnCzOl3V1heAvOLMTFTxwOj4?=
 =?us-ascii?Q?WHS4kpWW6brCZjBOg/LAqRpLRN30vB7jkVKfSz5TBiPleEt4AZ9f55NsKlLy?=
 =?us-ascii?Q?K0cQWHGYaDc7S4T7RWQb4P4jY660OTPhxm8m6Qo2TFQ+WBHj/rqkhBwSjGD2?=
 =?us-ascii?Q?xSdzEG8NYvH75YmlA77uci7uOoGJrP6f6WvwKqbLxqhqL9fR/5dHcvkcCdS/?=
 =?us-ascii?Q?WCRQkkGl?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 526eac20-7b3b-42a2-49fb-08d8c88f32a1
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3077.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2021 22:01:03.0243
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wBbsQCCQ8vfDktq1Myp/0uCAH4ke0nnFw8qGouDpOzsmVFfgjgU+1wC9Fb9VEGDGsQpB+xBK827ORt2aJoWaCEvhXZJdvoUFueq3wmaFy4U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3077
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9884 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 suspectscore=0
 spamscore=0 mlxscore=0 malwarescore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102030133
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9884 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 impostorscore=0
 mlxscore=0 spamscore=0 bulkscore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 malwarescore=0 phishscore=0 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102030133
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Rather than decrementing the head page refcount one by one, we
walk the page array and checking which belong to the same
compound_head. Later on we decrement the calculated amount
of references in a single write to the head page. To that
end switch to for_each_compound_head() does most of the work.

set_page_dirty() needs no adjustment as it's a nop for
non-dirty head pages and it doesn't operate on tail pages.

This considerably improves unpinning of pages with THP and
hugetlbfs:

- THP
gup_test -t -m 16384 -r 10 [-L|-a] -S -n 512 -w
PIN_LONGTERM_BENCHMARK (put values): ~87.6k us -> ~23.2k us

- 16G with 1G huge page size
gup_test -f /mnt/huge/file -m 16384 -r 10 [-L|-a] -S -n 512 -w
PIN_LONGTERM_BENCHMARK: (put values): ~87.6k us -> ~27.5k us

Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
---
 mm/gup.c | 29 +++++++++++------------------
 1 file changed, 11 insertions(+), 18 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index 4f88dcef39f2..971a24b4b73f 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -270,20 +270,15 @@ void unpin_user_pages_dirty_lock(struct page **pages, unsigned long npages,
 				 bool make_dirty)
 {
 	unsigned long index;
-
-	/*
-	 * TODO: this can be optimized for huge pages: if a series of pages is
-	 * physically contiguous and part of the same compound page, then a
-	 * single operation to the head page should suffice.
-	 */
+	struct page *head;
+	unsigned int ntails;
 
 	if (!make_dirty) {
 		unpin_user_pages(pages, npages);
 		return;
 	}
 
-	for (index = 0; index < npages; index++) {
-		struct page *page = compound_head(pages[index]);
+	for_each_compound_head(index, pages, npages, head, ntails) {
 		/*
 		 * Checking PageDirty at this point may race with
 		 * clear_page_dirty_for_io(), but that's OK. Two key
@@ -304,9 +299,9 @@ void unpin_user_pages_dirty_lock(struct page **pages, unsigned long npages,
 		 * written back, so it gets written back again in the
 		 * next writeback cycle. This is harmless.
 		 */
-		if (!PageDirty(page))
-			set_page_dirty_lock(page);
-		unpin_user_page(page);
+		if (!PageDirty(head))
+			set_page_dirty_lock(head);
+		put_compound_head(head, ntails, FOLL_PIN);
 	}
 }
 EXPORT_SYMBOL(unpin_user_pages_dirty_lock);
@@ -323,6 +318,8 @@ EXPORT_SYMBOL(unpin_user_pages_dirty_lock);
 void unpin_user_pages(struct page **pages, unsigned long npages)
 {
 	unsigned long index;
+	struct page *head;
+	unsigned int ntails;
 
 	/*
 	 * If this WARN_ON() fires, then the system *might* be leaking pages (by
@@ -331,13 +328,9 @@ void unpin_user_pages(struct page **pages, unsigned long npages)
 	 */
 	if (WARN_ON(IS_ERR_VALUE(npages)))
 		return;
-	/*
-	 * TODO: this can be optimized for huge pages: if a series of pages is
-	 * physically contiguous and part of the same compound page, then a
-	 * single operation to the head page should suffice.
-	 */
-	for (index = 0; index < npages; index++)
-		unpin_user_page(pages[index]);
+
+	for_each_compound_head(index, pages, npages, head, ntails)
+		put_compound_head(head, ntails, FOLL_PIN);
 }
 EXPORT_SYMBOL(unpin_user_pages);
 
-- 
2.17.1

