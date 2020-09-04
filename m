Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB6D425E3D1
	for <lists+linux-rdma@lfdr.de>; Sat,  5 Sep 2020 00:42:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727827AbgIDWm1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 4 Sep 2020 18:42:27 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:44606 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728084AbgIDWmV (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 4 Sep 2020 18:42:21 -0400
Received: from hkpgpgate102.nvidia.com (Not Verified[10.18.92.100]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f52c2c90001>; Sat, 05 Sep 2020 06:42:17 +0800
Received: from HKMAIL104.nvidia.com ([10.18.16.13])
  by hkpgpgate102.nvidia.com (PGP Universal service);
  Fri, 04 Sep 2020 15:42:17 -0700
X-PGP-Universal: processed;
        by hkpgpgate102.nvidia.com on Fri, 04 Sep 2020 15:42:17 -0700
Received: from HKMAIL102.nvidia.com (10.18.16.11) by HKMAIL104.nvidia.com
 (10.18.16.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 4 Sep
 2020 22:42:14 +0000
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.170)
 by HKMAIL102.nvidia.com (10.18.16.11) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Fri, 4 Sep 2020 22:42:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EwYT8s9Xe4D04B5Uul8zm0hLs4VQVEMP9Y22DGGScoYoJ9rtcYvAPG0m14Lw1Vvj53DTNDgI07XUCCJ8cP1o9to6qVXYVQGBo+xs6Uv9xdzhtljUPv1037aZelfg/66BpmKU8ES0Wci59Ujk1wf0zcpPdLjL5/UxW5ZujJCFVhNnfUuMBU9a4mHuzmfBtsnPwUwmQEc6EpTFO1BjY3YAXdFYM6XvbMy86sbGOMVow/wwj8K9GDsyLqfW+79b6KWeBV/d/VJeQ3U6F7bpoHQMsn0sx8w1Nw90gT5ptFSNLV+moMnt4KE1pnDCryisnIhMkPl/tBHiEBiASQWHHtJAGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9DaW4fMlu+pQfCvGTkMLYrO8NO+aT6iia6vs1aHUbXw=;
 b=j+Tmmr/fA83P/GAXRCWfPHy8gGl+pGv9LuNrv4SAKrcyJQsiTUm2xPstPyD0cSQWXheldl2PzmXVkh5qrSBn7Mb9VDXdjNNGm0haW5caZTK0vJ20AggknqADmVSZFe8KnKMKz4d3u9i7W30o1Dx66JgWcZtLfgiumoB29Iqspcieux+S5dkQzDvnc/S4KujwF9nEvWawZz1bTeHPA/5iFFzIm8J5OudGbC2gtUNBeZhndN0BQV9pcg61+M8teL0SvRZrf3bYctkDv73SyFn7OOe2PSqrGRVORGx7l+pl1DE50Xjyl+GH71OVwO980UhgWkviRdERnbCR/p0rzjCrRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB3827.namprd12.prod.outlook.com (2603:10b6:a03:1ab::16)
 by BYAPR12MB2856.namprd12.prod.outlook.com (2603:10b6:a03:136::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.16; Fri, 4 Sep
 2020 22:42:09 +0000
Received: from BY5PR12MB3827.namprd12.prod.outlook.com
 ([fe80::445b:111e:a091:66f9]) by BY5PR12MB3827.namprd12.prod.outlook.com
 ([fe80::445b:111e:a091:66f9%6]) with mapi id 15.20.3326.025; Fri, 4 Sep 2020
 22:42:09 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Doug Ledford <dledford@redhat.com>,
        "Wei Hu(Xavier)" <huwei87@hisilicon.com>,
        <linux-rdma@vger.kernel.org>, Weihang Li <liweihang@huawei.com>,
        Lijun Ou <oulijun@huawei.com>
Subject: [PATCH v2 12/17] RDMA/hns: Use ib_umem_num_dma_blocks() instead of opencoding
Date:   Fri, 4 Sep 2020 19:41:53 -0300
Message-ID: <12-v2-270386b7e60b+28f4-umem_1_jgg@nvidia.com>
In-Reply-To: <0-v2-270386b7e60b+28f4-umem_1_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: MN2PR17CA0016.namprd17.prod.outlook.com
 (2603:10b6:208:15e::29) To BY5PR12MB3827.namprd12.prod.outlook.com
 (2603:10b6:a03:1ab::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR17CA0016.namprd17.prod.outlook.com (2603:10b6:208:15e::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15 via Frontend Transport; Fri, 4 Sep 2020 22:42:05 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kEKP9-001vCi-77; Fri, 04 Sep 2020 19:41:59 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 836eb680-1b9c-459f-1d21-08d85123bffc
X-MS-TrafficTypeDiagnostic: BYAPR12MB2856:
X-Microsoft-Antispam-PRVS: <BYAPR12MB28560D01BF436BCE0D2880ADC22D0@BYAPR12MB2856.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 28x57vPs0DdudC+lO4HbCFeef4WEaRCYtpqfpJafK4kqLAOarcSwBX0jPMgZT5Sed+m313UZ+7+Bm982SNSIFUsnd4DwZCjfN/UCG2IFBr446vx/4N+opOuj/YF9fSxhI1i5JIvFZQp3UrJAtsk01KvjJYTmkpisjLkQ4pG4DUxKXrV4HuFj52oLIBYKEJKrdReNjaaAXZsgNXTMQnJ0G4011LQd9PhxOxlzCBZu3jI6MWZzMOXJF5wxPiPsUTuVYS7o96o1QOCRKqDljVcyA0qSqCULWUX9MI136GVQZT5SpNv66wC6d4EdcgRTtvKTihu2WFULSBen60YdzKmBTQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB3827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(136003)(366004)(396003)(346002)(36756003)(8936002)(8676002)(9746002)(86362001)(9786002)(5660300002)(2906002)(2616005)(66476007)(26005)(186003)(478600001)(83380400001)(6666004)(426003)(316002)(66556008)(66946007)(110136005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: Wpxyirs0uXHLXlZuxh3FjRR6LjxMtsPVuTlO9GMCETSHJX6lm6QW/49/L8fUuU2/SdP/Zj5Dm7y0PaBi7FX/VT7Cyron/rh/4i/EupU4/rQ8SpBe17XdQtl20EVv52Aq3+nqclvZ0ajTAeSaCtB7WzRgV2C+xZcDUM1wbR+NjwC60eCLgIPhUVssYP+9v8+aJKRMRyZ72I9QzqV0b5jpHRUCtDc80L5ZBMoeGh7fmooiKtknntDeb7HM4LQHTTjXXHJFh7ipZLPLj1+ABLWXZv3JauPLwQwgMgRmzw/nkWj8hXUiEekGwUhx0XMIQQr4cOrugsYX4ObIsGYJXFx9TUsK1aZGyznpNAfrwasj4Xz3aWf7d7+7WqsTstI7nnOfD700z9PGmZVp/pOXWwXqiolNn63eS05CrgCWzr6qI89q+eu2F9JqGFQNl8/2GCTOoK0+keGrmBhDdeKTZynlyav3OuiuEXNzEThpVsmTV8tsHvkapUDaRgcySWzqeMQhSorIN5Vb4bCCeMiCs8FdOFK7RsDCX8vNzx7sRAkJlWN3K45Ioa/DyGrYChul15kZ8a4G/ZtT94g//Cqrd6p3Pp1g5Gg7egg2rOdi6fJfs7aHn8ElaNMUp6rB4e0A+ikYkAWv3Qvp0LFIXUHvG5quwg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 836eb680-1b9c-459f-1d21-08d85123bffc
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2020 22:42:06.5107
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MRZWdOKvCEZe4ZOHMxOlCtJCDsXYHF+DQ8BqNYyX5+KVHOrRWrMEvpBj+UaPMR3v
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2856
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1599259337; bh=Y0rbSpvE2utNEz97wF2kX2sNXyfdDN0RCk6d2kyvxEY=;
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
        b=FRwo/9J1ykSaZMChL97NVgyCDneE8JYLmb/OIglLkGgqE0mCSIY1E2jBqjjtpY4ii
         LhkpZY4xlAF9TeL56SP94hhLyvDt5JavZvACIArLeDs+8YR8Y0XLnyDzsit9WFBLgM
         u5NlDIVxHFwP5xU2x8dsi7uAm2hQpJsQc6rreKAp2XoMe2rP7ESi3RWy8QhnOd0bXl
         GeCBbjUOJ6fR/bc6oRmQeMg17RJ79qcsMIg32ZDlPioXLDaooKKnSvIcMqVb279ZW+
         L8GI9GZGsaSVn/5jilldz0GGJvtvcEC44+GsodfyX0dZbdLpri7IJa6plkQ1hrPWwE
         Wxyg6A53yOetg==
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

