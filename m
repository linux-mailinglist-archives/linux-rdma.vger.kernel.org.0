Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 594B127DD5A
	for <lists+linux-rdma@lfdr.de>; Wed, 30 Sep 2020 02:24:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728684AbgI3AYp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 29 Sep 2020 20:24:45 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:56044 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728291AbgI3AYp (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 29 Sep 2020 20:24:45 -0400
Received: from HKMAIL103.nvidia.com (Not Verified[10.18.92.100]) by nat-hk.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f73d0490000>; Wed, 30 Sep 2020 08:24:41 +0800
Received: from HKMAIL102.nvidia.com (10.18.16.11) by HKMAIL103.nvidia.com
 (10.18.16.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 30 Sep
 2020 00:24:39 +0000
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.108)
 by HKMAIL102.nvidia.com (10.18.16.11) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Wed, 30 Sep 2020 00:24:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c3Z+h9JNaEKaV0ytRhz8zx2n9+oRcxdfI8enDyi+IsUgImJxD2Mz2YpFVz52uT0R4O7wGNWsiXuZqMpIutBE5qx47iecjhaDegaIbV7p+FtZByvkbiw47bu+CGtrCfssQDayVdwaDiyu/g8xM/MIQ10xYB84k9egRnnUmpX3ZKnS4lL2FjY7kx0VeEWVS+twDyji9yMXv1cw2DAAknJpualpR3Fovm4sCm6SRmsEhCe7+P6fDg872JuNrlXZM9Tf5LBwmbXIh/9+V1IViG8bdVNs6EvY18+bNgWZhne1syYNlBLZRsBTjFNt6jtkr/CubfT3nML5m4cteC1Gmsfq0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dcjadm0UQ5P+Bz7zdFoYsXP+P2VO6ZFWzD5+C4egUag=;
 b=OX4BaKFVbUDfYoi8aZl7FVf55F+zLoGf1XKuoo6gr73vZZwaLThSoYbXqAyMFKjjYlexVepYQXiL+c+QsJuD2m2O0YTsVp3+Ilg6B0WGfY67hi6StdeTaOYFCtkLxzhbtI7IRQISIYVhQb7pB/GRqb2n1IALRvz8stTTQH9TfZRzQUNgL/L+QvOgha4fJpDH0lu911BYXuDrlIjYd7ic4b5HkE+NgdN4oJaiMb3+6YC/eU53CzkvXewh1kXMjR89ysH5MqtOHnAs8Cc43vIYKa5JJXbOqIkDd6Ec/VfzrmwlIs/nn8YKnrByZljXAj0Gg7+PX8tjGC7y+H9G1Nupjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB1658.namprd12.prod.outlook.com (2603:10b6:4:5::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3412.24; Wed, 30 Sep 2020 00:24:37 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3433.032; Wed, 30 Sep 2020
 00:24:37 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Devesh Sharma <devesh.sharma@broadcom.com>,
        Doug Ledford <dledford@redhat.com>,
        <linux-rdma@vger.kernel.org>,
        Naresh Kumar PBS <nareshkumar.pbs@broadcom.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Somnath Kotur <somnath.kotur@broadcom.com>,
        Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Subject: [PATCH] RDMA/bnxt_re: Use rdma_umem_for_each_dma_block()
Date:   Tue, 29 Sep 2020 21:24:35 -0300
Message-ID: <0-v1-b37437a73f35+49c-bnxt_re_dma_block_jgg@nvidia.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: MN2PR11CA0006.namprd11.prod.outlook.com
 (2603:10b6:208:23b::11) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR11CA0006.namprd11.prod.outlook.com (2603:10b6:208:23b::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.34 via Frontend Transport; Wed, 30 Sep 2020 00:24:36 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kNPv9-003kmf-Ny; Tue, 29 Sep 2020 21:24:35 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1601425482; bh=fm1XbkN0otF22+fwA8FEio9VAO1RmRY5Bveqg6gIAW4=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:From:To:
         Subject:Date:Message-ID:Content-Transfer-Encoding:Content-Type:
         X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=WUfkNAQ6BsWa3ZeRkUSqXh/eGvdCE7tVy/HQl5k4HeCi1OQDNgFWc/31E+VHfW+zx
         Fdnsaw4yAeczIO2w4/EOqP/IjZuF6pDldSKz4qDSypGjiBoC0LJM9fww4uFtn+PYZZ
         MUNpY39/X0ITbApMMs8q8bNmtbcbBoI5Hsuew3pqY/fMytiq+Fs1eAjA3zlLxAuewJ
         8qyqjayVkOUSlTkp0qYgqoDKZvIGVM28m0rfheiOoLnxYQ1/JM3+XumJyOI73UedQZ
         SKtKDDdJORlMMZQaySEUylHi69Rp6JSutg9IWqIXjgzU0eUoYZ0i0HnjGDEI2TblVy
         kTxolZLnMxRgQ==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This driver is taking the SGL out of the umem and passing it through a
struct bnxt_qplib_sg_info. Instead of passing the SGL pass the umem and
then use rdma_umem_for_each_dma_block() directly.

Move the calls of ib_umem_num_dma_blocks() closer to their actual point of
use, npages is only set for non-umem pbl flows.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/infiniband/hw/bnxt_re/ib_verbs.c  | 18 +++-----------
 drivers/infiniband/hw/bnxt_re/qplib_res.c | 30 +++++++++++++----------
 drivers/infiniband/hw/bnxt_re/qplib_res.h |  3 +--
 3 files changed, 22 insertions(+), 29 deletions(-)

This is part of the umem cleanup. It is a bit complicated, would be good fo=
r
someone to check it. Thanks

diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/=
hw/bnxt_re/ib_verbs.c
index a0e8d93595d8e8..e2707b27c9500c 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -940,9 +940,7 @@ static int bnxt_re_init_user_qp(struct bnxt_re_dev *rde=
v, struct bnxt_re_pd *pd,
 		return PTR_ERR(umem);
=20
 	qp->sumem =3D umem;
-	qplib_qp->sq.sg_info.sghead =3D umem->sg_head.sgl;
-	qplib_qp->sq.sg_info.npages =3D ib_umem_num_dma_blocks(umem, PAGE_SIZE);
-	qplib_qp->sq.sg_info.nmap =3D umem->nmap;
+	qplib_qp->sq.sg_info.umem =3D umem;
 	qplib_qp->sq.sg_info.pgsize =3D PAGE_SIZE;
 	qplib_qp->sq.sg_info.pgshft =3D PAGE_SHIFT;
 	qplib_qp->qp_handle =3D ureq.qp_handle;
@@ -955,10 +953,7 @@ static int bnxt_re_init_user_qp(struct bnxt_re_dev *rd=
ev, struct bnxt_re_pd *pd,
 		if (IS_ERR(umem))
 			goto rqfail;
 		qp->rumem =3D umem;
-		qplib_qp->rq.sg_info.sghead =3D umem->sg_head.sgl;
-		qplib_qp->rq.sg_info.npages =3D
-			ib_umem_num_dma_blocks(umem, PAGE_SIZE);
-		qplib_qp->rq.sg_info.nmap =3D umem->nmap;
+		qplib_qp->rq.sg_info.umem =3D umem;
 		qplib_qp->rq.sg_info.pgsize =3D PAGE_SIZE;
 		qplib_qp->rq.sg_info.pgshft =3D PAGE_SHIFT;
 	}
@@ -1612,9 +1607,7 @@ static int bnxt_re_init_user_srq(struct bnxt_re_dev *=
rdev,
 		return PTR_ERR(umem);
=20
 	srq->umem =3D umem;
-	qplib_srq->sg_info.sghead =3D umem->sg_head.sgl;
-	qplib_srq->sg_info.npages =3D ib_umem_num_dma_blocks(umem, PAGE_SIZE);
-	qplib_srq->sg_info.nmap =3D umem->nmap;
+	qplib_srq->sg_info.umem =3D umem;
 	qplib_srq->sg_info.pgsize =3D PAGE_SIZE;
 	qplib_srq->sg_info.pgshft =3D PAGE_SHIFT;
 	qplib_srq->srq_handle =3D ureq.srq_handle;
@@ -2865,10 +2858,7 @@ int bnxt_re_create_cq(struct ib_cq *ibcq, const stru=
ct ib_cq_init_attr *attr,
 			rc =3D PTR_ERR(cq->umem);
 			goto fail;
 		}
-		cq->qplib_cq.sg_info.sghead =3D cq->umem->sg_head.sgl;
-		cq->qplib_cq.sg_info.npages =3D
-			ib_umem_num_dma_blocks(cq->umem, PAGE_SIZE);
-		cq->qplib_cq.sg_info.nmap =3D cq->umem->nmap;
+		cq->qplib_cq.sg_info.umem =3D cq->umem;
 		cq->qplib_cq.dpi =3D &uctx->dpi;
 	} else {
 		cq->max_cql =3D min_t(u32, entries, MAX_CQL_PER_POLL);
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_res.c b/drivers/infiniband=
/hw/bnxt_re/qplib_res.c
index 7efa6e5dce6282..fa7878336100ac 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_res.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_res.c
@@ -45,6 +45,9 @@
 #include <linux/dma-mapping.h>
 #include <linux/if_vlan.h>
 #include <linux/vmalloc.h>
+#include <rdma/ib_verbs.h>
+#include <rdma/ib_umem.h>
+
 #include "roce_hsi.h"
 #include "qplib_res.h"
 #include "qplib_sp.h"
@@ -87,12 +90,11 @@ static void __free_pbl(struct bnxt_qplib_res *res, stru=
ct bnxt_qplib_pbl *pbl,
 static void bnxt_qplib_fill_user_dma_pages(struct bnxt_qplib_pbl *pbl,
 					   struct bnxt_qplib_sg_info *sginfo)
 {
-	struct scatterlist *sghead =3D sginfo->sghead;
-	struct sg_dma_page_iter sg_iter;
+	struct ib_block_iter biter;
 	int i =3D 0;
=20
-	for_each_sg_dma_page(sghead, &sg_iter, sginfo->nmap, 0) {
-		pbl->pg_map_arr[i] =3D sg_page_iter_dma_address(&sg_iter);
+	rdma_umem_for_each_dma_block(sginfo->umem, &biter, sginfo->pgsize) {
+		pbl->pg_map_arr[i] =3D rdma_block_iter_dma_address(&biter);
 		pbl->pg_arr[i] =3D NULL;
 		pbl->pg_count++;
 		i++;
@@ -104,15 +106,16 @@ static int __alloc_pbl(struct bnxt_qplib_res *res,
 		       struct bnxt_qplib_sg_info *sginfo)
 {
 	struct pci_dev *pdev =3D res->pdev;
-	struct scatterlist *sghead;
 	bool is_umem =3D false;
 	u32 pages;
 	int i;
=20
 	if (sginfo->nopte)
 		return 0;
-	pages =3D sginfo->npages;
-	sghead =3D sginfo->sghead;
+	if (sginfo->umem)
+		pages =3D ib_umem_num_dma_blocks(sginfo->umem, sginfo->pgsize);
+	else
+		pages =3D sginfo->npages;
 	/* page ptr arrays */
 	pbl->pg_arr =3D vmalloc(pages * sizeof(void *));
 	if (!pbl->pg_arr)
@@ -127,7 +130,7 @@ static int __alloc_pbl(struct bnxt_qplib_res *res,
 	pbl->pg_count =3D 0;
 	pbl->pg_size =3D sginfo->pgsize;
=20
-	if (!sghead) {
+	if (!sginfo->umem) {
 		for (i =3D 0; i < pages; i++) {
 			pbl->pg_arr[i] =3D dma_alloc_coherent(&pdev->dev,
 							    pbl->pg_size,
@@ -183,14 +186,12 @@ int bnxt_qplib_alloc_init_hwq(struct bnxt_qplib_hwq *=
hwq,
 	struct bnxt_qplib_sg_info sginfo =3D {};
 	u32 depth, stride, npbl, npde;
 	dma_addr_t *src_phys_ptr, **dst_virt_ptr;
-	struct scatterlist *sghead =3D NULL;
 	struct bnxt_qplib_res *res;
 	struct pci_dev *pdev;
 	int i, rc, lvl;
=20
 	res =3D hwq_attr->res;
 	pdev =3D res->pdev;
-	sghead =3D hwq_attr->sginfo->sghead;
 	pg_size =3D hwq_attr->sginfo->pgsize;
 	hwq->level =3D PBL_LVL_MAX;
=20
@@ -204,7 +205,7 @@ int bnxt_qplib_alloc_init_hwq(struct bnxt_qplib_hwq *hw=
q,
 			aux_pages++;
 	}
=20
-	if (!sghead) {
+	if (!hwq_attr->sginfo->umem) {
 		hwq->is_user =3D false;
 		npages =3D (depth * stride) / pg_size + aux_pages;
 		if ((depth * stride) % pg_size)
@@ -213,11 +214,14 @@ int bnxt_qplib_alloc_init_hwq(struct bnxt_qplib_hwq *=
hwq,
 			return -EINVAL;
 		hwq_attr->sginfo->npages =3D npages;
 	} else {
+		unsigned long sginfo_num_pages =3D ib_umem_num_dma_blocks(
+			hwq_attr->sginfo->umem, hwq_attr->sginfo->pgsize);
+
 		hwq->is_user =3D true;
-		npages =3D hwq_attr->sginfo->npages;
+		npages =3D sginfo_num_pages;
 		npages =3D (npages * PAGE_SIZE) /
 			  BIT_ULL(hwq_attr->sginfo->pgshft);
-		if ((hwq_attr->sginfo->npages * PAGE_SIZE) %
+		if ((sginfo_num_pages * PAGE_SIZE) %
 		     BIT_ULL(hwq_attr->sginfo->pgshft))
 			if (!npages)
 				npages++;
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_res.h b/drivers/infiniband=
/hw/bnxt_re/qplib_res.h
index 9da470d1e4a3c2..ceb94db20a786a 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_res.h
+++ b/drivers/infiniband/hw/bnxt_re/qplib_res.h
@@ -126,8 +126,7 @@ struct bnxt_qplib_pbl {
 };
=20
 struct bnxt_qplib_sg_info {
-	struct scatterlist		*sghead;
-	u32				nmap;
+	struct ib_umem 			*umem;
 	u32				npages;
 	u32				pgshft;
 	u32				pgsize;
--=20
2.28.0

