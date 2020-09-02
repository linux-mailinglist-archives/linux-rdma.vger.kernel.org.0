Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 160B425A267
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Sep 2020 02:44:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726770AbgIBAoP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 1 Sep 2020 20:44:15 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:21279 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726871AbgIBAoI (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 1 Sep 2020 20:44:08 -0400
Received: from hkpgpgate102.nvidia.com (Not Verified[10.18.92.77]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f4eead00000>; Wed, 02 Sep 2020 08:44:00 +0800
Received: from HKMAIL101.nvidia.com ([10.18.16.10])
  by hkpgpgate102.nvidia.com (PGP Universal service);
  Tue, 01 Sep 2020 17:44:00 -0700
X-PGP-Universal: processed;
        by hkpgpgate102.nvidia.com on Tue, 01 Sep 2020 17:44:00 -0700
Received: from HKMAIL102.nvidia.com (10.18.16.11) by HKMAIL101.nvidia.com
 (10.18.16.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 2 Sep
 2020 00:43:51 +0000
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.172)
 by HKMAIL102.nvidia.com (10.18.16.11) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Wed, 2 Sep 2020 00:43:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j3CiSSlMJOU9lw2hdTM3pjXggZ41kNIcP+1yErLvFfYIFRzPFbgBK+tuTg07NTvotGY7NnTK93QRvoou4zKQc50/Kj015PaH3Ca0hUNOhNi3cSt02t7P0w+w6PGokxx9pAsFCHwKfYcMWsDIxHYgKfwBRm2L9pOTkPikZJbCThf3efU7Baau+8yh13WEbssfqOZ3WyMa2l97OFFhEoOmRxxGYr+zDKKj5FNIloMHAsakqhu85FYeiHB+kMKtdUfZOY1bgWapx7TyssiWLwGC69WcBsJEkOPo/muGfw+EwZa/I1ROly83o2VCitC4V0cZRR3KYcYdvD6W0XXRnkTnDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JwsKr5yJdCimpvp9StmwtDJ73QT8/wb6944NazKIqN8=;
 b=NaNH3euGj/WatN/VtKwfeeMbMhrQKWFhQ3n9NLN/pF4tp/nF4Wxjw9v91fHWrDyJkCDwhvqpPOsN7afZNKYjTAKVYEdNP0pShlAlMu5S7EOLhVkztdvzU7rMJNoss+kudgUCqGljojyUCU6hiOwB9VjuErUuHt412iNCpFaYDknU50qTxdA1VJmy7yoOrDgyKWLipGrjkO6CRhoW8JXjVN/rqL1B9DBC+VNSNF16ueUK5+Y7AOvtKfE51U1ftkIcYczY/nciiBPGbu1p74bc8+bkU8RwYqQYRuvTKj546QchqYp44m37XIA/4P8OvaBJ/PTUJNHRclz5aJvlGYdXhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: broadcom.com; dkim=none (message not signed)
 header.d=none;broadcom.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.23; Wed, 2 Sep
 2020 00:43:49 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76%3]) with mapi id 15.20.3326.025; Wed, 2 Sep 2020
 00:43:49 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Devesh Sharma <devesh.sharma@broadcom.com>,
        Doug Ledford <dledford@redhat.com>,
        <linux-rdma@vger.kernel.org>,
        Naresh Kumar PBS <nareshkumar.pbs@broadcom.com>,
        Somnath Kotur <somnath.kotur@broadcom.com>,
        Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
CC:     Selvin Xavier <selvin.xavier@broadcom.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>
Subject: [PATCH 09/14] RDMA/bnxt: Do not use ib_umem_page_count() or ib_umem_num_pages()
Date:   Tue, 1 Sep 2020 21:43:37 -0300
Message-ID: <9-v1-00f59ce24f1f+19f50-umem_1_jgg@nvidia.com>
In-Reply-To: <0-v1-00f59ce24f1f+19f50-umem_1_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: MN2PR18CA0011.namprd18.prod.outlook.com
 (2603:10b6:208:23c::16) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by MN2PR18CA0011.namprd18.prod.outlook.com (2603:10b6:208:23c::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15 via Frontend Transport; Wed, 2 Sep 2020 00:43:47 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kDGsJ-005P1P-64; Tue, 01 Sep 2020 21:43:43 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: df552eb6-5d89-4970-47a5-08d84ed940a3
X-MS-TrafficTypeDiagnostic: DM6PR12MB3834:
X-Microsoft-Antispam-PRVS: <DM6PR12MB383487043D3C9DCE24A195A8C22F0@DM6PR12MB3834.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2150;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZTqgPMwCkZLopde8UAZ7QBVz7tiiWq7LVkodGuvvJtnpGvtvI65t2AowKkY1g/ODXD+nHU4vh8dh7B9LOsZ0RYHZ6pbbq7Z1rhca+gkWb67CXniyDJMayby0MR6XPC9iycqAJWpDAj8OyxmFV6/UjDXW81ytAOtBsZLpI8HbcAgfuWzu6wWD3dDb6O8LYWUozNeYVykp1DpPKe5tEbYigyge4zYYx1eMQG4FNK7Js4N/2uKGZaFcGlrUiB5C0BHLqMTJCE90zB4JdtQxrNIUWDwMWmtmJs2uphMSYjvoM/uT1Gu27h3lDdNxjb52nrMREJE2Fca2iXoWQwc+edF6qBHxIvHF4Vka9/Hqko6PuIh3G7knk6jdi+tayLD+8O4a
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(39860400002)(396003)(346002)(136003)(366004)(8936002)(26005)(86362001)(426003)(8676002)(9746002)(9786002)(2616005)(6666004)(186003)(83380400001)(66556008)(66476007)(316002)(478600001)(66946007)(110136005)(2906002)(54906003)(36756003)(4326008)(5660300002)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: SqIF7QMxufmkkYipSDiwHyRXkwroJRBqQk57v23OMpvJ8fbcx98HFIGLwafFRY2l5f1xNlmVwRmjZIe+BAJ++ZTUePogKzj0HdT0tkgv15pUGwfll57BdUNx9aECoJf6rl5qWbFTm7EWMC1KP9/Xs9Hy1SiKUcLXGdAJByJKyVobdm7m1iHkNqdX4tZY0ElZvcVJRX54wvRLuB7MVmOoGDcttrgwqMgEZdh5/ruI5SjbNBBN6jgsM3E7kQI8MOmrf0HtQG97gevmSquQSIiuPhjzvACcwugKjI1gIT127hPe/EdhBDrqGPMNRxbeba4bLVN2jaGGQzAF8UL9tU9NR1BIVlNiqOdhzAWe3aQdC4LZmoSJLsvlUrw8mTUhQhTLgD3z+XdDNIvC+hXA+fOyNTqAYMiFy9zUhA1fB05tQhXV4FCJjr1R/gE/pOBfpr0Inmfv6gQC6K3/mLETKL3JLxxy2dGrLt8bt7xV84TspECP+9wUFkz9Jo/D35GJzMOzut5ZZfZXVQ6qyJiIEtCuas4roKgaeTOdTvBva/JwL42iCLaqnW/Cja914bbnkz5keCA4J85mM08JQeWVeB9+sDaSMmovHcfB5bwXaQ79dk6jiMY89tGQv2IEoUy4mBFMo5ztqIo4wujONsVHPzqWRw==
X-MS-Exchange-CrossTenant-Network-Message-Id: df552eb6-5d89-4970-47a5-08d84ed940a3
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2020 00:43:47.5455
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J/CGxDnViD7Gn8Aei70/lvWlIlWXhbpXlk7oNH6ABr6d3MHY3xkzEZJjqKWLKEro
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3834
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1599007440; bh=HclRIbqfnASPpb6kI/3pJO1qsQuptuMPRSl66ThNGMQ=;
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
        b=QOHVsEu77KmQi442S6JIjPIngd6pr68EnZWsFVi4JuxP5lgp7r/r+2QCCfumLAITF
         Q564f3ZdnNXcX8TuVXbEXNVi9+W3P5v+wPYdOSwpbVfX78Efhl6y5MRVlt5Hnv623B
         6obZgkb2yj/wrGp+d6cDC4pN5x87xN7VRWSddK4eVDRkeE6TyvZ+c552QHWTGqGTq9
         iMLpVfppqwcQXEOZv2xMKXpmKZVAF1EyZ1y0ngGGLN4e6mmAaEYDZuUzAkI2NfRW40
         yD5W5BEH4mwfURyo9VGtcp2CL9WIS3sSUmpfDd0EJ8cp4GyZF7NpbJV14gnBhkFe6a
         jp42hDQFFoDbQ==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

ib_umem_page_count() returns the number of 4k entries required for a DMA
map, but bnxt_re already computes a variable page size. The correct API to
determine the size of the page table array is ib_umem_num_dma_blocks().

Fix the overallocation of the page array in fill_umem_pbl_tbl() when
working with larger page sizes by using the right function. Lightly
re-organize this function to make it clearer.

Replace the other calls to ib_umem_num_pages().

Fixes: d85582517e91 ("RDMA/bnxt_re: Use core helpers to get aligned DMA add=
ress")
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/infiniband/hw/bnxt_re/ib_verbs.c | 70 ++++++++----------------
 1 file changed, 24 insertions(+), 46 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/=
hw/bnxt_re/ib_verbs.c
index 9e26e651730cb3..9dbf9ab5a4c8db 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -939,7 +939,7 @@ static int bnxt_re_init_user_qp(struct bnxt_re_dev *rde=
v, struct bnxt_re_pd *pd,
=20
 	qp->sumem =3D umem;
 	qplib_qp->sq.sg_info.sghead =3D umem->sg_head.sgl;
-	qplib_qp->sq.sg_info.npages =3D ib_umem_num_pages(umem);
+	qplib_qp->sq.sg_info.npages =3D ib_umem_num_dma_blocks(umem, PAGE_SIZE);
 	qplib_qp->sq.sg_info.nmap =3D umem->nmap;
 	qplib_qp->sq.sg_info.pgsize =3D PAGE_SIZE;
 	qplib_qp->sq.sg_info.pgshft =3D PAGE_SHIFT;
@@ -954,7 +954,8 @@ static int bnxt_re_init_user_qp(struct bnxt_re_dev *rde=
v, struct bnxt_re_pd *pd,
 			goto rqfail;
 		qp->rumem =3D umem;
 		qplib_qp->rq.sg_info.sghead =3D umem->sg_head.sgl;
-		qplib_qp->rq.sg_info.npages =3D ib_umem_num_pages(umem);
+		qplib_qp->rq.sg_info.npages =3D
+			ib_umem_num_dma_blocks(umem, PAGE_SIZE);
 		qplib_qp->rq.sg_info.nmap =3D umem->nmap;
 		qplib_qp->rq.sg_info.pgsize =3D PAGE_SIZE;
 		qplib_qp->rq.sg_info.pgshft =3D PAGE_SHIFT;
@@ -1609,7 +1610,7 @@ static int bnxt_re_init_user_srq(struct bnxt_re_dev *=
rdev,
=20
 	srq->umem =3D umem;
 	qplib_srq->sg_info.sghead =3D umem->sg_head.sgl;
-	qplib_srq->sg_info.npages =3D ib_umem_num_pages(umem);
+	qplib_srq->sg_info.npages =3D ib_umem_num_dma_blocks(umem, PAGE_SIZE);
 	qplib_srq->sg_info.nmap =3D umem->nmap;
 	qplib_srq->sg_info.pgsize =3D PAGE_SIZE;
 	qplib_srq->sg_info.pgshft =3D PAGE_SHIFT;
@@ -2861,7 +2862,8 @@ int bnxt_re_create_cq(struct ib_cq *ibcq, const struc=
t ib_cq_init_attr *attr,
 			goto fail;
 		}
 		cq->qplib_cq.sg_info.sghead =3D cq->umem->sg_head.sgl;
-		cq->qplib_cq.sg_info.npages =3D ib_umem_num_pages(cq->umem);
+		cq->qplib_cq.sg_info.npages =3D
+			ib_umem_num_dma_blocks(cq->umem, PAGE_SIZE);
 		cq->qplib_cq.sg_info.nmap =3D cq->umem->nmap;
 		cq->qplib_cq.dpi =3D &uctx->dpi;
 	} else {
@@ -3759,23 +3761,6 @@ int bnxt_re_dealloc_mw(struct ib_mw *ib_mw)
 	return rc;
 }
=20
-static int bnxt_re_page_size_ok(int page_shift)
-{
-	switch (page_shift) {
-	case CMDQ_REGISTER_MR_LOG2_PBL_PG_SIZE_PG_4K:
-	case CMDQ_REGISTER_MR_LOG2_PBL_PG_SIZE_PG_8K:
-	case CMDQ_REGISTER_MR_LOG2_PBL_PG_SIZE_PG_64K:
-	case CMDQ_REGISTER_MR_LOG2_PBL_PG_SIZE_PG_2M:
-	case CMDQ_REGISTER_MR_LOG2_PBL_PG_SIZE_PG_256K:
-	case CMDQ_REGISTER_MR_LOG2_PBL_PG_SIZE_PG_1M:
-	case CMDQ_REGISTER_MR_LOG2_PBL_PG_SIZE_PG_4M:
-	case CMDQ_REGISTER_MR_LOG2_PBL_PG_SIZE_PG_1G:
-		return 1;
-	default:
-		return 0;
-	}
-}
-
 static int fill_umem_pbl_tbl(struct ib_umem *umem, u64 *pbl_tbl_orig,
 			     int page_shift)
 {
@@ -3799,7 +3784,8 @@ struct ib_mr *bnxt_re_reg_user_mr(struct ib_pd *ib_pd=
, u64 start, u64 length,
 	struct bnxt_re_mr *mr;
 	struct ib_umem *umem;
 	u64 *pbl_tbl =3D NULL;
-	int umem_pgs, page_shift, rc;
+	unsigned long page_size;
+	int umem_pgs, rc;
=20
 	if (length > BNXT_RE_MAX_MR_SIZE) {
 		ibdev_err(&rdev->ibdev, "MR Size: %lld > Max supported:%lld\n",
@@ -3833,42 +3819,34 @@ struct ib_mr *bnxt_re_reg_user_mr(struct ib_pd *ib_=
pd, u64 start, u64 length,
 	mr->ib_umem =3D umem;
=20
 	mr->qplib_mr.va =3D virt_addr;
-	umem_pgs =3D ib_umem_page_count(umem);
-	if (!umem_pgs) {
-		ibdev_err(&rdev->ibdev, "umem is invalid!");
-		rc =3D -EINVAL;
-		goto free_umem;
-	}
-	mr->qplib_mr.total_size =3D length;
-
-	pbl_tbl =3D kcalloc(umem_pgs, sizeof(u64 *), GFP_KERNEL);
-	if (!pbl_tbl) {
-		rc =3D -ENOMEM;
-		goto free_umem;
-	}
-
-	page_shift =3D __ffs(ib_umem_find_best_pgsz(umem,
-				BNXT_RE_PAGE_SIZE_4K | BNXT_RE_PAGE_SIZE_2M,
-				virt_addr));
-
-	if (!bnxt_re_page_size_ok(page_shift)) {
+	page_size =3D ib_umem_find_best_pgsz(
+		umem, BNXT_RE_PAGE_SIZE_4K | BNXT_RE_PAGE_SIZE_2M, virt_addr);
+	if (!page_size) {
 		ibdev_err(&rdev->ibdev, "umem page size unsupported!");
 		rc =3D -EFAULT;
-		goto fail;
+		goto free_umem;
 	}
+	mr->qplib_mr.total_size =3D length;
=20
-	if (page_shift =3D=3D BNXT_RE_PAGE_SHIFT_4K &&
+	if (page_size =3D=3D BNXT_RE_PAGE_SIZE_4K &&
 	    length > BNXT_RE_MAX_MR_SIZE_LOW) {
 		ibdev_err(&rdev->ibdev, "Requested MR Sz:%llu Max sup:%llu",
 			  length, (u64)BNXT_RE_MAX_MR_SIZE_LOW);
 		rc =3D -EINVAL;
-		goto fail;
+		goto free_umem;
+	}
+
+	umem_pgs =3D ib_umem_num_dma_blocks(umem, page_size);
+	pbl_tbl =3D kcalloc(umem_pgs, sizeof(u64 *), GFP_KERNEL);
+	if (!pbl_tbl) {
+		rc =3D -ENOMEM;
+		goto free_umem;
 	}
=20
 	/* Map umem buf ptrs to the PBL */
-	umem_pgs =3D fill_umem_pbl_tbl(umem, pbl_tbl, page_shift);
+	umem_pgs =3D fill_umem_pbl_tbl(umem, pbl_tbl, order_base_2(page_size));
 	rc =3D bnxt_qplib_reg_mr(&rdev->qplib_res, &mr->qplib_mr, pbl_tbl,
-			       umem_pgs, false, 1 << page_shift);
+			       umem_pgs, false, page_size);
 	if (rc) {
 		ibdev_err(&rdev->ibdev, "Failed to register user MR");
 		goto fail;
--=20
2.28.0

