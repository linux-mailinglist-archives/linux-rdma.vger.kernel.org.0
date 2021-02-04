Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD27530FE3C
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Feb 2021 21:28:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238894AbhBDU1X (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 4 Feb 2021 15:27:23 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:33898 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240096AbhBDU0J (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 4 Feb 2021 15:26:09 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 114KJi0r094824;
        Thu, 4 Feb 2021 20:25:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2020-01-29;
 bh=Mg0EG9jyZ1sq9/BmNNBYOGVTgJOCH8UybdaYtPghJi4=;
 b=uETIJsmVeP1ZhmOSx6f66dBJQn0GASXvhLqYnh44TkX06zDiw0EBRvU9wxVjRvvth49A
 flbLXk0Oa5uGCycx9zwl8YujVsuE0Wq4ec1PW/Zh2p2yrLkeISv3xlXgrmgl0SuXAomz
 Z/SeMmChLqssClrTCIEjiRCaOzUs4e6MS/mT1ZDG6HluFE2p7V6MfzNX6E6Fqs90zC5h
 MdttitkiacopP61mHCCRE34Y/79YCfi2mKPssEvQTWQaYRHjQdwMZmplPTH1LhmenGJT
 dNnZbGJHSC3lfNUA3WzFyiY8BSfN9hoelgndb/h4SHRzEv3ITwlaebDHmU34Q/wnCytn 6A== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 36cydm71xr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 Feb 2021 20:25:17 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 114KF6Kn155762;
        Thu, 4 Feb 2021 20:25:17 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2176.outbound.protection.outlook.com [104.47.57.176])
        by aserp3020.oracle.com with ESMTP id 36dhc369ty-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 Feb 2021 20:25:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PwwWHI+DtPvF0hBkxhkwq1IOs8F52IxRnUtTw/0CjMh4GADjI0mgYHC7wdv4c9VKkPjAdntGT8yG01KXEHw/XwrJvd7oR7+7ZxQ3qXHDeRY6n4MlyuSWGrC0Va8ASMZKVb37GQdfSwcqh3eOFnYli/ogXqOWn4edJ0AXBmflOIUPixhkJwHrDuO4Oc41dejCgEMZGWhqJ7ivNsXptwUIH1aRkVENi3WpnXa+Ghum+3XzNF+xelh7O1qDvygqsAXf4hOR7o44EmV0LDZkmW2MPdBIYZCzGedHUWN1i5/4MYCVoOnY/NWwzFVY85qAG9Um2z4x0D9uCz6PzwBq3j73+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mg0EG9jyZ1sq9/BmNNBYOGVTgJOCH8UybdaYtPghJi4=;
 b=bVwTp7qqwXAMqR6fu0g44uWW6AQMbkf64TH9zcXm4Uw2l8otirlEHAtnX6AOvNnSXEFmqKDr4Uf3sMaxu+rYU4BMEa2sUNYvdDtIbHL2LTUrD0K21IC10xEgnDAk2m7hBfYJauZW795fOz+vqa1Ay4GM4nxGUpWsqESbooqkP1z+xAXhRU3J1fFKy0IRTMvhnrHBgJzHyKBvmjJU/P9Ar+W0kOeqYD5kFtrG0gKNlWGEgKPp7H4jsvmU8zWcN7guipQPonkgP6R0T2Hfd/5hZejLKRQqyv4ts1HyEVHMIfPD/+wRJdb1R6aVN80VNEDYkvoihuu8y2hrw5hk58jGlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mg0EG9jyZ1sq9/BmNNBYOGVTgJOCH8UybdaYtPghJi4=;
 b=lhzX4tyz6elSWDbxAnnrqIsMVj1KKi4tcQuNq2RfZZYF3+ZQoOnWYCQX5oIrhOxHTKYKW7wdyGj2aN9ZviFUaJbeA/EgSTRojEn6sf1g2b5P/CHvTHIK7jtDxnodJq5qgi23HbPveXi/tbQY85NQchgrKOnv+G7dV1p6NcDluY0=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=oracle.com;
Received: from BYAPR10MB3077.namprd10.prod.outlook.com (2603:10b6:a03:8c::12)
 by SJ0PR10MB4590.namprd10.prod.outlook.com (2603:10b6:a03:2d1::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.20; Thu, 4 Feb
 2021 20:25:15 +0000
Received: from BYAPR10MB3077.namprd10.prod.outlook.com
 ([fe80::74a8:8649:e20b:d571]) by BYAPR10MB3077.namprd10.prod.outlook.com
 ([fe80::74a8:8649:e20b:d571%7]) with mapi id 15.20.3805.024; Thu, 4 Feb 2021
 20:25:15 +0000
From:   Joao Martins <joao.m.martins@oracle.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Doug Ledford <dledford@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Matthew Wilcox <willy@infradead.org>,
        Joao Martins <joao.m.martins@oracle.com>
Subject: [PATCH v2 2/4] mm/gup: decrement head page once for group of subpages
Date:   Thu,  4 Feb 2021 20:24:58 +0000
Message-Id: <20210204202500.26474-3-joao.m.martins@oracle.com>
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
Received: from paddy.uk.oracle.com (94.61.1.144) by LO2P123CA0104.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:139::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3825.21 via Frontend Transport; Thu, 4 Feb 2021 20:25:13 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 591bc5d8-446a-4b84-381b-08d8c94afb1f
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4590:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SJ0PR10MB4590BBAA8913E4A583EFE156BBB39@SJ0PR10MB4590.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VzZFmrYx8iaUxMHD8ZPjVkv4IO68S9G7x1v26dsKFCQBJYWRKUFmyRxnpbtq3wsfOwDTNZEXVNTYuvz3ozBREleDZ1XRfQ40aICF8+qAPfhnWFxIxGJdbpgQV4eOAz4Ks09Qzghda+HR3nL9bNZlpel+16wa5l/ugPBmCw2w124B7WCQZ1dg1cOcS9pT5KXDopUDUQ9tIk1P5xj+A/lKA2uzJMewFIPgdefGNF5zE7rvSXhZRRDLNJ+/dbyu9qqqQGzmv7+Arg1jcjOTdkp4Q0Jb5tzJGQUqUJZ6Ubt9FbiE8Bd1MlWRNEj8vuywsrhz5ydLOilb3MHjuZFi2UBtSjlHJ7TdYqXVBixizLE1xbKXRgVC/g78A/Z0E7u8oKVOTO06tAQM4vGdYAvn8xuo/+vY0Xsn/RV3WfaTP1nOF9uEitk8TSWcMvRTEY/PBtxmDOEqvo6YbRDsUUCqMzfOv7rrRcJlyElrJcp8eO7ex/DzG0+SYzEImaMkI0WSq/9L/d859g7nHvFRzJ02VoDOfg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3077.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(346002)(396003)(366004)(376002)(136003)(52116002)(7696005)(26005)(2906002)(16526019)(66476007)(186003)(66556008)(478600001)(103116003)(316002)(6486002)(66946007)(956004)(54906003)(86362001)(5660300002)(1076003)(8936002)(83380400001)(107886003)(36756003)(4326008)(6666004)(2616005)(6916009)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?svZl6ozDJnxKppplU2Xj+CdHRf1s9sVexj3nCSzgz1dV5cl37RMnjruCxcUc?=
 =?us-ascii?Q?1UKaTSlxNDdy9+TF6TlMIPAG8RIOR3JKVoJb5kd3SnKtimrYMc30QOZ46OEy?=
 =?us-ascii?Q?pP03fVy8rbwc/jfUuiHZ6d6AMX7C83w06anGFHpMEaLe0ixd7ww9nZMhJdM5?=
 =?us-ascii?Q?2WNwH6pva2LYm7VWs1wYsasKaYJ2mDk5FgoCixqaxIn6gXc6RwW1sa6xGa4s?=
 =?us-ascii?Q?zlvk7hsg6alpOl3w5x4RKtJrbk4aQ4Zn7ZXO9THEQNptQQL7sVq5JRLjemPg?=
 =?us-ascii?Q?WlantCU8fAa4FgyQsrMsH067+qhwj3eBFjrZfHWhZvTVYBijxsJ0hJzcMXcI?=
 =?us-ascii?Q?aLxMeqw2MEK13fjShF4DPtse0FxApwCRS3dZEzw8JkYJQrlXiXuFw/8weMEJ?=
 =?us-ascii?Q?u5t4cJAFqAT+nwm9DTp7DRgGKH57FWnHkzib+ly/RO4smN4IM1cgSdbpp7lX?=
 =?us-ascii?Q?jX0OoRJ412w0Z7Qg+MP2z/s1qKh2XUeKcpnHvNgfj5w9+0cCKCA0FeD8HSqq?=
 =?us-ascii?Q?18y8ti5X1zq+YIEOc/+4VK1/i2+q6zBROZotEDgGlb/5i0e+wh2Ept2LUMdw?=
 =?us-ascii?Q?KQppi6gp9iFh5vn9TnGD+tkgi3ysltRnkSCwhxbU/itTYuXb4/z9jw1UqjQg?=
 =?us-ascii?Q?uBYJzddb5c0yn+lTC88Vy855P0mj32cghOnNxax2GGW6iJUdm7HHw3rX0YNu?=
 =?us-ascii?Q?I+Vrm9FerSEfmMy41NMeSfPf+yMQ4HBMSPlISuS5DT93a9vps3ji10cq8T+l?=
 =?us-ascii?Q?jFEbHJbN5WyNoxRHFgjAOsa35cLp0Zbz4jMfj+OFmC7W+gkcRyQKpRrz1YzM?=
 =?us-ascii?Q?6mO5pT292WBzGt0TteX0PsMpn+BXASjFmjfSROyDku+yR161JfRVoXsoeu/u?=
 =?us-ascii?Q?m0ltbekvAZbq6CjLf0BRlz144ZcXoNnyxc8fCyLdmM4I3qGNzmZxLn7DPmIs?=
 =?us-ascii?Q?cJqy7hJj4xpWeOkz52tzsz/8iyOSiMa5WyfoQq82tQsoDoJXpq/BnAh42s9v?=
 =?us-ascii?Q?2i7PnPjr4kup8kWDHWLZ+yUAfpRyw8ZjpG3uZNnfG8MEiS/oaoJ0Ky+7wDhc?=
 =?us-ascii?Q?sUhSX1Vs?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 591bc5d8-446a-4b84-381b-08d8c94afb1f
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3077.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2021 20:25:15.2354
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jxlLFD8qzSXD3HFipxxcKvc8aoQYXWpX438mWK7bsalqDckNrsF2U/2cINMCA9w4FJj4T4S0wbrhG0xEwj8EgCbneHi0LxxMSdpY/z+iobA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4590
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9885 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 suspectscore=0
 spamscore=0 mlxscore=0 malwarescore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102040124
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9885 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 clxscore=1015
 spamscore=0 lowpriorityscore=0 phishscore=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102040124
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
---
 mm/gup.c | 29 +++++++++++------------------
 1 file changed, 11 insertions(+), 18 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index d1549c61c2f6..5a3dd235017a 100644
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

