Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 805B73D39A7
	for <lists+linux-rdma@lfdr.de>; Fri, 23 Jul 2021 13:41:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234678AbhGWK7p (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 23 Jul 2021 06:59:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:38962 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234623AbhGWK7l (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 23 Jul 2021 06:59:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E64F460E8E;
        Fri, 23 Jul 2021 11:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627040414;
        bh=9xv4JmFZ3GB3RoiD7Y9IW8R3273Ho3jy6hJWvUao1ro=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DMuSQVyMn9bkUtw48nTxpQDWSIbbPwvG86/z4gwU0nUYtPluh0cRubzldKrW2/M6X
         ZLO4wrsfnCayQzafPHr1zvq6eXaly7lCzOoG8ukA62IEFid7vpHT7ZaMqEBLm2s0E3
         qcAvUcKJxcajatn+OI9EdLVxLFCYSJ9eURksvLgLyTpQDZ/p1Cdmkn6y6MJ1K7Nwkh
         UTDd+yl7OzwSv2+ara84FCUaCoZ0cbmKGS0UVd/9Fu75ni/HvZdG14CcyGs72VFFPH
         4TP/V/RRdeKxMfd2dsT2sqVKEb+GAeKGv/A6d9DW9qbpeG1NXVcdZmtIAbdapMm3p9
         i41yeVqPJs9Ag==
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
Subject: [PATCH rdma-next v1 6/9] RDMA/mlx5: Rework custom driver QP type creation
Date:   Fri, 23 Jul 2021 14:39:48 +0300
Message-Id: <51682ab82298748941f38bd23ee3bf77ef1cab7b.1627040189.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1627040189.git.leonro@nvidia.com>
References: <cover.1627040189.git.leonro@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@nvidia.com>

Starting from commit 2b1f747071c5 ("RDMA/core: Allow drivers to disable
restrack DB") the restrack is able to handle non-standard QP types either.

That change allows us to rewrite custom QP calls to their IB/core counterparts,
so we will use general QP creation flow even for the driver QP types.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/gsi.c  | 15 ++-------------
 drivers/infiniband/hw/mlx5/main.c | 20 +++++++-------------
 drivers/infiniband/hw/mlx5/qp.c   |  6 +++++-
 3 files changed, 14 insertions(+), 27 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/gsi.c b/drivers/infiniband/hw/mlx5/gsi.c
index e549d6fa4a41..541da52470cb 100644
--- a/drivers/infiniband/hw/mlx5/gsi.c
+++ b/drivers/infiniband/hw/mlx5/gsi.c
@@ -145,24 +145,13 @@ int mlx5_ib_create_gsi(struct ib_pd *pd, struct mlx5_ib_qp *mqp,
 		hw_init_attr.cap.max_inline_data = 0;
 	}
 
-	gsi->rx_qp = mlx5_ib_create_qp(pd, &hw_init_attr, NULL);
+	gsi->rx_qp = ib_create_qp(pd, &hw_init_attr);
 	if (IS_ERR(gsi->rx_qp)) {
 		mlx5_ib_warn(dev, "unable to create hardware GSI QP. error %ld\n",
 			     PTR_ERR(gsi->rx_qp));
 		ret = PTR_ERR(gsi->rx_qp);
 		goto err_destroy_cq;
 	}
-	gsi->rx_qp->device = pd->device;
-	gsi->rx_qp->pd = pd;
-	gsi->rx_qp->real_qp = gsi->rx_qp;
-
-	gsi->rx_qp->qp_type = hw_init_attr.qp_type;
-	gsi->rx_qp->send_cq = hw_init_attr.send_cq;
-	gsi->rx_qp->recv_cq = hw_init_attr.recv_cq;
-	gsi->rx_qp->event_handler = hw_init_attr.event_handler;
-	spin_lock_init(&gsi->rx_qp->mr_lock);
-	INIT_LIST_HEAD(&gsi->rx_qp->rdma_mrs);
-	INIT_LIST_HEAD(&gsi->rx_qp->sig_mrs);
 
 	dev->devr.ports[attr->port_num - 1].gsi = gsi;
 	return 0;
@@ -184,7 +173,7 @@ int mlx5_ib_destroy_gsi(struct mlx5_ib_qp *mqp)
 	int qp_index;
 	int ret;
 
-	ret = mlx5_ib_destroy_qp(gsi->rx_qp, NULL);
+	ret = ib_destroy_qp(gsi->rx_qp);
 	if (ret) {
 		mlx5_ib_warn(dev, "unable to destroy hardware GSI QP. error %d\n",
 			     ret);
diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index cac05bbe14c2..bcdbc3033b0a 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -4073,7 +4073,7 @@ static void mlx5_ib_stage_pre_ib_reg_umr_cleanup(struct mlx5_ib_dev *dev)
 		mlx5_ib_warn(dev, "mr cache cleanup failed\n");
 
 	if (dev->umrc.qp)
-		mlx5_ib_destroy_qp(dev->umrc.qp, NULL);
+		ib_destroy_qp(dev->umrc.qp);
 	if (dev->umrc.cq)
 		ib_free_cq(dev->umrc.cq);
 	if (dev->umrc.pd)
@@ -4126,23 +4126,17 @@ static int mlx5_ib_stage_post_ib_reg_umr_init(struct mlx5_ib_dev *dev)
 	init_attr->cap.max_send_sge = 1;
 	init_attr->qp_type = MLX5_IB_QPT_REG_UMR;
 	init_attr->port_num = 1;
-	qp = mlx5_ib_create_qp(pd, init_attr, NULL);
+	qp = ib_create_qp(pd, init_attr);
 	if (IS_ERR(qp)) {
 		mlx5_ib_dbg(dev, "Couldn't create sync UMR QP\n");
 		ret = PTR_ERR(qp);
 		goto error_3;
 	}
-	qp->device     = &dev->ib_dev;
-	qp->real_qp    = qp;
-	qp->uobject    = NULL;
-	qp->qp_type    = MLX5_IB_QPT_REG_UMR;
-	qp->send_cq    = init_attr->send_cq;
-	qp->recv_cq    = init_attr->recv_cq;
 
 	attr->qp_state = IB_QPS_INIT;
 	attr->port_num = 1;
-	ret = mlx5_ib_modify_qp(qp, attr, IB_QP_STATE | IB_QP_PKEY_INDEX |
-				IB_QP_PORT, NULL);
+	ret = ib_modify_qp(qp, attr,
+			   IB_QP_STATE | IB_QP_PKEY_INDEX | IB_QP_PORT);
 	if (ret) {
 		mlx5_ib_dbg(dev, "Couldn't modify UMR QP\n");
 		goto error_4;
@@ -4152,7 +4146,7 @@ static int mlx5_ib_stage_post_ib_reg_umr_init(struct mlx5_ib_dev *dev)
 	attr->qp_state = IB_QPS_RTR;
 	attr->path_mtu = IB_MTU_256;
 
-	ret = mlx5_ib_modify_qp(qp, attr, IB_QP_STATE, NULL);
+	ret = ib_modify_qp(qp, attr, IB_QP_STATE);
 	if (ret) {
 		mlx5_ib_dbg(dev, "Couldn't modify umr QP to rtr\n");
 		goto error_4;
@@ -4160,7 +4154,7 @@ static int mlx5_ib_stage_post_ib_reg_umr_init(struct mlx5_ib_dev *dev)
 
 	memset(attr, 0, sizeof(*attr));
 	attr->qp_state = IB_QPS_RTS;
-	ret = mlx5_ib_modify_qp(qp, attr, IB_QP_STATE, NULL);
+	ret = ib_modify_qp(qp, attr, IB_QP_STATE);
 	if (ret) {
 		mlx5_ib_dbg(dev, "Couldn't modify umr QP to rts\n");
 		goto error_4;
@@ -4183,7 +4177,7 @@ static int mlx5_ib_stage_post_ib_reg_umr_init(struct mlx5_ib_dev *dev)
 	return 0;
 
 error_4:
-	mlx5_ib_destroy_qp(qp, NULL);
+	ib_destroy_qp(qp);
 	dev->umrc.qp = NULL;
 
 error_3:
diff --git a/drivers/infiniband/hw/mlx5/qp.c b/drivers/infiniband/hw/mlx5/qp.c
index 3d797be84bfa..d6c6bfe9921a 100644
--- a/drivers/infiniband/hw/mlx5/qp.c
+++ b/drivers/infiniband/hw/mlx5/qp.c
@@ -2675,7 +2675,6 @@ static int create_dct(struct mlx5_ib_dev *dev, struct ib_pd *pd,
 	}
 
 	qp->state = IB_QPS_RESET;
-	rdma_restrack_no_track(&qp->ibqp.res);
 	return 0;
 }
 
@@ -3014,6 +3013,7 @@ static int create_qp(struct mlx5_ib_dev *dev, struct ib_pd *pd,
 	switch (qp->type) {
 	case MLX5_IB_QPT_DCT:
 		err = create_dct(dev, pd, qp, params);
+		rdma_restrack_no_track(&qp->ibqp.res);
 		break;
 	case MLX5_IB_QPT_DCI:
 		err = create_dci(dev, pd, qp, params);
@@ -3024,6 +3024,10 @@ static int create_qp(struct mlx5_ib_dev *dev, struct ib_pd *pd,
 	case IB_QPT_GSI:
 		err = mlx5_ib_create_gsi(pd, qp, params->attr);
 		break;
+	case MLX5_IB_QPT_HW_GSI:
+	case MLX5_IB_QPT_REG_UMR:
+		rdma_restrack_no_track(&qp->ibqp.res);
+		fallthrough;
 	default:
 		if (params->udata)
 			err = create_user_qp(dev, pd, qp, params);
-- 
2.31.1

