Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB6893CC8F3
	for <lists+linux-rdma@lfdr.de>; Sun, 18 Jul 2021 14:01:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233207AbhGRMER (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 18 Jul 2021 08:04:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:43912 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233225AbhGRMEQ (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 18 Jul 2021 08:04:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 238846108B;
        Sun, 18 Jul 2021 12:01:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626609677;
        bh=uzq54RD5rZlPgk1E6YmXI5XtGyehCEp6l22OvYxcfvA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GVxrMkCQYE+pAomwkbx63lnQMvryKVV5dnEGWkl81UYrEgqmqF//S9YKv5qwjgCAw
         WLh6PNMpBOI9qMBq/QpxCLnjzZNdJE0H5h8xpL0MyY+x74P9i6ngquMcKKqE/yRntk
         YNifI/qGlAYzw1ROZilcnAXkjXQGqA0AzEB7WeJReqe2qTEoEQbPX0ydTWNvtLfQXv
         OIf4GTCkp3sMLliXTt64JxqUvEE/gcCsCRw6JB2E+TesqxqKF7dczpCMFCf/THjoAD
         AHcnkMEI/0njNW6ufeEIvl6z4TjG8lJcdxBegyUJQUl7VWEwP2f3oT2K4wDgKtrrYE
         ziOThhJRMsloQ==
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
Subject: [PATCH rdma-next 5/9] RDMA/mlx5: Delete device resource mutex that didn't protect anything
Date:   Sun, 18 Jul 2021 15:00:55 +0300
Message-Id: <f95293039318b38d4a0ecd7780dd09b5c7de0a9e.1626609283.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1626609283.git.leonro@nvidia.com>
References: <cover.1626609283.git.leonro@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@nvidia.com>

The dev->devr.mutex was intended to protect GSI QP pointer change
in the struct mlx5_ib_port_resources when it is accessed from the
pkey_change_work. However that pointer isn't changed during the
runtime and once IB/core adds MAD, it stays stable.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/gsi.c     | 34 ++++++++--------------------
 drivers/infiniband/hw/mlx5/main.c    |  9 ++++++--
 drivers/infiniband/hw/mlx5/mlx5_ib.h |  2 --
 3 files changed, 16 insertions(+), 29 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/gsi.c b/drivers/infiniband/hw/mlx5/gsi.c
index 7fcad9135276..e549d6fa4a41 100644
--- a/drivers/infiniband/hw/mlx5/gsi.c
+++ b/drivers/infiniband/hw/mlx5/gsi.c
@@ -116,8 +116,6 @@ int mlx5_ib_create_gsi(struct ib_pd *pd, struct mlx5_ib_qp *mqp,
 		goto err_free_tx;
 	}
 
-	mutex_lock(&dev->devr.mutex);
-
 	if (dev->devr.ports[port_num - 1].gsi) {
 		mlx5_ib_warn(dev, "GSI QP already exists on port %d\n",
 			     port_num);
@@ -167,15 +165,11 @@ int mlx5_ib_create_gsi(struct ib_pd *pd, struct mlx5_ib_qp *mqp,
 	INIT_LIST_HEAD(&gsi->rx_qp->sig_mrs);
 
 	dev->devr.ports[attr->port_num - 1].gsi = gsi;
-
-	mutex_unlock(&dev->devr.mutex);
-
 	return 0;
 
 err_destroy_cq:
 	ib_free_cq(gsi->cq);
 err_free_wrs:
-	mutex_unlock(&dev->devr.mutex);
 	kfree(gsi->outstanding_wrs);
 err_free_tx:
 	kfree(gsi->tx_qps);
@@ -190,16 +184,13 @@ int mlx5_ib_destroy_gsi(struct mlx5_ib_qp *mqp)
 	int qp_index;
 	int ret;
 
-	mutex_lock(&dev->devr.mutex);
 	ret = mlx5_ib_destroy_qp(gsi->rx_qp, NULL);
 	if (ret) {
 		mlx5_ib_warn(dev, "unable to destroy hardware GSI QP. error %d\n",
 			     ret);
-		mutex_unlock(&dev->devr.mutex);
 		return ret;
 	}
 	dev->devr.ports[port_num - 1].gsi = NULL;
-	mutex_unlock(&dev->devr.mutex);
 	gsi->rx_qp = NULL;
 
 	for (qp_index = 0; qp_index < gsi->num_qps; ++qp_index) {
@@ -339,23 +330,13 @@ static void setup_qp(struct mlx5_ib_gsi_qp *gsi, u16 qp_index)
 	WARN_ON_ONCE(qp);
 }
 
-static void setup_qps(struct mlx5_ib_gsi_qp *gsi)
-{
-	struct mlx5_ib_dev *dev = to_mdev(gsi->rx_qp->device);
-	u16 qp_index;
-
-	mutex_lock(&dev->devr.mutex);
-	for (qp_index = 0; qp_index < gsi->num_qps; ++qp_index)
-		setup_qp(gsi, qp_index);
-	mutex_unlock(&dev->devr.mutex);
-}
-
 int mlx5_ib_gsi_modify_qp(struct ib_qp *qp, struct ib_qp_attr *attr,
 			  int attr_mask)
 {
 	struct mlx5_ib_dev *dev = to_mdev(qp->device);
 	struct mlx5_ib_qp *mqp = to_mqp(qp);
 	struct mlx5_ib_gsi_qp *gsi = &mqp->gsi;
+	u16 qp_index;
 	int ret;
 
 	mlx5_ib_dbg(dev, "modifying GSI QP to state %d\n", attr->qp_state);
@@ -366,8 +347,11 @@ int mlx5_ib_gsi_modify_qp(struct ib_qp *qp, struct ib_qp_attr *attr,
 		return ret;
 	}
 
-	if (to_mqp(gsi->rx_qp)->state == IB_QPS_RTS)
-		setup_qps(gsi);
+	if (to_mqp(gsi->rx_qp)->state != IB_QPS_RTS)
+		return 0;
+
+	for (qp_index = 0; qp_index < gsi->num_qps; ++qp_index)
+		setup_qp(gsi, qp_index);
 	return 0;
 }
 
@@ -511,8 +495,8 @@ int mlx5_ib_gsi_post_recv(struct ib_qp *qp, const struct ib_recv_wr *wr,
 
 void mlx5_ib_gsi_pkey_change(struct mlx5_ib_gsi_qp *gsi)
 {
-	if (!gsi)
-		return;
+	u16 qp_index;
 
-	setup_qps(gsi);
+	for (qp_index = 0; qp_index < gsi->num_qps; ++qp_index)
+		setup_qp(gsi, qp_index);
 }
diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index 75d5de14f80b..cac05bbe14c2 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -2501,6 +2501,13 @@ static void pkey_change_handler(struct work_struct *work)
 		container_of(work, struct mlx5_ib_port_resources,
 			     pkey_change_work);
 
+	if (!ports->gsi)
+		/*
+		 * We got this event before device was fully configured
+		 * and MAD registration code wasn't called/finished yet.
+		 */
+		return;
+
 	mlx5_ib_gsi_pkey_change(ports->gsi);
 }
 
@@ -2795,8 +2802,6 @@ static int mlx5_ib_dev_res_init(struct mlx5_ib_dev *dev)
 	if (!MLX5_CAP_GEN(dev->mdev, xrc))
 		return -EOPNOTSUPP;
 
-	mutex_init(&devr->mutex);
-
 	devr->p0 = rdma_zalloc_drv_obj(ibdev, ib_pd);
 	if (!devr->p0)
 		return -ENOMEM;
diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
index dbbcb53d2ca2..f2c8a6375b16 100644
--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -813,8 +813,6 @@ struct mlx5_ib_resources {
 	struct ib_srq	*s0;
 	struct ib_srq	*s1;
 	struct mlx5_ib_port_resources ports[2];
-	/* Protects changes to the port resources */
-	struct mutex	mutex;
 };
 
 struct mlx5_ib_counters {
-- 
2.31.1

