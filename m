Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6A253112B8
	for <lists+linux-rdma@lfdr.de>; Fri,  5 Feb 2021 21:44:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233360AbhBETBL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 5 Feb 2021 14:01:11 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:33808 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233338AbhBETA0 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 5 Feb 2021 14:00:26 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 115KeRU4135734;
        Fri, 5 Feb 2021 20:41:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : mime-version;
 s=corp-2020-01-29; bh=7UPmf3w0lJGQpONOccDVkx5jTS8GSLBZOmfFFXzOoX8=;
 b=o4+g8i9r/+k7DXNjdiO+Ipvfh4lGekoujSrwMs53B+ZnVksOu4KJSsx/LmB8Gnz9uC08
 VV1pGDNw359A5ou4x0OzqI8mRrOpl0DnOONqGwp0egMcxMeavAgRcO+HdrksLQgxyIqZ
 Ps/WAqwxqR7kla7pROrC8j+5Lv0Gviw4Rr9t4lxFZRAuMDUGRj5DgHsfeoUaQtldos9f
 nQvIOItIat2ORF68HM19YiQoKdWYutOHFVzqrGrAtwAPq7E5xVJ8aje2nh48G2LW8cK/
 HuKGGInGbNv7+0Xu8Z8h6oM3uZI6RaQLirNJK4DqV6pT9yw3rfLbFLmvnUsbsohQfKXa Ig== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2130.oracle.com with ESMTP id 36cvybb8df-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 Feb 2021 20:41:52 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 115KdfsC065119;
        Fri, 5 Feb 2021 20:41:52 GMT
Received: from nam04-sn1-obe.outbound.protection.outlook.com (mail-sn1nam04lp2057.outbound.protection.outlook.com [104.47.44.57])
        by aserp3030.oracle.com with ESMTP id 36dh1uehyy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 Feb 2021 20:41:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k2dtgSlaE12EuxOgi3EU09wYczxI4B5s8vVieAdYEy8J5/XC7E62Rj6yFSA97QQEbeDSW+N/YxKGA6ws/bgOXsnSuflA0FHHoEGCTRW1A8BerAK4AA2mCrYoUD37+fjp6c4WkXfmADCiV/zreDeBPs84DoIGg0c6zwglEM3J9zRiczs2CSJtxlnherKIP3epfscF3dKW2GQ60ZtSbQf1gRqNbJSbvT0auYUwrQj1wK303bC1vKxB/6mJQSuey+DwqKWYxthIqvllG4REXd1NjA05hJzN2ogw1qos6kpf1I8EqELHcvnUih5LGjI+rjgEGPfYvgEA7I0t1fdIXcFnmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7UPmf3w0lJGQpONOccDVkx5jTS8GSLBZOmfFFXzOoX8=;
 b=TururGeULblqFRs+SDCjAwuRB0CimslW2xyvxEzu6WVK4lvTMTrdNznyCF1wNrRxjW/vg93yyy5JDeDZQoVl4fLkKWDsMOLNbvMOx6auYxDVjVX1oF6Mad6qdKaJWeUxYRgmiDpnPNnL++qF50tCYnYhLDHtzyN5IfacU/ZdMcBgdP2A7E/MBgGi5qXQii24/OnsqstXNUzCFBG6Volmn2zd71p40xw18VCCAHPzUa8Gj4XXgIK712vbn417Av27y9nlaYK3VWLuMgAL4uiqkNeacb9k279JLF9Ehttj13NohyXy1ORM2Eor/qSLJ6NJ80K1yIksh9DjFQYZZD1CUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7UPmf3w0lJGQpONOccDVkx5jTS8GSLBZOmfFFXzOoX8=;
 b=zTzUwJdwC13Ek0M2KYq88cMh8vuETSUwB2E9EcM6hzkZnAXbNybnfgWhb4gDk4KDNoOaseY8bZ50LK8j3pXNWpLxl12+kddDJzj4bk/mLsgx5J5BWtsQfM6M3BsX0txOAoDyKWjoNQ8z9qMDuc7dGGXcielSDCEXJr7WHUTv1IM=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=oracle.com;
Received: from BYAPR10MB3077.namprd10.prod.outlook.com (2603:10b6:a03:8c::12)
 by SJ0PR10MB4432.namprd10.prod.outlook.com (2603:10b6:a03:2df::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.21; Fri, 5 Feb
 2021 20:41:50 +0000
Received: from BYAPR10MB3077.namprd10.prod.outlook.com
 ([fe80::74a8:8649:e20b:d571]) by BYAPR10MB3077.namprd10.prod.outlook.com
 ([fe80::74a8:8649:e20b:d571%7]) with mapi id 15.20.3805.024; Fri, 5 Feb 2021
 20:41:49 +0000
From:   Joao Martins <joao.m.martins@oracle.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Doug Ledford <dledford@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Matthew Wilcox <willy@infradead.org>,
        Joao Martins <joao.m.martins@oracle.com>
Subject: [PATCH v3 0/4] mm/gup: page unpining improvements
Date:   Fri,  5 Feb 2021 20:41:23 +0000
Message-Id: <20210205204127.29441-1-joao.m.martins@oracle.com>
X-Mailer: git-send-email 2.11.0
Content-Type: text/plain
X-Originating-IP: [94.61.1.144]
X-ClientProxiedBy: AM3PR03CA0058.eurprd03.prod.outlook.com
 (2603:10a6:207:5::16) To BYAPR10MB3077.namprd10.prod.outlook.com
 (2603:10b6:a03:8c::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from paddy.uk.oracle.com (94.61.1.144) by AM3PR03CA0058.eurprd03.prod.outlook.com (2603:10a6:207:5::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3825.19 via Frontend Transport; Fri, 5 Feb 2021 20:41:46 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5a59e25a-de0a-4c1d-c753-08d8ca16764a
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4432:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SJ0PR10MB4432C6DB554218A60703B08FBBB29@SJ0PR10MB4432.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:112;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RRr/pOF31v++qXKSM/4qmL3Yd3QpvD9HCbo8fD7FjZJKpWs2EL7OCVx4nGHjNhBnkDYavGluvaud86bl7QaE/riQHivoiymcVHKeMmpDSrg7jJuYTEYOJf3mJjWrZDczOf9x9Noux88/IJAX3751AGumtx/vhW0xUkgPIIyFROEz1ObomSwZR924aCqhyscHoGBU5yx2oLEBTaV5BhTC3hxCR+GyBH3PeqvQwUDbjCAnJW8BRRJIMNx7Wdg8ZHzX72NcPor8U4N/2qvpM5jsPDVeHdqt5Xz28pBbIN74D0ZUaX0sZo+qAnuTlTIQqH0a1FAK2D0+BNFBx5c6vBGLDLZlnClI7mm0GJgQO/+8ip2vl6ywjylc80fiSuhJXoXgYDzCtK/W6vr2TcYdxqEoIydtQu0bX5eHS/MX5HhVfO/8CP1FfGN0DpmulGVPfPrbhB63UgtX+1FvsmHpBR5ZBdaw/qiCtNw5sFfGnV8/GzSiGeP+DQ4rqvlCVelyErVLKRqpDojvmNOl8p8tlWH40vwVD3geNWF9Uv2MnD2qYX/K2D8wvMjOx92oy5G4yQ+6kt45VxbOwLoMOvrqDWaE2UY4jvkAT4j4iakcvzLlwsI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3077.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(396003)(366004)(136003)(376002)(39860400002)(6916009)(1076003)(5660300002)(186003)(26005)(54906003)(52116002)(103116003)(4326008)(8676002)(83380400001)(66946007)(2906002)(36756003)(6486002)(478600001)(6666004)(966005)(66476007)(8936002)(107886003)(66556008)(16526019)(2616005)(7696005)(86362001)(316002)(956004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?dgdXciARuLbaIatJJaTDvsDT2QDOESsOy5WNfkkzSeC56WJUa5YmVEXrKpGh?=
 =?us-ascii?Q?IWHTAKq5utYvZTS5YaRVjUAWScJhaN1zKUXthaEQ5RPjKs0jtEdRTCMrM5/5?=
 =?us-ascii?Q?9uCU+YNGYDNAUP2cK0BzTRc2brjv4loCbJw+/XqMGZrGmlPwiJPAwf402Wlv?=
 =?us-ascii?Q?fCfyMvR1DwhMOcn+wEtRDzeucA83zxp5yVFMDOZ5ZdvQDm8jPoZPrG7KSBq+?=
 =?us-ascii?Q?7Aad5aG1PgTwjAXu7hQLS8tBtUn4zY9QiYKRoCGGNz/xBzqwK4PGEv4JI8LC?=
 =?us-ascii?Q?zgxmGymx3BknLHbR3kk8ZLn1D4XRlVwcXOMviI4JMTeD5MuVgHYKdxx+/CV0?=
 =?us-ascii?Q?WgIXJY+dseP1w8z3fAj3Tit1rGNN7VoVtqkfxewSHRf1TwoOAEClBy/wWe89?=
 =?us-ascii?Q?i1t4vXRC0IN73R5nAPPwzX1L5PuixA9yNXHBbdfRV+hN3C5DBWz6mVcIWVT8?=
 =?us-ascii?Q?491deS6xTMMwBElSTEl3EPAlUFEmXG5mb3aAYOQ9AnSLlOrVEBiHz+1ws7fo?=
 =?us-ascii?Q?aIZNTVduR5wB0M1YPkaXyQvijoyVkhnAInS/Eui8tmRKfoqGbjSlQf7eBMUW?=
 =?us-ascii?Q?QBxzywrNUa5hkpBIa8sa15SEk/jgoRemWtvCJn3DgCIowuUo/C+UaYQbyI+g?=
 =?us-ascii?Q?1elubyZEKufKCPmQg0JEVCUHQc2PJWH/4IDBZgOCi8g3kvTC5NUNsl+mmhM7?=
 =?us-ascii?Q?pi/IcV7h5NAgAnAZ8vx1053PdM9tYYY6ZRMtOtOfkXPkyWVjb5zveTh3+w7x?=
 =?us-ascii?Q?EXmIU9He1/1jPAnlBtRkFScsrr6wG7bYObjYE9uH98ghO2oPVr0kXG41RqVK?=
 =?us-ascii?Q?CICWk/nfLbX0MvVRvO7sixuIjSdvnV1Gv7v/f8gYclxjFKCc5GcVc6DO9n1Z?=
 =?us-ascii?Q?QC3ohZgBdxYiOWwGhBtlueskXygYrV2yfo28gP7+4+AAvGefgoIJocBc5rRW?=
 =?us-ascii?Q?EoDGTwGJnvhZKgfdThYBq3/+ZojTDxBrlpRqcxmXPLsiVkGOXUX5dlWLgipI?=
 =?us-ascii?Q?+017NJFhOnTa08Nn0X/EP2Xd1mrfsQo4dVV//e2EYFlX4xXSehbzF2jz62bT?=
 =?us-ascii?Q?YfWieAfzTk4V8L6QPqNKCL7OvhTa/E2otxT69Eqvk+MWiZ41W6LhQAA5Yfu4?=
 =?us-ascii?Q?rkpOVqP8ZXbSb1/+Me5jMeekqkl0L3MjoCMjpTlU9Y7OcyesHrZFKDAB5X2k?=
 =?us-ascii?Q?vIv+uX/W6drgDyem0TF7aMuSP1C9DzJutfIs9gvYNNieN3QQVnGUYHG8UVcm?=
 =?us-ascii?Q?OMsPpdGEqpLISffcq74e4Q/IYise65SrqjR5HokArqHBN/QhIWVb4k49e/UC?=
 =?us-ascii?Q?quWOmLQdU1hZ52Crh9WBHBSv?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a59e25a-de0a-4c1d-c753-08d8ca16764a
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3077.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2021 20:41:49.7227
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7tFl0jGrR2HACPKwVgs0iMxi/7l9u2WyEzcUIYGFjpjoe26WhAC+ZERBM1vx7lgVi3JJKy3m7xq7oQfhL2jP8Zlc6V8tTt0RzFaU97y4QMw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4432
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9886 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 phishscore=0
 suspectscore=0 mlxlogscore=999 bulkscore=0 mlxscore=0 malwarescore=0
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

Hey,

This series improves page unpinning, with an eye on improving MR
deregistration for big swaths of memory (which is bound by the page
unpining), particularly:

 1) Decrement the head page by @ntails and thus reducing a lot the number of
atomic operations per compound page. This is done by comparing individual
tail pages heads, and counting number of consecutive tails on which they 
match heads and based on that update head page refcount. Should have a
visible improvement in all page (un)pinners which use compound pages.

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
to page unpinning in general. Thanks for all the comments so far.

These patches apply on top of linux-next tag next-20210202.

Suggestions, comments, welcomed as usual.

	Joao

Changelog since,

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

