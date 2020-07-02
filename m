Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29729211DED
	for <lists+linux-rdma@lfdr.de>; Thu,  2 Jul 2020 10:18:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727017AbgGBISe (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 2 Jul 2020 04:18:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:46506 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726826AbgGBISe (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 2 Jul 2020 04:18:34 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5271520772;
        Thu,  2 Jul 2020 08:18:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593677912;
        bh=vpYjrrMl4NLr6in/8jo1btBBGArhqj+9M53cQxJuOS8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ChTyggQv4MA01WjxUQUTk5Xehuw0OMIc77bGy4z9w/k9X/RcjTmDnzq07qiZviv++
         ryB6VdNxDG0QqdSrvFxX7wPiUG6sy2Ar6lJF0xB+v8S+penEmxGVXYaInyYxi0ElbN
         7dfJfmjvJxBLH31LEJ9Oo2yN2A4rAlUNcc8QeO/s=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>, linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next 6/6] RDMA/mlx5: Delete one-time used functions
Date:   Thu,  2 Jul 2020 11:18:09 +0300
Message-Id: <20200702081809.423482-7-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200702081809.423482-1-leon@kernel.org>
References: <20200702081809.423482-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@mellanox.com>

Fast and furious cleanup of main.c from one-time and duplicated functions.

Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/hw/mlx5/main.c | 472 +++++++++++++-----------------
 1 file changed, 198 insertions(+), 274 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index 882755f7adf0..4ca74afaab99 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -3023,137 +3023,6 @@ static int get_port_caps(struct mlx5_ib_dev *dev, u8 port)
 	return __get_port_caps(dev, port);
 }
 
-static void destroy_umrc_res(struct mlx5_ib_dev *dev)
-{
-	int err;
-
-	err = mlx5_mr_cache_cleanup(dev);
-	if (err)
-		mlx5_ib_warn(dev, "mr cache cleanup failed\n");
-
-	if (dev->umrc.qp)
-		mlx5_ib_destroy_qp(dev->umrc.qp, NULL);
-	if (dev->umrc.cq)
-		ib_free_cq(dev->umrc.cq);
-	if (dev->umrc.pd)
-		ib_dealloc_pd(dev->umrc.pd);
-}
-
-enum {
-	MAX_UMR_WR = 128,
-};
-
-static int create_umr_res(struct mlx5_ib_dev *dev)
-{
-	struct ib_qp_init_attr *init_attr = NULL;
-	struct ib_qp_attr *attr = NULL;
-	struct ib_pd *pd;
-	struct ib_cq *cq;
-	struct ib_qp *qp;
-	int ret;
-
-	attr = kzalloc(sizeof(*attr), GFP_KERNEL);
-	init_attr = kzalloc(sizeof(*init_attr), GFP_KERNEL);
-	if (!attr || !init_attr) {
-		ret = -ENOMEM;
-		goto error_0;
-	}
-
-	pd = ib_alloc_pd(&dev->ib_dev, 0);
-	if (IS_ERR(pd)) {
-		mlx5_ib_dbg(dev, "Couldn't create PD for sync UMR QP\n");
-		ret = PTR_ERR(pd);
-		goto error_0;
-	}
-
-	cq = ib_alloc_cq(&dev->ib_dev, NULL, 128, 0, IB_POLL_SOFTIRQ);
-	if (IS_ERR(cq)) {
-		mlx5_ib_dbg(dev, "Couldn't create CQ for sync UMR QP\n");
-		ret = PTR_ERR(cq);
-		goto error_2;
-	}
-
-	init_attr->send_cq = cq;
-	init_attr->recv_cq = cq;
-	init_attr->sq_sig_type = IB_SIGNAL_ALL_WR;
-	init_attr->cap.max_send_wr = MAX_UMR_WR;
-	init_attr->cap.max_send_sge = 1;
-	init_attr->qp_type = MLX5_IB_QPT_REG_UMR;
-	init_attr->port_num = 1;
-	qp = mlx5_ib_create_qp(pd, init_attr, NULL);
-	if (IS_ERR(qp)) {
-		mlx5_ib_dbg(dev, "Couldn't create sync UMR QP\n");
-		ret = PTR_ERR(qp);
-		goto error_3;
-	}
-	qp->device     = &dev->ib_dev;
-	qp->real_qp    = qp;
-	qp->uobject    = NULL;
-	qp->qp_type    = MLX5_IB_QPT_REG_UMR;
-	qp->send_cq    = init_attr->send_cq;
-	qp->recv_cq    = init_attr->recv_cq;
-
-	attr->qp_state = IB_QPS_INIT;
-	attr->port_num = 1;
-	ret = mlx5_ib_modify_qp(qp, attr, IB_QP_STATE | IB_QP_PKEY_INDEX |
-				IB_QP_PORT, NULL);
-	if (ret) {
-		mlx5_ib_dbg(dev, "Couldn't modify UMR QP\n");
-		goto error_4;
-	}
-
-	memset(attr, 0, sizeof(*attr));
-	attr->qp_state = IB_QPS_RTR;
-	attr->path_mtu = IB_MTU_256;
-
-	ret = mlx5_ib_modify_qp(qp, attr, IB_QP_STATE, NULL);
-	if (ret) {
-		mlx5_ib_dbg(dev, "Couldn't modify umr QP to rtr\n");
-		goto error_4;
-	}
-
-	memset(attr, 0, sizeof(*attr));
-	attr->qp_state = IB_QPS_RTS;
-	ret = mlx5_ib_modify_qp(qp, attr, IB_QP_STATE, NULL);
-	if (ret) {
-		mlx5_ib_dbg(dev, "Couldn't modify umr QP to rts\n");
-		goto error_4;
-	}
-
-	dev->umrc.qp = qp;
-	dev->umrc.cq = cq;
-	dev->umrc.pd = pd;
-
-	sema_init(&dev->umrc.sem, MAX_UMR_WR);
-	ret = mlx5_mr_cache_init(dev);
-	if (ret) {
-		mlx5_ib_warn(dev, "mr cache init failed %d\n", ret);
-		goto error_4;
-	}
-
-	kfree(attr);
-	kfree(init_attr);
-
-	return 0;
-
-error_4:
-	mlx5_ib_destroy_qp(qp, NULL);
-	dev->umrc.qp = NULL;
-
-error_3:
-	ib_free_cq(cq);
-	dev->umrc.cq = NULL;
-
-error_2:
-	ib_dealloc_pd(pd);
-	dev->umrc.pd = NULL;
-
-error_0:
-	kfree(attr);
-	kfree(init_attr);
-	return ret;
-}
-
 static u8 mlx5_get_umr_fence(u8 umr_fence_cap)
 {
 	switch (umr_fence_cap) {
@@ -3166,16 +3035,15 @@ static u8 mlx5_get_umr_fence(u8 umr_fence_cap)
 	}
 }
 
-static int create_dev_resources(struct mlx5_ib_resources *devr)
+static int mlx5_ib_dev_res_init(struct mlx5_ib_dev *dev)
 {
+	struct mlx5_ib_resources *devr = &dev->devr;
 	struct ib_srq_init_attr attr;
-	struct mlx5_ib_dev *dev;
 	struct ib_device *ibdev;
 	struct ib_cq_init_attr cq_attr = {.cqe = 1};
 	int port;
 	int ret = 0;
 
-	dev = container_of(devr, struct mlx5_ib_dev, devr);
 	ibdev = &dev->ib_dev;
 
 	mutex_init(&devr->mutex);
@@ -3296,8 +3164,9 @@ static int create_dev_resources(struct mlx5_ib_resources *devr)
 	return ret;
 }
 
-static void destroy_dev_resources(struct mlx5_ib_resources *devr)
+static void mlx5_ib_dev_res_cleanup(struct mlx5_ib_dev *dev)
 {
+	struct mlx5_ib_resources *devr = &dev->devr;
 	int port;
 
 	mlx5_ib_destroy_srq(devr->s1, NULL);
@@ -3509,23 +3378,6 @@ static int mlx5_ib_rn_get_params(struct ib_device *device, u8 port_num,
 	return mlx5_rdma_rn_get_params(to_mdev(device)->mdev, device, params);
 }
 
-static void delay_drop_debugfs_cleanup(struct mlx5_ib_dev *dev)
-{
-	if (!dev->delay_drop.dir_debugfs)
-		return;
-	debugfs_remove_recursive(dev->delay_drop.dir_debugfs);
-	dev->delay_drop.dir_debugfs = NULL;
-}
-
-static void cancel_delay_drop(struct mlx5_ib_dev *dev)
-{
-	if (!(dev->ib_dev.attrs.raw_packet_caps & IB_RAW_PACKET_CAP_DELAY_DROP))
-		return;
-
-	cancel_work_sync(&dev->delay_drop.delay_drop_work);
-	delay_drop_debugfs_cleanup(dev);
-}
-
 static ssize_t delay_drop_timeout_read(struct file *filp, char __user *buf,
 				       size_t count, loff_t *pos)
 {
@@ -3565,40 +3417,6 @@ static const struct file_operations fops_delay_drop_timeout = {
 	.read	= delay_drop_timeout_read,
 };
 
-static void delay_drop_debugfs_init(struct mlx5_ib_dev *dev)
-{
-	struct dentry *root;
-
-	if (!mlx5_debugfs_root)
-		return;
-
-	root = debugfs_create_dir("delay_drop", dev->mdev->priv.dbg_root);
-	dev->delay_drop.dir_debugfs = root;
-
-	debugfs_create_atomic_t("num_timeout_events", 0400, root,
-				&dev->delay_drop.events_cnt);
-	debugfs_create_atomic_t("num_rqs", 0400, root,
-				&dev->delay_drop.rqs_cnt);
-	debugfs_create_file("timeout", 0600, root, &dev->delay_drop,
-			    &fops_delay_drop_timeout);
-}
-
-static void init_delay_drop(struct mlx5_ib_dev *dev)
-{
-	if (!(dev->ib_dev.attrs.raw_packet_caps & IB_RAW_PACKET_CAP_DELAY_DROP))
-		return;
-
-	mutex_init(&dev->delay_drop.lock);
-	dev->delay_drop.dev = dev;
-	dev->delay_drop.activate = false;
-	dev->delay_drop.timeout = MLX5_MAX_DELAY_DROP_TIMEOUT_MS * 1000;
-	INIT_WORK(&dev->delay_drop.delay_drop_work, delay_drop_handler);
-	atomic_set(&dev->delay_drop.rqs_cnt, 0);
-	atomic_set(&dev->delay_drop.events_cnt, 0);
-
-	delay_drop_debugfs_init(dev);
-}
-
 static void mlx5_ib_unbind_slave_port(struct mlx5_ib_dev *ibdev,
 				      struct mlx5_ib_multiport_info *mpi)
 {
@@ -4463,65 +4281,36 @@ static const struct ib_device_ops mlx5_ib_dev_common_roce_ops = {
 	.modify_wq = mlx5_ib_modify_wq,
 };
 
-static int mlx5_ib_stage_common_roce_init(struct mlx5_ib_dev *dev)
-{
-	u8 port_num;
-
-	dev->ib_dev.uverbs_ex_cmd_mask |=
-			(1ull << IB_USER_VERBS_EX_CMD_CREATE_WQ) |
-			(1ull << IB_USER_VERBS_EX_CMD_MODIFY_WQ) |
-			(1ull << IB_USER_VERBS_EX_CMD_DESTROY_WQ) |
-			(1ull << IB_USER_VERBS_EX_CMD_CREATE_RWQ_IND_TBL) |
-			(1ull << IB_USER_VERBS_EX_CMD_DESTROY_RWQ_IND_TBL);
-	ib_set_device_ops(&dev->ib_dev, &mlx5_ib_dev_common_roce_ops);
-
-	port_num = mlx5_core_native_port_num(dev->mdev) - 1;
-
-	/* Register only for native ports */
-	return mlx5_add_netdev_notifier(dev, port_num);
-}
-
-static void mlx5_ib_stage_common_roce_cleanup(struct mlx5_ib_dev *dev)
-{
-	u8 port_num = mlx5_core_native_port_num(dev->mdev) - 1;
-
-	mlx5_remove_netdev_notifier(dev, port_num);
-}
-
-static int mlx5_ib_stage_raw_eth_roce_init(struct mlx5_ib_dev *dev)
-{
-	struct mlx5_core_dev *mdev = dev->mdev;
-	enum rdma_link_layer ll;
-	int port_type_cap;
-	int err = 0;
-
-	port_type_cap = MLX5_CAP_GEN(mdev, port_type);
-	ll = mlx5_port_type_cap_to_rdma_ll(port_type_cap);
-
-	if (ll == IB_LINK_LAYER_ETHERNET)
-		err = mlx5_ib_stage_common_roce_init(dev);
-
-	return err;
-}
-
-static void mlx5_ib_stage_raw_eth_roce_cleanup(struct mlx5_ib_dev *dev)
-{
-	mlx5_ib_stage_common_roce_cleanup(dev);
-}
-
-static int mlx5_ib_stage_roce_init(struct mlx5_ib_dev *dev)
+static int mlx5_ib_roce_init(struct mlx5_ib_dev *dev)
 {
 	struct mlx5_core_dev *mdev = dev->mdev;
 	enum rdma_link_layer ll;
 	int port_type_cap;
+	u8 port_num = 0;
 	int err;
 
 	port_type_cap = MLX5_CAP_GEN(mdev, port_type);
 	ll = mlx5_port_type_cap_to_rdma_ll(port_type_cap);
 
 	if (ll == IB_LINK_LAYER_ETHERNET) {
-		err = mlx5_ib_stage_common_roce_init(dev);
-		if (err)
+		dev->ib_dev.uverbs_ex_cmd_mask |=
+			(1ull << IB_USER_VERBS_EX_CMD_CREATE_WQ) |
+			(1ull << IB_USER_VERBS_EX_CMD_MODIFY_WQ) |
+			(1ull << IB_USER_VERBS_EX_CMD_DESTROY_WQ) |
+			(1ull << IB_USER_VERBS_EX_CMD_CREATE_RWQ_IND_TBL) |
+			(1ull << IB_USER_VERBS_EX_CMD_DESTROY_RWQ_IND_TBL);
+		ib_set_device_ops(&dev->ib_dev, &mlx5_ib_dev_common_roce_ops);
+
+		port_num = mlx5_core_native_port_num(dev->mdev) - 1;
+
+		/* Register only for native ports */
+		err = mlx5_add_netdev_notifier(dev, port_num);
+		if (err || dev->is_rep || !mlx5_is_roce_enabled(mdev))
+			/*
+			 * We don't enable ETH interface for
+			 * 1. IB representors
+			 * 2. User disabled ROCE through devlink interface
+			 */
 			return err;
 
 		err = mlx5_enable_eth(dev);
@@ -4531,44 +4320,27 @@ static int mlx5_ib_stage_roce_init(struct mlx5_ib_dev *dev)
 
 	return 0;
 cleanup:
-	mlx5_ib_stage_common_roce_cleanup(dev);
-
+	mlx5_remove_netdev_notifier(dev, port_num);
 	return err;
 }
 
-static void mlx5_ib_stage_roce_cleanup(struct mlx5_ib_dev *dev)
+static void mlx5_ib_roce_cleanup(struct mlx5_ib_dev *dev)
 {
 	struct mlx5_core_dev *mdev = dev->mdev;
 	enum rdma_link_layer ll;
 	int port_type_cap;
+	u8 port_num;
 
 	port_type_cap = MLX5_CAP_GEN(mdev, port_type);
 	ll = mlx5_port_type_cap_to_rdma_ll(port_type_cap);
 
 	if (ll == IB_LINK_LAYER_ETHERNET) {
-		mlx5_disable_eth(dev);
-		mlx5_ib_stage_common_roce_cleanup(dev);
-	}
-}
-
-static int mlx5_ib_stage_dev_res_init(struct mlx5_ib_dev *dev)
-{
-	return create_dev_resources(&dev->devr);
-}
-
-static void mlx5_ib_stage_dev_res_cleanup(struct mlx5_ib_dev *dev)
-{
-	destroy_dev_resources(&dev->devr);
-}
-
-static int mlx5_ib_stage_odp_init(struct mlx5_ib_dev *dev)
-{
-	return mlx5_ib_odp_init_one(dev);
-}
+		if (!dev->is_rep)
+			mlx5_disable_eth(dev);
 
-static void mlx5_ib_stage_odp_cleanup(struct mlx5_ib_dev *dev)
-{
-	mlx5_ib_odp_cleanup_one(dev);
+		port_num = mlx5_core_native_port_num(dev->mdev) - 1;
+		mlx5_remove_netdev_notifier(dev, port_num);
+	}
 }
 
 static int mlx5_ib_stage_cong_debugfs_init(struct mlx5_ib_dev *dev)
@@ -4630,7 +4402,18 @@ static int mlx5_ib_stage_ib_reg_init(struct mlx5_ib_dev *dev)
 
 static void mlx5_ib_stage_pre_ib_reg_umr_cleanup(struct mlx5_ib_dev *dev)
 {
-	destroy_umrc_res(dev);
+	int err;
+
+	err = mlx5_mr_cache_cleanup(dev);
+	if (err)
+		mlx5_ib_warn(dev, "mr cache cleanup failed\n");
+
+	if (dev->umrc.qp)
+		mlx5_ib_destroy_qp(dev->umrc.qp, NULL);
+	if (dev->umrc.cq)
+		ib_free_cq(dev->umrc.cq);
+	if (dev->umrc.pd)
+		ib_dealloc_pd(dev->umrc.pd);
 }
 
 static void mlx5_ib_stage_ib_reg_cleanup(struct mlx5_ib_dev *dev)
@@ -4638,21 +4421,162 @@ static void mlx5_ib_stage_ib_reg_cleanup(struct mlx5_ib_dev *dev)
 	ib_unregister_device(&dev->ib_dev);
 }
 
+enum {
+	MAX_UMR_WR = 128,
+};
+
 static int mlx5_ib_stage_post_ib_reg_umr_init(struct mlx5_ib_dev *dev)
 {
-	return create_umr_res(dev);
+	struct ib_qp_init_attr *init_attr = NULL;
+	struct ib_qp_attr *attr = NULL;
+	struct ib_pd *pd;
+	struct ib_cq *cq;
+	struct ib_qp *qp;
+	int ret;
+
+	attr = kzalloc(sizeof(*attr), GFP_KERNEL);
+	init_attr = kzalloc(sizeof(*init_attr), GFP_KERNEL);
+	if (!attr || !init_attr) {
+		ret = -ENOMEM;
+		goto error_0;
+	}
+
+	pd = ib_alloc_pd(&dev->ib_dev, 0);
+	if (IS_ERR(pd)) {
+		mlx5_ib_dbg(dev, "Couldn't create PD for sync UMR QP\n");
+		ret = PTR_ERR(pd);
+		goto error_0;
+	}
+
+	cq = ib_alloc_cq(&dev->ib_dev, NULL, 128, 0, IB_POLL_SOFTIRQ);
+	if (IS_ERR(cq)) {
+		mlx5_ib_dbg(dev, "Couldn't create CQ for sync UMR QP\n");
+		ret = PTR_ERR(cq);
+		goto error_2;
+	}
+
+	init_attr->send_cq = cq;
+	init_attr->recv_cq = cq;
+	init_attr->sq_sig_type = IB_SIGNAL_ALL_WR;
+	init_attr->cap.max_send_wr = MAX_UMR_WR;
+	init_attr->cap.max_send_sge = 1;
+	init_attr->qp_type = MLX5_IB_QPT_REG_UMR;
+	init_attr->port_num = 1;
+	qp = mlx5_ib_create_qp(pd, init_attr, NULL);
+	if (IS_ERR(qp)) {
+		mlx5_ib_dbg(dev, "Couldn't create sync UMR QP\n");
+		ret = PTR_ERR(qp);
+		goto error_3;
+	}
+	qp->device     = &dev->ib_dev;
+	qp->real_qp    = qp;
+	qp->uobject    = NULL;
+	qp->qp_type    = MLX5_IB_QPT_REG_UMR;
+	qp->send_cq    = init_attr->send_cq;
+	qp->recv_cq    = init_attr->recv_cq;
+
+	attr->qp_state = IB_QPS_INIT;
+	attr->port_num = 1;
+	ret = mlx5_ib_modify_qp(qp, attr, IB_QP_STATE | IB_QP_PKEY_INDEX |
+				IB_QP_PORT, NULL);
+	if (ret) {
+		mlx5_ib_dbg(dev, "Couldn't modify UMR QP\n");
+		goto error_4;
+	}
+
+	memset(attr, 0, sizeof(*attr));
+	attr->qp_state = IB_QPS_RTR;
+	attr->path_mtu = IB_MTU_256;
+
+	ret = mlx5_ib_modify_qp(qp, attr, IB_QP_STATE, NULL);
+	if (ret) {
+		mlx5_ib_dbg(dev, "Couldn't modify umr QP to rtr\n");
+		goto error_4;
+	}
+
+	memset(attr, 0, sizeof(*attr));
+	attr->qp_state = IB_QPS_RTS;
+	ret = mlx5_ib_modify_qp(qp, attr, IB_QP_STATE, NULL);
+	if (ret) {
+		mlx5_ib_dbg(dev, "Couldn't modify umr QP to rts\n");
+		goto error_4;
+	}
+
+	dev->umrc.qp = qp;
+	dev->umrc.cq = cq;
+	dev->umrc.pd = pd;
+
+	sema_init(&dev->umrc.sem, MAX_UMR_WR);
+	ret = mlx5_mr_cache_init(dev);
+	if (ret) {
+		mlx5_ib_warn(dev, "mr cache init failed %d\n", ret);
+		goto error_4;
+	}
+
+	kfree(attr);
+	kfree(init_attr);
+
+	return 0;
+
+error_4:
+	mlx5_ib_destroy_qp(qp, NULL);
+	dev->umrc.qp = NULL;
+
+error_3:
+	ib_free_cq(cq);
+	dev->umrc.cq = NULL;
+
+error_2:
+	ib_dealloc_pd(pd);
+	dev->umrc.pd = NULL;
+
+error_0:
+	kfree(attr);
+	kfree(init_attr);
+	return ret;
 }
 
 static int mlx5_ib_stage_delay_drop_init(struct mlx5_ib_dev *dev)
 {
-	init_delay_drop(dev);
+	struct dentry *root;
+
+	if (!(dev->ib_dev.attrs.raw_packet_caps & IB_RAW_PACKET_CAP_DELAY_DROP))
+		return 0;
+
+	mutex_init(&dev->delay_drop.lock);
+	dev->delay_drop.dev = dev;
+	dev->delay_drop.activate = false;
+	dev->delay_drop.timeout = MLX5_MAX_DELAY_DROP_TIMEOUT_MS * 1000;
+	INIT_WORK(&dev->delay_drop.delay_drop_work, delay_drop_handler);
+	atomic_set(&dev->delay_drop.rqs_cnt, 0);
+	atomic_set(&dev->delay_drop.events_cnt, 0);
+
+	if (!mlx5_debugfs_root)
+		return 0;
 
+	root = debugfs_create_dir("delay_drop", dev->mdev->priv.dbg_root);
+	dev->delay_drop.dir_debugfs = root;
+
+	debugfs_create_atomic_t("num_timeout_events", 0400, root,
+				&dev->delay_drop.events_cnt);
+	debugfs_create_atomic_t("num_rqs", 0400, root,
+				&dev->delay_drop.rqs_cnt);
+	debugfs_create_file("timeout", 0600, root, &dev->delay_drop,
+			    &fops_delay_drop_timeout);
 	return 0;
 }
 
 static void mlx5_ib_stage_delay_drop_cleanup(struct mlx5_ib_dev *dev)
 {
-	cancel_delay_drop(dev);
+	if (!(dev->ib_dev.attrs.raw_packet_caps & IB_RAW_PACKET_CAP_DELAY_DROP))
+		return;
+
+	cancel_work_sync(&dev->delay_drop.delay_drop_work);
+	if (!dev->delay_drop.dir_debugfs)
+		return;
+
+	debugfs_remove_recursive(dev->delay_drop.dir_debugfs);
+	dev->delay_drop.dir_debugfs = NULL;
 }
 
 static int mlx5_ib_stage_dev_notifier_init(struct mlx5_ib_dev *dev)
@@ -4724,8 +4648,8 @@ static const struct mlx5_ib_profile pf_profile = {
 		     mlx5_ib_stage_non_default_cb,
 		     NULL),
 	STAGE_CREATE(MLX5_IB_STAGE_ROCE,
-		     mlx5_ib_stage_roce_init,
-		     mlx5_ib_stage_roce_cleanup),
+		     mlx5_ib_roce_init,
+		     mlx5_ib_roce_cleanup),
 	STAGE_CREATE(MLX5_IB_STAGE_QP,
 		     mlx5_init_qp_table,
 		     mlx5_cleanup_qp_table),
@@ -4733,14 +4657,14 @@ static const struct mlx5_ib_profile pf_profile = {
 		     mlx5_init_srq_table,
 		     mlx5_cleanup_srq_table),
 	STAGE_CREATE(MLX5_IB_STAGE_DEVICE_RESOURCES,
-		     mlx5_ib_stage_dev_res_init,
-		     mlx5_ib_stage_dev_res_cleanup),
+		     mlx5_ib_dev_res_init,
+		     mlx5_ib_dev_res_cleanup),
 	STAGE_CREATE(MLX5_IB_STAGE_DEVICE_NOTIFIER,
 		     mlx5_ib_stage_dev_notifier_init,
 		     mlx5_ib_stage_dev_notifier_cleanup),
 	STAGE_CREATE(MLX5_IB_STAGE_ODP,
-		     mlx5_ib_stage_odp_init,
-		     mlx5_ib_stage_odp_cleanup),
+		     mlx5_ib_odp_init_one,
+		     mlx5_ib_odp_cleanup_one),
 	STAGE_CREATE(MLX5_IB_STAGE_COUNTERS,
 		     mlx5_ib_counters_init,
 		     mlx5_ib_counters_cleanup),
@@ -4787,8 +4711,8 @@ const struct mlx5_ib_profile raw_eth_profile = {
 		     mlx5_ib_stage_raw_eth_non_default_cb,
 		     NULL),
 	STAGE_CREATE(MLX5_IB_STAGE_ROCE,
-		     mlx5_ib_stage_raw_eth_roce_init,
-		     mlx5_ib_stage_raw_eth_roce_cleanup),
+		     mlx5_ib_roce_init,
+		     mlx5_ib_roce_cleanup),
 	STAGE_CREATE(MLX5_IB_STAGE_QP,
 		     mlx5_init_qp_table,
 		     mlx5_cleanup_qp_table),
@@ -4796,8 +4720,8 @@ const struct mlx5_ib_profile raw_eth_profile = {
 		     mlx5_init_srq_table,
 		     mlx5_cleanup_srq_table),
 	STAGE_CREATE(MLX5_IB_STAGE_DEVICE_RESOURCES,
-		     mlx5_ib_stage_dev_res_init,
-		     mlx5_ib_stage_dev_res_cleanup),
+		     mlx5_ib_dev_res_init,
+		     mlx5_ib_dev_res_cleanup),
 	STAGE_CREATE(MLX5_IB_STAGE_DEVICE_NOTIFIER,
 		     mlx5_ib_stage_dev_notifier_init,
 		     mlx5_ib_stage_dev_notifier_cleanup),
-- 
2.26.2

