Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76746319F8C
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Feb 2021 14:12:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231882AbhBLNLE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 12 Feb 2021 08:11:04 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:33728 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232038AbhBLNKK (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 12 Feb 2021 08:10:10 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11CD8pwS019100;
        Fri, 12 Feb 2021 13:09:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2020-01-29;
 bh=6oemqd8Diiulu5DhGb8pGtVKtq3abrahSXvKSZWQwI4=;
 b=iT81OQbSznwacNEdP8nIloLSv2VTaw17TKwH4MLO7wccNEUL9jNIXUHMTyOg9c6yu7z0
 zwpyAlxGq/xMkv+tGNSWANiVWocoaiSUGG3g4kAjEQfHIgjA+13lC2IPHd3zk26UEM3W
 UWCMDCMJOfWDSYJS+2cH542R1ffeuWPeoCHRUJCTYtYC1tsVUsNI3XS3zDxvDSgwe7Hr
 FX0pkZVEoUMXfaqjLUz/gWsnttoF/WIPBdCuKSBCy4EuR9Txca+F1744wN7/boMx6gpu
 X1oBlLoealzix9GBshOaWKIdDRN7MsWEE1p0DqJHtEzP89+N+hXJDVU1UzFXIIcriZrY mA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 36mv9dwadp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Feb 2021 13:09:18 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11CCopAs195735;
        Fri, 12 Feb 2021 13:09:17 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2175.outbound.protection.outlook.com [104.47.58.175])
        by userp3020.oracle.com with ESMTP id 36j4vvq2mh-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Feb 2021 13:09:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b6VGAlEDjWSFkEOg4la1+DQKlEch/0fMKVc8A42DyPOtljGGRPO2TBA98oj/Wx7hOuMgxKNDGNhyeo8Qj6kaXSpl24+LHyO1eWDrUAI9j3ctxyf3N+YdAN+ghNhX2XNWHsXSX9KbL5jaFKQb24qsbzx3Vqb6x5yfQAE0BlnOR5hfh/kwUjRrQQpD+A68+4JqFc4dEKOo0zZK4nZtISW7dH+OxGfSacN0nQrV09xnhuwjSTQQopbEDxSIXULLYHpmXSwmWFzQcEmKcltarx/B6hIKtrUt/LdBTusvM8lJV9snjaKCM5h3sRePIxQdUI/+5TgJ5VEUNyuXZAmGtaoxlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6oemqd8Diiulu5DhGb8pGtVKtq3abrahSXvKSZWQwI4=;
 b=of0Cuh1ArnrWpTNfvfH9ZCh8OCxxdxFRVstKEMtV2+8mKXwKL41n5Gv4XuZuhXWjcT96JzeBIUF0DBUlZdTSPLpSMUpG3t8I6QZUItT4cMM5psTFagyCNzkuyg1MTXLw1dHe3mdZXlMC1elWu/mEN1kIJknBbBiIo20e+KmjMkuvE4ataGop3S+4WuVQ8Wd4cOkWwSTes8Cy6gi7YQ3kkx62cgtLmZg2UFAD2M1SUOZc/Wk0gIHtunYybOwovcVEeth/AeG3x3KVsnSgGNXYnl2dH1+iLxhGT6JddMmvdMkAsPLWIQcUKS1EP4wqDfPMbgDBf2MO3Jj66BoLWPVM9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6oemqd8Diiulu5DhGb8pGtVKtq3abrahSXvKSZWQwI4=;
 b=OF0Z4KCslWt/8z1CRdoxbgL6qZVhrh6I/tXEZyNtQ/fSNUdL1BS8yj7tWwp7y7LmmVGikEjGeArmaqXL/DxOsMX4lMqyVWpRaeH+sOE5I6+Uw+bYFxoPFqA89uX0SvsfIUI4ztQyE6axt0aEVJFGhTrSf03NrXuBkQX3kA3jDXw=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=oracle.com;
Received: from BYAPR10MB3077.namprd10.prod.outlook.com (2603:10b6:a03:8c::12)
 by SJ0PR10MB4509.namprd10.prod.outlook.com (2603:10b6:a03:2d9::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.17; Fri, 12 Feb
 2021 13:09:12 +0000
Received: from BYAPR10MB3077.namprd10.prod.outlook.com
 ([fe80::74a8:8649:e20b:d571]) by BYAPR10MB3077.namprd10.prod.outlook.com
 ([fe80::74a8:8649:e20b:d571%7]) with mapi id 15.20.3846.034; Fri, 12 Feb 2021
 13:09:12 +0000
From:   Joao Martins <joao.m.martins@oracle.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Doug Ledford <dledford@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Matthew Wilcox <willy@infradead.org>,
        Joao Martins <joao.m.martins@oracle.com>
Subject: [PATCH v4 4/4] RDMA/umem: batch page unpin in __ib_umem_release()
Date:   Fri, 12 Feb 2021 13:08:43 +0000
Message-Id: <20210212130843.13865-5-joao.m.martins@oracle.com>
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
Received: from paddy.uk.oracle.com (94.61.1.144) by LO4P123CA0347.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:18d::10) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3825.17 via Frontend Transport; Fri, 12 Feb 2021 13:09:09 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4cbebe4d-b4a6-4dbf-118a-08d8cf57641e
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4509:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SJ0PR10MB4509E35BDEFF8BFB949572A9BB8B9@SJ0PR10MB4509.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:370;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 37Vwgp8VV4VdwqkYjf6y/s/AxaXAhcPHMOq9oLDHrILgBa08TXuqQylUCkXOPfr+Qkjk7nwCtjRCQOpyLw0kQ0SBNnt5DmGzNeFQEAg2dFOl0WnDrENl84G3sw6qR/8C4e+uJpycH7CuLhavP4ZzdXWIJ7kbQfSctzAMTPVH2SHYPwtEbvd3jZccce0KYoMMdQzpeG9ksjhoy2SXe2yOHptp5OtwMMzNsVN38AP9X8+G1WkLfOoviBygPAo2Wk7hGhGQe8szaaiHKFZWDlINKXa5vvDdHTWihkb3JAdU2JsLJ+QGNOnfquiNnCo5tFgTVbtC0fzYWgOgkIhYRNFEJoGOTJQY94HLCDELzu6XUueHf72SaHlY3oivXUSK69W0dfmDbhd+SydMdLoDofqcbJJAzxJUyrxTbS8HtBtSXY3Zk6BZlPUQ9FTDPUXk2GvTnhI7VDTjNdQ4Mex8CFCUU8BP4xEeSlqwpHqJ6JWebDcu+YDM0VzMQv5ezP7xeHGGvf3UGRztRjuMTvnwlYiseA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3077.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(396003)(346002)(136003)(39860400002)(366004)(6486002)(2906002)(8676002)(4326008)(52116002)(186003)(26005)(2616005)(1076003)(316002)(8936002)(107886003)(6666004)(478600001)(6916009)(36756003)(66476007)(5660300002)(86362001)(66946007)(103116003)(66556008)(54906003)(956004)(83380400001)(16526019)(7696005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?nccj6ngQJgArfH/nqd/JuQ24PLwsNdKXg6T5KF/bqumXqL4O8M2X6ZcK36N4?=
 =?us-ascii?Q?8vOkM3rjlpOvS6yWw+NU1UVMDV/E3IYEpu/oHPx6c6p5PmjY4HFI78HVOXmC?=
 =?us-ascii?Q?Ae2LtwbPd0twNACG1N8PTf1oSNph+KfV7sRHUXsyyaJQbDf0GdA7xIrEl16D?=
 =?us-ascii?Q?qUE2tNfbafNgH+Gg7LseSqh2K+zmv+CWwN5To4TcPzwgz7BT2m4wx80KI+AO?=
 =?us-ascii?Q?OA3UfI1I+uEA/SV082hHTUecYscLzS48qjIlk1QWt80y56G8kimttmPCl4sK?=
 =?us-ascii?Q?VVAxoySabjJivcMOO8ySfLSvuFFuHwsuwWsfb/QDPYvkG1CTBRLKlXWY3QoZ?=
 =?us-ascii?Q?ZqeBF3hLFq7DKfOkUhKHkjo0d/fBu89a/dsv79cLwGTHvexGhD02XITh1w4P?=
 =?us-ascii?Q?IybWOwZu1FZB8aBDxGM9JCgwSPKEyvMYJennK+DSbwPyD8JqIbFDG1Jzqe0a?=
 =?us-ascii?Q?sQF2a1+Faa+nU62zjEe9/nnB/zCmdH1FiyiDHB4PR5U9HXoRQPt0AVt/KTpj?=
 =?us-ascii?Q?+8lDRJK7cLEnv+0o98NeXKxqlHmlVL0H52QGgHjYr2GJ1JevqLQ7D3zqqlul?=
 =?us-ascii?Q?MY1AxB60SzEeuwoApYax3uaJTsvGlG/gEMpOBHUGJi9l6X9iM14RWx0l6Ukc?=
 =?us-ascii?Q?kroD7Ig+/ocpLRQhuqSXyL6IvMAZP+QGzLIrMOha9ToqWPPXkYMU7hJi4aGg?=
 =?us-ascii?Q?ZQRO2UC+flM00grrKUf87yEfbh7hoC6SKDXw++uFeO2c1AZmoSlGr7OuIlIR?=
 =?us-ascii?Q?3ufCH1r6LPNy+FLdV0FhtgHv+WvWnbWA/p/mW8IEZJ6qcnwsNLCBgZ2O6qD5?=
 =?us-ascii?Q?lJo7fG99cRDL7XhW7qkx1aAqLSw9oJnRw1r9p/xAck/Evt7fUWh2M+bQ+GfV?=
 =?us-ascii?Q?bIu2GcG7NHHqV4AtNnMewoJC5Is3OuP3U6/OMzqvkk1w7bDUy0hXeGJGQUOF?=
 =?us-ascii?Q?4RscsjINZeG2c8yNM4gFTX+rqcy1YuJBmbyWQol1QNvkHkY9iMsAmzl6izzn?=
 =?us-ascii?Q?HftC+0VCHNCR3DNcgOeNsFXCrYVPKDDVBh40ycwa+NPqKqJFUHhxgF810K8/?=
 =?us-ascii?Q?i4deM+RMAMmzqfoNMrVpF9J+RvO5OCYt2IsqBoghukzUDStCOz0pBiEkzTwa?=
 =?us-ascii?Q?ID2pEdyxhxhQo0BWAZK+gTohF1WpzOaB95LXMKkpIGS2X4RRvJlO8EP9I/LM?=
 =?us-ascii?Q?Aai1EB8YKEe9GXxMv80K0A+GIzBL4gVEBHEeSKD7BUbEkVVZzdyhguSjJadK?=
 =?us-ascii?Q?DQ6AlENmwBRCPGEKo1Dpkxc4f9ujx7O5PKhUfRBu5FP1/OMtab8e2K2ANpCG?=
 =?us-ascii?Q?lU6Gqj5OQAHWPs7OK8edL9gy?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cbebe4d-b4a6-4dbf-118a-08d8cf57641e
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3077.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2021 13:09:12.4510
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wEKN4pxQynWnvWfLlyDdW1WH8E202yWloEoi/C+srOcJuf7FQdaBTdYDH3ryPRDgFKUeXkQusmMIHZNriXpSdCXsU9/cUqJok/ZIu2RAIww=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4509
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9892 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 malwarescore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102120101
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9892 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 mlxlogscore=999
 bulkscore=0 suspectscore=0 phishscore=0 adultscore=0 impostorscore=0
 mlxscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102120102
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
Acked-by: Jason Gunthorpe <jgg@nvidia.com>
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

