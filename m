Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08DCD31134D
	for <lists+linux-rdma@lfdr.de>; Fri,  5 Feb 2021 22:18:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233591AbhBEVST (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 5 Feb 2021 16:18:19 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:52198 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233100AbhBETAp (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 5 Feb 2021 14:00:45 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 115Kd1tA017993;
        Fri, 5 Feb 2021 20:41:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2020-01-29;
 bh=nXQCScTnEmz9YpfAfESz0ZBlMiwzMlpLGxkAJpBxnVo=;
 b=QQtB5LdyOFniFaaDZUKwfzJj84PLhwPf/qhABEnHO1JfBcqj5Z6wCZQeW6fb+pgvpzIk
 SjguMYT/h50IQP/QFVAf5ZkmDpWSxGuwerukj145v+qwqvvSc49o8xwBa0tzqt6RRCXp
 Ks9grPaH8UDaMYvvLRWNyPrRjbZFXs4hbb7j3q6JF6671WBS/3QoSh0V2g4zxl5sTwLZ
 rnInH3rsKeB3iMkJesSzr1nDAQIFEgoH7GEEGTJ3jz9yeTl9gttT7vcGDaOgP0g1ebZv
 YORmnlprFdkuA6aidoBHPwwZU/o9lzGU8nz0ajaeaZlyY2ER3eudc/VwiQoEhzaQCMDS Yg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 36cxvrdu59-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 Feb 2021 20:41:59 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 115KelXG041067;
        Fri, 5 Feb 2021 20:41:59 GMT
Received: from nam04-sn1-obe.outbound.protection.outlook.com (mail-sn1nam04lp2053.outbound.protection.outlook.com [104.47.44.53])
        by userp3030.oracle.com with ESMTP id 36dhd3fqjt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 Feb 2021 20:41:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eXxzYD7LK+Afh24bCjjKiSCbRoekJnDQG4Ii5Y/FKsf2s/hr2oTevVWeKdlHw3B7qAXatwRwBSuMWCkWhVEGkJvkzqg+es+hDjfIiSzGKPHKzY1PpVG3wEzCTLRQ1W9tslwtX4XDMs0G9XyrFP0bu3JjbckbeBHV0M4hjDDFfPkJ+lYVktuYM/RNxbQepIvU0sCEkA9a2wZhKa53yV1eiGvWKU7uB4MTsYgJ9OIuE+bwN5nu0zIPYhPKwZGIl0TGpnwx41gtkiCRiqHdkrybvVE30L32vaZCL5hgPQ1y7BJOsd8l+fxtkBNjKcpmpo3x7gOLPVnJO/BHBY6icEc2RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nXQCScTnEmz9YpfAfESz0ZBlMiwzMlpLGxkAJpBxnVo=;
 b=LjH1BygoFaWVwLkkOO3YU1XdNyWXSzJlp/4bUCOKmbyX7SKKLvyVpWJgkyRFzKXfDuvZp0bx0x94c9mXnaqIoV75+AHYNX+XQRkX6fJl6eiyQLlWtFXRWMm54GTY53RJBtY+z8BXqyKOnzCFM7mPUOjLt4XbsJf9bxg2CT0AKlLCUw63u15Yu9UbMnQLXbNOEIoB1SZT8iXtRbIdwMokdo9WDL9VgL0vIC6lGbXQ0OQ8ggYR/P4+TGM0G25/yBTe7HymrTQIW6itwmQbzRqgEsiTmThVIvT7filj67uh1VRY/7zXpfUg8M0xSZthFolkGjiQFcZFoUfdQh1N065qOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nXQCScTnEmz9YpfAfESz0ZBlMiwzMlpLGxkAJpBxnVo=;
 b=EclOh5Duf2mtaSXz35E6/1DO4QDtZUbQbSJP+WZ15AN1OOdWFugmSITxbyF9jVN4yha8slWs9AGLJgOr0Al7hoExbAhQaV/KWdPIT4O7pXKKNw8deI863HF2a4aYjfhL4EAbF+BDU17JOJyt8WJrrhe1VfTt4HAX+YtldhM6jNo=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=oracle.com;
Received: from BYAPR10MB3077.namprd10.prod.outlook.com (2603:10b6:a03:8c::12)
 by SJ0PR10MB4432.namprd10.prod.outlook.com (2603:10b6:a03:2df::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.21; Fri, 5 Feb
 2021 20:41:56 +0000
Received: from BYAPR10MB3077.namprd10.prod.outlook.com
 ([fe80::74a8:8649:e20b:d571]) by BYAPR10MB3077.namprd10.prod.outlook.com
 ([fe80::74a8:8649:e20b:d571%7]) with mapi id 15.20.3805.024; Fri, 5 Feb 2021
 20:41:55 +0000
From:   Joao Martins <joao.m.martins@oracle.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Doug Ledford <dledford@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Matthew Wilcox <willy@infradead.org>,
        Joao Martins <joao.m.martins@oracle.com>
Subject: [PATCH v3 2/4] mm/gup: decrement head page once for group of subpages
Date:   Fri,  5 Feb 2021 20:41:25 +0000
Message-Id: <20210205204127.29441-3-joao.m.martins@oracle.com>
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
Received: from paddy.uk.oracle.com (94.61.1.144) by AM3PR03CA0058.eurprd03.prod.outlook.com (2603:10a6:207:5::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3825.19 via Frontend Transport; Fri, 5 Feb 2021 20:41:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7d7084ce-126e-44cf-fe20-08d8ca1679f0
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4432:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SJ0PR10MB4432286E1E91053F7AE7BD03BBB29@SJ0PR10MB4432.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hV0JdkC8m975A76sTARfBvHapW7oQjoTs7Let4b7nVHvCFuvRcfzqwO8n7cZDEvS+6qsnvlRozbhVs6P0i6r/LEuVmvbEKVT9Agnd4SuOFuFbMO4J9nMLdRcbpI3vLSTNWFZZFlcI6/wMTvlR2HCGJ7dXj0lEk13AaedcD/IoGrNa9LuN6HV2SjouvY3iat5qxF8GElypQlxf0fTxO3EVaXOVllZ+XRb2RaGYpLf22mLWz4XchOCWaQk7vdyKvDt4F8dY1yXSYBeWazGBLkRM3XV9VnjvfXR9FOJpO/PtRFyuu+QwKyzbxNjRHQ7X2V1sH33qLvT+KrzsPBvN8CvvLYSiToVnMY3zw+HnCOWMP/A2fJjmKW4I80YTJIrsdJqogYnfiDPX/WNdE6Gepm7b7rYH4ytaQZUSVBzpAaUZWVsl6QdrmySjohkKVsZVJnv1ukrF8mhV6EpTWn49hulCevWnljtjtKicWUe8dv2c4lJdyKs+/xImjY4UimeNPtGz9D953dmw+7GPegRbbEpIw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3077.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(396003)(366004)(136003)(376002)(39860400002)(6916009)(1076003)(5660300002)(186003)(26005)(54906003)(52116002)(103116003)(4326008)(8676002)(83380400001)(66946007)(2906002)(36756003)(6486002)(478600001)(6666004)(66476007)(8936002)(107886003)(66556008)(16526019)(2616005)(7696005)(86362001)(316002)(956004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?RHB+wNW0N7tpUEVp9oj3rB5w1u70Z1VZTNhF0vWEEqYvw41h5Q73oBj9W2Mc?=
 =?us-ascii?Q?3b9p1Q5neFVcuNLYqbcGMMDti5NRSG2PR+B5p0cIIABp9zLBT2314mYMy+HA?=
 =?us-ascii?Q?CQmU1nklRvkSzPCdePN2NT+QxYLteAE+nJdwwbHA67KeFyRE4A1fYUpoJXSZ?=
 =?us-ascii?Q?nPKsdhZ2OEUIzMZwoiiUmprxdDD/lSiQqu7LTz9W+Twi1oNJDnLkmuDiSIMD?=
 =?us-ascii?Q?PwjSKmA/ZSLSgv/2wXHmOBx5HFYsSgP2uGlpDEAPvZ9hA2nYkEQsOrYeGZ7z?=
 =?us-ascii?Q?iL3LlNGA11l486te5820PrD8Y9efbCseIk3VTDyg4S3sLVlixdn+rpZE7nwr?=
 =?us-ascii?Q?HRIQIPitS2M4xU9KlELrP1x2tBoxynsrPXOnvBLU0WSw/A8jwxVCUsciUx6T?=
 =?us-ascii?Q?tYNVvqW82eayljIkZomBbObwEXIuYnpDA2EN3gD3Hmu0fvMvNCTSSPaElIUK?=
 =?us-ascii?Q?Cndc62N3xN2/vbaB9CUZ9tM98DoSs/vudrHDk1/AssLFARp0JxrSJF4ZppcF?=
 =?us-ascii?Q?4IpFUdWldnKoaBOKybn9bsdEt8+HNDUhl0pvmTLvVfbTSoSD44VaK6erSuQt?=
 =?us-ascii?Q?W2tgUmJFr4/RsuGUwPABFPdM3bdojwAZPtesyeEqPJO1K+4ImcQzGWcKZfaK?=
 =?us-ascii?Q?KBvpC4SsOkXxxWv/wbRBNRs9kmBIFIbiWg+tqiHIOsGgHIXy4EJKCT/8rWEB?=
 =?us-ascii?Q?eW54BdamXh9KDoVLTERoe1Y5vWE+RBFcmOEkaXHDZ00pNz2HJwyO0VNwCVbc?=
 =?us-ascii?Q?plAcuFBJaUJ6jInFN7ELuPNnVlpS6l7xuG/k+5iRfxH0z7fJnSnGQALMc6pG?=
 =?us-ascii?Q?NjAeFITo2lQa4z0pLHPboepkSvEm2XQPb1lNiD1jufmw3mGWODXDym5YuP4k?=
 =?us-ascii?Q?WPHT7qOYVktLNhqzEZ1fshiH/+AWRE8q7rHHxeg8l2reFG87xCLaIZ08s1UN?=
 =?us-ascii?Q?NQoOOqufLu4uSWOOIsvp1Snh4OrbhOKMMCZav1pkeTD734V5Hx2SFO0R0r95?=
 =?us-ascii?Q?amwSP5lcNAKOgENv5WCz0xu8bL1+K204b2Vzq75v8L2x8binailRuezEd9Mp?=
 =?us-ascii?Q?+Jg+0wXPu6fh/shb7cn0uTeqXt/0WlMPJje9Lv3ASuZX7kJuEFTdJgPlKrzg?=
 =?us-ascii?Q?wSpO5+VmUvRooFPHD/D4e88nXm74b3puGmywpOIhYuzdqAoLyl2pNk0IYx+R?=
 =?us-ascii?Q?4w3XckPXUHX6Pna2EFkXfaXi+f4J5pjjHkctawUoQHIUGwx+W/Ihhj45Capm?=
 =?us-ascii?Q?8pqX71H4HBjA/fsDbjKKDrpvYAfoG5VKdw4lTDdDUUwpaCiTQdRfYf6LIm+O?=
 =?us-ascii?Q?DNEgILN+NkyEApORNY1uvxMC?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d7084ce-126e-44cf-fe20-08d8ca1679f0
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3077.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2021 20:41:55.8532
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BGkrzbTDBEqgMJm9McZPtfjgjmP2Ho3sN2HN8j97951Hj+6LkimmvnlSFFrFzkwxFobQWVV9dzYV1gKyEsAN7+EKh2P2C8yLZywmK8qehfQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4432
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9886 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 phishscore=0
 spamscore=0 suspectscore=0 malwarescore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102050129
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9886 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 mlxscore=0 priorityscore=1501 spamscore=0 impostorscore=0 clxscore=1015
 suspectscore=0 lowpriorityscore=0 phishscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102050129
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
index 8defe4f670d5..467a11df216d 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -267,20 +267,15 @@ void unpin_user_pages_dirty_lock(struct page **pages, unsigned long npages,
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
@@ -301,9 +296,9 @@ void unpin_user_pages_dirty_lock(struct page **pages, unsigned long npages,
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
@@ -320,6 +315,8 @@ EXPORT_SYMBOL(unpin_user_pages_dirty_lock);
 void unpin_user_pages(struct page **pages, unsigned long npages)
 {
 	unsigned long index;
+	struct page *head;
+	unsigned int ntails;
 
 	/*
 	 * If this WARN_ON() fires, then the system *might* be leaking pages (by
@@ -328,13 +325,9 @@ void unpin_user_pages(struct page **pages, unsigned long npages)
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

