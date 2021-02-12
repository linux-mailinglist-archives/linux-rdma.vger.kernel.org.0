Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 826F3319F88
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Feb 2021 14:12:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232096AbhBLNKq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 12 Feb 2021 08:10:46 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:57128 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231975AbhBLNKE (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 12 Feb 2021 08:10:04 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11CCoEBw167872;
        Fri, 12 Feb 2021 13:09:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2020-01-29;
 bh=QBC+NEiAE4J7sT4BZ6CfLxXlcIQg8NpsGdBzSgXbwdY=;
 b=Wh2XoqNxgTS/nmwij6wDGOxxeP8pDhp4bzMv4N1bq24kj2NI2vju5dlDm3ANImU4QIne
 9ItcIw62JtYHSY/Xcg+EAdKwAivCpDsT6WMlG2DXqXi8c2UmnYF+BPLtjrN+ei1ntFdF
 EAEeMkty2ByD8dV/UXHk5DwKK05oB6SP/jX/GfNzW6FL3l0D0HYvwZ4t4YF8awLDKkJ0
 24jYNK55R7riNTOW4plL/gHvaIhj6u/QxHkQP+T6CO4G0XugMdDHAPOFSBSGrHIWzDrR
 SOlKf/jcIn+DY9A8dSf18HOC/cLZFbqpXKXCeG3jXnQgQTyXLBfKnkWOvsWFwOrUfuhE lw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 36hkrnb2g1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Feb 2021 13:09:09 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11CCnacs184188;
        Fri, 12 Feb 2021 13:09:09 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
        by aserp3020.oracle.com with ESMTP id 36j515fn3u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Feb 2021 13:09:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P7nMAxmZmyPiqm2lvl4DO+n4bD9M+7dIvDCaIK7/n9JwmBzSUtwweRkKU9k/JXyO4nUdosp6Geu+IEqs+t8Ph6d6Fh3Y6ErGIwcChcSyfbyhtV5nR25HmQGisuPyJ/fYLNqQ6EzEUUIaOKCNoJcCxZzpIyaZhKOXipb/CLXKfESFuYIVfVsdsJgxhIAxc7KaozANSCkuIqJnldUnHDyNkUyjog6i3lnhFnN2FS1v3wpQSfJ7UI3UcTL/fmfOq9pkW7nm4bQs3J5dNCHebdBFSBIGUrbJrVR77Gyc170Uuthcq7AuOFYwD2/r9ukMy/mjRlEe0GgrHFMC7QKCfTo1Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QBC+NEiAE4J7sT4BZ6CfLxXlcIQg8NpsGdBzSgXbwdY=;
 b=dzZuuw+rQLVF1zec0l6r+fYh9mQRQxsUCCGgUpaUwhV4C5JpkgcaHnVwAjbEp2lzVk2yKg1VoGIpO4pZT6/lioQlygqX1OXZKINknNaCCFdGY2qKvdHN5UkM9q353/nkmQRmbxidV1pbVLBJLZSomUVH9XJc+CJ66hWgUrbxUQX+WOVOzw52yFyj08wSx60DMZoPk/h+LcMBJzcMPK5zOha+bFM3ZV9YeoNwluKr32ahPOFciJ/tAoZ+WA+tpnx+7m5PV7PRW5frlvQVbCYWkmjOKxTOHIafiOIeoz2u6i56B/kD4h0qpJg4jvVXQ4VAyvzsm2x4WdhaYlGvVJn5wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QBC+NEiAE4J7sT4BZ6CfLxXlcIQg8NpsGdBzSgXbwdY=;
 b=dYURuKAg32RhEdQOE3yRETebZPhO+2nLRgKLft2G+H8c80F9ijXlkXkUhguVCdyIUuoGW8yzqT1cjxcdw85CQpYcpSVgQKSsmMtgLHSkVC1U1Yvq2jSdOM2YTJFqkyPUaZYrB3VqzaPvE40/9CsrZxC445Tiu8MbTLZfznlz8+k=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=oracle.com;
Received: from BYAPR10MB3077.namprd10.prod.outlook.com (2603:10b6:a03:8c::12)
 by SJ0PR10MB4509.namprd10.prod.outlook.com (2603:10b6:a03:2d9::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.17; Fri, 12 Feb
 2021 13:09:07 +0000
Received: from BYAPR10MB3077.namprd10.prod.outlook.com
 ([fe80::74a8:8649:e20b:d571]) by BYAPR10MB3077.namprd10.prod.outlook.com
 ([fe80::74a8:8649:e20b:d571%7]) with mapi id 15.20.3846.034; Fri, 12 Feb 2021
 13:09:06 +0000
From:   Joao Martins <joao.m.martins@oracle.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Doug Ledford <dledford@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Matthew Wilcox <willy@infradead.org>,
        Joao Martins <joao.m.martins@oracle.com>
Subject: [PATCH v4 2/4] mm/gup: decrement head page once for group of subpages
Date:   Fri, 12 Feb 2021 13:08:41 +0000
Message-Id: <20210212130843.13865-3-joao.m.martins@oracle.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20210212130843.13865-1-joao.m.martins@oracle.com>
References: <20210212130843.13865-1-joao.m.martins@oracle.com>
Content-Type: text/plain
X-Originating-IP: [94.61.1.144]
X-ClientProxiedBy: LO4P123CA0347.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18d::10) To BYAPR10MB3077.namprd10.prod.outlook.com
 (2603:10b6:a03:8c::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from paddy.uk.oracle.com (94.61.1.144) by LO4P123CA0347.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:18d::10) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3825.17 via Frontend Transport; Fri, 12 Feb 2021 13:09:04 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b490f408-5d16-4f2b-3c81-08d8cf5760cf
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4509:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SJ0PR10MB450992CEBD07D446A79DF0A4BB8B9@SJ0PR10MB4509.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: amGFWmKdQ14t9r+EdHlYeqwXWGs7aYAqm4BvWNypZCtW5E4mOfSZCgC32gXu0dAVaTrEFzpQAJELo4oAzra8kyBynq/VG4cWevv2OxMubvQNTPrZBmw6tPs4UOMsRzs7Ii4CyvuPSH4/3SS4W0tMfAqHa1KtJv2FU1Z+W87D9BRgT8dIMIhTxfQJY3QnX1jMfkfVhmsbopdNFVSsTelvFj1sMM8O2SwPy+RjYQ9p4IBjGmX/BpqXiRkhP3yFJt1nH9cGWudrGcVOSjmRrnJZdtyTFdwyLYa0JI71BpkyKfs4x2QOgdAvK0nbbSh2295hUnEdfFT5uLcYFedoii2wgqbFFhWvMEcszFWoUwqxVHxMkVPMp1YI6UycsemlqIl0lPi77/3CrVcdS1KPC5KoLBt2gMY/3c7Szs2SOB0p39bf8RM3zQ4b8YzUnGqGp93/k0mzCthGriDKnm1/tz5GNQyCR20sCRilDaj7conAzDZZHcclTmQsRxnW3cPSwYNBjVmCFEgEUF+fyA6taHkTBA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3077.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(396003)(346002)(136003)(39860400002)(366004)(6486002)(2906002)(8676002)(4326008)(52116002)(186003)(26005)(2616005)(1076003)(316002)(8936002)(107886003)(6666004)(478600001)(6916009)(36756003)(66476007)(5660300002)(86362001)(66946007)(103116003)(66556008)(54906003)(956004)(83380400001)(16526019)(7696005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?cGfekFzzr44Je2OluGb/ps0JKO2F5iC+aI59txIbljtuNnoo4dWjUKQRdDP9?=
 =?us-ascii?Q?P/oeyvPFsz2Y+eS8ob8FCVvfdTIM8AlUKUE66mdh1EuuwxTaU6ABU8CfmVpV?=
 =?us-ascii?Q?Y1hYrp/Z5Z86fdrMoDUL5QYH05uCM5QPK78U0yCzU+wQvFEwGQ0oBoTuF/Ci?=
 =?us-ascii?Q?fe5713CWlahye81cUgz6xmXr7DoCgm0rnqT11N8ZRp84yskOCCBZuvKugPJB?=
 =?us-ascii?Q?ahOovQ2Cmoz/jaHbAjqSFJ/OFo+qn62nfBUO4APc4BmSjMD0OVqfeX4o7f6E?=
 =?us-ascii?Q?1kPuEw2fff3abxU+Y7Qugd3oAsUS87JBeTQUV5gYD02ttJkjRXgy4GVNMrK1?=
 =?us-ascii?Q?KworaeudKZBVWmVkQDesBVfTngfNpigx106Arv/nbSM46PmW0Q8oHg5oB2K3?=
 =?us-ascii?Q?49bvgXieldmQKzwaEkJgly/R2WvD40GbQdIBCN3A39L8FcYUm0DFoaN2cfi/?=
 =?us-ascii?Q?L4pxUVDtjV8RxXnR477IeBxZFRWQPtVheByjZv9ZOm91B0CwyiNp/3VLYfBh?=
 =?us-ascii?Q?hxX3huk+YUR+t6EiuKuHUEI753cl3JQbPJKIb1QYEFLxeUKIm+qypPNWIlU4?=
 =?us-ascii?Q?xncb6RVwxMSqkU3LfI5FLANSVktvO7EUYk8mK5EeVUh2zapN3I8Cd9Og3qsa?=
 =?us-ascii?Q?9wvFAstmFJshPXCXEDksx6Z6YAP+cNRpR/yLi7LSMJ5AQljmFU+OPcKSaxWc?=
 =?us-ascii?Q?9xQEWPJIBgatMLwx+1IkwREfLzktGrtqpU65fnRFhSEzL8rdaIFEVcNmbkHp?=
 =?us-ascii?Q?2TsSkm93lbhjKU0fiQq5feI9ina9rHOc03QR+oFiAmZSkvIJysiv/0XnHrjX?=
 =?us-ascii?Q?SIWFl7xHkZayfSqeHFkHZgDfLyRqQtjaxoYF5Gb192u3GLOnv+q3mYSLPwTt?=
 =?us-ascii?Q?jd3sj696JIsbHBIQ00eYImvEBFQUEzDC6mMzDF/gnZtyZuYI7ONt+3zIET27?=
 =?us-ascii?Q?qotvd4lOQN8OzsDa7JmzAO3VqMRCuf/FeOoegGJmQp9lH/7ivo9q+zvRWOEm?=
 =?us-ascii?Q?G3fQucBd34GAomDxMQnPAVA68xbqfMJgqDyv6608htxtfb2zkg+/yFgim/mj?=
 =?us-ascii?Q?LAOFC61jSpqMNi4BjIHTZq7qsY/5uttnRjpFQulECya1cInui6jNPAAJUqio?=
 =?us-ascii?Q?ptofD9N8WVkRQssPhkpdX6sCBN+UNuJ7C5uzBL/2YedvS5rVdERsNtk3wD31?=
 =?us-ascii?Q?q7UQbofmfqEiF0eiEJ8WQf5vouYQH3jVTeTmIu5mR/lHcuKLpFvI+iljh7sk?=
 =?us-ascii?Q?2jEAGTKPByZsiyVmEfGpOqnWwNZF4e42XSC41VY5yDBqRxKPf9K3YQoCd6KU?=
 =?us-ascii?Q?HI3CsH9ayZ4TxY+4iKmTAdQf?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b490f408-5d16-4f2b-3c81-08d8cf5760cf
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3077.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2021 13:09:06.8282
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CYcx/FKWnt32Qf4vy5VEiLUc31vGoL+tXNenmnRDFl0vvolhJbr1w520tHjWnXIZN0WKNBmtkZkYfmHM91xkJekNeQEngjIZUwHeP9f2qNc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4509
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9892 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 adultscore=0
 mlxlogscore=999 phishscore=0 spamscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102120101
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9892 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 priorityscore=1501 bulkscore=0 spamscore=0 impostorscore=0 mlxscore=0
 suspectscore=0 mlxlogscore=999 adultscore=0 clxscore=1015
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102120101
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
Reviewed-by: John Hubbard <jhubbard@nvidia.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
---
 mm/gup.c | 29 +++++++++++------------------
 1 file changed, 11 insertions(+), 18 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index 1a709eae2bfd..384571be2c66 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -265,20 +265,15 @@ void unpin_user_pages_dirty_lock(struct page **pages, unsigned long npages,
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
@@ -299,9 +294,9 @@ void unpin_user_pages_dirty_lock(struct page **pages, unsigned long npages,
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
@@ -318,6 +313,8 @@ EXPORT_SYMBOL(unpin_user_pages_dirty_lock);
 void unpin_user_pages(struct page **pages, unsigned long npages)
 {
 	unsigned long index;
+	struct page *head;
+	unsigned int ntails;
 
 	/*
 	 * If this WARN_ON() fires, then the system *might* be leaking pages (by
@@ -326,13 +323,9 @@ void unpin_user_pages(struct page **pages, unsigned long npages)
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

