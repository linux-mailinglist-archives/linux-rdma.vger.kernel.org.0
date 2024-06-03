Return-Path: <linux-rdma+bounces-2772-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 20C0F8D7FEE
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Jun 2024 12:27:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6FAA5B23EBB
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Jun 2024 10:27:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E791082860;
	Mon,  3 Jun 2024 10:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GM0SxvbK"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3B077D3E8;
	Mon,  3 Jun 2024 10:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717410413; cv=none; b=NDsri7hLLJPPpLcX03qCh21t8HPOxzY0oIAo05q8S536LLIIAslJ+NyDP2KiimtQSE8HO8ASsBHxLpkFv867pDtvTOD3wTSaCT2NN4oJ46asoY6pQRNeZaj5Foo5LthatZr1LuGGHOath3n54p3jFXBd/YZ9CIIMtFEHb1ovAj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717410413; c=relaxed/simple;
	bh=YJm484bKJFA/LdVIrq3DyBeXXKwOdHrzAcPw9SaHP9I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=axTW3kacshbH6UXqUgjxOJMVrA2QFMZZTmotBWmIkP4zXqUEbvtkoO5HLoGS8WftBtNLmXZd1cpBbbd5HhPv/DO+xXRwu2cLfQLm3FDePnakHAAZL3K5uTOuQe0rnp0WnWJ1PD3jk+RNAZg86Gpv9hrJnP9/UMpTG+bKsZK7/58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GM0SxvbK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A5F4C2BD10;
	Mon,  3 Jun 2024 10:26:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717410413;
	bh=YJm484bKJFA/LdVIrq3DyBeXXKwOdHrzAcPw9SaHP9I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GM0SxvbKWBVj9p07NkLyoktNYQmLMTiibmQCBEqmWUYG+bMafRYSKZfnItoOW9ZJO
	 9bLsVZfTElfIh+/pxtxI/KZYPr3JDfLgmOgLCB1i76fdwlCVwKEhrYQchoj38Ked5L
	 pV1XYpzZ46vDFGoKq5cvvbrGHxRR7o1Dz31aoBSu7z5ymIwWXY5G+8ZLzURt/vKmqP
	 qRYxLTR/p9xYoA8JD4xYzqy5uaCilkPT3Van57uavia1qlNHp4qLjBAbLlJQ7mSRUr
	 zv9kKrGgBuMkcF+YrgeAljue7AB0WgXRPgtQPlrLzno9OiX7kAJzxkq1NTO26fklpJ
	 q3ZQgnZ5GrhFg==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Jianbo Liu <jianbol@nvidia.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH mlx5-next 1/3] net/mlx5: Reimplement write combining test
Date: Mon,  3 Jun 2024 13:26:37 +0300
Message-ID: <4ff5a8cc4c5b5b0d98397baa45a5019bcdbf096e.1717409369.git.leon@kernel.org>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <cover.1717409369.git.leon@kernel.org>
References: <cover.1717409369.git.leon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jianbo Liu <jianbol@nvidia.com>

The test of write combining was added before in mlx5_ib driver. It
opens UD QP and posts NOP WQEs, and uses BlueFlame doorbell. When
BlueFlame is used, WQEs get written directly to a PCI BAR of the
device (in addition to memory) so that the device handles them without
having to access memory.

In this test, the WQEs written in memory are different from the ones
written to the BlueFlame which request CQE update. By checking the
completion reports posted on CQ, we can know if BlueFlame succeeds or
not. The write combining must be supported if BlueFlame succeeds as
its register is written using write combining.

This patch reimplements the test in the same way, but using a pair of
SQ and CQ only. It is moved to mlx5_core as a general feature used by
both mlx5_core and mlx5_ib.

Besides, save write combine test result of the PCI function, so that
its thousands of child functions such as SF can query without paying
the time and resource penalty by itself. The test function is called
only after failing to get the cached result. With this enhancement,
all thousands of SFs of the PF attached to same driver no longer need
to perform WC check explicitly, which is already done in the system.
This saves several commands per SF, thereby speeds up SF creation and
also saves completion EQ creation.

Signed-off-by: Jianbo Liu <jianbol@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/main.c             |  19 +-
 drivers/infiniband/hw/mlx5/mem.c              | 198 --------
 drivers/infiniband/hw/mlx5/mlx5_ib.h          |   3 -
 drivers/infiniband/hw/mlx5/qp.c               |  16 -
 .../net/ethernet/mellanox/mlx5/core/Makefile  |   2 +-
 .../net/ethernet/mellanox/mlx5/core/main.c    |   2 +
 drivers/net/ethernet/mellanox/mlx5/core/wc.c  | 434 ++++++++++++++++++
 include/linux/mlx5/driver.h                   |  11 +
 8 files changed, 451 insertions(+), 234 deletions(-)
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/wc.c

diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index c5b0e004fdd5..ec4031e851e6 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -1841,7 +1841,7 @@ static int set_ucontext_resp(struct ib_ucontext *uctx,
 	}
 
 	resp->qp_tab_size = 1 << MLX5_CAP_GEN(dev->mdev, log_max_qp);
-	if (dev->wc_support)
+	if (mlx5_wc_support_get(dev->mdev))
 		resp->bf_reg_size = 1 << MLX5_CAP_GEN(dev->mdev,
 						      log_bf_reg_size);
 	resp->cache_line_size = cache_line_size();
@@ -2368,7 +2368,7 @@ static int mlx5_ib_mmap(struct ib_ucontext *ibcontext, struct vm_area_struct *vm
 	switch (command) {
 	case MLX5_IB_MMAP_WC_PAGE:
 	case MLX5_IB_MMAP_ALLOC_WC:
-		if (!dev->wc_support)
+		if (!mlx5_wc_support_get(dev->mdev))
 			return -EPERM;
 		fallthrough;
 	case MLX5_IB_MMAP_NC_PAGE:
@@ -3643,7 +3643,7 @@ static int UVERBS_HANDLER(MLX5_IB_METHOD_UAR_OBJ_ALLOC)(
 	    alloc_type != MLX5_IB_UAPI_UAR_ALLOC_TYPE_NC)
 		return -EOPNOTSUPP;
 
-	if (!to_mdev(c->ibucontext.device)->wc_support &&
+	if (!mlx5_wc_support_get(to_mdev(c->ibucontext.device)->mdev) &&
 	    alloc_type == MLX5_IB_UAPI_UAR_ALLOC_TYPE_BF)
 		return -EOPNOTSUPP;
 
@@ -3797,18 +3797,6 @@ static int mlx5_ib_stage_init_init(struct mlx5_ib_dev *dev)
 	return err;
 }
 
-static int mlx5_ib_enable_driver(struct ib_device *dev)
-{
-	struct mlx5_ib_dev *mdev = to_mdev(dev);
-	int ret;
-
-	ret = mlx5_ib_test_wc(mdev);
-	mlx5_ib_dbg(mdev, "Write-Combining %s",
-		    mdev->wc_support ? "supported" : "not supported");
-
-	return ret;
-}
-
 static const struct ib_device_ops mlx5_ib_dev_ops = {
 	.owner = THIS_MODULE,
 	.driver_id = RDMA_DRIVER_MLX5,
@@ -3839,7 +3827,6 @@ static const struct ib_device_ops mlx5_ib_dev_ops = {
 	.drain_rq = mlx5_ib_drain_rq,
 	.drain_sq = mlx5_ib_drain_sq,
 	.device_group = &mlx5_attr_group,
-	.enable_driver = mlx5_ib_enable_driver,
 	.get_dev_fw_str = get_dev_fw_str,
 	.get_dma_mr = mlx5_ib_get_dma_mr,
 	.get_link_layer = mlx5_ib_port_link_layer,
diff --git a/drivers/infiniband/hw/mlx5/mem.c b/drivers/infiniband/hw/mlx5/mem.c
index 5a22be14d958..af321f6ef7f5 100644
--- a/drivers/infiniband/hw/mlx5/mem.c
+++ b/drivers/infiniband/hw/mlx5/mem.c
@@ -30,10 +30,8 @@
  * SOFTWARE.
  */
 
-#include <linux/io.h>
 #include <rdma/ib_umem_odp.h>
 #include "mlx5_ib.h"
-#include <linux/jiffies.h>
 
 /*
  * Fill in a physical address list. ib_umem_num_dma_blocks() entries will be
@@ -95,199 +93,3 @@ unsigned long __mlx5_umem_find_best_quantized_pgoff(
 		return 0;
 	return page_size;
 }
-
-#define WR_ID_BF 0xBF
-#define WR_ID_END 0xBAD
-#define TEST_WC_NUM_WQES 255
-#define TEST_WC_POLLING_MAX_TIME_JIFFIES msecs_to_jiffies(100)
-static int post_send_nop(struct mlx5_ib_dev *dev, struct ib_qp *ibqp, u64 wr_id,
-			 bool signaled)
-{
-	struct mlx5_ib_qp *qp = to_mqp(ibqp);
-	struct mlx5_wqe_ctrl_seg *ctrl;
-	struct mlx5_bf *bf = &qp->bf;
-	__be32 mmio_wqe[16] = {};
-	unsigned long flags;
-	unsigned int idx;
-
-	if (unlikely(dev->mdev->state == MLX5_DEVICE_STATE_INTERNAL_ERROR))
-		return -EIO;
-
-	spin_lock_irqsave(&qp->sq.lock, flags);
-
-	idx = qp->sq.cur_post & (qp->sq.wqe_cnt - 1);
-	ctrl = mlx5_frag_buf_get_wqe(&qp->sq.fbc, idx);
-
-	memset(ctrl, 0, sizeof(struct mlx5_wqe_ctrl_seg));
-	ctrl->fm_ce_se = signaled ? MLX5_WQE_CTRL_CQ_UPDATE : 0;
-	ctrl->opmod_idx_opcode =
-		cpu_to_be32(((u32)(qp->sq.cur_post) << 8) | MLX5_OPCODE_NOP);
-	ctrl->qpn_ds = cpu_to_be32((sizeof(struct mlx5_wqe_ctrl_seg) / 16) |
-				   (qp->trans_qp.base.mqp.qpn << 8));
-
-	qp->sq.wrid[idx] = wr_id;
-	qp->sq.w_list[idx].opcode = MLX5_OPCODE_NOP;
-	qp->sq.wqe_head[idx] = qp->sq.head + 1;
-	qp->sq.cur_post += DIV_ROUND_UP(sizeof(struct mlx5_wqe_ctrl_seg),
-					MLX5_SEND_WQE_BB);
-	qp->sq.w_list[idx].next = qp->sq.cur_post;
-	qp->sq.head++;
-
-	memcpy(mmio_wqe, ctrl, sizeof(*ctrl));
-	((struct mlx5_wqe_ctrl_seg *)&mmio_wqe)->fm_ce_se |=
-		MLX5_WQE_CTRL_CQ_UPDATE;
-
-	/* Make sure that descriptors are written before
-	 * updating doorbell record and ringing the doorbell
-	 */
-	wmb();
-
-	qp->db.db[MLX5_SND_DBR] = cpu_to_be32(qp->sq.cur_post);
-
-	/* Make sure doorbell record is visible to the HCA before
-	 * we hit doorbell
-	 */
-	wmb();
-	__iowrite64_copy(bf->bfreg->map + bf->offset, mmio_wqe,
-			 sizeof(mmio_wqe) / 8);
-
-	bf->offset ^= bf->buf_size;
-
-	spin_unlock_irqrestore(&qp->sq.lock, flags);
-
-	return 0;
-}
-
-static int test_wc_poll_cq_result(struct mlx5_ib_dev *dev, struct ib_cq *cq)
-{
-	int ret;
-	struct ib_wc wc = {};
-	unsigned long end = jiffies + TEST_WC_POLLING_MAX_TIME_JIFFIES;
-
-	do {
-		ret = ib_poll_cq(cq, 1, &wc);
-		if (ret < 0 || wc.status)
-			return ret < 0 ? ret : -EINVAL;
-		if (ret)
-			break;
-	} while (!time_after(jiffies, end));
-
-	if (!ret)
-		return -ETIMEDOUT;
-
-	if (wc.wr_id != WR_ID_BF)
-		ret = 0;
-
-	return ret;
-}
-
-static int test_wc_do_send(struct mlx5_ib_dev *dev, struct ib_qp *qp)
-{
-	int err, i;
-
-	for (i = 0; i < TEST_WC_NUM_WQES; i++) {
-		err = post_send_nop(dev, qp, WR_ID_BF, false);
-		if (err)
-			return err;
-	}
-
-	return post_send_nop(dev, qp, WR_ID_END, true);
-}
-
-int mlx5_ib_test_wc(struct mlx5_ib_dev *dev)
-{
-	struct ib_cq_init_attr cq_attr = { .cqe = TEST_WC_NUM_WQES + 1 };
-	int port_type_cap = MLX5_CAP_GEN(dev->mdev, port_type);
-	struct ib_qp_init_attr qp_init_attr = {
-		.cap = { .max_send_wr = TEST_WC_NUM_WQES },
-		.qp_type = IB_QPT_UD,
-		.sq_sig_type = IB_SIGNAL_REQ_WR,
-		.create_flags = MLX5_IB_QP_CREATE_WC_TEST,
-	};
-	struct ib_qp_attr qp_attr = { .port_num = 1 };
-	struct ib_device *ibdev = &dev->ib_dev;
-	struct ib_qp *qp;
-	struct ib_cq *cq;
-	struct ib_pd *pd;
-	int ret;
-
-	if (!MLX5_CAP_GEN(dev->mdev, bf))
-		return 0;
-
-	if (!dev->mdev->roce.roce_en &&
-	    port_type_cap == MLX5_CAP_PORT_TYPE_ETH) {
-		if (mlx5_core_is_pf(dev->mdev))
-			dev->wc_support = arch_can_pci_mmap_wc();
-		return 0;
-	}
-
-	ret = mlx5_alloc_bfreg(dev->mdev, &dev->wc_bfreg, true, false);
-	if (ret)
-		goto print_err;
-
-	if (!dev->wc_bfreg.wc)
-		goto out1;
-
-	pd = ib_alloc_pd(ibdev, 0);
-	if (IS_ERR(pd)) {
-		ret = PTR_ERR(pd);
-		goto out1;
-	}
-
-	cq = ib_create_cq(ibdev, NULL, NULL, NULL, &cq_attr);
-	if (IS_ERR(cq)) {
-		ret = PTR_ERR(cq);
-		goto out2;
-	}
-
-	qp_init_attr.recv_cq = cq;
-	qp_init_attr.send_cq = cq;
-	qp = ib_create_qp(pd, &qp_init_attr);
-	if (IS_ERR(qp)) {
-		ret = PTR_ERR(qp);
-		goto out3;
-	}
-
-	qp_attr.qp_state = IB_QPS_INIT;
-	ret = ib_modify_qp(qp, &qp_attr,
-			   IB_QP_STATE | IB_QP_PORT | IB_QP_PKEY_INDEX |
-				   IB_QP_QKEY);
-	if (ret)
-		goto out4;
-
-	qp_attr.qp_state = IB_QPS_RTR;
-	ret = ib_modify_qp(qp, &qp_attr, IB_QP_STATE);
-	if (ret)
-		goto out4;
-
-	qp_attr.qp_state = IB_QPS_RTS;
-	ret = ib_modify_qp(qp, &qp_attr, IB_QP_STATE | IB_QP_SQ_PSN);
-	if (ret)
-		goto out4;
-
-	ret = test_wc_do_send(dev, qp);
-	if (ret < 0)
-		goto out4;
-
-	ret = test_wc_poll_cq_result(dev, cq);
-	if (ret > 0) {
-		dev->wc_support = true;
-		ret = 0;
-	}
-
-out4:
-	ib_destroy_qp(qp);
-out3:
-	ib_destroy_cq(cq);
-out2:
-	ib_dealloc_pd(pd);
-out1:
-	mlx5_free_bfreg(dev->mdev, &dev->wc_bfreg);
-print_err:
-	if (ret)
-		mlx5_ib_err(
-			dev,
-			"Error %d while trying to test write-combining support\n",
-			ret);
-	return ret;
-}
diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
index 652e1e4ca033..a74e6f5798f6 100644
--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -341,7 +341,6 @@ struct mlx5_ib_flow_db {
  * rely on the range reserved for that use in the ib_qp_create_flags enum.
  */
 #define MLX5_IB_QP_CREATE_SQPN_QP1	IB_QP_CREATE_RESERVED_START
-#define MLX5_IB_QP_CREATE_WC_TEST	(IB_QP_CREATE_RESERVED_START << 1)
 
 struct wr_list {
 	u16	opcode;
@@ -1123,7 +1122,6 @@ struct mlx5_ib_dev {
 	bool				ib_active;
 	u8				is_rep:1;
 	u8				lag_active:1;
-	u8				wc_support:1;
 	u8				fill_delay;
 	struct umr_common		umrc;
 	/* sync used page count stats
@@ -1149,7 +1147,6 @@ struct mlx5_ib_dev {
 	/* Array with num_ports elements */
 	struct mlx5_ib_port	*port;
 	struct mlx5_sq_bfreg	bfreg;
-	struct mlx5_sq_bfreg	wc_bfreg;
 	struct mlx5_sq_bfreg	fp_bfreg;
 	struct mlx5_ib_delay_drop	delay_drop;
 	const struct mlx5_ib_profile	*profile;
diff --git a/drivers/infiniband/hw/mlx5/qp.c b/drivers/infiniband/hw/mlx5/qp.c
index 8c16c9278ce4..1d09e515aec7 100644
--- a/drivers/infiniband/hw/mlx5/qp.c
+++ b/drivers/infiniband/hw/mlx5/qp.c
@@ -1109,8 +1109,6 @@ static int _create_kernel_qp(struct mlx5_ib_dev *dev,
 
 	if (init_attr->qp_type == MLX5_IB_QPT_REG_UMR)
 		qp->bf.bfreg = &dev->fp_bfreg;
-	else if (qp->flags & MLX5_IB_QP_CREATE_WC_TEST)
-		qp->bf.bfreg = &dev->wc_bfreg;
 	else
 		qp->bf.bfreg = &dev->bfreg;
 
@@ -2961,14 +2959,6 @@ static void process_create_flag(struct mlx5_ib_dev *dev, int *flags, int flag,
 		return;
 	}
 
-	if (flag == MLX5_IB_QP_CREATE_WC_TEST) {
-		/*
-		 * Special case, if condition didn't meet, it won't be error,
-		 * just different in-kernel flow.
-		 */
-		*flags &= ~MLX5_IB_QP_CREATE_WC_TEST;
-		return;
-	}
 	mlx5_ib_dbg(dev, "Verbs create QP flag 0x%X is not supported\n", flag);
 }
 
@@ -3029,8 +3019,6 @@ static int process_create_flags(struct mlx5_ib_dev *dev, struct mlx5_ib_qp *qp,
 			    IB_QP_CREATE_PCI_WRITE_END_PADDING,
 			    MLX5_CAP_GEN(mdev, end_pad), qp);
 
-	process_create_flag(dev, &create_flags, MLX5_IB_QP_CREATE_WC_TEST,
-			    qp_type != MLX5_IB_QPT_REG_UMR, qp);
 	process_create_flag(dev, &create_flags, MLX5_IB_QP_CREATE_SQPN_QP1,
 			    true, qp);
 
@@ -4611,10 +4599,6 @@ static bool mlx5_ib_modify_qp_allowed(struct mlx5_ib_dev *dev,
 	if (qp->type == IB_QPT_RAW_PACKET || qp->type == MLX5_IB_QPT_REG_UMR)
 		return true;
 
-	/* Internal QP used for wc testing, with NOPs in wq */
-	if (qp->flags & MLX5_IB_QP_CREATE_WC_TEST)
-		return true;
-
 	return false;
 }
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/Makefile b/drivers/net/ethernet/mellanox/mlx5/core/Makefile
index 76dc5a9b9648..1289475e7be7 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/Makefile
+++ b/drivers/net/ethernet/mellanox/mlx5/core/Makefile
@@ -17,7 +17,7 @@ mlx5_core-y :=	main.o cmd.o debugfs.o fw.o eq.o uar.o pagealloc.o \
 		fs_counters.o fs_ft_pool.o rl.o lag/debugfs.o lag/lag.o dev.o events.o wq.o lib/gid.o \
 		lib/devcom.o lib/pci_vsc.o lib/dm.o lib/fs_ttc.o diag/fs_tracepoint.o \
 		diag/fw_tracer.o diag/crdump.o devlink.o diag/rsc_dump.o diag/reporter_vnic.o \
-		fw_reset.o qos.o lib/tout.o lib/aso.o
+		fw_reset.o qos.o lib/tout.o lib/aso.o wc.o
 
 #
 # Netdev basic
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/main.c b/drivers/net/ethernet/mellanox/mlx5/core/main.c
index 6574c145dc1e..91ab55289104 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/main.c
@@ -1816,6 +1816,7 @@ int mlx5_mdev_init(struct mlx5_core_dev *dev, int profile_idx)
 	mutex_init(&dev->intf_state_mutex);
 	lockdep_set_class(&dev->intf_state_mutex, &dev->lock_key);
 	mutex_init(&dev->mlx5e_res.uplink_netdev_lock);
+	mutex_init(&dev->wc_state_lock);
 
 	mutex_init(&priv->bfregs.reg_head.lock);
 	mutex_init(&priv->bfregs.wc_head.lock);
@@ -1913,6 +1914,7 @@ void mlx5_mdev_uninit(struct mlx5_core_dev *dev)
 	mutex_destroy(&priv->alloc_mutex);
 	mutex_destroy(&priv->bfregs.wc_head.lock);
 	mutex_destroy(&priv->bfregs.reg_head.lock);
+	mutex_destroy(&dev->wc_state_lock);
 	mutex_destroy(&dev->mlx5e_res.uplink_netdev_lock);
 	mutex_destroy(&dev->intf_state_mutex);
 	lockdep_unregister_key(&dev->lock_key);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/wc.c b/drivers/net/ethernet/mellanox/mlx5/core/wc.c
new file mode 100644
index 000000000000..1bed75eca97d
--- /dev/null
+++ b/drivers/net/ethernet/mellanox/mlx5/core/wc.c
@@ -0,0 +1,434 @@
+// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
+// Copyright (c) 2024, NVIDIA CORPORATION & AFFILIATES. All rights reserved.
+
+#include <linux/io.h>
+#include <linux/mlx5/transobj.h>
+#include "lib/clock.h"
+#include "mlx5_core.h"
+#include "wq.h"
+
+#define TEST_WC_NUM_WQES 255
+#define TEST_WC_LOG_CQ_SZ (order_base_2(TEST_WC_NUM_WQES))
+#define TEST_WC_SQ_LOG_WQ_SZ TEST_WC_LOG_CQ_SZ
+#define TEST_WC_POLLING_MAX_TIME_JIFFIES msecs_to_jiffies(100)
+
+struct mlx5_wc_cq {
+	/* data path - accessed per cqe */
+	struct mlx5_cqwq wq;
+
+	/* data path - accessed per napi poll */
+	struct mlx5_core_cq mcq;
+
+	/* control */
+	struct mlx5_core_dev *mdev;
+	struct mlx5_wq_ctrl wq_ctrl;
+};
+
+struct mlx5_wc_sq {
+	/* data path */
+	u16 cc;
+	u16 pc;
+
+	/* read only */
+	struct mlx5_wq_cyc wq;
+	u32 sqn;
+
+	/* control path */
+	struct mlx5_wq_ctrl wq_ctrl;
+
+	struct mlx5_wc_cq cq;
+	struct mlx5_sq_bfreg bfreg;
+};
+
+static int mlx5_wc_create_cqwq(struct mlx5_core_dev *mdev, void *cqc,
+			       struct mlx5_wc_cq *cq)
+{
+	struct mlx5_core_cq *mcq = &cq->mcq;
+	struct mlx5_wq_param param = {};
+	int err;
+	u32 i;
+
+	err = mlx5_cqwq_create(mdev, &param, cqc, &cq->wq, &cq->wq_ctrl);
+	if (err)
+		return err;
+
+	mcq->cqe_sz     = 64;
+	mcq->set_ci_db  = cq->wq_ctrl.db.db;
+	mcq->arm_db     = cq->wq_ctrl.db.db + 1;
+
+	for (i = 0; i < mlx5_cqwq_get_size(&cq->wq); i++) {
+		struct mlx5_cqe64 *cqe = mlx5_cqwq_get_wqe(&cq->wq, i);
+
+		cqe->op_own = 0xf1;
+	}
+
+	cq->mdev = mdev;
+
+	return 0;
+}
+
+static int create_wc_cq(struct mlx5_wc_cq *cq, void *cqc_data)
+{
+	u32 out[MLX5_ST_SZ_DW(create_cq_out)];
+	struct mlx5_core_dev *mdev = cq->mdev;
+	struct mlx5_core_cq *mcq = &cq->mcq;
+	int err, inlen, eqn;
+	void *in, *cqc;
+
+	err = mlx5_comp_eqn_get(mdev, 0, &eqn);
+	if (err)
+		return err;
+
+	inlen = MLX5_ST_SZ_BYTES(create_cq_in) +
+		sizeof(u64) * cq->wq_ctrl.buf.npages;
+	in = kvzalloc(inlen, GFP_KERNEL);
+	if (!in)
+		return -ENOMEM;
+
+	cqc = MLX5_ADDR_OF(create_cq_in, in, cq_context);
+
+	memcpy(cqc, cqc_data, MLX5_ST_SZ_BYTES(cqc));
+
+	mlx5_fill_page_frag_array(&cq->wq_ctrl.buf,
+				  (__be64 *)MLX5_ADDR_OF(create_cq_in, in, pas));
+
+	MLX5_SET(cqc,   cqc, cq_period_mode, MLX5_CQ_PERIOD_MODE_START_FROM_EQE);
+	MLX5_SET(cqc,   cqc, c_eqn_or_apu_element, eqn);
+	MLX5_SET(cqc,   cqc, uar_page,      mdev->priv.uar->index);
+	MLX5_SET(cqc,   cqc, log_page_size, cq->wq_ctrl.buf.page_shift -
+					    MLX5_ADAPTER_PAGE_SHIFT);
+	MLX5_SET64(cqc, cqc, dbr_addr,      cq->wq_ctrl.db.dma);
+
+	err = mlx5_core_create_cq(mdev, mcq, in, inlen, out, sizeof(out));
+
+	kvfree(in);
+
+	return err;
+}
+
+static int mlx5_wc_create_cq(struct mlx5_core_dev *mdev, struct mlx5_wc_cq *cq)
+{
+	void *cqc;
+	int err;
+
+	cqc = kvzalloc(MLX5_ST_SZ_BYTES(cqc), GFP_KERNEL);
+	if (!cqc)
+		return -ENOMEM;
+
+	MLX5_SET(cqc, cqc, log_cq_size, TEST_WC_LOG_CQ_SZ);
+	MLX5_SET(cqc, cqc, uar_page, mdev->priv.uar->index);
+	if (MLX5_CAP_GEN(mdev, cqe_128_always) && cache_line_size() >= 128)
+		MLX5_SET(cqc, cqc, cqe_sz, CQE_STRIDE_128_PAD);
+
+	err = mlx5_wc_create_cqwq(mdev, cqc, cq);
+	if (err) {
+		mlx5_core_err(mdev, "Failed to create wc cq wq, err=%d\n", err);
+		goto err_create_cqwq;
+	}
+
+	err = create_wc_cq(cq, cqc);
+	if (err) {
+		mlx5_core_err(mdev, "Failed to create wc cq, err=%d\n", err);
+		goto err_create_cq;
+	}
+
+	kvfree(cqc);
+	return 0;
+
+err_create_cq:
+	mlx5_wq_destroy(&cq->wq_ctrl);
+err_create_cqwq:
+	kvfree(cqc);
+	return err;
+}
+
+static void mlx5_wc_destroy_cq(struct mlx5_wc_cq *cq)
+{
+	mlx5_core_destroy_cq(cq->mdev, &cq->mcq);
+	mlx5_wq_destroy(&cq->wq_ctrl);
+}
+
+static int create_wc_sq(struct mlx5_core_dev *mdev, void *sqc_data,
+			struct mlx5_wc_sq *sq)
+{
+	void *in, *sqc, *wq;
+	int inlen, err;
+	u8 ts_format;
+
+	inlen = MLX5_ST_SZ_BYTES(create_sq_in) +
+		sizeof(u64) * sq->wq_ctrl.buf.npages;
+	in = kvzalloc(inlen, GFP_KERNEL);
+	if (!in)
+		return -ENOMEM;
+
+	sqc = MLX5_ADDR_OF(create_sq_in, in, ctx);
+	wq = MLX5_ADDR_OF(sqc, sqc, wq);
+
+	memcpy(sqc, sqc_data, MLX5_ST_SZ_BYTES(sqc));
+	MLX5_SET(sqc,  sqc, cqn, sq->cq.mcq.cqn);
+
+	MLX5_SET(sqc,  sqc, state, MLX5_SQC_STATE_RST);
+	MLX5_SET(sqc,  sqc, flush_in_error_en, 1);
+
+	ts_format = mlx5_is_real_time_sq(mdev) ?
+			MLX5_TIMESTAMP_FORMAT_REAL_TIME :
+			MLX5_TIMESTAMP_FORMAT_FREE_RUNNING;
+	MLX5_SET(sqc, sqc, ts_format, ts_format);
+
+	MLX5_SET(wq,   wq, wq_type,       MLX5_WQ_TYPE_CYCLIC);
+	MLX5_SET(wq,   wq, uar_page,      sq->bfreg.index);
+	MLX5_SET(wq,   wq, log_wq_pg_sz,  sq->wq_ctrl.buf.page_shift -
+					  MLX5_ADAPTER_PAGE_SHIFT);
+	MLX5_SET64(wq, wq, dbr_addr,      sq->wq_ctrl.db.dma);
+
+	mlx5_fill_page_frag_array(&sq->wq_ctrl.buf,
+				  (__be64 *)MLX5_ADDR_OF(wq, wq, pas));
+
+	err = mlx5_core_create_sq(mdev, in, inlen, &sq->sqn);
+	if (err) {
+		mlx5_core_err(mdev, "Failed to create wc sq, err=%d\n", err);
+		goto err_create_sq;
+	}
+
+	memset(in, 0,  MLX5_ST_SZ_BYTES(modify_sq_in));
+	MLX5_SET(modify_sq_in, in, sq_state, MLX5_SQC_STATE_RST);
+	sqc = MLX5_ADDR_OF(modify_sq_in, in, ctx);
+	MLX5_SET(sqc, sqc, state, MLX5_SQC_STATE_RDY);
+
+	err = mlx5_core_modify_sq(mdev, sq->sqn, in);
+	if (err) {
+		mlx5_core_err(mdev, "Failed to set wc sq(sqn=0x%x) ready, err=%d\n",
+			      sq->sqn, err);
+		goto err_modify_sq;
+	}
+
+	kvfree(in);
+	return 0;
+
+err_modify_sq:
+	mlx5_core_destroy_sq(mdev, sq->sqn);
+err_create_sq:
+	kvfree(in);
+	return err;
+}
+
+static int mlx5_wc_create_sq(struct mlx5_core_dev *mdev, struct mlx5_wc_sq *sq)
+{
+	struct mlx5_wq_param param = {};
+	void *sqc_data, *wq;
+	int err;
+
+	sqc_data = kvzalloc(MLX5_ST_SZ_BYTES(sqc), GFP_KERNEL);
+	if (!sqc_data)
+		return -ENOMEM;
+
+	wq = MLX5_ADDR_OF(sqc, sqc_data, wq);
+	MLX5_SET(wq, wq, log_wq_stride, ilog2(MLX5_SEND_WQE_BB));
+	MLX5_SET(wq, wq, pd, mdev->mlx5e_res.hw_objs.pdn);
+	MLX5_SET(wq, wq, log_wq_sz, TEST_WC_SQ_LOG_WQ_SZ);
+
+	err = mlx5_wq_cyc_create(mdev, &param, wq, &sq->wq, &sq->wq_ctrl);
+	if (err) {
+		mlx5_core_err(mdev, "Failed to create wc sq wq, err=%d\n", err);
+		goto err_create_wq_cyc;
+	}
+
+	err = create_wc_sq(mdev, sqc_data, sq);
+	if (err)
+		goto err_create_sq;
+
+	mlx5_core_dbg(mdev, "wc sq->sqn = 0x%x created\n", sq->sqn);
+
+	kvfree(sqc_data);
+	return 0;
+
+err_create_sq:
+	mlx5_wq_destroy(&sq->wq_ctrl);
+err_create_wq_cyc:
+	kvfree(sqc_data);
+	return err;
+}
+
+static void mlx5_wc_destroy_sq(struct mlx5_wc_sq *sq)
+{
+	mlx5_core_destroy_sq(sq->cq.mdev, sq->sqn);
+	mlx5_wq_destroy(&sq->wq_ctrl);
+}
+
+static void mlx5_wc_post_nop(struct mlx5_wc_sq *sq, bool signaled)
+{
+	int buf_size = (1 << MLX5_CAP_GEN(sq->cq.mdev, log_bf_reg_size)) / 2;
+	struct mlx5_wqe_ctrl_seg *ctrl;
+	__be32 mmio_wqe[16] = {};
+	u16 pi;
+
+	pi = mlx5_wq_cyc_ctr2ix(&sq->wq, sq->pc);
+	ctrl = mlx5_wq_cyc_get_wqe(&sq->wq, pi);
+	memset(ctrl, 0, sizeof(*ctrl));
+	ctrl->opmod_idx_opcode =
+		cpu_to_be32((sq->pc << MLX5_WQE_CTRL_WQE_INDEX_SHIFT) | MLX5_OPCODE_NOP);
+	ctrl->qpn_ds =
+		cpu_to_be32((sq->sqn << MLX5_WQE_CTRL_QPN_SHIFT) |
+			    DIV_ROUND_UP(sizeof(struct mlx5_wqe_ctrl_seg), MLX5_SEND_WQE_DS));
+	if (signaled)
+		ctrl->fm_ce_se |= MLX5_WQE_CTRL_CQ_UPDATE;
+
+	memcpy(mmio_wqe, ctrl, sizeof(*ctrl));
+	((struct mlx5_wqe_ctrl_seg *)&mmio_wqe)->fm_ce_se |=
+		MLX5_WQE_CTRL_CQ_UPDATE;
+
+	/* ensure wqe is visible to device before updating doorbell record */
+	dma_wmb();
+
+	sq->pc++;
+	sq->wq.db[MLX5_SND_DBR] = cpu_to_be32(sq->pc);
+
+	/* ensure doorbell record is visible to device before ringing the
+	 * doorbell
+	 */
+	wmb();
+
+	__iowrite64_copy(sq->bfreg.map + sq->bfreg.offset, mmio_wqe,
+			 sizeof(mmio_wqe) / 8);
+
+	sq->bfreg.offset ^= buf_size;
+}
+
+static int mlx5_wc_poll_cq(struct mlx5_wc_sq *sq)
+{
+	struct mlx5_wc_cq *cq = &sq->cq;
+	struct mlx5_cqe64 *cqe;
+
+	cqe = mlx5_cqwq_get_cqe(&cq->wq);
+	if (!cqe)
+		return -ETIMEDOUT;
+
+	/* sq->cc must be updated only after mlx5_cqwq_update_db_record(),
+	 * otherwise a cq overrun may occur
+	 */
+	mlx5_cqwq_pop(&cq->wq);
+
+	if (get_cqe_opcode(cqe) == MLX5_CQE_REQ) {
+		int wqe_counter = be16_to_cpu(cqe->wqe_counter);
+		struct mlx5_core_dev *mdev = cq->mdev;
+
+		if (wqe_counter == TEST_WC_NUM_WQES - 1)
+			mdev->wc_state = MLX5_WC_STATE_UNSUPPORTED;
+		else
+			mdev->wc_state = MLX5_WC_STATE_SUPPORTED;
+
+		mlx5_core_dbg(mdev, "wc wqe_counter = 0x%x\n", wqe_counter);
+	}
+
+	mlx5_cqwq_update_db_record(&cq->wq);
+
+	/* ensure cq space is freed before enabling more cqes */
+	wmb();
+
+	sq->cc++;
+
+	return 0;
+}
+
+static void mlx5_core_test_wc(struct mlx5_core_dev *mdev)
+{
+	unsigned long expires;
+	struct mlx5_wc_sq *sq;
+	int i, err;
+
+	if (mdev->wc_state != MLX5_WC_STATE_UNINITIALIZED)
+		return;
+
+	sq = kzalloc(sizeof(*sq), GFP_KERNEL);
+	if (!sq)
+		return;
+
+	err = mlx5_alloc_bfreg(mdev, &sq->bfreg, true, false);
+	if (err) {
+		mlx5_core_err(mdev, "Failed to alloc bfreg for wc, err=%d\n", err);
+		goto err_alloc_bfreg;
+	}
+
+	err = mlx5_wc_create_cq(mdev, &sq->cq);
+	if (err)
+		goto err_create_cq;
+
+	err = mlx5_wc_create_sq(mdev, sq);
+	if (err)
+		goto err_create_sq;
+
+	for (i = 0; i < TEST_WC_NUM_WQES - 1; i++)
+		mlx5_wc_post_nop(sq, false);
+
+	mlx5_wc_post_nop(sq, true);
+
+	expires = jiffies + TEST_WC_POLLING_MAX_TIME_JIFFIES;
+	do {
+		err = mlx5_wc_poll_cq(sq);
+		if (err)
+			usleep_range(2, 10);
+	} while (mdev->wc_state == MLX5_WC_STATE_UNINITIALIZED &&
+		 time_is_after_jiffies(expires));
+
+	mlx5_wc_destroy_sq(sq);
+
+err_create_sq:
+	mlx5_wc_destroy_cq(&sq->cq);
+err_create_cq:
+	mlx5_free_bfreg(mdev, &sq->bfreg);
+err_alloc_bfreg:
+	kfree(sq);
+}
+
+bool mlx5_wc_support_get(struct mlx5_core_dev *mdev)
+{
+	struct mlx5_core_dev *parent = NULL;
+
+	if (!MLX5_CAP_GEN(mdev, bf)) {
+		mlx5_core_dbg(mdev, "BlueFlame not supported\n");
+		goto out;
+	}
+
+	if (!MLX5_CAP_GEN(mdev, log_max_sq)) {
+		mlx5_core_dbg(mdev, "SQ not supported\n");
+		goto out;
+	}
+
+	if (mdev->wc_state != MLX5_WC_STATE_UNINITIALIZED)
+		/* No need to lock anything as we perform WC test only
+		 * once for whole device and was already done.
+		 */
+		goto out;
+
+	mutex_lock(&mdev->wc_state_lock);
+
+	if (mdev->wc_state != MLX5_WC_STATE_UNINITIALIZED)
+		goto unlock;
+
+#ifdef CONFIG_MLX5_SF
+	if (mlx5_core_is_sf(mdev))
+		parent = mdev->priv.parent_mdev;
+#endif
+
+	if (parent) {
+		mutex_lock(&parent->wc_state_lock);
+
+		mlx5_core_test_wc(parent);
+
+		mlx5_core_dbg(mdev, "parent set wc_state=%d\n",
+			      parent->wc_state);
+		mdev->wc_state = parent->wc_state;
+
+		mutex_unlock(&parent->wc_state_lock);
+	}
+
+	mlx5_core_test_wc(mdev);
+
+unlock:
+	mutex_unlock(&mdev->wc_state_lock);
+out:
+	mlx5_core_dbg(mdev, "wc_state=%d\n", mdev->wc_state);
+
+	return mdev->wc_state == MLX5_WC_STATE_SUPPORTED;
+}
+EXPORT_SYMBOL(mlx5_wc_support_get);
diff --git a/include/linux/mlx5/driver.h b/include/linux/mlx5/driver.h
index ee50301a1a0e..145e2fb1b832 100644
--- a/include/linux/mlx5/driver.h
+++ b/include/linux/mlx5/driver.h
@@ -766,6 +766,12 @@ struct mlx5_hca_cap {
 	u32 max[MLX5_UN_SZ_DW(hca_cap_union)];
 };
 
+enum mlx5_wc_state {
+	MLX5_WC_STATE_UNINITIALIZED,
+	MLX5_WC_STATE_UNSUPPORTED,
+	MLX5_WC_STATE_SUPPORTED,
+};
+
 struct mlx5_core_dev {
 	struct device *device;
 	enum mlx5_coredev_type coredev_type;
@@ -824,6 +830,9 @@ struct mlx5_core_dev {
 #endif
 	u64 num_ipsec_offloads;
 	struct mlx5_sd          *sd;
+	enum mlx5_wc_state wc_state;
+	/* sync write combining state */
+	struct mutex wc_state_lock;
 };
 
 struct mlx5_db {
@@ -1377,4 +1386,6 @@ static inline bool mlx5_is_macsec_roce_supported(struct mlx5_core_dev *mdev)
 enum {
 	MLX5_OCTWORD = 16,
 };
+
+bool mlx5_wc_support_get(struct mlx5_core_dev *mdev);
 #endif /* MLX5_DRIVER_H */
-- 
2.45.1


