Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CE6725A25D
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Sep 2020 02:43:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726174AbgIBAn4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 1 Sep 2020 20:43:56 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:4707 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726400AbgIBAns (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 1 Sep 2020 20:43:48 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f4eeab60001>; Tue, 01 Sep 2020 17:43:34 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 01 Sep 2020 17:43:48 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 01 Sep 2020 17:43:48 -0700
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 2 Sep
 2020 00:43:48 +0000
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by HQMAIL101.nvidia.com (172.20.187.10) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Wed, 2 Sep 2020 00:43:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gyz/tGau79X0hf3y+LbAucssnxMWf65bNIGH9+9+hJEh+1rQpov83W39BO2Ru7M4iv355Kf/8dKH945aIrMZvvTf1xevYgvn1fpTRNGrypCVla4pkS9IA3WStzjeIelGaCix0hGF/K9ThV4gKdmsTuAefOCnNBJ7dKU4cDI1Lma5NbBei2N3xMgBR4myTgCVEQo2KjykCzedVM1Jt9+mx/zqBBA+51gBbZwpAllGyiIGZOgV4uZU1QlmSHDJvxF6X72UuRd2dBKnoGalR4d4v17koLiN1fIL3zDnGk0oI5m1zaft1Zr60cqiuFwvUKJU4oTomAGHZemDMUQzyY6nIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tx3M/j0Xy5uioDT34gKd7Ab7+O0m486goEuDpaauLyg=;
 b=WDmmQhdORwav18Bs6bVU/JjElSWSQBcnI2+0CLeFgyNEYBXaDiStnD9w+Y5ZHSvxG1IU27+71RPOpyc3sLp3bzmD6NRzMpkhuX5KSh4AHzUiwb+7yE+C9wJ3+TlZKN6MYQFOF4FAZBL3BlnU6iDgZvL0m+RHUHs5JENO1MjzXl0voowBAJs2FSxaUFq5hEoT8ENVs5hBnhtGwzfeFg1XTwDKZW1Zc2mIMpomLn9+WPE7ft074qfKveg46r6N9mCRGDKuw5/l4mePbD/t5xarTJYAu4GM20X8HDrnMi4q2nnu+awpgZToBLPIZOpGfvxkvaJEEL+5+RGC6ytAEDuRwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: vmware.com; dkim=none (message not signed)
 header.d=none;vmware.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.23; Wed, 2 Sep
 2020 00:43:47 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76%3]) with mapi id 15.20.3326.025; Wed, 2 Sep 2020
 00:43:47 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Adit Ranadive <aditr@vmware.com>,
        Potnuri Bharat Teja <bharat@chelsio.com>,
        Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leon@kernel.org>,
        <linux-rdma@vger.kernel.org>,
        VMware PV-Drivers <pv-drivers@vmware.com>
Subject: [PATCH 06/14] RDMA/umem: Split ib_umem_num_pages() into ib_umem_num_dma_blocks()
Date:   Tue, 1 Sep 2020 21:43:34 -0300
Message-ID: <6-v1-00f59ce24f1f+19f50-umem_1_jgg@nvidia.com>
In-Reply-To: <0-v1-00f59ce24f1f+19f50-umem_1_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: MN2PR19CA0002.namprd19.prod.outlook.com
 (2603:10b6:208:178::15) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by MN2PR19CA0002.namprd19.prod.outlook.com (2603:10b6:208:178::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15 via Frontend Transport; Wed, 2 Sep 2020 00:43:45 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kDGsJ-005P1D-2R; Tue, 01 Sep 2020 21:43:43 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fce499e9-84a7-43d0-f43a-08d84ed93fb0
X-MS-TrafficTypeDiagnostic: DM6PR12MB3834:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3834DD2B5F18FC2C5F50C6F5C22F0@DM6PR12MB3834.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2201;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZlQeGFE2aK2pLyDw/WlV+bWjHxd/zh6faoiyOH5VYe8oTRyYMoHGdjyE1/Gqv82fZoCMN4H1MSU4ZpkMDBWNpFTz7RHnBqeT6swW+ENDV9LJGesnu4qROq4yzx5yXfUXTm64vwFX5j3g9Ol4p+JetK0ju1QrfQJrfLhJfwDl591UoE9L4VGwSDMIin8/1scg7WgyrU7AMuYyagS7zogqPMnAnorZfSGUeOWZAuctQgNnkrBA6D6BsyDzxOr06YHWpqPVs7YGEQMr/NE2qqpFbFSIzKiWj/Vil7w6+uKf83PNGR1iuJ9zgKlzFg1znGcBJcZvjRFOC1mZjxcXc540x6bvWgiPTM4KXOhfwD3/swqPgsdL+N0V0EIdmgI1yyI1
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(39860400002)(396003)(346002)(136003)(366004)(8936002)(26005)(86362001)(426003)(8676002)(9746002)(9786002)(2616005)(6666004)(186003)(83380400001)(66556008)(66476007)(316002)(478600001)(66946007)(110136005)(2906002)(36756003)(5660300002)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 8Z0X+sR5PjR8m19RbOGoPOsBxpJSZ/8mZI403qh07NP5ech/x++xGAoYQCrWQXjwMcbX/kaKhtt4TNXg8nJZxFiZuevN+xrfGWmnBkMuRhNJKZZ/m+ZtzOKuPByEdoC+b4h1HZ3yCPwJsu6o9AjlPQRnepa9AL99Nt+GTJ0WBe0PiWvbSWf0GO9sqEqvm/1ZE5MAe6fNQ6bNi55KJFHQUnQY3hx38eizAmWuKEuVHFScXRBenMOMVnybYt/msu1C2tkYrFLxhr0yrC1aCLtJVaXq0h9g33s5Ly6SRXQoDhmOgUkV+ZfEq18mnUe91JlMzekEZoWn/FBPxBKC3COMc8uj0p749YYA7M+AlkGC6KuXUqGHNhmrBEfXORXItlOaHDUYI62PK34ttePcy5uvJ2xH3p66/R8QPqmNyH5p4sYOf+voMcuyEpfh3r+ew6kzS9qe50ot5nu/SS/LYjJ8psSzBH1y11R0E0YHUG6fwBIpBZnb/Oep8lNl69eO3v+SYD+rRHlnarCkvcr4EazzdcK9TORCVhHijo35xdrPI1PeccU/h08I/37qFbV6QEkxhH+S/iz3P3TByhpMHrEPaPc/VSa2qrAcy4/s9MtAmLbf3KeZIKbTMouRLx8eGP6zbeE7LfRKwoUw3SObV4zsWQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: fce499e9-84a7-43d0-f43a-08d84ed93fb0
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2020 00:43:45.8815
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NjIwspBbvc1/aXg1CjXus2LMnKjhWgT+sJUOmATrq8+btcYPujeegE/1Uk/v5Kx7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3834
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1599007414; bh=uB1fNw7qR1Z2HDM4vBJ3VFVOXD0LLIgILn7I9HjxzCY=;
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
        b=Wa53oifZCBOVTys/WU0A+GMkmH3hcnVqhDFib5CYfYNNmlushpF8mGLeYXYpJBipr
         GLxtt9htKVSXNjizPYvKJCAdf/yvhKexynmCL+Tp85/BRyJC8m1DeO1bo8CCQEte1K
         h6hwfRSz+K2allacydX/PfZ/HbutRPA9x+Gyd9VVInFtX5C36bDUQH6ALy33jYPrBM
         jLnzd+NIqZRE0nJw1BTTStoaRrcs8GyQoqpiR434kd7sprLx1FGvj206HkiuNjLugZ
         Obd66T2D7gD1MJjmFWDzff3xN+H3CkiSaFgWNoegcSRAtx1uaDvnBefHcykqjmvPf7
         t17Lqmr6GW91w==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

ib_num_pages() should only be used by things working with the SGL in CPU
pages directly.

Drivers building DMA lists should use the new ib_num_dma_blocks() which
returns the number of blocks rdma_umem_for_each_block() will return.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/infiniband/hw/cxgb4/mem.c            |  2 +-
 drivers/infiniband/hw/mlx5/mem.c             |  5 +++--
 drivers/infiniband/hw/mthca/mthca_provider.c |  2 +-
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_mr.c |  2 +-
 include/rdma/ib_umem.h                       | 14 +++++++++++---
 5 files changed, 17 insertions(+), 8 deletions(-)

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
index c19ec9fd8a63c3..5641dbda72ff66 100644
--- a/drivers/infiniband/hw/mlx5/mem.c
+++ b/drivers/infiniband/hw/mlx5/mem.c
@@ -169,8 +169,9 @@ void mlx5_ib_populate_pas(struct mlx5_ib_dev *dev, stru=
ct ib_umem *umem,
 			  int page_shift, __be64 *pas, int access_flags)
 {
 	return __mlx5_ib_populate_pas(dev, umem, page_shift, 0,
-				      ib_umem_num_pages(umem), pas,
-				      access_flags);
+				      ib_umem_num_dma_blocks(umem,
+							     1 << page_shift),
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
index b880512ba95f16..ba3b9be0d8c56a 100644
--- a/include/rdma/ib_umem.h
+++ b/include/rdma/ib_umem.h
@@ -33,11 +33,17 @@ static inline int ib_umem_offset(struct ib_umem *umem)
 	return umem->address & ~PAGE_MASK;
 }
=20
+static inline size_t ib_umem_num_dma_blocks(struct ib_umem *umem,
+					    unsigned long pgsz)
+{
+	return (ALIGN(umem->address + umem->length, pgsz) -
+		ALIGN_DOWN(umem->address, pgsz)) /
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
@@ -55,6 +61,8 @@ static inline void __rdma_umem_block_iter_start(struct ib=
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

