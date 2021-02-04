Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBD2930FE3E
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Feb 2021 21:28:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240013AbhBDU13 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 4 Feb 2021 15:27:29 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:36832 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239717AbhBDU0N (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 4 Feb 2021 15:26:13 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 114KJocn136311;
        Thu, 4 Feb 2021 20:25:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2020-01-29;
 bh=0LTNyLhfcQU8WurGe4uk1JQtTl/ZkrEkTZA6jP+zRYs=;
 b=OewiCsqUbwT1WSPdt+KcuKs2qKRgwk68fdfxYnJ4fildLzTHOZhVRWJ2Sl8Z5JCZ4JMi
 dx4KVarWpH86Cc+SQ+i9L/kx09X0MXBxQ7JJs0BlxNCwghP+7sZ1ZVy7b+htVHtnWLut
 oKeOqbqNzyZrp4cPkUYev7EhCj8zrT3g8uUykgobo8tw4CMJOVd04RoZU5648wF1bUgu
 ff+x9rLZte0G2LmUuC1K3YZg0fXBG4pVKBSB7Ay0VUH0kRr5DvoZVmhXpfJweU+9HUzp
 EcZ1kv7z1edvXl+qVoBXPVFizA3JtUr+S6xEQORDUG+IkQGLuvBLIMBOqis76DMxJiIE QQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2130.oracle.com with ESMTP id 36cvyb782m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 Feb 2021 20:25:23 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 114KGLVq070843;
        Thu, 4 Feb 2021 20:25:22 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2170.outbound.protection.outlook.com [104.47.57.170])
        by userp3020.oracle.com with ESMTP id 36dh7vpbjy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 Feb 2021 20:25:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Oa2ujLm95mY8uMhZNGZjcZwIiVus2+z1uue7k6Zr0Ramk8LWThvSKi92HWSpZjIg2ySSWuAiMadlEsJLtbPlKRhIfNQrnYLAbvY2hDxyDC5nKHtgHTMcWT9FPfZAOVjuu2qe1M+NJSvFeMhAD0+Zd80cVyuBt19DUg5a9me4GZ/sDnWQhxbus+b3gobZQJPTs2wueDdWW1dDm1dvUerRHUM4+N4OPXZ3YjTSYe+PWmh3oVIqhzyZAO9GlAF0LblANnBuuH4WbyLofFUKNCBLJKKUx9s6iBlEqc15iPNgvkMzWzQBQ0+lBzGVlODvIwKMbpyE379sr4sPIBOcHg84WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0LTNyLhfcQU8WurGe4uk1JQtTl/ZkrEkTZA6jP+zRYs=;
 b=TZoHfc4C/wNgSvYJdCSmplv3ZvefCyBpT/X9Tt8gn8hLxd+oO3qdXBFuswZqdxoZKlQLJR1cX/i4fURernQ7swDouemcSOJvm1fiDt06cJ/cTevl1PRfRdzsiHmxw7JNmTwMvu68B1iwZKIGDpgrG4W/ZXunj7nXcMiVJv236huXeLAVg/AqU0z/ewXL7LwQ8/bzMxTOcvJza6iC07VBG/6oDBG6pmPqhNtidKBPx5/4e2PpHEqWndPXXKXccMYGV4Dt7QJtND902GVQhyOZ8LjwaS1k5vuUPH2xpXPD1T3161L5nwfdcaggBmEf2Y1udlpmBJ/1OLS9M3qLmXVK/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0LTNyLhfcQU8WurGe4uk1JQtTl/ZkrEkTZA6jP+zRYs=;
 b=W9fGzDBcgn1YyqjOlGPHP2CjzY+4leOK7g7JAsewlDgSeYrOyVQueJU2dyawuoFlBjo1jZBzdTpK+5ZC2FwkPOji7vufzjyh8Ig9gaBzGQhj1blo/8rV23ujMZtn7HzSAZZCTnoV/rCLIineK8yFPDtmjIpcVk+kCXlYx3u0vX4=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=oracle.com;
Received: from BYAPR10MB3077.namprd10.prod.outlook.com (2603:10b6:a03:8c::12)
 by SJ0PR10MB4590.namprd10.prod.outlook.com (2603:10b6:a03:2d1::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.20; Thu, 4 Feb
 2021 20:25:20 +0000
Received: from BYAPR10MB3077.namprd10.prod.outlook.com
 ([fe80::74a8:8649:e20b:d571]) by BYAPR10MB3077.namprd10.prod.outlook.com
 ([fe80::74a8:8649:e20b:d571%7]) with mapi id 15.20.3805.024; Thu, 4 Feb 2021
 20:25:20 +0000
From:   Joao Martins <joao.m.martins@oracle.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Doug Ledford <dledford@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Matthew Wilcox <willy@infradead.org>,
        Joao Martins <joao.m.martins@oracle.com>
Subject: [PATCH v2 4/4] RDMA/umem: batch page unpin in __ib_umem_release()
Date:   Thu,  4 Feb 2021 20:25:00 +0000
Message-Id: <20210204202500.26474-5-joao.m.martins@oracle.com>
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
Received: from paddy.uk.oracle.com (94.61.1.144) by LO2P123CA0104.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:139::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3825.21 via Frontend Transport; Thu, 4 Feb 2021 20:25:18 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 462c7a86-d458-49f4-3996-08d8c94afe5a
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4590:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SJ0PR10MB4590D41D6526528B8ADB8E76BBB39@SJ0PR10MB4590.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:370;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: H0yfwBVwQ9JChHEe5ZjArW5oLXhHwRUXnPG5O9ZLwhFCNc9S1T8Mn1cD1qI3Kdf75pgkRfeB7xydV5jYQurPGi27lBv5zSj/e4prKn+YRkig9itbrIVXtE5IGpgf7cmJl0Y3mzNnU1F5uvykEqasZCfKtZFy60yMwHJtQSru+BEf3n9edkQ+QT7+a11mPfmthNU9gAkQzX0OZtIZzQJimhSp6VQowMA2zE3nP7ea5faDJgRWwnuA6ldW+s/2i347tnAFp4UqhwIEhyd7ZUtUSqfyY+QWlUtHoWjnRGqhHPWwKeoHuaL/c32XlZi7ghDSqk0nj+4RT9fDQVETRqZHSrtHHkl7UFf5vkAZqCcY3b4QO3fswkLC/TDau8vPg3pqjrsNCCKrpA4J2DJjMwhnBXYq1Z3cuwglJ1fz6IoZl3TGBJrojzAMLbEY6y0mQE7or/ahm2WV+L/L1w+ApoZgzm4G/1vwEkoI8PhmMGpLhvubN6KpOPy5Bvgw8S5Igud8SgBH1JOQav1c3XxPektcBw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3077.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(346002)(396003)(366004)(376002)(136003)(52116002)(7696005)(26005)(2906002)(16526019)(66476007)(186003)(66556008)(478600001)(103116003)(316002)(6486002)(66946007)(956004)(54906003)(86362001)(5660300002)(1076003)(8936002)(83380400001)(107886003)(36756003)(4326008)(6666004)(2616005)(6916009)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?RXnn7J/Qya1eqKXG5A1j6wLBejq/ixKjme2DnAYE5vz09XqU/d4aOSRTDIst?=
 =?us-ascii?Q?dAZ6v+NcvOJM55TB6iCzjbP47yaVYgQPGKoemPZ+I7ZuE4x8dRWMk/I2WMfj?=
 =?us-ascii?Q?L1zk2YhMtBxhVXvD9myK0Oq2n55TszcvjtOIPBA9MVE0XGJ7GVgymvnx6yCi?=
 =?us-ascii?Q?lC/1w9EoeJfkJcnJQerW++l5vaGuHG+LDWfx8eVIf0fUxM82zna/2SCgFl0t?=
 =?us-ascii?Q?PT5dFcEKp+Au+cS7pYLw8RmvWz+81Odz13pV0rblClhcWRYMA1OAMHFpdD9N?=
 =?us-ascii?Q?znzR69fMOWnKsilmhBHGuWJ5rwTy2dWUTtplmr5tMPPfviJJPFlOVvIgM/ea?=
 =?us-ascii?Q?SFiNfQIoaeqlhx9jVGIjgvieYnSsKGnvRKOoCiGxpXC97LHeMMUES7UnZRjZ?=
 =?us-ascii?Q?H1yTGhClaftdYJqQMoeh48I/nbbkYCg7i9MnZcRSPiMEh7UIA6PledBxhEQw?=
 =?us-ascii?Q?iGozv+/0t3ccMZ21rUtmxUvWXT74rKHKkRvrIpUd6FhfwF7oywKhGd98RHJ3?=
 =?us-ascii?Q?0QYBeJ/Df8iLDzwE5ru44qAk4eii5jvqbqtPMDJmek4E8MmL7RyO/H+RBKY3?=
 =?us-ascii?Q?aHaSt4ihkeCpPGOW2KWU2uP1PYeUpE7CNDhXgIirEUARKxrNg7ALSDt9by3d?=
 =?us-ascii?Q?8FfRbQKexatyif3Cq3p3+0+40FhYr60XlFiBUrsiJoaYD/Df5QR5bM9jbHmj?=
 =?us-ascii?Q?TgCCg7YhT2yxPI2zQ2W2d532plaHH/3/phP1r5/9lFe+uzAYMCga+iykjWqG?=
 =?us-ascii?Q?FS5uVDmBYowsrxHNT0a/OMSPJnIWAcV955FLjrphzUFObtrLI4kafMxabT1a?=
 =?us-ascii?Q?9DM85k58Zb+bVcEVPFdDgP/azqBGW3LdO4tpGaFj3h+GjBExVGnhE1rfkFeY?=
 =?us-ascii?Q?y2qEPXeD79OskBr1bXqoL5XVgAQK9uZqx6q7FHXfmkmwTfz7cbK106JY6RER?=
 =?us-ascii?Q?T+bHxMw0Cm+kZlOSGBnG9SpfglNRDwzjtAmkQ6yAmUthStr1hU22Ikt4faAK?=
 =?us-ascii?Q?XBbJoaI1uTXJItnw6cjHgPqTy5wuVBZ7IUTK0hDcHOtuP7gA7ftnFRXrewni?=
 =?us-ascii?Q?SEGqv6eX?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 462c7a86-d458-49f4-3996-08d8c94afe5a
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3077.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2021 20:25:20.6253
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DYROqw5k9ogOeoqWmwt7llfgIo7KYx+x3fn0TEkI0j/ZcR8+uAHbJtXHWIX4JoQ1K8NEsS0kFfn99jj/ATtuRIaMOxMXPNU8SP6xbl5yCd8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4590
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9885 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0
 suspectscore=0 spamscore=0 mlxlogscore=999 phishscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102040124
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9885 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 impostorscore=0
 mlxscore=0 spamscore=0 bulkscore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 malwarescore=0 phishscore=0 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102040124
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Use the newly added unpin_user_page_range_dirty_lock()
for more quickly unpinning a consecutive range of pages
represented as compound pages. This will also calculate
number of pages to unpin (for the tail pages which matching
head page) and thus batch the refcount update.

Running a test program which calls mr reg/unreg on a 1G in size
and measures cost of both operations together (in a guest using rxe)
with THP and hugetlbfs:

Before:
590 rounds in 5.003 sec: 8480.335 usec / round
6898 rounds in 60.001 sec: 8698.367 usec / round

After:
2688 rounds in 5.002 sec: 1860.786 usec / round
32517 rounds in 60.001 sec: 1845.225 usec / round

Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
---
 drivers/infiniband/core/umem.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/infiniband/core/umem.c b/drivers/infiniband/core/umem.c
index 2dde99a9ba07..9b607013e2a2 100644
--- a/drivers/infiniband/core/umem.c
+++ b/drivers/infiniband/core/umem.c
@@ -47,17 +47,17 @@
 
 static void __ib_umem_release(struct ib_device *dev, struct ib_umem *umem, int dirty)
 {
-	struct sg_page_iter sg_iter;
-	struct page *page;
+	bool make_dirty = umem->writable && dirty;
+	struct scatterlist *sg;
+	unsigned int i;
 
 	if (umem->nmap > 0)
 		ib_dma_unmap_sg(dev, umem->sg_head.sgl, umem->sg_nents,
 				DMA_BIDIRECTIONAL);
 
-	for_each_sg_page(umem->sg_head.sgl, &sg_iter, umem->sg_nents, 0) {
-		page = sg_page_iter_page(&sg_iter);
-		unpin_user_pages_dirty_lock(&page, 1, umem->writable && dirty);
-	}
+	for_each_sg(umem->sg_head.sgl, sg, umem->sg_nents, i)
+		unpin_user_page_range_dirty_lock(sg_page(sg),
+			DIV_ROUND_UP(sg->length, PAGE_SIZE), make_dirty);
 
 	sg_free_table(&umem->sg_head);
 }
-- 
2.17.1

