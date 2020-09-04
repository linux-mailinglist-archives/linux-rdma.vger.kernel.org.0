Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19AE725E3DB
	for <lists+linux-rdma@lfdr.de>; Sat,  5 Sep 2020 00:42:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726265AbgIDWmm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 4 Sep 2020 18:42:42 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:16388 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728116AbgIDWmh (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 4 Sep 2020 18:42:37 -0400
Received: from hkpgpgate101.nvidia.com (Not Verified[10.18.92.9]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f52c2ce0001>; Sat, 05 Sep 2020 06:42:22 +0800
Received: from HKMAIL104.nvidia.com ([10.18.16.13])
  by hkpgpgate101.nvidia.com (PGP Universal service);
  Fri, 04 Sep 2020 15:42:22 -0700
X-PGP-Universal: processed;
        by hkpgpgate101.nvidia.com on Fri, 04 Sep 2020 15:42:22 -0700
Received: from HKMAIL104.nvidia.com (10.18.16.13) by HKMAIL104.nvidia.com
 (10.18.16.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 4 Sep
 2020 22:42:07 +0000
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.107)
 by HKMAIL104.nvidia.com (10.18.16.13) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Fri, 4 Sep 2020 22:42:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FAcqFWLTkhkvzoJN6l1B0nmaUSmXqxHWuIh6hFHScIyGHD6E7vv8ajOrqfSQXYpXrLarTIAVvbs2qUeh+m8BE558/4EIO0bcnNeoaBw6joTmmLXzFDe7YbL6EtnY+3BJmtnoGs+N3GiHX7qtlugFkuTumAFtu7qRsrRWu6n7P8WBoQjzAZJNeFGo14lXBqNXBdRXA7tbim6dIfJchObnAonQKyukAt8lNx3PHCa35KMN8nHZ7dxDdLWHqNRaf+KIF44BoYphFsV8c67ncasdJj8VmqqIcioio8bgUm3ePzNKEDH4CkaecbIdBwTzvWoOH2F5hnzqO3zWJWEml0kdMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1qHp5GQyzKUZ7hOtgCWa/j+tQQo0rzLw72UdoReXYXE=;
 b=Oq91cMaJvMlUBTH7Dnc+pZrBgNeSj8N0CMl8GW+qeU1Zx6lwh3OFxJDj7zubzqR9xF32jxfpY/Wz5kDy5PIe3+D2kmG2O3fT77B3xXnJL6k0SO+XUVgUmcgiverMWRRjZBv+vBiB2Wh5aQ3liKNVj/LjxIew6zzDoo5l9MeS9ual+FFc1kjjvMz3pch+WQ0FQLOQ3KYYHWOAuHdxcvf46X1Qu9FBkSa63XDEmBN9EDiWUI/0kV85ICSBnOTJDc6SHt72pdvbvjcR7iJaDzM6XgzKWw3KQwrbuDB3MBPxppkipOzn3GAKPJ7essqYi5kchsAEqJAu50/2YrwK04gODw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: broadcom.com; dkim=none (message not signed)
 header.d=none;broadcom.com; dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB3827.namprd12.prod.outlook.com (2603:10b6:a03:1ab::16)
 by BYAPR12MB2806.namprd12.prod.outlook.com (2603:10b6:a03:70::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.22; Fri, 4 Sep
 2020 22:42:05 +0000
Received: from BY5PR12MB3827.namprd12.prod.outlook.com
 ([fe80::445b:111e:a091:66f9]) by BY5PR12MB3827.namprd12.prod.outlook.com
 ([fe80::445b:111e:a091:66f9%6]) with mapi id 15.20.3326.025; Fri, 4 Sep 2020
 22:42:05 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Devesh Sharma <devesh.sharma@broadcom.com>,
        Doug Ledford <dledford@redhat.com>,
        Faisal Latif <faisal.latif@intel.com>,
        Gal Pressman <galpress@amazon.com>,
        "Wei Hu(Xavier)" <huwei87@hisilicon.com>,
        <linux-rdma@vger.kernel.org>, Weihang Li <liweihang@huawei.com>,
        "Naresh Kumar PBS" <nareshkumar.pbs@broadcom.com>,
        Lijun Ou <oulijun@huawei.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Yossi Leybovich <sleybo@amazon.com>,
        Somnath Kotur <somnath.kotur@broadcom.com>,
        "Sriharsha Basavapatna" <sriharsha.basavapatna@broadcom.com>
CC:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>
Subject: [PATCH v2 04/17] RDMA/umem: Add rdma_umem_for_each_dma_block()
Date:   Fri, 4 Sep 2020 19:41:45 -0300
Message-ID: <4-v2-270386b7e60b+28f4-umem_1_jgg@nvidia.com>
In-Reply-To: <0-v2-270386b7e60b+28f4-umem_1_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: BL0PR02CA0010.namprd02.prod.outlook.com
 (2603:10b6:207:3c::23) To BY5PR12MB3827.namprd12.prod.outlook.com
 (2603:10b6:a03:1ab::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by BL0PR02CA0010.namprd02.prod.outlook.com (2603:10b6:207:3c::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.20 via Frontend Transport; Fri, 4 Sep 2020 22:42:02 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kEKP8-001vCC-TC; Fri, 04 Sep 2020 19:41:58 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c7c940c8-5fce-4e8f-cf13-08d85123be1c
X-MS-TrafficTypeDiagnostic: BYAPR12MB2806:
X-Microsoft-Antispam-PRVS: <BYAPR12MB2806630AA11BCA4846EED99CC22D0@BYAPR12MB2806.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1060;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VpEU0nbLbnuV6rq6l/cj3u1sI3gFymnqent61qPz5oAlaN2w9Vqm0p46wWFaHjCtpFoW9zZ2YLxOzdKKyXwORFvSW8py1VP2mA6ftwbfQq4E6ix4ZxQweANGSXYp1yxnRq4Mnml+LJz7kb//avndcD9lVu6YDrx0LotbfQ5ehkgG48HKnzSfn6Y0sGnKXSIsDkORIBYDUwfCflDxwirv4qHbyWkI9cP0NiQRnQQ/aH4HXEY6JiQ6laM20MsotcYMoPODOL+VX6WOMDSjtljWjY2Lc5idzM3EDl2lL4/voLUMlz0/PIladAy3ZHfnKyWCmR7MGMjGERs4illcDnZWomP+VJDOZ7kbG0MK2LPXz/vTImCd31ZcPwF1T1FxYRS8
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB3827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(39860400002)(396003)(136003)(346002)(66556008)(26005)(54906003)(66476007)(6666004)(110136005)(8676002)(186003)(316002)(83380400001)(426003)(7416002)(2616005)(9786002)(478600001)(36756003)(9746002)(86362001)(8936002)(5660300002)(2906002)(4326008)(66946007)(4216001)(921003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: /4D/DyWEB4mCgsnOmQ+OvNaKXO6hH2kk6VQcFgQFaUQ7zSjZVJkx/VDJXN6cx7s4i77WNo+/Zm426B2uw5zSRiCEpLRpi/WvxXFbwfcGe+vBkoNxSQKW4NKVHJnVzNjfaSkLbRvjrdDN0nsRxNU3KVBK1gMMYwSYa229aYPN3pVmp4ieqGJTgErFUh6XVqdvKncq/UpU1BfiO/o1Qyea3FPHCuXXenpV3xlAIjdolqHrUm4d/GIWnaBEbc5WJ26n3kcxIgn7/KqYsKRBR41HeKacZGTox1+5pYya+2FaP3M5hsfScPg9cabMKMlmiHo+U5zILyAs4yqYOlYsBVrqdYJ/8SeThyIXdgUjViKl7r1BaYOkGmBcB4IXz+SedYOibjTmchoZnjIiHCHQW8+tLPO6ooC8RUyPKXxP5zYo4d4JmVZ8WZjuZV7/Vtf//F/sY5cxBW17amCwSjikws4Y+t4uZyQDpBxBpPQBsk/NBAiS5TZGUevEGmYSKbtJodvgEojVpw7aEp6+LIBOh7prYomrBEpxtE6Ucoi/0PAcNxVNzJv55u+LCVarvBUURINckOJWFvBL+nPjv5OhweKpLRgEowkr6F2kavCVppZ92iSHmTBF0kMqfB2rdX017g3jpd4QGxASI8l3yJu297S+6A==
X-MS-Exchange-CrossTenant-Network-Message-Id: c7c940c8-5fce-4e8f-cf13-08d85123be1c
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2020 22:42:03.2506
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SuEp1PtTE+St8ku9nNJHR8yxbFpsyvpqt0za9lbvYeROjgD0SCBp9nVJBxgekNW6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2806
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1599259342; bh=u3PpiuRl9//9NIPj3pc0GTKxf0hzmaQi40cC0OCPo/o=;
        h=X-PGP-Universal:ARC-Seal:ARC-Message-Signature:
         ARC-Authentication-Results:Authentication-Results:From:To:CC:
         Subject:Date:Message-ID:In-Reply-To:References:
         Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:
         MIME-Version:X-MS-Exchange-MessageSentRepresentingType:
         X-Originating-IP:X-MS-PublicTrafficType:
         X-MS-Office365-Filtering-Correlation-Id:X-MS-TrafficTypeDiagnostic:
         X-Microsoft-Antispam-PRVS:X-MS-Oob-TLC-OOBClassifiers:
         X-MS-Exchange-SenderADCheck:X-Microsoft-Antispam:
         X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
         X-MS-Exchange-AntiSpam-MessageData:
         X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-AuthSource:
         X-MS-Exchange-CrossTenant-AuthAs:
         X-MS-Exchange-CrossTenant-OriginalArrivalTime:
         X-MS-Exchange-CrossTenant-FromEntityHeader:
         X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
         X-MS-Exchange-CrossTenant-UserPrincipalName:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
        b=XP7svUz+kfBn8jbVoh3CuMYg9RjNvVkMHoePWJuFYP4cO3iHxKNrDX4bM+qwNSxXC
         PrPyGYYwMBT+0EgsHwpAydORLKmxe8qeMnzMR1LigUrmSmvkk6cnOjgq6b7BASh4wI
         LwBj3H4KBctdeDDJv6mkS8OT84/C3XnfoS/GaIODzfUtac2jZvJ+tb+OA+5Ogf4Ukt
         IBxDgzq76nKnfuxI7TE1mKJCnhvkvIOL9nxiCX1fab6kPWKdKVCvmEjyE9ZaJqvtCp
         xa1ydBQQp4Nm6ZGth8imZi4RqFfcieWFh7X6ESKkpekvevZKPlgSlG7+S1rj9mzkxk
         1lceG7oUxGO5A==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This helper does the same as rdma_for_each_block(), except it works on a
umem. This simplifies most of the call sites.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Acked-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Acked-by: Shiraz Saleem <shiraz.saleem@intel.com>
---
 .clang-format                              |  1 +
 drivers/infiniband/hw/bnxt_re/ib_verbs.c   |  2 +-
 drivers/infiniband/hw/efa/efa_verbs.c      |  3 +--
 drivers/infiniband/hw/hns/hns_roce_alloc.c |  3 +--
 drivers/infiniband/hw/i40iw/i40iw_verbs.c  |  3 +--
 include/rdma/ib_umem.h                     | 20 ++++++++++++++++++++
 6 files changed, 25 insertions(+), 7 deletions(-)

diff --git a/.clang-format b/.clang-format
index a0a96088c74f49..311ef2c61a1bdf 100644
--- a/.clang-format
+++ b/.clang-format
@@ -415,6 +415,7 @@ ForEachMacros:
   - 'rbtree_postorder_for_each_entry_safe'
   - 'rdma_for_each_block'
   - 'rdma_for_each_port'
+  - 'rdma_umem_for_each_dma_block'
   - 'resource_list_for_each_entry'
   - 'resource_list_for_each_entry_safe'
   - 'rhl_for_each_entry_rcu'
diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/=
hw/bnxt_re/ib_verbs.c
index 5ee272d27aaade..9e26e651730cb3 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -3783,7 +3783,7 @@ static int fill_umem_pbl_tbl(struct ib_umem *umem, u6=
4 *pbl_tbl_orig,
 	u64 page_size =3D  BIT_ULL(page_shift);
 	struct ib_block_iter biter;
=20
-	rdma_for_each_block(umem->sg_head.sgl, &biter, umem->nmap, page_size)
+	rdma_umem_for_each_dma_block(umem, &biter, page_size)
 		*pbl_tbl++ =3D rdma_block_iter_dma_address(&biter);
=20
 	return pbl_tbl - pbl_tbl_orig;
diff --git a/drivers/infiniband/hw/efa/efa_verbs.c b/drivers/infiniband/hw/=
efa/efa_verbs.c
index de9a22f0fcc218..d85c63a5021a70 100644
--- a/drivers/infiniband/hw/efa/efa_verbs.c
+++ b/drivers/infiniband/hw/efa/efa_verbs.c
@@ -1142,8 +1142,7 @@ static int umem_to_page_list(struct efa_dev *dev,
 	ibdev_dbg(&dev->ibdev, "hp_cnt[%u], pages_in_hp[%u]\n",
 		  hp_cnt, pages_in_hp);
=20
-	rdma_for_each_block(umem->sg_head.sgl, &biter, umem->nmap,
-			    BIT(hp_shift))
+	rdma_umem_for_each_dma_block(umem, &biter, BIT(hp_shift))
 		page_list[hp_idx++] =3D rdma_block_iter_dma_address(&biter);
=20
 	return 0;
diff --git a/drivers/infiniband/hw/hns/hns_roce_alloc.c b/drivers/infiniban=
d/hw/hns/hns_roce_alloc.c
index a522cb2d29eabc..a6b23dec1adcf6 100644
--- a/drivers/infiniband/hw/hns/hns_roce_alloc.c
+++ b/drivers/infiniband/hw/hns/hns_roce_alloc.c
@@ -268,8 +268,7 @@ int hns_roce_get_umem_bufs(struct hns_roce_dev *hr_dev,=
 dma_addr_t *bufs,
 	}
=20
 	/* convert system page cnt to hw page cnt */
-	rdma_for_each_block(umem->sg_head.sgl, &biter, umem->nmap,
-			    1 << page_shift) {
+	rdma_umem_for_each_dma_block(umem, &biter, 1 << page_shift) {
 		addr =3D rdma_block_iter_dma_address(&biter);
 		if (idx >=3D start) {
 			bufs[total++] =3D addr;
diff --git a/drivers/infiniband/hw/i40iw/i40iw_verbs.c b/drivers/infiniband=
/hw/i40iw/i40iw_verbs.c
index b51339328a51ef..beb611b157bc8d 100644
--- a/drivers/infiniband/hw/i40iw/i40iw_verbs.c
+++ b/drivers/infiniband/hw/i40iw/i40iw_verbs.c
@@ -1320,8 +1320,7 @@ static void i40iw_copy_user_pgaddrs(struct i40iw_mr *=
iwmr,
 	if (iwmr->type =3D=3D IW_MEMREG_TYPE_QP)
 		iwpbl->qp_mr.sq_page =3D sg_page(region->sg_head.sgl);
=20
-	rdma_for_each_block(region->sg_head.sgl, &biter, region->nmap,
-			    iwmr->page_size) {
+	rdma_umem_for_each_dma_block(region, &biter, iwmr->page_size) {
 		*pbl =3D rdma_block_iter_dma_address(&biter);
 		pbl =3D i40iw_next_pbl_addr(pbl, &pinfo, &idx);
 	}
diff --git a/include/rdma/ib_umem.h b/include/rdma/ib_umem.h
index 07a764eb692eed..b880512ba95f16 100644
--- a/include/rdma/ib_umem.h
+++ b/include/rdma/ib_umem.h
@@ -40,6 +40,26 @@ static inline size_t ib_umem_num_pages(struct ib_umem *u=
mem)
 	       PAGE_SHIFT;
 }
=20
+static inline void __rdma_umem_block_iter_start(struct ib_block_iter *bite=
r,
+						struct ib_umem *umem,
+						unsigned long pgsz)
+{
+	__rdma_block_iter_start(biter, umem->sg_head.sgl, umem->nmap, pgsz);
+}
+
+/**
+ * rdma_umem_for_each_dma_block - iterate over contiguous DMA blocks of th=
e umem
+ * @umem: umem to iterate over
+ * @pgsz: Page size to split the list into
+ *
+ * pgsz must be <=3D PAGE_SIZE or computed by ib_umem_find_best_pgsz(). Th=
e
+ * returned DMA blocks will be aligned to pgsz and span the range:
+ * ALIGN_DOWN(umem->address, pgsz) to ALIGN(umem->address + umem->length, =
pgsz)
+ */
+#define rdma_umem_for_each_dma_block(umem, biter, pgsz)                   =
     \
+	for (__rdma_umem_block_iter_start(biter, umem, pgsz);                  \
+	     __rdma_block_iter_next(biter);)
+
 #ifdef CONFIG_INFINIBAND_USER_MEM
=20
 struct ib_umem *ib_umem_get(struct ib_device *device, unsigned long addr,
--=20
2.28.0

