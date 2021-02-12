Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71C39319F8A
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Feb 2021 14:12:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232070AbhBLNKx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 12 Feb 2021 08:10:53 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:57130 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231952AbhBLNKI (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 12 Feb 2021 08:10:08 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11CCnvg2167631;
        Fri, 12 Feb 2021 13:09:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : mime-version;
 s=corp-2020-01-29; bh=WSbBM7PtGpXLsEuLwh7yJ5FLn3Jf4ndP5Mw+IX7i2os=;
 b=PrILnExuY3m4efcH6gdrMxjRXjDwu3bIjwIxAG5Mja4b8mmDaTkiQlQp5O9txja6bfos
 k8U3MsqXZG6zn7bsWmhVITfLNWk7e1jIszLDkiSSaSoJwxOodzXmTVDk0poEgH3uz9gg
 QB9f1ogHYuz+H3dOYrbK8d0I6hdh2hoKlXUmR3FQl9WKb9cONc9fAgB3Lir2DTjNnDuz
 WaC6OQQjnTUR7XCY30kGVbyvfdg3r6V/eTs7oYXQ/Yv0ygjMayDl9unIUEHY0dv5oTxg
 LsWgAH/yVBbWJES8AEu9ek8bI4ISBWSRqqe/+kH/1iWQYiQ463X1Z5sGez9mhdgXO2Nl Sg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 36hkrnb2ft-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Feb 2021 13:09:04 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11CCo6t5055467;
        Fri, 12 Feb 2021 13:09:03 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2172.outbound.protection.outlook.com [104.47.58.172])
        by aserp3030.oracle.com with ESMTP id 36j4psyf3t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Feb 2021 13:09:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MBrViagkWY7EGlZgtoNaGhbm22fqBV+LYnAS4dAlZP0qH/89X3NPhXOyV1InrTdhxmeWAOr7pvb8GA/uxNAPkR28lgoUSTDBgllKl/o9wZ4IQ51lIGrfohZ9Mb/9a40i/787fhqqiCa8r+04FKVv4g/IPFnuhHmno9FTqtFshLS1AS6DifY8zqcLsJHBXVP7b0jkFtHp4x4kLGr/xu/n30dKScCZYLi6jpmP4DYjcYGlrEsmUx/xHNylvf3UIksSdkmIrHT6GDLIeHtRCCtAlFDfFlvXM9oYw9ue8TpvGtFuza37sDfcB5q7ibo6eOmDfYCkzG5b5fCegupeo4fXpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WSbBM7PtGpXLsEuLwh7yJ5FLn3Jf4ndP5Mw+IX7i2os=;
 b=DwnjOuseWOAJ54N22bUZeCBTGwniZq/WOYK23KoQ9LIQVdEDDW1JdySyyNaHKcRWrqABFL09azlVXrD9gjkkaIjvGNrSWjbB87us1UrNZxWKaLvPv0n4yPXUt5mcq6a+yGfCxDblbDune2nTRMFIAc3HXr0dlJLKyQJNQMLXhkrbEdk5tT+5Gbm3oxdfROotWL6PQ0jKJ0O81ayYCIWuQNHL3QItCRd01aAQ/uHOZewA2Bu+eFBcB2URX1bcuP5n4hTrsot1lXjpA/o5GWJR/JY5oXdebU2k1xYLgHgtrTw5EUIKFXZE2sBVgdSXuzF/HA4TntxR7XHWIWUcgXGrWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WSbBM7PtGpXLsEuLwh7yJ5FLn3Jf4ndP5Mw+IX7i2os=;
 b=kNqWIwGEYiQJHq8H1JLZFEQUvGMKY/2pxmiUdGtrZm+AFXkV73MjPTfiAZBcs0IXM+nISxfYd5zHxFZSOcXz6zMva8uEygGTO/BpH94QH+lD94eBW37BGQmipe5voY6KVk8RVvquq8l3sEtIZyG9+nKF/UFqJneKzcn/qm4lbbs=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=oracle.com;
Received: from BYAPR10MB3077.namprd10.prod.outlook.com (2603:10b6:a03:8c::12)
 by SJ0PR10MB4509.namprd10.prod.outlook.com (2603:10b6:a03:2d9::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.17; Fri, 12 Feb
 2021 13:09:01 +0000
Received: from BYAPR10MB3077.namprd10.prod.outlook.com
 ([fe80::74a8:8649:e20b:d571]) by BYAPR10MB3077.namprd10.prod.outlook.com
 ([fe80::74a8:8649:e20b:d571%7]) with mapi id 15.20.3846.034; Fri, 12 Feb 2021
 13:09:01 +0000
From:   Joao Martins <joao.m.martins@oracle.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Doug Ledford <dledford@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Matthew Wilcox <willy@infradead.org>,
        Joao Martins <joao.m.martins@oracle.com>
Subject: [PATCH v4 0/4] mm/gup: page unpining improvements
Date:   Fri, 12 Feb 2021 13:08:39 +0000
Message-Id: <20210212130843.13865-1-joao.m.martins@oracle.com>
X-Mailer: git-send-email 2.11.0
Content-Type: text/plain
X-Originating-IP: [94.61.1.144]
X-ClientProxiedBy: LO4P123CA0347.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18d::10) To BYAPR10MB3077.namprd10.prod.outlook.com
 (2603:10b6:a03:8c::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from paddy.uk.oracle.com (94.61.1.144) by LO4P123CA0347.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:18d::10) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3825.17 via Frontend Transport; Fri, 12 Feb 2021 13:08:58 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 45660e2a-ba55-4714-caaa-08d8cf575d88
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4509:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SJ0PR10MB4509B4CE89D21CD45BF81B3ABB8B9@SJ0PR10MB4509.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:112;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aJWohGYfwsreQGWZY1Dtw5+KoizcX3HJ70iNUEQld/sMywgPr5QJXPtJR+TYFrxFdhO+2qz825uBnLuAG+k9KvZMIugHlZmT+96vqBSL0ZhscGS2QAAUoQrrFYpFWlwVP5qhZWQOjDLMyGnNe+cBjWIahs4vJcieupmT/H+LJ8MVO+qHj8dmPT5fbE5nAHn5SXVl+XQIawbU4r28/GjnG6z36xlYMyD9t064Un11GKTnzLf/4cJQ8FPIOZqX6pSI2kkIyaTD5GnQrcsnriTeAi7MCH20GTPJMSpNS+aHPKh3SzsXKgCcRLm5uCv0s95g8dRyMVLzgZREg4ub67Ys4AwGjN6KcMOIbDv/o79UsHJAW1dpDSBxGuBQQpiSKxQ6vjG3HM+ZOt3OsQuxEuqEoOziVlNayO6fTOvFbQ8wpCZDWKb+06lTnE6VI9r38wlj5jMhxGOlqwIqau+9TrAQ0GT16ut+QssRvTDG9Ex6Bb2Su+jdnNMbFqMjW4V9YO/Uk5Eb4vEQfVmGo+tXyks9skStIeK1unsidaloSzFNevxZ5d88i6E0W4bOtsbmimCJl8LTugIiGhPeEWfbMrQnQFkWCOL8/WnpvN1PfyUDZ+A=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3077.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(396003)(346002)(136003)(39860400002)(366004)(6486002)(2906002)(8676002)(4326008)(52116002)(186003)(966005)(26005)(2616005)(1076003)(316002)(8936002)(107886003)(6666004)(478600001)(6916009)(36756003)(66476007)(5660300002)(86362001)(66946007)(103116003)(66556008)(54906003)(956004)(83380400001)(16526019)(7696005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?N6eqRFEEVWFECrkkJnYOg20//hKYKHI8QGmdRsgU6iNHn3XM/9L4gjDdy1kW?=
 =?us-ascii?Q?YQe39Aa2NkA2RKp+qCOjXIT/S3HkPBAoaHr8YhEzToTaMXxAhK9sdlGALmXR?=
 =?us-ascii?Q?hnaobiv/5+zpTjRviE0J0Elzty6BL85rrXPe76syPS1E6cGx5gUN+wCg+TQ3?=
 =?us-ascii?Q?htMyDDSVWGTzNo1obeo1lsg0HxGRZv65no3v3vc/vmdl3szEyyL+IkOtPSRl?=
 =?us-ascii?Q?RhXWvNJ/K6qxkewNxwaiM2dpIh7j7XB5ml4GOcYX+voo5Ak7UOog9tw379E+?=
 =?us-ascii?Q?DJjtc6kBEuEMiYGIDDlurOigUIMBQk7XL6Di0AOpflYnjzmB0rv9/7TMOW1r?=
 =?us-ascii?Q?HcyWDx7vVn2+muaqEJsTNQszLr+4YvBFp9XyC3AqMe/apBHXmH8Q1/bXOlQT?=
 =?us-ascii?Q?hwPJ/7x+BA4fOQ30pn+o44GE4Ae6Is9GVTcIlCTTx+syvRr2m0wY53H7D8nN?=
 =?us-ascii?Q?lJtiKXb6/VxCSbQvJjK0DJsZWak0TwcFxTYuSNSnhmJt8ycWLOPG0RL2ehxV?=
 =?us-ascii?Q?x+ii1KMjHgyJYEnwIWakzRb182wse6DeMP9+ZdsP76NqVKr6W/dswdCGMA6s?=
 =?us-ascii?Q?lBzeptW1XDzfnHReEZvKW9aQHxxvd9oIuExQDovEZsJKQEC8CmLx23Gw6SQI?=
 =?us-ascii?Q?YrDOvuvzPMdUo7bXcVGAJuX7dSKo3DUQAOMLltbrUwagA79OjgzXKBnwOECs?=
 =?us-ascii?Q?UP3+dhM9gMrD5yEE8HBPBSb0zBlVR3iYQJBI2dT+B4kf7/JaIEb1tVVkM3+O?=
 =?us-ascii?Q?Rf54/UdyyRLoOVsCMGwtOyQjb5aJ7dH1VObyi/O+3XRjN0LUBd/4b5wRriXi?=
 =?us-ascii?Q?7V+hoaWjhr2sA8WVVOf+5XM7RKeRbYABPprw2dy9Ds0iVYMuMiGJPnrt6kew?=
 =?us-ascii?Q?Pp7ApsJJaYjB2rnZHI1xW2TqNLnfFINjXOSRe6ZxqjZM8maSjdO9tqcVL5s1?=
 =?us-ascii?Q?5zAdpjy12uDInsUiFxgJAT5zip1PpQsIyNyAkPE3/D5A3MAPPZRcTlKFTFLP?=
 =?us-ascii?Q?sNGl76iInEJwXLuEnIlVq99/ZyND1IRt238kG3/rjol+I/m/VTgeTKux00f5?=
 =?us-ascii?Q?fltSYwKLr39E1ad6ZPaR7fPRP70h+yKWu/Z0bac6PIjdDnX99m0SBwsSs7Bm?=
 =?us-ascii?Q?GWDsmRmvRLorx26l8VzhcetEcCl5ueWZpwIcerPX7wAhuQ7LyOa/3rimNKHZ?=
 =?us-ascii?Q?m+a6ka5ueJuNQVs7tK4T4gORrfUFW2XZMBvtVdwg6oYJCeSihlRyQlEETMNz?=
 =?us-ascii?Q?o5rnarCSj4LBqyzZALcJcvtr/s6LsZU901f8yMyLnSzk8DQDtkmXrKc1iqoZ?=
 =?us-ascii?Q?5WU69zr9zjWLuqYPyLz8MXKY?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45660e2a-ba55-4714-caaa-08d8cf575d88
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3077.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2021 13:09:01.3084
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m12/oLIqsq6dlqAC2EQHsu0Runh9iQSgG0beeXRFgjmoQj+IrEARgKqSXmpB/FJLcHjMDXrjrP+77nxB9Yti7+AE5PxYZ9T4JoAnB0bt6rA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4509
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9892 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 phishscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102120101
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9892 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 priorityscore=1501 bulkscore=0 spamscore=0 impostorscore=0 mlxscore=0
 suspectscore=0 mlxlogscore=999 adultscore=0 clxscore=1015
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102120101
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hey,

This series improves page unpinning, with an eye on improving MR
deregistration for big swaths of memory (which is bound by the page
unpining), particularly:

 1) Decrement the head page by @ntails and thus reducing a lot the number of
atomic operations per compound page. This is done by comparing individual
tail pages heads, and counting number of consecutive tails on which they 
match heads and based on that update head page refcount. Should have a
visible improvement in all page (un)pinners which use compound pages

 2) Introducing a new API for unpinning page ranges (to avoid the trick in the
previous item and be based on math), and use that in RDMA ib_mem_release
(used for mr deregistration).

Performance improvements: unpin_user_pages() for hugetlbfs and THP improves ~3x
(through gup_test) and RDMA MR dereg improves ~4.5x with the new API.
See patches 2 and 4 for those.

These patches used to be in this RFC:

https://lore.kernel.org/linux-mm/20201208172901.17384-1-joao.m.martins@oracle.com/,
"[PATCH RFC 0/9] mm, sparse-vmemmap: Introduce compound pagemaps"

But were moved separately at the suggestion of Jason, given it's applicable
to page unpinning in general. Thanks Jason and John for all the comments.

These patches apply on top of linux-next tag next-20210202.

Suggestions, comments, welcomed as usual.

	Joao

Changelog since,

v3 -> v4:
 * Add the Reviewed-by/Acked-by by Jason on all patches.
 * Add the Reviewed-by by John on the third patch.
 * Fix the wrong mention to get_user_pages()  in
 unpin_user_page_range_dirty_lock()  docs (third patch).

v2 -> v3:
 * Handle compound_order = 1 as well and move subtraction to min_t()
   on patch 3.
 * Remove stale paragraph on patch 3 commit description (John)
 * Rename range_next to compound_range_next() (John)
 * Add John's Reviewed-by on patch 1 (John)
 * Clean and rework compound_next() on patch 1 (John)

v1 -> v2:
 * Prefix macro arguments with __ to avoid collisions with other defines (John)
 * Remove count_tails() and have the logic for the two iterators split into
   range_next() and compound_next() (John)
 * Remove the @range boolean from the iterator helpers (John)
 * Add docs on unpin_user_page_range_dirty_lock() on patch 3 (John)
 * Use unsigned for @i on patch 4 (John)
 * Fix subject line of patch 4 (John)
 * Add John's Reviewed-by on the second patch
 * Fix incorrect use of @nmap and use @sg_nents instead (Jason)

RFC -> v1:
 * Introduce a head/ntails iterator and change unpin_*_pages() to use that,
   inspired by folio iterators (Jason)
 * Introduce an alternative unpin_user_page_range_dirty_lock() to unpin based
   on a consecutive page range without having to walk page arrays (Jason)
 * Use unsigned for number of tails (Jason)


Joao Martins (4):
  mm/gup: add compound page list iterator
  mm/gup: decrement head page once for group of subpages
  mm/gup: add a range variant of unpin_user_pages_dirty_lock()
  RDMA/umem: batch page unpin in __ib_umem_release()

 drivers/infiniband/core/umem.c |  12 ++--
 include/linux/mm.h             |   2 +
 mm/gup.c                       | 117 ++++++++++++++++++++++++++++-----
 3 files changed, 107 insertions(+), 24 deletions(-)

-- 
2.17.1

