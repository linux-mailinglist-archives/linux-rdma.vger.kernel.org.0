Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E40225E3D4
	for <lists+linux-rdma@lfdr.de>; Sat,  5 Sep 2020 00:42:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728061AbgIDWmd (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 4 Sep 2020 18:42:33 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:50823 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726441AbgIDWmZ (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 4 Sep 2020 18:42:25 -0400
Received: from hkpgpgate102.nvidia.com (Not Verified[10.18.92.9]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f52c2c40000>; Sat, 05 Sep 2020 06:42:12 +0800
Received: from HKMAIL103.nvidia.com ([10.18.16.12])
  by hkpgpgate102.nvidia.com (PGP Universal service);
  Fri, 04 Sep 2020 15:42:12 -0700
X-PGP-Universal: processed;
        by hkpgpgate102.nvidia.com on Fri, 04 Sep 2020 15:42:12 -0700
Received: from HKMAIL102.nvidia.com (10.18.16.11) by HKMAIL103.nvidia.com
 (10.18.16.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 4 Sep
 2020 22:42:11 +0000
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.170)
 by HKMAIL102.nvidia.com (10.18.16.11) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Fri, 4 Sep 2020 22:42:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fm+DoXtB5UqxdPZONo1QRXRt3Hb+0CjYq/v4NuL59NtxoYDli/DBBbDKnO8lRYcH9Gi5djCxtiLldhAxBZvby1K266ijSyXfxF+ug8WoJaWYupsoFBcNQ1EnrpWaqP3JSYmiwndMDYi/HGhJ2to1a8W2lPkcNFXieqKvaz79eyNBAvX+WHt1OWm3kX8xhn7vFirRQ/hnYnMk48NlBmbQ8MpZvD2Wxk3qc4v7t3Sqbl7EsiQqMBH6GVH4l6ZNAyYJ8fpNQAsaRtWn/q2UuCg34WWc7iueiC3bUF0yOw+Z7mRHJQ/7fY8LmnUAetmstjhwuzFSGhbvOJvH4rhc3eT10Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z4fDVGjnMAWcxyoiTZR7kgvr7HA7uBbiWcbXtujeQEk=;
 b=LvMrkM/RAhfoeF+5CBrSxd6kdSN+q5wv/oIS2JhI4cZK8OZRJULpyG0DE2Gvi51eifrbpvGBgu9HYLhCEOL8nPVZO70bKUrR7Nu12BUD2f64D0ljG1r417qoVFTJyFtESf6Rtkt5g7X5GS47xokvGSUC53zBdGvESPpQ3PJDu2fTCXuB7hvkU85Z905S0y6s/i9Wr368vwH5uxvjOsDyzilxVGWdjst1H8i82ntS0msjwQB26HTo92Aui/ZdA4JFe5S9U0tcKeu860jPY/eFVw37KbvciYmduafwf1Wfa/IVKMKm63VT71sxqkX91aaoUNyMc9ogM1bTT+Nja93GSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB3827.namprd12.prod.outlook.com (2603:10b6:a03:1ab::16)
 by BYAPR12MB2856.namprd12.prod.outlook.com (2603:10b6:a03:136::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.16; Fri, 4 Sep
 2020 22:42:08 +0000
Received: from BY5PR12MB3827.namprd12.prod.outlook.com
 ([fe80::445b:111e:a091:66f9]) by BY5PR12MB3827.namprd12.prod.outlook.com
 ([fe80::445b:111e:a091:66f9%6]) with mapi id 15.20.3326.025; Fri, 4 Sep 2020
 22:42:08 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Doug Ledford <dledford@redhat.com>, <linux-rdma@vger.kernel.org>,
        Yishai Hadas <yishaih@nvidia.com>
Subject: [PATCH v2 15/17] RDMA/mlx4: Use ib_umem_num_dma_blocks()
Date:   Fri, 4 Sep 2020 19:41:56 -0300
Message-ID: <15-v2-270386b7e60b+28f4-umem_1_jgg@nvidia.com>
In-Reply-To: <0-v2-270386b7e60b+28f4-umem_1_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: BL0PR02CA0014.namprd02.prod.outlook.com
 (2603:10b6:207:3c::27) To BY5PR12MB3827.namprd12.prod.outlook.com
 (2603:10b6:a03:1ab::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by BL0PR02CA0014.namprd02.prod.outlook.com (2603:10b6:207:3c::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.20 via Frontend Transport; Fri, 4 Sep 2020 22:42:04 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kEKP9-001vCt-9a; Fri, 04 Sep 2020 19:41:59 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d0f6e2e6-a080-40d1-ca42-08d85123bf12
X-MS-TrafficTypeDiagnostic: BYAPR12MB2856:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB2856252D923F0A00A5A15760C22D0@BYAPR12MB2856.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:785;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nFG6X/fwZzxzn+UZtqI9I7i8+k1FpEJy4iMHHzMd4cZt4isnqJP9Bh/v8cdO+wOwlUqHFssLqySWj2/9btoacNDc4CL3z7NnnCEG5ha8oF2UqVtRemLKphGtD/xRWYDW3RgJKrOSfjOdunl2P150WcGTMKCnotA4Sy4TwGk+f+oaccVLbvHeWW4tn/uFpN2v0+E+06hiEbuwffRlrJmnR0KP3BAxP+G7uz4H3hC/TnykK5ztNKxbssuWy5QIp717U8TekYWVSjRvYYjaXywOGzjVJ0HGx/hg2Oc+gn7KBhrnIfmfIMrVj+LbiLXmEO6E2askZDbBNZNuHvHCHHLAiQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB3827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(136003)(366004)(396003)(346002)(36756003)(6636002)(8936002)(8676002)(9746002)(86362001)(9786002)(5660300002)(2906002)(2616005)(66476007)(26005)(186003)(478600001)(83380400001)(6666004)(426003)(316002)(66556008)(66946007)(110136005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: Qon1vU6WnTgFjIn7sb0ytkrQmdLwH8HH6mmptkhquImsGa/MQZfdg5ikZMIg1atekUWj8zALIf26aQDHzcUTPgBAEP4ixrcTqeDdPCRFcZfoZx/5ydE+wcFg1pBw9pLQEaDqOgx2dqfe4rQg0K8a2+7IlW+5Tpb8koagGnfaiFrS60ofObGsWSWyVPD8lbVTptrKCyy1z9leKOcshqelmQUC3Z2M//NfjY2LqcUK+Q9RzhGwDVtyL7Ik+Q+/aQBqJ/EpfwaI9DnTOgSWGh8AoHES97HjuJqJLI2vwCoxpDvUCWwY0dP5gGTLCuc3mrWEWLU4dgxsn8q0Sxmv8V92aipLYmWyzDZDqgm3ulXStZxM8k/s7nKmGUbGn5Qx/maGBrpCZre4FvZ3slRXNKqIY8QQaWLKIGqpoBeIEohXOG6xexflWxsCYlkFFQu380rbc0tGhF3Da4WtXaXmfABSh/rDMVQfAcR3GggLrAlotcLHyx+9llup+Dn8Acpvs4HXr0w+GulxGbMJPiRxhwcqH7ZWv6Yq21/ZlQAYbCFGsfYoQ4Rw7lqKtqU15ELbLxae5ugFXYZpYqWr/Eun6QVGhssWK1kodTB5tvn6T+NWY2vcWvYWb6tDulS1NSJmOj2BaTqwgwfJm1BAu2zgYG1bHA==
X-MS-Exchange-CrossTenant-Network-Message-Id: d0f6e2e6-a080-40d1-ca42-08d85123bf12
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2020 22:42:05.1266
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8gZnNGZhf3QxpsrUkE9cqzsVx/SOT/Q9c+KVOnTqs+pfxMpjrtxm+nAT5SYxSVEk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2856
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1599259332; bh=VF+xCA0rps0FjffVsg48abVfPfJqo+u8RZxi1lPjvrg=;
        h=X-PGP-Universal:ARC-Seal:ARC-Message-Signature:
         ARC-Authentication-Results:Authentication-Results:From:To:Subject:
         Date:Message-ID:In-Reply-To:References:Content-Transfer-Encoding:
         Content-Type:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-Originating-IP:
         X-MS-PublicTrafficType:X-MS-Office365-Filtering-Correlation-Id:
         X-MS-TrafficTypeDiagnostic:X-MS-Exchange-Transport-Forked:
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
        b=Vxzi2AtJkBACaqO4g02QX/PzPd1zGLfgO0vEaZzWsT2Hu7iI1qvyei9mAuDh9KUxF
         HdvCqoyAH+cFsiB9FEdWxrzOhMxwjqQiaCpIQeX+5avKtSFhaUoeKNFSpHpyAKWXks
         owP3JyVPEWxB9yRyv1xUy6f9CjhTajq6Kq/xaABaKSVwV1EZ7xsN8DqgDedNu9XEF+
         yd2brvrJgQKsg5h89WWeMmTCySo1H6QzKTraKXYKqYLg1Mle8ji8TLGxtOi/YDA9Ra
         k0f2KECOI4f3BGfZ6so0KrB/TaBIO9iqDaPfhoEfmVoELxepUD0Xgy/RhtvMkPHfDj
         PcM5WEJ/03hnQ==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

For the calls linked to mlx4_ib_umem_calc_optimal_mtt_size() use
ib_umem_num_dma_blocks() inside the function, it is just some weird static
default.

All other places are just using it with PAGE_SIZE, switch to
ib_umem_num_dma_blocks().

As this is the last call site, remove ib_umem_num_count().

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/infiniband/core/umem.c   | 12 ------------
 drivers/infiniband/hw/mlx4/cq.c  |  1 -
 drivers/infiniband/hw/mlx4/mr.c  |  5 +++--
 drivers/infiniband/hw/mlx4/qp.c  |  2 --
 drivers/infiniband/hw/mlx4/srq.c |  5 +++--
 include/rdma/ib_umem.h           |  2 --
 6 files changed, 6 insertions(+), 21 deletions(-)

diff --git a/drivers/infiniband/core/umem.c b/drivers/infiniband/core/umem.=
c
index b57dbb14de8378..c1ab6a4f2bc386 100644
--- a/drivers/infiniband/core/umem.c
+++ b/drivers/infiniband/core/umem.c
@@ -350,18 +350,6 @@ void ib_umem_release(struct ib_umem *umem)
 }
 EXPORT_SYMBOL(ib_umem_release);
=20
-int ib_umem_page_count(struct ib_umem *umem)
-{
-	int i, n =3D 0;
-	struct scatterlist *sg;
-
-	for_each_sg(umem->sg_head.sgl, sg, umem->nmap, i)
-		n +=3D sg_dma_len(sg) >> PAGE_SHIFT;
-
-	return n;
-}
-EXPORT_SYMBOL(ib_umem_page_count);
-
 /*
  * Copy from the given ib_umem's pages to the given buffer.
  *
diff --git a/drivers/infiniband/hw/mlx4/cq.c b/drivers/infiniband/hw/mlx4/c=
q.c
index 8a3436994f8097..f62afc13d34885 100644
--- a/drivers/infiniband/hw/mlx4/cq.c
+++ b/drivers/infiniband/hw/mlx4/cq.c
@@ -149,7 +149,6 @@ static int mlx4_ib_get_cq_umem(struct mlx4_ib_dev *dev,=
 struct ib_udata *udata,
 	if (IS_ERR(*umem))
 		return PTR_ERR(*umem);
=20
-	n =3D ib_umem_page_count(*umem);
 	shift =3D mlx4_ib_umem_calc_optimal_mtt_size(*umem, 0, &n);
 	err =3D mlx4_mtt_init(dev->dev, n, shift, &buf->mtt);
=20
diff --git a/drivers/infiniband/hw/mlx4/mr.c b/drivers/infiniband/hw/mlx4/m=
r.c
index 1d5ef0de12c950..bfb779b5eeb3d2 100644
--- a/drivers/infiniband/hw/mlx4/mr.c
+++ b/drivers/infiniband/hw/mlx4/mr.c
@@ -271,6 +271,8 @@ int mlx4_ib_umem_calc_optimal_mtt_size(struct ib_umem *=
umem, u64 start_va,
 	u64 total_len =3D 0;
 	int i;
=20
+	*num_of_mtts =3D ib_umem_num_dma_blocks(umem, PAGE_SIZE);
+
 	for_each_sg(umem->sg_head.sgl, sg, umem->nmap, i) {
 		/*
 		 * Initialization - save the first chunk start as the
@@ -421,7 +423,6 @@ struct ib_mr *mlx4_ib_reg_user_mr(struct ib_pd *pd, u64=
 start, u64 length,
 		goto err_free;
 	}
=20
-	n =3D ib_umem_page_count(mr->umem);
 	shift =3D mlx4_ib_umem_calc_optimal_mtt_size(mr->umem, start, &n);
=20
 	err =3D mlx4_mr_alloc(dev->dev, to_mpd(pd)->pdn, virt_addr, length,
@@ -511,7 +512,7 @@ int mlx4_ib_rereg_user_mr(struct ib_mr *mr, int flags,
 			mmr->umem =3D NULL;
 			goto release_mpt_entry;
 		}
-		n =3D ib_umem_page_count(mmr->umem);
+		n =3D ib_umem_num_dma_blocks(mmr->umem, PAGE_SIZE);
 		shift =3D PAGE_SHIFT;
=20
 		err =3D mlx4_mr_rereg_mem_write(dev->dev, &mmr->mmr,
diff --git a/drivers/infiniband/hw/mlx4/qp.c b/drivers/infiniband/hw/mlx4/q=
p.c
index 2975f350b9fd10..31839f95d44af9 100644
--- a/drivers/infiniband/hw/mlx4/qp.c
+++ b/drivers/infiniband/hw/mlx4/qp.c
@@ -922,7 +922,6 @@ static int create_rq(struct ib_pd *pd, struct ib_qp_ini=
t_attr *init_attr,
 		goto err;
 	}
=20
-	n =3D ib_umem_page_count(qp->umem);
 	shift =3D mlx4_ib_umem_calc_optimal_mtt_size(qp->umem, 0, &n);
 	err =3D mlx4_mtt_init(dev->dev, n, shift, &qp->mtt);
=20
@@ -1117,7 +1116,6 @@ static int create_qp_common(struct ib_pd *pd, struct =
ib_qp_init_attr *init_attr,
 			goto err;
 		}
=20
-		n =3D ib_umem_page_count(qp->umem);
 		shift =3D mlx4_ib_umem_calc_optimal_mtt_size(qp->umem, 0, &n);
 		err =3D mlx4_mtt_init(dev->dev, n, shift, &qp->mtt);
=20
diff --git a/drivers/infiniband/hw/mlx4/srq.c b/drivers/infiniband/hw/mlx4/=
srq.c
index 8f9d5035142d33..108b2d0118d064 100644
--- a/drivers/infiniband/hw/mlx4/srq.c
+++ b/drivers/infiniband/hw/mlx4/srq.c
@@ -115,8 +115,9 @@ int mlx4_ib_create_srq(struct ib_srq *ib_srq,
 		if (IS_ERR(srq->umem))
 			return PTR_ERR(srq->umem);
=20
-		err =3D mlx4_mtt_init(dev->dev, ib_umem_page_count(srq->umem),
-				    PAGE_SHIFT, &srq->mtt);
+		err =3D mlx4_mtt_init(
+			dev->dev, ib_umem_num_dma_blocks(srq->umem, PAGE_SIZE),
+			PAGE_SHIFT, &srq->mtt);
 		if (err)
 			goto err_buf;
=20
diff --git a/include/rdma/ib_umem.h b/include/rdma/ib_umem.h
index 0f1ab3d8f77dea..fa556da3337c86 100644
--- a/include/rdma/ib_umem.h
+++ b/include/rdma/ib_umem.h
@@ -74,7 +74,6 @@ static inline void __rdma_umem_block_iter_start(struct ib=
_block_iter *biter,
 struct ib_umem *ib_umem_get(struct ib_device *device, unsigned long addr,
 			    size_t size, int access);
 void ib_umem_release(struct ib_umem *umem);
-int ib_umem_page_count(struct ib_umem *umem);
 int ib_umem_copy_from(void *dst, struct ib_umem *umem, size_t offset,
 		      size_t length);
 unsigned long ib_umem_find_best_pgsz(struct ib_umem *umem,
@@ -92,7 +91,6 @@ static inline struct ib_umem *ib_umem_get(struct ib_devic=
e *device,
 	return ERR_PTR(-EINVAL);
 }
 static inline void ib_umem_release(struct ib_umem *umem) { }
-static inline int ib_umem_page_count(struct ib_umem *umem) { return 0; }
 static inline int ib_umem_copy_from(void *dst, struct ib_umem *umem, size_=
t offset,
 		      		    size_t length) {
 	return -EINVAL;
--=20
2.28.0

