Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B674425A260
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Sep 2020 02:44:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726622AbgIBAn7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 1 Sep 2020 20:43:59 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:5450 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726064AbgIBAnw (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 1 Sep 2020 20:43:52 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f4eea480000>; Tue, 01 Sep 2020 17:41:44 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 01 Sep 2020 17:43:51 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 01 Sep 2020 17:43:51 -0700
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 2 Sep
 2020 00:43:47 +0000
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by HQMAIL101.nvidia.com (172.20.187.10) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Wed, 2 Sep 2020 00:43:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=npwNYgl+X4sPv3CaXbK4T6D52mg+MEhL4qlGvcc30MjEixwD79iwFH7kNfl+jrFlsBAn9HYXULKM0Cv4STOAzOW83JgJZ3eB9LMGzleax4rxaz9ru5fEp5JcoihiPjXGD/t0igBrrp2zEmfTcxhzPnlNF2KRxRVYAgbuoXNqZ0O9zETfCxEeUJeHCrsmlWnk9AVNYpySvhgIey3AQ3nasCj5XaWP7LFIaOUIvR2v85en2IrEjazw3JqYgW/MbfxlAtIBCYWRroz86R450j9FGZ/UZUMgvCjH9bYHw5kSdKCyoLtgEwK0ANWo9c/YImH5hbvfoM2tbIKPaDJ5hV/NtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9DaW4fMlu+pQfCvGTkMLYrO8NO+aT6iia6vs1aHUbXw=;
 b=bXx0ZHjTWQNpYo0qOG4ihiiabLWKKZjkraYhJ5eUv8Z2q0EntgNk2okULsmTKmVGTGAdwdox9JoAGRnfcFmo417kyYkPV0TdZiB0ntTQh89WHOwXhATaJpd2V48LRSw4eoQK585Mf/UfY2E2rf0Ln7RFcRdPUlnBdYMSI7GmKr7YJvvKyEdE+Il/gtLbli/d2qfWcIWftLOmYstl90NOjXsxQlMOHLRf0ICncenIDt+icKSgvnmx8QMGpNLzPMFEnWj48MzhrMoKwBIR8to9r3IfG2vDl4kcZA64GSQzM2jtlCi/xyPD16bdeP4fTMXkfPA37DovHwyWQuNbN4z+LA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.23; Wed, 2 Sep
 2020 00:43:46 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76%3]) with mapi id 15.20.3326.025; Wed, 2 Sep 2020
 00:43:46 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Doug Ledford <dledford@redhat.com>,
        "Wei Hu(Xavier)" <huwei87@hisilicon.com>,
        <linux-rdma@vger.kernel.org>, Weihang Li <liweihang@huawei.com>,
        Lijun Ou <oulijun@huawei.com>
Subject: [PATCH 10/14] RDMA/hns: Use ib_umem_num_dma_blocks() instead of opencoding
Date:   Tue, 1 Sep 2020 21:43:38 -0300
Message-ID: <10-v1-00f59ce24f1f+19f50-umem_1_jgg@nvidia.com>
In-Reply-To: <0-v1-00f59ce24f1f+19f50-umem_1_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: BL0PR1501CA0034.namprd15.prod.outlook.com
 (2603:10b6:207:17::47) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by BL0PR1501CA0034.namprd15.prod.outlook.com (2603:10b6:207:17::47) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.20 via Frontend Transport; Wed, 2 Sep 2020 00:43:45 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kDGsJ-005P1S-7a; Tue, 01 Sep 2020 21:43:43 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 060b2b2f-57c1-4e67-599f-08d84ed93f58
X-MS-TrafficTypeDiagnostic: DM6PR12MB3834:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3834DA967939FDD05F856F63C22F0@DM6PR12MB3834.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6OXIFfnfjmr5I7g3tyaWO6wmtTbFzLze7RrGjtEjr0iBVOHaiT5mJEPjG93HxlhMDBFfb6SJ9G5kQ6aDobJR9hdBVd3xmIwYXouPJAYnlVR4CVkvJBPg6ZLaagPtaNztGxP/Ga+dYjsz2axAQV9D8v/H1Re0xlq7Pft5ghMntaf0QBDsghbo36lNtZeERbihwOBlLNQrZZQNPNDuPEAurDlKzT5AB3iQBsdgG2hugvuuhiNKnCOAj+C36VWpsvc64kTb5pdiUfntillskgu7XWhA+xJRRsav07DOxY/Fdr1P9cKJGetI4LskYchBrH8UztKS87xzHxHeMAD905qlMg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(39860400002)(396003)(346002)(136003)(366004)(8936002)(26005)(86362001)(426003)(8676002)(9746002)(9786002)(2616005)(6666004)(186003)(83380400001)(66556008)(66476007)(316002)(478600001)(66946007)(110136005)(2906002)(36756003)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: UG7Scm29awM+1k0EY6Jf5cdHSG+iU2DP3WCzfHRkZ+MMyzZnL77TfnXsYE7Dkk9Xit56HzHy6ldGwRVfEFaM8eOc7lHEeSIuZkpXe+zsdiJDjyXQSODtEmkh/jsCuUrFLY5QPJ3u+SS/f+QNCHuKn9n/NlXH+ldJMUD24k69c1LoXi80QpyG9T1KXiR4rEoanVbyYuWPLmyELfUhv/zE2Jl3R0kSKxB8LqxVEEAP8ubQEwoDwmKzRMsM3FtjQ7KpbDlFXOEK/WrUSDD/zT4cPrMQ+e/ZsrDfXbyHa6G4Z4OFW+rFP6qzizee/cT+Kq69eztsIaB66Q6JaHqUh6wk+NO1ii3iNIyOaqmJJergrXJjkbjfbbjjJprLzE7hLaJ8ExZtye5NBrv3//1hfMI4LiV1iVEAdPYumVjguxfRDJsM7YNf+vDJ92wOouw3Og/ygkaiQlqqXQSQxKriGYu+NJ+PFAkPryPJYWpjdlvlVmlIAR4mYfm/Ef2VzA5/Et/XiSxp/h38LWXl5/LFnlTiBY6ojQkgjLPxwO2p1o/3DhAS96wshKJN/NXgTepUuouXR3WfBlpOy0pbBT6uGM71p1Z1abcaiQgdRKxv64FmJZRp5y2HMcD76skSGcl6FPLiiqt/piD05md57iSxiN+tfg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 060b2b2f-57c1-4e67-599f-08d84ed93f58
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2020 00:43:45.2568
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /8iB6jPPzLfOy0qI2Yvn14fN6TDzDUP8MJCuQaITJKEUT4NUABJuC8xeM83Xge59
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3834
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1599007304; bh=Y0rbSpvE2utNEz97wF2kX2sNXyfdDN0RCk6d2kyvxEY=;
        h=X-PGP-Universal:ARC-Seal:ARC-Message-Signature:
         ARC-Authentication-Results:Authentication-Results:From:To:Subject:
         Date:Message-ID:In-Reply-To:References:Content-Transfer-Encoding:
         Content-Type:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-Originating-IP:
         X-MS-PublicTrafficType:X-MS-Office365-Filtering-Correlation-Id:
         X-MS-TrafficTypeDiagnostic:X-Microsoft-Antispam-PRVS:
         X-MS-Oob-TLC-OOBClassifiers:X-MS-Exchange-SenderADCheck:
         X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
         X-Forefront-Antispam-Report:X-MS-Exchange-AntiSpam-MessageData:
         X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-AuthSource:
         X-MS-Exchange-CrossTenant-AuthAs:
         X-MS-Exchange-CrossTenant-OriginalArrivalTime:
         X-MS-Exchange-CrossTenant-FromEntityHeader:
         X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
         X-MS-Exchange-CrossTenant-UserPrincipalName:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
        b=AaioOkZ+tCYc7/PGvL2+M0N2Gusyj8OGYvNt7Za2KlvrjpJmhDmkATFYp9FBWnNkL
         hjggi6K9GVcf8+RZQFJaQF1SAmVO8HVvLV0WvQHUx3BmCh0lqAiH6OjaZYByEyxmoF
         Mut2I4jyk5uErwArfhRWgtEU2R9GZJNuYFt+lluDIlULPoOaKGt54HH/zHZwG411Bj
         Sow8Y7iLhPR/bZlUF2lG5ESg5Yxs1sMTolEUEMDF2BI4SpUa3iQ7guE3yl3h4iCAqx
         Q9NLHBzPELJ5ArRNPxCJa246kCzlYrD2HBfZ8BQXIr8wFFknssApFbrtaZlplkQDYa
         wgPYU8POXwCRg==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

mtr_umem_page_count() does the same thing, replace it with the core code.

Also, ib_umem_find_best_pgsz() should always be called to check that the
umem meets the page_size requirement. If there is a limited set of
page_sizes that work it the pgsz_bitmap should be set to that set. 0 is a
failure and the umem cannot be used.

Lightly tidy the control flow to implement this flow properly.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/infiniband/hw/hns/hns_roce_mr.c | 49 ++++++++++---------------
 1 file changed, 19 insertions(+), 30 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_mr.c b/drivers/infiniband/h=
w/hns/hns_roce_mr.c
index e5df3884b41dda..16699f6bb03a51 100644
--- a/drivers/infiniband/hw/hns/hns_roce_mr.c
+++ b/drivers/infiniband/hw/hns/hns_roce_mr.c
@@ -707,19 +707,6 @@ static inline size_t mtr_bufs_size(struct hns_roce_buf=
_attr *attr)
 	return size;
 }
=20
-static inline int mtr_umem_page_count(struct ib_umem *umem,
-				      unsigned int page_shift)
-{
-	int count =3D ib_umem_page_count(umem);
-
-	if (page_shift >=3D PAGE_SHIFT)
-		count >>=3D page_shift - PAGE_SHIFT;
-	else
-		count <<=3D PAGE_SHIFT - page_shift;
-
-	return count;
-}
-
 static inline size_t mtr_kmem_direct_size(bool is_direct, size_t alloc_siz=
e,
 					  unsigned int page_shift)
 {
@@ -767,12 +754,10 @@ static int mtr_alloc_bufs(struct hns_roce_dev *hr_dev=
, struct hns_roce_mtr *mtr,
 			  struct ib_udata *udata, unsigned long user_addr)
 {
 	struct ib_device *ibdev =3D &hr_dev->ib_dev;
-	unsigned int max_pg_shift =3D buf_attr->page_shift;
-	unsigned int best_pg_shift =3D 0;
+	unsigned int best_pg_shift;
 	int all_pg_count =3D 0;
 	size_t direct_size;
 	size_t total_size;
-	unsigned long tmp;
 	int ret =3D 0;
=20
 	total_size =3D mtr_bufs_size(buf_attr);
@@ -782,6 +767,9 @@ static int mtr_alloc_bufs(struct hns_roce_dev *hr_dev, =
struct hns_roce_mtr *mtr,
 	}
=20
 	if (udata) {
+		unsigned long pgsz_bitmap;
+		unsigned long page_size;
+
 		mtr->kmem =3D NULL;
 		mtr->umem =3D ib_umem_get(ibdev, user_addr, total_size,
 					buf_attr->user_access);
@@ -790,15 +778,17 @@ static int mtr_alloc_bufs(struct hns_roce_dev *hr_dev=
, struct hns_roce_mtr *mtr,
 				  PTR_ERR(mtr->umem));
 			return -ENOMEM;
 		}
-		if (buf_attr->fixed_page) {
-			best_pg_shift =3D max_pg_shift;
-		} else {
-			tmp =3D GENMASK(max_pg_shift, 0);
-			ret =3D ib_umem_find_best_pgsz(mtr->umem, tmp, user_addr);
-			best_pg_shift =3D (ret <=3D PAGE_SIZE) ?
-					PAGE_SHIFT : ilog2(ret);
-		}
-		all_pg_count =3D mtr_umem_page_count(mtr->umem, best_pg_shift);
+		if (buf_attr->fixed_page)
+			pgsz_bitmap =3D 1 << buf_attr->page_shift;
+		else
+			pgsz_bitmap =3D GENMASK(buf_attr->page_shift, PAGE_SHIFT);
+
+		page_size =3D ib_umem_find_best_pgsz(mtr->umem, pgsz_bitmap,
+						   user_addr);
+		if (!page_size)
+			return -EINVAL;
+		best_pg_shift =3D order_base_2(page_size);
+		all_pg_count =3D ib_umem_num_dma_blocks(mtr->umem, page_size);
 		ret =3D 0;
 	} else {
 		mtr->umem =3D NULL;
@@ -808,16 +798,15 @@ static int mtr_alloc_bufs(struct hns_roce_dev *hr_dev=
, struct hns_roce_mtr *mtr,
 			return -ENOMEM;
 		}
 		direct_size =3D mtr_kmem_direct_size(is_direct, total_size,
-						   max_pg_shift);
+						   buf_attr->page_shift);
 		ret =3D hns_roce_buf_alloc(hr_dev, total_size, direct_size,
-					 mtr->kmem, max_pg_shift);
+					 mtr->kmem, buf_attr->page_shift);
 		if (ret) {
 			ibdev_err(ibdev, "Failed to alloc kmem, ret %d\n", ret);
 			goto err_alloc_mem;
-		} else {
-			best_pg_shift =3D max_pg_shift;
-			all_pg_count =3D mtr->kmem->npages;
 		}
+		best_pg_shift =3D buf_attr->page_shift;
+		all_pg_count =3D mtr->kmem->npages;
 	}
=20
 	/* must bigger than minimum hardware page shift */
--=20
2.28.0

