Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E62FA3CC8FE
	for <lists+linux-rdma@lfdr.de>; Sun, 18 Jul 2021 14:01:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233621AbhGRMEh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 18 Jul 2021 08:04:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:44376 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233673AbhGRMEd (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 18 Jul 2021 08:04:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3450F610D1;
        Sun, 18 Jul 2021 12:01:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626609695;
        bh=/xVusLaIisjwDrhXsvTfDCOTo4UomSFhxaE4UNzqDKw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tlBgpCaOgQl+f4P/lZePWrp2FJY1W7wWBVXbsPlBArWT5cbsCdBdIF4RUkXHiSd1J
         msWD0is3f7tLTVjqsKGWrsRoh6vtRtvLFsNCICtcyyTCkH1Q6aTDxBG5r/SPfekhga
         2mSplqEyAGYmfXXbYMOFrF91pEfkEwRYc/0GFEwSuflgFnOTnXuVpe5NZotDIFbdBK
         MuQusF6riXH45KhMs4F43bzOxgH+ECJGF+qfJYRuAtmRBNY+nuucGA7A7b+GQRJPRi
         qdWQU+WFgPqMDfZcbxkKK4ClCN5cHZy55CaSyQbEpqd+sdSLLh9J5K8+wGUbR8GL4x
         mbWfNHeYpUGVg==
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leonro@nvidia.com>,
        Adit Ranadive <aditr@vmware.com>,
        Ariel Elior <aelior@marvell.com>,
        Bernard Metzler <bmt@zurich.ibm.com>,
        Christian Benvenuti <benve@cisco.com>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Gal Pressman <galpress@amazon.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Michal Kalderon <mkalderon@marvell.com>,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        Mustafa Ismail <mustafa.ismail@intel.com>,
        Naresh Kumar PBS <nareshkumar.pbs@broadcom.com>,
        Nelson Escobar <neescoba@cisco.com>,
        Potnuri Bharat Teja <bharat@chelsio.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Steve Wise <larrystevenwise@gmail.com>,
        VMware PV-Drivers <pv-drivers@vmware.com>,
        Weihang Li <liweihang@huawei.com>,
        Wenpeng Liang <liangwenpeng@huawei.com>,
        Yishai Hadas <yishaih@nvidia.com>,
        Zhu Yanjun <zyjzyj2000@gmail.com>
Subject: [PATCH rdma-next 9/9] RDMA/mlx5: Drop in-driver verbs object creations
Date:   Sun, 18 Jul 2021 15:00:59 +0300
Message-Id: <b5f778c93b2d98721f635c0c160f05d33dea9285.1626609283.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1626609283.git.leonro@nvidia.com>
References: <cover.1626609283.git.leonro@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@nvidia.com>

There is no real value in bypassing IB/core APIs for creating standard
objects with standard types. The open-coded variant didn't have any
restrack task management calls and caused to such objects to be not
present when running rdmatoool.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/core/verbs.c   |  7 ++-
 drivers/infiniband/hw/mlx5/main.c | 92 +++++++------------------------
 2 files changed, 25 insertions(+), 74 deletions(-)

diff --git a/drivers/infiniband/core/verbs.c b/drivers/infiniband/core/verbs.c
index a164609c2ee7..89c6987cb5eb 100644
--- a/drivers/infiniband/core/verbs.c
+++ b/drivers/infiniband/core/verbs.c
@@ -1035,7 +1035,8 @@ struct ib_srq *ib_create_srq_user(struct ib_pd *pd,
 	}
 	if (srq->srq_type == IB_SRQT_XRC) {
 		srq->ext.xrc.xrcd = srq_init_attr->ext.xrc.xrcd;
-		atomic_inc(&srq->ext.xrc.xrcd->usecnt);
+		if (srq->ext.xrc.xrcd)
+			atomic_inc(&srq->ext.xrc.xrcd->usecnt);
 	}
 	atomic_inc(&pd->usecnt);
 
@@ -1046,7 +1047,7 @@ struct ib_srq *ib_create_srq_user(struct ib_pd *pd,
 	if (ret) {
 		rdma_restrack_put(&srq->res);
 		atomic_dec(&srq->pd->usecnt);
-		if (srq->srq_type == IB_SRQT_XRC)
+		if (srq->srq_type == IB_SRQT_XRC && srq->ext.xrc.xrcd)
 			atomic_dec(&srq->ext.xrc.xrcd->usecnt);
 		if (ib_srq_has_cq(srq->srq_type))
 			atomic_dec(&srq->ext.cq->usecnt);
@@ -1090,7 +1091,7 @@ int ib_destroy_srq_user(struct ib_srq *srq, struct ib_udata *udata)
 		return ret;
 
 	atomic_dec(&srq->pd->usecnt);
-	if (srq->srq_type == IB_SRQT_XRC)
+	if (srq->srq_type == IB_SRQT_XRC && srq->ext.xrc.xrcd)
 		atomic_dec(&srq->ext.xrc.xrcd->usecnt);
 	if (ib_srq_has_cq(srq->srq_type))
 		atomic_dec(&srq->ext.cq->usecnt);
diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index 7a6bafc19c9b..fbed9e4241e1 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -2802,31 +2802,16 @@ static int mlx5_ib_dev_res_init(struct mlx5_ib_dev *dev)
 	if (!MLX5_CAP_GEN(dev->mdev, xrc))
 		return -EOPNOTSUPP;
 
-	devr->p0 = rdma_zalloc_drv_obj(ibdev, ib_pd);
-	if (!devr->p0)
-		return -ENOMEM;
-
-	devr->p0->device  = ibdev;
-	devr->p0->uobject = NULL;
-	atomic_set(&devr->p0->usecnt, 0);
+	devr->p0 = ib_alloc_pd(ibdev, 0);
+	if (IS_ERR(devr->p0))
+		return PTR_ERR(devr->p0);
 
-	ret = mlx5_ib_alloc_pd(devr->p0, NULL);
-	if (ret)
-		goto error0;
-
-	devr->c0 = rdma_zalloc_drv_obj(ibdev, ib_cq);
-	if (!devr->c0) {
-		ret = -ENOMEM;
+	devr->c0 = ib_create_cq(ibdev, NULL, NULL, NULL, &cq_attr);
+	if (IS_ERR(devr->c0)) {
+		ret = PTR_ERR(devr->c0);
 		goto error1;
 	}
 
-	devr->c0->device = &dev->ib_dev;
-	atomic_set(&devr->c0->usecnt, 0);
-
-	ret = mlx5_ib_create_cq(devr->c0, &cq_attr, NULL);
-	if (ret)
-		goto err_create_cq;
-
 	ret = mlx5_cmd_xrcd_alloc(dev->mdev, &devr->xrcdn0, 0);
 	if (ret)
 		goto error2;
@@ -2841,45 +2826,22 @@ static int mlx5_ib_dev_res_init(struct mlx5_ib_dev *dev)
 	attr.srq_type = IB_SRQT_XRC;
 	attr.ext.cq = devr->c0;
 
-	devr->s0 = rdma_zalloc_drv_obj(ibdev, ib_srq);
-	if (!devr->s0) {
-		ret = -ENOMEM;
-		goto error4;
-	}
-
-	devr->s0->device	= &dev->ib_dev;
-	devr->s0->pd		= devr->p0;
-	devr->s0->srq_type      = IB_SRQT_XRC;
-	devr->s0->ext.cq	= devr->c0;
-	ret = mlx5_ib_create_srq(devr->s0, &attr, NULL);
-	if (ret)
+	devr->s0 = ib_create_srq(devr->p0, &attr);
+	if (IS_ERR(devr->s0)) {
+		ret = PTR_ERR(devr->s0);
 		goto err_create;
-
-	atomic_inc(&devr->s0->ext.cq->usecnt);
-	atomic_inc(&devr->p0->usecnt);
-	atomic_set(&devr->s0->usecnt, 0);
+	}
 
 	memset(&attr, 0, sizeof(attr));
 	attr.attr.max_sge = 1;
 	attr.attr.max_wr = 1;
 	attr.srq_type = IB_SRQT_BASIC;
-	devr->s1 = rdma_zalloc_drv_obj(ibdev, ib_srq);
-	if (!devr->s1) {
-		ret = -ENOMEM;
-		goto error5;
-	}
-
-	devr->s1->device	= &dev->ib_dev;
-	devr->s1->pd		= devr->p0;
-	devr->s1->srq_type      = IB_SRQT_BASIC;
-	devr->s1->ext.cq	= devr->c0;
 
-	ret = mlx5_ib_create_srq(devr->s1, &attr, NULL);
-	if (ret)
+	devr->s1 = ib_create_srq(devr->p0, &attr);
+	if (IS_ERR(devr->s1)) {
+		ret = PTR_ERR(devr->s1);
 		goto error6;
-
-	atomic_inc(&devr->p0->usecnt);
-	atomic_set(&devr->s1->usecnt, 0);
+	}
 
 	for (port = 0; port < ARRAY_SIZE(devr->ports); ++port)
 		INIT_WORK(&devr->ports[port].pkey_change_work,
@@ -2888,23 +2850,15 @@ static int mlx5_ib_dev_res_init(struct mlx5_ib_dev *dev)
 	return 0;
 
 error6:
-	kfree(devr->s1);
-error5:
-	mlx5_ib_destroy_srq(devr->s0, NULL);
+	ib_destroy_srq(devr->s0);
 err_create:
-	kfree(devr->s0);
-error4:
 	mlx5_cmd_xrcd_dealloc(dev->mdev, devr->xrcdn1, 0);
 error3:
 	mlx5_cmd_xrcd_dealloc(dev->mdev, devr->xrcdn0, 0);
 error2:
-	mlx5_ib_destroy_cq(devr->c0, NULL);
-err_create_cq:
-	kfree(devr->c0);
+	ib_destroy_cq(devr->c0);
 error1:
-	mlx5_ib_dealloc_pd(devr->p0, NULL);
-error0:
-	kfree(devr->p0);
+	ib_dealloc_pd(devr->p0);
 	return ret;
 }
 
@@ -2922,16 +2876,12 @@ static void mlx5_ib_dev_res_cleanup(struct mlx5_ib_dev *dev)
 	for (port = 0; port < ARRAY_SIZE(devr->ports); ++port)
 		cancel_work_sync(&devr->ports[port].pkey_change_work);
 
-	mlx5_ib_destroy_srq(devr->s1, NULL);
-	kfree(devr->s1);
-	mlx5_ib_destroy_srq(devr->s0, NULL);
-	kfree(devr->s0);
+	ib_destroy_srq(devr->s1);
+	ib_destroy_srq(devr->s0);
 	mlx5_cmd_xrcd_dealloc(dev->mdev, devr->xrcdn1, 0);
 	mlx5_cmd_xrcd_dealloc(dev->mdev, devr->xrcdn0, 0);
-	mlx5_ib_destroy_cq(devr->c0, NULL);
-	kfree(devr->c0);
-	mlx5_ib_dealloc_pd(devr->p0, NULL);
-	kfree(devr->p0);
+	ib_destroy_cq(devr->c0);
+	ib_dealloc_pd(devr->p0);
 }
 
 static u32 get_core_cap_flags(struct ib_device *ibdev,
-- 
2.31.1

