Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 736DF25E3CD
	for <lists+linux-rdma@lfdr.de>; Sat,  5 Sep 2020 00:42:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726277AbgIDWmT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 4 Sep 2020 18:42:19 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:15223 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728160AbgIDWmR (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 4 Sep 2020 18:42:17 -0400
Received: from hkpgpgate101.nvidia.com (Not Verified[10.18.92.77]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f52c2c50000>; Sat, 05 Sep 2020 06:42:13 +0800
Received: from HKMAIL103.nvidia.com ([10.18.16.12])
  by hkpgpgate101.nvidia.com (PGP Universal service);
  Fri, 04 Sep 2020 15:42:13 -0700
X-PGP-Universal: processed;
        by hkpgpgate101.nvidia.com on Fri, 04 Sep 2020 15:42:13 -0700
Received: from HKMAIL102.nvidia.com (10.18.16.11) by HKMAIL103.nvidia.com
 (10.18.16.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 4 Sep
 2020 22:42:13 +0000
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.170)
 by HKMAIL102.nvidia.com (10.18.16.11) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Fri, 4 Sep 2020 22:42:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IXUlwGkEJQ6JM0avda2nyvLn2mBE7KoI4sAy32X1qPk7LuuX2d+7P2vI77rznRJQfxnUsUkvTGYHC0e/dQb0TEhe1T06axw2RNg0fEUBK2UdkHsPcjcJUWPJlM07bOIa3N3Q3xHDN0z23M+b2vLWCqlK4V2tMb7mt+OKDk10GSPr2G/i+vrLRJsZ/o/Mb/K2PR++l0Dd1uKbaBDd7qvl2Qp/8DJvOQ6IKQoZitQZEjHOI7IPBH/QpJH6FL1RZXtBR425uxGZOSZpDpB7QAxwal2IT9cOjzvLjy1E3jrevhxIbMQaujqyeqfCk3W+E0QK5UeNyHoGH+t57ZDJVWukeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2rP441f5O30gALdl44CikwASZxWM6W2gj9AdCxp5ZlU=;
 b=Kdeg9tx7tKlAqaX1im65VhaWIoX/V4e+8qDOtlZB/aWlsoGi1qfgq00hyq50NkyIcXaic1a0CgqNfVYAypXaak5PF9cVzwjgMcBVCKHZyO2A3/yQRSh10yGfq+xBwqcBupBaaTZ4s4pFMrR0PP9BodkG7HbaA0IcwrsXcFMecZpx06cUgvVbAku06KYCAuBt7Na0nXJjpO3hdP33tIadHPuXAXas/nCQgU0jtiDfsxgWhvMr/vEHp61VYG5Oug90QcKU0CA2SoCuZuKpYQg303TnXPA19R0PYQ02oJ+7lkrdtAkXxweeeVYsBtZsqLhzVd/a/dbAH4irXaDtqaPecw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: vmware.com; dkim=none (message not signed)
 header.d=none;vmware.com; dmarc=none action=none header.from=nvidia.com;
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
To:     Adit Ranadive <aditr@vmware.com>,
        Potnuri Bharat Teja <bharat@chelsio.com>,
        Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leon@kernel.org>,
        <linux-rdma@vger.kernel.org>,
        VMware PV-Drivers <pv-drivers@vmware.com>
Subject: [PATCH v2 06/17] RDMA/umem: Split ib_umem_num_pages() into ib_umem_num_dma_blocks()
Date:   Fri, 4 Sep 2020 19:41:47 -0300
Message-ID: <6-v2-270386b7e60b+28f4-umem_1_jgg@nvidia.com>
In-Reply-To: <0-v2-270386b7e60b+28f4-umem_1_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: MN2PR13CA0022.namprd13.prod.outlook.com
 (2603:10b6:208:160::35) To BY5PR12MB3827.namprd12.prod.outlook.com
 (2603:10b6:a03:1ab::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR13CA0022.namprd13.prod.outlook.com (2603:10b6:208:160::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.9 via Frontend Transport; Fri, 4 Sep 2020 22:42:05 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kEKP9-001vCJ-08; Fri, 04 Sep 2020 19:41:59 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e175b47f-9d81-422c-c435-08d85123bfdd
X-MS-TrafficTypeDiagnostic: BYAPR12MB2856:
X-Microsoft-Antispam-PRVS: <BYAPR12MB2856595FDCF32EFA1B34B126C22D0@BYAPR12MB2856.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FhpxTEP23BwSvDFeizFWH064Kk+JxAHGniwSWrNI71Si8E4kYaMzzNLwT+217SV05PhDnFvqaKnYG5k0yRIPWpyc2ZnrMQFS/71OO/va9mHNmbdk2iXQXMvhx/exM74YYeXdGqOYgO9ZW0VCOW9ZpRsHXroLnrLJUJMmkb+/wCyNj+TebUbrdas62rOYZyFXDKfcLjGzOAY77XTETFlkRoIWk/OLfgvMgr3kszDZFko1CgcQTuQrKGW/qN/biRYe8FrA9CMYWJlcMM6EpctLOfeRRMr+zsalB+pNqVZE9he6QvJ1dnfe8SnBwIQgBEqWLMPeYkX02aku4YDyphjB0IsagStsJ0537hau93PDkiw6/I8cG/qLrhHRf64DdGO1
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB3827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(136003)(366004)(396003)(346002)(36756003)(8936002)(8676002)(9746002)(86362001)(9786002)(5660300002)(2906002)(2616005)(66476007)(26005)(186003)(478600001)(83380400001)(6666004)(426003)(316002)(66556008)(66946007)(110136005)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 2Qls2msMsUDyMvCU+e06hq/vL7ratCEb3dR8QUk7hsLeXJB0L27YGouxpW1VLQOPTcR/r19wPdZwNCVYocidG8rKEwS8U9HfPUIO055rjSIC3ahBjrgCQ9mpRNDyQaudBbj6BI1/9wQakDH6jT18MzIai++GVsM4X8rTbx/YfgMhsoOkAlV118KZVhymkjnIA8FuxUV28ePOldfM817qHwneTDGX/I02enxZwPtHfGQ7HLL/b8ZZnDBOyjm4NlxXbMponZJtbLN/UuTsC5aV+Vf0LKQ159jcoEwlLAqfBhXw8nPerCdT9e65mHoyCHXtepdmOZqRQVaRperdkXzwBx7oPRBrB+L0EP6SKXGTQ3CDohv54wCjqaDBY3kqGOQHYHnKJ3sQvvwi1YfgQu1kHaJXLApIuR5B4Urvbt5WWHwgx33FesV3G7F7Vb3YuBRU9osoblBQXgL6uucj4t8EOqLRBVrWpAiXRKb1ToMMTslyR9F4/91OzMwFlwNcf3IzJuSqPtOPua7eXjxOJD1+ZX8FH1ltK6oWngld3VEpon2Fke/5wicRGr3sf2AJ2XXZB+HPBJetYWDc1oUs1fkMzXt5ylpGdIAXqar4raFyWumHa9fy7coddEBamFaAayWoQ2JnFmbPIKXzxPKM6W+oEA==
X-MS-Exchange-CrossTenant-Network-Message-Id: e175b47f-9d81-422c-c435-08d85123bfdd
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2020 22:42:06.2179
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xB50WPqmkXRvUMiIJvF7lZ9yxuy0j4Cra7vhYTm4J0HRoSWf9lvP4WviBsKekwu7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2856
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1599259334; bh=fEtbnP9lRhZurTGj6SuS/fPwWIlNYUcDxIyy5M5jptY=;
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
        b=lFdU5gOjpebkgxQSTdYH5rHgysKLnOr6B1s5vqP9HGSyUZ12vg7if7WQKlFckHYD9
         HADbRImmbWQbVJMzitKdqYcKWvkscVEDoSLY664suGgs2crRADL6mcDNJT3lZ7lWZy
         FInlSAlknnskRuWxYMy7ryhHPKbwz0OiVeZdenqNOBPQMPjVuc0thvTbxaXOkD3A9U
         n+UIYqdMFHDkmbRPxWUvvmvjzhmdvgE03mqqeCpewCqVjWVdBvu8aCiMmt72BIOHBm
         oReaWeH396qg97Bzl2aGicmhG5NY4IT/AJgsqtPAzZ25SHgNIrdsUCH++85qBfbS+P
         0Lxwzsh4ngs9A==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

ib_num_pages() should only be used by things working with the SGL in CPU
pages directly.

Drivers building DMA lists should use the new ib_num_dma_blocks() which
returns the number of blocks rdma_umem_for_each_block() will return.

To make this general for DMA drivers requires a different implementation.
Computing DMA block count based on umem->address only works if the
requested page size is < PAGE_SIZE and/or the IOVA =3D=3D umem->address.

Instead the number of DMA pages should be computed in the IOVA address
space, not umem->address. Thus the IOVA has to be stored inside the umem
so it can be used for these calculations.

For now set it to umem->address by default and fix it up if
ib_umem_find_best_pgsz() was called. This allows drivers to be converted
to ib_umem_num_dma_blocks() safely.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/infiniband/core/umem.c               |  7 ++++++-
 drivers/infiniband/hw/cxgb4/mem.c            |  2 +-
 drivers/infiniband/hw/mlx5/mem.c             |  4 ++--
 drivers/infiniband/hw/mthca/mthca_provider.c |  2 +-
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_mr.c |  2 +-
 include/rdma/ib_umem.h                       | 15 ++++++++++++---
 6 files changed, 23 insertions(+), 9 deletions(-)

diff --git a/drivers/infiniband/core/umem.c b/drivers/infiniband/core/umem.=
c
index fb7630e7aac3a7..b57dbb14de8378 100644
--- a/drivers/infiniband/core/umem.c
+++ b/drivers/infiniband/core/umem.c
@@ -161,7 +161,7 @@ unsigned long ib_umem_find_best_pgsz(struct ib_umem *um=
em,
 	if (WARN_ON(!(pgsz_bitmap & GENMASK(PAGE_SHIFT, 0))))
 		return 0;
=20
-	va =3D virt;
+	umem->iova =3D va =3D virt;
 	/* The best result is the smallest page size that results in the minimum
 	 * number of required pages. Compute the largest page size that could
 	 * work based on VA address bits that don't change.
@@ -240,6 +240,11 @@ struct ib_umem *ib_umem_get(struct ib_device *device, =
unsigned long addr,
 	umem->ibdev      =3D device;
 	umem->length     =3D size;
 	umem->address    =3D addr;
+	/*
+	 * Drivers should call ib_umem_find_best_pgsz() to set the iova
+	 * correctly.
+	 */
+	umem->iova =3D addr;
 	umem->writable   =3D ib_access_writable(access);
 	umem->owning_mm =3D mm =3D current->mm;
 	mmgrab(mm);
diff --git a/drivers/infiniband/hw/cxgb4/mem.c b/drivers/infiniband/hw/cxgb=
4/mem.c
index 82afdb1987eff6..22c8f5745047db 100644
--- a/drivers/infiniband/hw/cxgb4/mem.c
+++ b/drivers/infiniband/hw/cxgb4/mem.c
@@ -548,7 +548,7 @@ struct ib_mr *c4iw_reg_user_mr(struct ib_pd *pd, u64 st=
art, u64 length,
=20
 	shift =3D PAGE_SHIFT;
=20
-	n =3D ib_umem_num_pages(mhp->umem);
+	n =3D ib_umem_num_dma_blocks(mhp->umem, 1 << shift);
 	err =3D alloc_pbl(mhp, n);
 	if (err)
 		goto err_umem_release;
diff --git a/drivers/infiniband/hw/mlx5/mem.c b/drivers/infiniband/hw/mlx5/=
mem.c
index c19ec9fd8a63c3..13de3d2edd34e3 100644
--- a/drivers/infiniband/hw/mlx5/mem.c
+++ b/drivers/infiniband/hw/mlx5/mem.c
@@ -169,8 +169,8 @@ void mlx5_ib_populate_pas(struct mlx5_ib_dev *dev, stru=
ct ib_umem *umem,
 			  int page_shift, __be64 *pas, int access_flags)
 {
 	return __mlx5_ib_populate_pas(dev, umem, page_shift, 0,
-				      ib_umem_num_pages(umem), pas,
-				      access_flags);
+				      ib_umem_num_dma_blocks(umem, PAGE_SIZE),
+				      pas, access_flags);
 }
 int mlx5_ib_get_buf_offset(u64 addr, int page_shift, u32 *offset)
 {
diff --git a/drivers/infiniband/hw/mthca/mthca_provider.c b/drivers/infinib=
and/hw/mthca/mthca_provider.c
index 317e67ad915fe8..b785fb9a2634ff 100644
--- a/drivers/infiniband/hw/mthca/mthca_provider.c
+++ b/drivers/infiniband/hw/mthca/mthca_provider.c
@@ -877,7 +877,7 @@ static struct ib_mr *mthca_reg_user_mr(struct ib_pd *pd=
, u64 start, u64 length,
 		goto err;
 	}
=20
-	n =3D ib_umem_num_pages(mr->umem);
+	n =3D ib_umem_num_dma_blocks(mr->umem, PAGE_SIZE);
=20
 	mr->mtt =3D mthca_alloc_mtt(dev, n);
 	if (IS_ERR(mr->mtt)) {
diff --git a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_mr.c b/drivers/infinib=
and/hw/vmw_pvrdma/pvrdma_mr.c
index 91f0957e611543..e80848bfb3bdbf 100644
--- a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_mr.c
+++ b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_mr.c
@@ -133,7 +133,7 @@ struct ib_mr *pvrdma_reg_user_mr(struct ib_pd *pd, u64 =
start, u64 length,
 		return ERR_CAST(umem);
 	}
=20
-	npages =3D ib_umem_num_pages(umem);
+	npages =3D ib_umem_num_dma_blocks(umem, PAGE_SIZE);
 	if (npages < 0 || npages > PVRDMA_PAGE_DIR_MAX_PAGES) {
 		dev_warn(&dev->pdev->dev, "overflow %d pages in mem region\n",
 			 npages);
diff --git a/include/rdma/ib_umem.h b/include/rdma/ib_umem.h
index b880512ba95f16..0f1ab3d8f77dea 100644
--- a/include/rdma/ib_umem.h
+++ b/include/rdma/ib_umem.h
@@ -17,6 +17,7 @@ struct ib_umem_odp;
 struct ib_umem {
 	struct ib_device       *ibdev;
 	struct mm_struct       *owning_mm;
+	u64 iova;
 	size_t			length;
 	unsigned long		address;
 	u32 writable : 1;
@@ -33,11 +34,17 @@ static inline int ib_umem_offset(struct ib_umem *umem)
 	return umem->address & ~PAGE_MASK;
 }
=20
+static inline size_t ib_umem_num_dma_blocks(struct ib_umem *umem,
+					    unsigned long pgsz)
+{
+	return (ALIGN(umem->iova + umem->length, pgsz) -
+		ALIGN_DOWN(umem->iova, pgsz)) /
+	       pgsz;
+}
+
 static inline size_t ib_umem_num_pages(struct ib_umem *umem)
 {
-	return (ALIGN(umem->address + umem->length, PAGE_SIZE) -
-		ALIGN_DOWN(umem->address, PAGE_SIZE)) >>
-	       PAGE_SHIFT;
+	return ib_umem_num_dma_blocks(umem, PAGE_SIZE);
 }
=20
 static inline void __rdma_umem_block_iter_start(struct ib_block_iter *bite=
r,
@@ -55,6 +62,8 @@ static inline void __rdma_umem_block_iter_start(struct ib=
_block_iter *biter,
  * pgsz must be <=3D PAGE_SIZE or computed by ib_umem_find_best_pgsz(). Th=
e
  * returned DMA blocks will be aligned to pgsz and span the range:
  * ALIGN_DOWN(umem->address, pgsz) to ALIGN(umem->address + umem->length, =
pgsz)
+ *
+ * Performs exactly ib_umem_num_dma_blocks() iterations.
  */
 #define rdma_umem_for_each_dma_block(umem, biter, pgsz)                   =
     \
 	for (__rdma_umem_block_iter_start(biter, umem, pgsz);                  \
--=20
2.28.0

