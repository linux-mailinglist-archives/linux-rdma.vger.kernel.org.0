Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 532C6282750
	for <lists+linux-rdma@lfdr.de>; Sun,  4 Oct 2020 01:20:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726056AbgJCXUP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 3 Oct 2020 19:20:15 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:14497 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726053AbgJCXUP (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 3 Oct 2020 19:20:15 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f7907220000>; Sat, 03 Oct 2020 16:20:02 -0700
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sat, 3 Oct
 2020 23:20:14 +0000
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.36.54) by
 HQMAIL111.nvidia.com (172.20.187.18) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Sat, 3 Oct 2020 23:20:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EJK1Iq5sM6io1sHnxC5nVwL7FLl8FGvzVtfOOo7XOOEmH086KaVWms+tI5PxNlfCx2mKWQI2eN8AvMNezUiRVhjj52tCLv+bwNwjnHYlvoNt6EIsoDLgw30IYKTaEAqTgpFRgpbbZ9+MW37tQxeOAb6d0JLUBjg6lC7GPMnjS4en/c6ImwnSEDLbFVuhM0LZzTWJPkamlV3BgrZMpPTNaQTLMaQcnI9den/l7HgyTPWLFG0XPrAMhUzqQT1ciIv2Fk1MSygtstlLBokowV2nW6cXTz1y/FCiTrnH8AR5/zWoP6LuBgJaUwzVT2AV2CLhTHahwYbtHRgbJmG0sWYK0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YhyIV5HUoqfn6LQx1f5TdOOUyuAvrrRj1NADnVKqZLQ=;
 b=Op+C5t+fGB0XDtCsSz5Bb21er0QaqlM2Mz1sEHsC03d+dE4Tvb/JlCi9px9TImVOqdpFfsSg7UoSDHifYxVrzrR9UbgJEEUAve5h9mbkcflBAUSm/6BLEauWOlwsevC4of4Lw0Ybd/aoU6+wQiSbn35cVW60V9F8OCdPRiGGJ6AeeS0btatvc3J0PmbEaTxLEPF3jXWGyR94CtoA3He60Kpa0xzstFc+lKhomRYHvQJWyz1rmeHgZfzCemwbSJu4XeWIpFiyBEJr0ckjpZYHwwRoNprlPlyrJsbw9YTFEAC85Rf+jRZ926q+zwXh9aC/UWrMiDYa4W3+40w4s1PVtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB2582.namprd12.prod.outlook.com (2603:10b6:4:b5::37) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.32; Sat, 3 Oct
 2020 23:20:13 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3433.038; Sat, 3 Oct 2020
 23:20:13 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Potnuri Bharat Teja <bharat@chelsio.com>,
        <linux-rdma@vger.kernel.org>, Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH 01/11] RDMA/cxgb4: Remove MW support
Date:   Sat, 3 Oct 2020 20:20:01 -0300
Message-ID: <1-v1-caa70ba3d1ab+1436e-ucmd_mask_jgg@nvidia.com>
In-Reply-To: <0-v1-caa70ba3d1ab+1436e-ucmd_mask_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: MN2PR15CA0020.namprd15.prod.outlook.com
 (2603:10b6:208:1b4::33) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR15CA0020.namprd15.prod.outlook.com (2603:10b6:208:1b4::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.35 via Frontend Transport; Sat, 3 Oct 2020 23:20:12 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kOqp1-0075cE-G6; Sat, 03 Oct 2020 20:20:11 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1601767202; bh=TQeEQAHjHvktZH9akivjBmYmkG0IZMo+JcT9vYvSjaI=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:From:To:
         Subject:Date:Message-ID:In-Reply-To:References:
         Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:
         MIME-Version:X-MS-Exchange-MessageSentRepresentingType;
        b=AUb5L5d5QC2R1BkVMToqxs8Mi+5yC/0q0igDfSao9eDiePPHR+5CKedE1j1w4tG2E
         8cs9993JAADAdLRb1/YSiqrINcPHubKfKRLN11tzmuZSirL2R23oJysbUDclzTZjWO
         btz69PXHAlAfGtuAOaNftTR4fmh4HZ6Iyer/sPzrUgqGfU5O2YXYhCsOSrnRFo8YOB
         F6b0O3OnKseK9AFkqpu1bayBOV/EU/at13vSlWnevRbSHDctAyHMiJ5QrZfYCcp6ef
         v2ptH6OjQRDbDrqcv084HNnZ+fJ5BiWbuVwKpHhBpG3Z8NJRi8w/kOmqhy7UtBBueV
         utZwXAZH55BTQ==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This driver never enabled IB_USER_VERBS_CMD_ALLOC_MW so memory windows
were not usable from userspace. The kernel side was removed long ago. Drop
this dead code.

Fixes: feb7c1e38bcc ("IB: remove in-kernel support for memory windows")
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/infiniband/hw/cxgb4/iw_cxgb4.h |  2 -
 drivers/infiniband/hw/cxgb4/mem.c      | 84 --------------------------
 drivers/infiniband/hw/cxgb4/provider.c |  2 -
 3 files changed, 88 deletions(-)

diff --git a/drivers/infiniband/hw/cxgb4/iw_cxgb4.h b/drivers/infiniband/hw=
/cxgb4/iw_cxgb4.h
index a27899402f59a5..f85477f3b037d2 100644
--- a/drivers/infiniband/hw/cxgb4/iw_cxgb4.h
+++ b/drivers/infiniband/hw/cxgb4/iw_cxgb4.h
@@ -983,9 +983,7 @@ struct ib_mr *c4iw_alloc_mr(struct ib_pd *pd, enum ib_m=
r_type mr_type,
 			    u32 max_num_sg);
 int c4iw_map_mr_sg(struct ib_mr *ibmr, struct scatterlist *sg, int sg_nent=
s,
 		   unsigned int *sg_offset);
-int c4iw_dealloc_mw(struct ib_mw *mw);
 void c4iw_dealloc(struct uld_ctx *ctx);
-int c4iw_alloc_mw(struct ib_mw *mw, struct ib_udata *udata);
 struct ib_mr *c4iw_reg_user_mr(struct ib_pd *pd, u64 start,
 					   u64 length, u64 virt, int acc,
 					   struct ib_udata *udata);
diff --git a/drivers/infiniband/hw/cxgb4/mem.c b/drivers/infiniband/hw/cxgb=
4/mem.c
index 42234df896fb2c..a2c71a1d93d5a8 100644
--- a/drivers/infiniband/hw/cxgb4/mem.c
+++ b/drivers/infiniband/hw/cxgb4/mem.c
@@ -365,22 +365,6 @@ static int dereg_mem(struct c4iw_rdev *rdev, u32 stag,=
 u32 pbl_size,
 			       pbl_size, pbl_addr, skb, wr_waitp);
 }
=20
-static int allocate_window(struct c4iw_rdev *rdev, u32 *stag, u32 pdid,
-			   struct c4iw_wr_wait *wr_waitp)
-{
-	*stag =3D T4_STAG_UNSET;
-	return write_tpt_entry(rdev, 0, stag, 0, pdid, FW_RI_STAG_MW, 0, 0, 0,
-			       0UL, 0, 0, 0, 0, NULL, wr_waitp);
-}
-
-static int deallocate_window(struct c4iw_rdev *rdev, u32 stag,
-			     struct sk_buff *skb,
-			     struct c4iw_wr_wait *wr_waitp)
-{
-	return write_tpt_entry(rdev, 1, &stag, 0, 0, 0, 0, 0, 0, 0UL, 0, 0, 0,
-			       0, skb, wr_waitp);
-}
-
 static int allocate_stag(struct c4iw_rdev *rdev, u32 *stag, u32 pdid,
 			 u32 pbl_size, u32 pbl_addr,
 			 struct c4iw_wr_wait *wr_waitp)
@@ -611,74 +595,6 @@ struct ib_mr *c4iw_reg_user_mr(struct ib_pd *pd, u64 s=
tart, u64 length,
 	return ERR_PTR(err);
 }
=20
-int c4iw_alloc_mw(struct ib_mw *ibmw, struct ib_udata *udata)
-{
-	struct c4iw_mw *mhp =3D to_c4iw_mw(ibmw);
-	struct c4iw_dev *rhp;
-	struct c4iw_pd *php;
-	u32 mmid;
-	u32 stag =3D 0;
-	int ret;
-
-	if (ibmw->type !=3D IB_MW_TYPE_1)
-		return -EINVAL;
-
-	php =3D to_c4iw_pd(ibmw->pd);
-	rhp =3D php->rhp;
-	mhp->wr_waitp =3D c4iw_alloc_wr_wait(GFP_KERNEL);
-	if (!mhp->wr_waitp)
-		return -ENOMEM;
-
-	mhp->dereg_skb =3D alloc_skb(SGE_MAX_WR_LEN, GFP_KERNEL);
-	if (!mhp->dereg_skb) {
-		ret =3D -ENOMEM;
-		goto free_wr_wait;
-	}
-
-	ret =3D allocate_window(&rhp->rdev, &stag, php->pdid, mhp->wr_waitp);
-	if (ret)
-		goto free_skb;
-
-	mhp->rhp =3D rhp;
-	mhp->attr.pdid =3D php->pdid;
-	mhp->attr.type =3D FW_RI_STAG_MW;
-	mhp->attr.stag =3D stag;
-	mmid =3D (stag) >> 8;
-	ibmw->rkey =3D stag;
-	if (xa_insert_irq(&rhp->mrs, mmid, mhp, GFP_KERNEL)) {
-		ret =3D -ENOMEM;
-		goto dealloc_win;
-	}
-	pr_debug("mmid 0x%x mhp %p stag 0x%x\n", mmid, mhp, stag);
-	return 0;
-
-dealloc_win:
-	deallocate_window(&rhp->rdev, mhp->attr.stag, mhp->dereg_skb,
-			  mhp->wr_waitp);
-free_skb:
-	kfree_skb(mhp->dereg_skb);
-free_wr_wait:
-	c4iw_put_wr_wait(mhp->wr_waitp);
-	return ret;
-}
-
-int c4iw_dealloc_mw(struct ib_mw *mw)
-{
-	struct c4iw_dev *rhp;
-	struct c4iw_mw *mhp;
-	u32 mmid;
-
-	mhp =3D to_c4iw_mw(mw);
-	rhp =3D mhp->rhp;
-	mmid =3D (mw->rkey) >> 8;
-	xa_erase_irq(&rhp->mrs, mmid);
-	deallocate_window(&rhp->rdev, mhp->attr.stag, mhp->dereg_skb,
-			  mhp->wr_waitp);
-	kfree_skb(mhp->dereg_skb);
-	c4iw_put_wr_wait(mhp->wr_waitp);
-	return 0;
-}
-
 struct ib_mr *c4iw_alloc_mr(struct ib_pd *pd, enum ib_mr_type mr_type,
 			    u32 max_num_sg)
 {
diff --git a/drivers/infiniband/hw/cxgb4/provider.c b/drivers/infiniband/hw=
/cxgb4/provider.c
index 4b76f2f3f4e483..3bdcdce9def2da 100644
--- a/drivers/infiniband/hw/cxgb4/provider.c
+++ b/drivers/infiniband/hw/cxgb4/provider.c
@@ -456,13 +456,11 @@ static const struct ib_device_ops c4iw_dev_ops =3D {
=20
 	.alloc_hw_stats =3D c4iw_alloc_stats,
 	.alloc_mr =3D c4iw_alloc_mr,
-	.alloc_mw =3D c4iw_alloc_mw,
 	.alloc_pd =3D c4iw_allocate_pd,
 	.alloc_ucontext =3D c4iw_alloc_ucontext,
 	.create_cq =3D c4iw_create_cq,
 	.create_qp =3D c4iw_create_qp,
 	.create_srq =3D c4iw_create_srq,
-	.dealloc_mw =3D c4iw_dealloc_mw,
 	.dealloc_pd =3D c4iw_deallocate_pd,
 	.dealloc_ucontext =3D c4iw_dealloc_ucontext,
 	.dereg_mr =3D c4iw_dereg_mr,
--=20
2.28.0

