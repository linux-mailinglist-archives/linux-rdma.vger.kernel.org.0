Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A29D3DDD15
	for <lists+linux-rdma@lfdr.de>; Sun, 20 Oct 2019 08:44:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726179AbfJTGoP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 20 Oct 2019 02:44:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:56932 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725941AbfJTGoO (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 20 Oct 2019 02:44:14 -0400
Received: from localhost (unknown [77.137.89.37])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9DA69222C2;
        Sun, 20 Oct 2019 06:44:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571553853;
        bh=ilb8X+QIJgWyKHYOlERTx+wV6eOEU/pQUuwuclZyAqw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GxzywgXmSpNKADUhf/K/ziS5pvP4V6f2WGpjk3akcaf/dWsoPBMD+wfhhmloXVUHt
         WZcvO8yLY7zAgFihNhGwNG7wzNCXNavq+Ut8DDqmelFgihL7l3ppY8HN0qv/RbGJQC
         IqK3J0PWSzuibi667sq11j854rfXBrGVIB/072vI=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Michael Guralnik <michaelgur@mellanox.com>
Subject: [PATCH rdma-next 2/2] IB/mlx5: Test write combining support
Date:   Sun, 20 Oct 2019 09:44:00 +0300
Message-Id: <20191020064400.8344-3-leon@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191020064400.8344-1-leon@kernel.org>
References: <20191020064400.8344-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Michael Guralnik <michaelgur@mellanox.com>

Add a test in mlx5_ib initialization process to test whether
write-combining is supported on the machine.
The test will run as part of the enable_driver callback to ensure that
the test runs after the device is setup and can create and modify the
QP needed, but runs before the device is exposed to the users.

The test opens UD QP and posts NOP WQEs, the WQE written to the BlueFlame
is different from the WQE in memory, requesting CQE only on the BlueFlame
WQE. By checking whether we received a completion on one of these WQEs we
can know if BlueFlame succeeded and whether write-combining is supported.

Change reporting of BlueFlame support to be dependent on write-combining
support.

Signed-off-by: Michael Guralnik <michaelgur@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/hw/mlx5/main.c    |  15 +-
 drivers/infiniband/hw/mlx5/mem.c     | 200 +++++++++++++++++++++++++++
 drivers/infiniband/hw/mlx5/mlx5_ib.h |   6 +
 drivers/infiniband/hw/mlx5/qp.c      |   6 +-
 4 files changed, 224 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index 39d54e285ae9..27255f68b2fb 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -1811,7 +1811,7 @@ static int mlx5_ib_alloc_ucontext(struct ib_ucontext *uctx,
 		return -EINVAL;

 	resp.qp_tab_size = 1 << MLX5_CAP_GEN(dev->mdev, log_max_qp);
-	if (mlx5_core_is_pf(dev->mdev) && MLX5_CAP_GEN(dev->mdev, bf))
+	if (dev->wc_support)
 		resp.bf_reg_size = 1 << MLX5_CAP_GEN(dev->mdev, log_bf_reg_size);
 	resp.cache_line_size = cache_line_size();
 	resp.max_sq_desc_sz = MLX5_CAP_GEN(dev->mdev, max_wqe_sz_sq);
@@ -6272,6 +6272,7 @@ static const struct ib_device_ops mlx5_ib_dev_ops = {
 	.disassociate_ucontext = mlx5_ib_disassociate_ucontext,
 	.drain_rq = mlx5_ib_drain_rq,
 	.drain_sq = mlx5_ib_drain_sq,
+	.enable_driver = mlx5_ib_enable_driver,
 	.fill_res_entry = mlx5_ib_fill_res_entry,
 	.fill_stat_entry = mlx5_ib_fill_stat_entry,
 	.get_dev_fw_str = get_dev_fw_str,
@@ -6715,6 +6716,18 @@ static void mlx5_ib_stage_devx_cleanup(struct mlx5_ib_dev *dev)
 	}
 }

+int mlx5_ib_enable_driver(struct ib_device *dev)
+{
+	struct mlx5_ib_dev *mdev = to_mdev(dev);
+	int ret;
+
+	ret = mlx5_ib_test_wc(mdev);
+	mlx5_ib_dbg(mdev, "Write-Combining %s",
+		    mdev->wc_support ? "supported" : "not supported");
+
+	return ret;
+}
+
 void __mlx5_ib_remove(struct mlx5_ib_dev *dev,
 		      const struct mlx5_ib_profile *profile,
 		      int stage)
diff --git a/drivers/infiniband/hw/mlx5/mem.c b/drivers/infiniband/hw/mlx5/mem.c
index b5aece786b36..8a436fdc5d3a 100644
--- a/drivers/infiniband/hw/mlx5/mem.c
+++ b/drivers/infiniband/hw/mlx5/mem.c
@@ -34,6 +34,7 @@
 #include <rdma/ib_umem.h>
 #include <rdma/ib_umem_odp.h>
 #include "mlx5_ib.h"
+#include <linux/jiffies.h>

 /* @umem: umem object to scan
  * @addr: ib virtual address requested by the user
@@ -216,3 +217,202 @@ int mlx5_ib_get_buf_offset(u64 addr, int page_shift, u32 *offset)
 	*offset = buf_off >> ilog2(off_size);
 	return 0;
 }
+
+#define WR_ID_BF 0xBF
+#define WR_ID_END 0xBAD
+#define TEST_WC_NUM_WQES 255
+#define TEST_WC_POLLING_MAX_TIME_JIFFIES msecs_to_jiffies(100)
+static int post_send_nop(struct mlx5_ib_dev *dev, struct ib_qp *ibqp, u64 wr_id,
+			 bool signaled)
+{
+	struct mlx5_ib_qp *qp = to_mqp(ibqp);
+	struct mlx5_wqe_ctrl_seg *ctrl;
+	struct mlx5_bf *bf = &qp->bf;
+	__be32 mmio_wqe[16] = {};
+	unsigned int idx;
+	int i;
+
+	if (unlikely(dev->mdev->state == MLX5_DEVICE_STATE_INTERNAL_ERROR))
+		return -EIO;
+
+	/* This could be done without taking the lock as the test is running in
+	 * init process. Using spin lock anyway to maintain code completness.
+	 */
+	spin_lock(&qp->sq.lock);
+
+	idx = qp->sq.cur_post & (qp->sq.wqe_cnt - 1);
+	ctrl = mlx5_frag_buf_get_wqe(&qp->sq.fbc, idx);
+
+	memset(ctrl, 0, sizeof(struct mlx5_wqe_ctrl_seg));
+	ctrl->fm_ce_se = signaled ? MLX5_WQE_CTRL_CQ_UPDATE : 0;
+	ctrl->opmod_idx_opcode =
+		cpu_to_be32(((u32)(qp->sq.cur_post) << 8) | MLX5_OPCODE_NOP);
+	ctrl->qpn_ds = cpu_to_be32((sizeof(struct mlx5_wqe_ctrl_seg) / 16) |
+				   (qp->trans_qp.base.mqp.qpn << 8));
+
+	qp->sq.wrid[idx] = wr_id;
+	qp->sq.w_list[idx].opcode = MLX5_OPCODE_NOP;
+	qp->sq.wqe_head[idx] = qp->sq.head + 1;
+	qp->sq.cur_post += MLX5_SEND_WQE_BB;
+	qp->sq.w_list[idx].next = qp->sq.cur_post;
+	qp->sq.head++;
+
+	memcpy(mmio_wqe, ctrl, sizeof(*ctrl));
+	((struct mlx5_wqe_ctrl_seg *)&mmio_wqe)->fm_ce_se |=
+		MLX5_WQE_CTRL_CQ_UPDATE;
+
+	/* Make sure that descriptors are written before
+	 * updating doorbell record and ringing the doorbell
+	 */
+	wmb();
+
+	qp->db.db[MLX5_SND_DBR] = cpu_to_be32(qp->sq.cur_post);
+
+	/* Make sure doorbell record is visible to the HCA before
+	 * we hit doorbell
+	 */
+	wmb();
+	for (i = 0; i < 8; i++)
+		mlx5_write64(&mmio_wqe[i * 2],
+			     bf->bfreg->map + bf->offset + i * 8);
+
+	bf->offset ^= bf->buf_size;
+
+	spin_unlock(&qp->sq.lock);
+
+	return 0;
+}
+
+static int test_wc_poll_cq_result(struct mlx5_ib_dev *dev, struct ib_cq *cq)
+{
+	int ret;
+	struct ib_wc wc = {};
+	unsigned long end = jiffies + TEST_WC_POLLING_MAX_TIME_JIFFIES;
+
+	do {
+		ret = ib_poll_cq(cq, 1, &wc);
+		if (ret < 0 || wc.status)
+			return ret < 0 ? ret : -EINVAL;
+		if (ret)
+			break;
+	} while (!time_after(jiffies, end));
+
+	if (!ret)
+		return -ETIMEDOUT;
+
+	if (wc.wr_id != WR_ID_BF)
+		ret = 0;
+
+	return ret;
+}
+
+static int test_wc_do_send(struct mlx5_ib_dev *dev, struct ib_qp *qp)
+{
+	int err, i;
+
+	for (i = 0; i < TEST_WC_NUM_WQES; i++) {
+		err = post_send_nop(dev, qp, WR_ID_BF, false);
+		if (err)
+			return err;
+	}
+
+	return post_send_nop(dev, qp, WR_ID_END, true);
+}
+
+int mlx5_ib_test_wc(struct mlx5_ib_dev *dev)
+{
+	struct ib_cq_init_attr cq_attr = { .cqe = TEST_WC_NUM_WQES + 1 };
+	int port_type_cap = MLX5_CAP_GEN(dev->mdev, port_type);
+	struct ib_qp_init_attr qp_init_attr = {
+		.cap = { .max_send_wr = TEST_WC_NUM_WQES },
+		.qp_type = IB_QPT_UD,
+		.sq_sig_type = IB_SIGNAL_REQ_WR,
+		.create_flags = MLX5_IB_QP_CREATE_WC_TEST,
+	};
+	struct ib_qp_attr qp_attr = { .port_num = 1 };
+	struct ib_device *ibdev = &dev->ib_dev;
+	struct ib_qp *qp;
+	struct ib_cq *cq;
+	struct ib_pd *pd;
+	int ret;
+
+	if (!MLX5_CAP_GEN(dev->mdev, bf))
+		return 0;
+
+	if (!dev->mdev->roce.roce_en &&
+	    port_type_cap == MLX5_CAP_PORT_TYPE_ETH) {
+		if (mlx5_core_is_pf(dev->mdev))
+			dev->wc_support = true;
+		return 0;
+	}
+
+	ret = mlx5_alloc_bfreg(dev->mdev, &dev->wc_bfreg, true, false);
+	if (ret)
+		goto print_err;
+
+	if (!dev->wc_bfreg.wc)
+		goto out1;
+
+	pd = ib_alloc_pd(ibdev, 0);
+	if (IS_ERR(pd)) {
+		ret = PTR_ERR(pd);
+		goto out1;
+	}
+
+	cq = ib_create_cq(ibdev, NULL, NULL, NULL, &cq_attr);
+	if (IS_ERR(cq)) {
+		ret = PTR_ERR(cq);
+		goto out2;
+	}
+
+	qp_init_attr.recv_cq = cq;
+	qp_init_attr.send_cq = cq;
+	qp = ib_create_qp(pd, &qp_init_attr);
+	if (IS_ERR(qp)) {
+		ret = PTR_ERR(qp);
+		goto out3;
+	}
+
+	qp_attr.qp_state = IB_QPS_INIT;
+	ret = ib_modify_qp(qp, &qp_attr,
+			   IB_QP_STATE | IB_QP_PORT | IB_QP_PKEY_INDEX |
+				   IB_QP_QKEY);
+	if (ret)
+		goto out4;
+
+	qp_attr.qp_state = IB_QPS_RTR;
+	ret = ib_modify_qp(qp, &qp_attr, IB_QP_STATE);
+	if (ret)
+		goto out4;
+
+	qp_attr.qp_state = IB_QPS_RTS;
+	ret = ib_modify_qp(qp, &qp_attr, IB_QP_STATE | IB_QP_SQ_PSN);
+	if (ret)
+		goto out4;
+
+	ret = test_wc_do_send(dev, qp);
+	if (ret < 0)
+		goto out4;
+
+	ret = test_wc_poll_cq_result(dev, cq);
+	if (ret > 0) {
+		dev->wc_support = true;
+		ret = 0;
+	}
+
+out4:
+	ib_destroy_qp(qp);
+out3:
+	ib_destroy_cq(cq);
+out2:
+	ib_dealloc_pd(pd);
+out1:
+	mlx5_free_bfreg(dev->mdev, &dev->wc_bfreg);
+print_err:
+	if (ret)
+		mlx5_ib_err(
+			dev,
+			"Error %d while trying to test write-combining support\n",
+			ret);
+	return ret;
+}
diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
index 27980295aee8..d5c80aa9efb1 100644
--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -248,6 +248,7 @@ struct mlx5_ib_flow_db {
  * rely on the range reserved for that use in the ib_qp_create_flags enum.
  */
 #define MLX5_IB_QP_CREATE_SQPN_QP1	IB_QP_CREATE_RESERVED_START
+#define MLX5_IB_QP_CREATE_WC_TEST	(IB_QP_CREATE_RESERVED_START << 1)

 struct wr_list {
 	u16	opcode;
@@ -962,6 +963,7 @@ struct mlx5_ib_dev {
 	u8				fill_delay:1;
 	u8				is_rep:1;
 	u8				lag_active:1;
+	u8				wc_support:1;
 	struct umr_common		umrc;
 	/* sync used page count stats
 	 */
@@ -987,6 +989,7 @@ struct mlx5_ib_dev {
 	/* Array with num_ports elements */
 	struct mlx5_ib_port	*port;
 	struct mlx5_sq_bfreg	bfreg;
+	struct mlx5_sq_bfreg	wc_bfreg;
 	struct mlx5_sq_bfreg	fp_bfreg;
 	struct mlx5_ib_delay_drop	delay_drop;
 	const struct mlx5_ib_profile	*profile;
@@ -1496,4 +1499,7 @@ static inline bool mlx5_ib_can_use_umr(struct mlx5_ib_dev *dev,

 	return true;
 }
+
+int mlx5_ib_enable_driver(struct ib_device *dev);
+int mlx5_ib_test_wc(struct mlx5_ib_dev *dev);
 #endif /* MLX5_IB_H */
diff --git a/drivers/infiniband/hw/mlx5/qp.c b/drivers/infiniband/hw/mlx5/qp.c
index bb3f432e2fb6..c831b455ffa8 100644
--- a/drivers/infiniband/hw/mlx5/qp.c
+++ b/drivers/infiniband/hw/mlx5/qp.c
@@ -1041,11 +1041,14 @@ static int create_kernel_qp(struct mlx5_ib_dev *dev,
 					IB_QP_CREATE_BLOCK_MULTICAST_LOOPBACK |
 					IB_QP_CREATE_IPOIB_UD_LSO |
 					IB_QP_CREATE_NETIF_QP |
-					MLX5_IB_QP_CREATE_SQPN_QP1))
+					MLX5_IB_QP_CREATE_SQPN_QP1 |
+					MLX5_IB_QP_CREATE_WC_TEST))
 		return -EINVAL;

 	if (init_attr->qp_type == MLX5_IB_QPT_REG_UMR)
 		qp->bf.bfreg = &dev->fp_bfreg;
+	else if (init_attr->create_flags & MLX5_IB_QP_CREATE_WC_TEST)
+		qp->bf.bfreg = &dev->wc_bfreg;
 	else
 		qp->bf.bfreg = &dev->bfreg;

@@ -5328,7 +5331,6 @@ static int _mlx5_ib_post_send(struct ib_qp *ibqp, const struct ib_send_wr *wr,
 		 * we hit doorbell */
 		wmb();

-		/* currently we support only regular doorbells */
 		mlx5_write64((__be32 *)ctrl, bf->bfreg->map + bf->offset);
 		/* Make sure doorbells don't leak out of SQ spinlock
 		 * and reach the HCA out of order.
--
2.20.1

