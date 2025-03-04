Return-Path: <linux-rdma+bounces-8312-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F24AA4E07F
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Mar 2025 15:18:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C1801887240
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Mar 2025 14:16:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7EE420551D;
	Tue,  4 Mar 2025 14:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KwPD8XgW"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88699205518;
	Tue,  4 Mar 2025 14:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741097766; cv=none; b=PPlF9uV+IB3eBZvZoyFD05Mj/MNVpxMluzXpKOyAMLVrDo6p0L8z/BTHhTHwA191IrkCggSGDLqv/m4MjY8e4hREnUGpdk+yXS6jk+PRcdqy88Kbel1Y3GIA2ZC4JuN8+7lUyIet3jWARJsir9qKmjEzXkmByx6NNBHQpjCOt10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741097766; c=relaxed/simple;
	bh=sN0DLmvq/imr6sTeAr1Tu9Tpft4mYmIThOllTYwmeYo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E0gZP7vu6HBmk+K7lklXVbOjmceXNzjj+8ljdfQ0PKq0QSejSBrHtcM9ec6ckuViTKniJH6hTAJ8c4L2Hy9PdTQwEXMNZPzzSfTXaFD5thaKIghyVnfE+PJH5vg3MBZHkTRAgfYITcARUQxNRco24ODPNM0ua+ISvz+H/C36izs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KwPD8XgW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44796C4CEE5;
	Tue,  4 Mar 2025 14:16:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741097766;
	bh=sN0DLmvq/imr6sTeAr1Tu9Tpft4mYmIThOllTYwmeYo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KwPD8XgWv5sv8aa2tNM5imMTWzShrzRc2jRUU2udGwVH7gi1I5ZddaUFbxQyIYHSu
	 m/kGfLEdnr35VvsLWguklsN1eU607ZhLxTNN7Ye8gWf3uXjuWSlKqWc7rq9yuLJaRF
	 PyF8vlCorg9UMty4FdHANhjvdvf8GOCRXF0C15fv+Tms8hWx0XFXS6fYnAOASqSrBU
	 nqka2ivVYjejAGxW5dSzxQfj8+lzb2n9BrTU7Tv+358nDDj4iCPOVeQgoSkDQJWjaJ
	 W5FbsgP3X4bzGRpD0Wei0Jwfq0SrBDD1/+2L90uRw2TIQhpcAZEll7YpCLzud0BKdZ
	 Zkr30hA8xjYOw==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Patrisious Haddad <phaddad@nvidia.com>,
	linux-rdma@vger.kernel.org,
	Mark Bloch <mbloch@nvidia.com>,
	netdev@vger.kernel.org,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH mlx5-next 5/5] RDMA/mlx5: Support optional-counters binding for QPs
Date: Tue,  4 Mar 2025 16:15:29 +0200
Message-ID: <b89d216c34ab8d2b4e81bcb78e6983c3f4be1d0d.1741097408.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1741097408.git.leonro@nvidia.com>
References: <cover.1741097408.git.leonro@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Patrisious Haddad <phaddad@nvidia.com>

Add support to allow optional-counters binding to a QP, whereas when
a bind operation is requested depending on the counter optional-counter
binding state the driver will determine if to also add optional-counters
to this QP binding.

The optional-counter binding is done by simply adding a steering
rule for the specific optional-counter condition with the additional
match over that QP number.

Note that optional-counters per QP rules are handled on an earlier prio
than per device counters, and per device counter correctness is maintained
by core whereas it is responsible to sum active counters when checking device
counter and to add them to history count when they are deallocated.

Signed-off-by: Patrisious Haddad <phaddad@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/counters.c |  99 +++++-
 drivers/infiniband/hw/mlx5/counters.h |   9 +
 drivers/infiniband/hw/mlx5/fs.c       | 428 +++++++++++++++++++++++++-
 drivers/infiniband/hw/mlx5/mlx5_ib.h  |  16 +
 include/linux/mlx5/device.h           |   4 +-
 5 files changed, 545 insertions(+), 11 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/counters.c b/drivers/infiniband/hw/mlx5/counters.c
index d826f03b6ec5..7d32b8c6c1a5 100644
--- a/drivers/infiniband/hw/mlx5/counters.c
+++ b/drivers/infiniband/hw/mlx5/counters.c
@@ -437,12 +437,49 @@ static int do_get_hw_stats(struct ib_device *ibdev,
 static bool is_rdma_bytes_counter(u32 type)
 {
 	if (type == MLX5_IB_OPCOUNTER_RDMA_TX_BYTES ||
-	    type == MLX5_IB_OPCOUNTER_RDMA_RX_BYTES)
+	    type == MLX5_IB_OPCOUNTER_RDMA_RX_BYTES ||
+	    type == MLX5_IB_OPCOUNTER_RDMA_TX_BYTES_PER_QP ||
+	    type == MLX5_IB_OPCOUNTER_RDMA_RX_BYTES_PER_QP)
 		return true;
 
 	return false;
 }
 
+static int do_per_qp_get_op_stat(struct rdma_counter *counter)
+{
+	struct mlx5_ib_dev *dev = to_mdev(counter->device);
+	const struct mlx5_ib_counters *cnts = get_counters(dev, counter->port);
+	struct mlx5_rdma_counter *mcounter = to_mcounter(counter);
+	int i, ret, index, num_hw_counters;
+	u64 packets = 0, bytes = 0;
+
+	for (i = MLX5_IB_OPCOUNTER_CC_RX_CE_PKTS_PER_QP;
+	     i <= MLX5_IB_OPCOUNTER_RDMA_RX_BYTES_PER_QP; i++) {
+		if (!mcounter->fc[i])
+			continue;
+
+		ret = mlx5_fc_query(dev->mdev, mcounter->fc[i],
+				    &packets, &bytes);
+		if (ret)
+			return ret;
+
+		num_hw_counters = cnts->num_q_counters +
+				  cnts->num_cong_counters +
+				  cnts->num_ext_ppcnt_counters;
+
+		index = i - MLX5_IB_OPCOUNTER_CC_RX_CE_PKTS_PER_QP +
+			num_hw_counters;
+
+		if (is_rdma_bytes_counter(i))
+			counter->stats->value[index] = bytes;
+		else
+			counter->stats->value[index] = packets;
+
+		clear_bit(index, counter->stats->is_disabled);
+	}
+	return 0;
+}
+
 static int do_get_op_stat(struct ib_device *ibdev,
 			  struct rdma_hw_stats *stats,
 			  u32 port_num, int index)
@@ -542,19 +579,30 @@ static int mlx5_ib_counter_update_stats(struct rdma_counter *counter)
 {
 	struct mlx5_ib_dev *dev = to_mdev(counter->device);
 	const struct mlx5_ib_counters *cnts = get_counters(dev, counter->port);
+	int ret;
+
+	ret = mlx5_ib_query_q_counters(dev->mdev, cnts, counter->stats,
+				       counter->id);
+	if (ret)
+		return ret;
+
+	if (!counter->mode.bind_opcnt)
+		return 0;
 
-	return mlx5_ib_query_q_counters(dev->mdev, cnts,
-					counter->stats, counter->id);
+	return do_per_qp_get_op_stat(counter);
 }
 
 static int mlx5_ib_counter_dealloc(struct rdma_counter *counter)
 {
+	struct mlx5_rdma_counter *mcounter = to_mcounter(counter);
 	struct mlx5_ib_dev *dev = to_mdev(counter->device);
 	u32 in[MLX5_ST_SZ_DW(dealloc_q_counter_in)] = {};
 
 	if (!counter->id)
 		return 0;
 
+	WARN_ON(!xa_empty(&mcounter->qpn_opfc_xa));
+	mlx5r_fs_destroy_fcs(dev, counter);
 	MLX5_SET(dealloc_q_counter_in, in, opcode,
 		 MLX5_CMD_OP_DEALLOC_Q_COUNTER);
 	MLX5_SET(dealloc_q_counter_in, in, counter_set_id, counter->id);
@@ -585,8 +633,14 @@ static int mlx5_ib_counter_bind_qp(struct rdma_counter *counter,
 	if (err)
 		goto fail_set_counter;
 
+	err = mlx5r_fs_bind_op_fc(qp, counter, port);
+	if (err)
+		goto fail_bind_op_fc;
+
 	return 0;
 
+fail_bind_op_fc:
+	mlx5_ib_qp_set_counter(qp, NULL);
 fail_set_counter:
 	mlx5_ib_counter_dealloc(counter);
 	counter->id = 0;
@@ -596,7 +650,20 @@ static int mlx5_ib_counter_bind_qp(struct rdma_counter *counter,
 
 static int mlx5_ib_counter_unbind_qp(struct ib_qp *qp, u32 port)
 {
-	return mlx5_ib_qp_set_counter(qp, NULL);
+	struct rdma_counter *counter = qp->counter;
+	int err;
+
+	mlx5r_fs_unbind_op_fc(qp, counter);
+
+	err = mlx5_ib_qp_set_counter(qp, NULL);
+	if (err)
+		goto fail_set_counter;
+
+	return 0;
+
+fail_set_counter:
+	mlx5r_fs_bind_op_fc(qp, counter, port);
+	return err;
 }
 
 static void mlx5_ib_fill_counters(struct mlx5_ib_dev *dev,
@@ -789,9 +856,8 @@ static int __mlx5_ib_alloc_counters(struct mlx5_ib_dev *dev,
  * was already created, if both conditions are met return true and the counter
  * else return false.
  */
-static bool mlx5r_is_opfc_shared_and_in_use(struct mlx5_ib_op_fc *opfcs,
-					    u32 type,
-					    struct mlx5_ib_op_fc **opfc)
+bool mlx5r_is_opfc_shared_and_in_use(struct mlx5_ib_op_fc *opfcs, u32 type,
+				     struct mlx5_ib_op_fc **opfc)
 {
 	u32 shared_fc_type;
 
@@ -808,6 +874,18 @@ static bool mlx5r_is_opfc_shared_and_in_use(struct mlx5_ib_op_fc *opfcs,
 	case MLX5_IB_OPCOUNTER_RDMA_RX_BYTES:
 		shared_fc_type = MLX5_IB_OPCOUNTER_RDMA_RX_PACKETS;
 		break;
+	case MLX5_IB_OPCOUNTER_RDMA_TX_PACKETS_PER_QP:
+		shared_fc_type = MLX5_IB_OPCOUNTER_RDMA_TX_BYTES_PER_QP;
+		break;
+	case MLX5_IB_OPCOUNTER_RDMA_TX_BYTES_PER_QP:
+		shared_fc_type = MLX5_IB_OPCOUNTER_RDMA_TX_PACKETS_PER_QP;
+		break;
+	case MLX5_IB_OPCOUNTER_RDMA_RX_PACKETS_PER_QP:
+		shared_fc_type = MLX5_IB_OPCOUNTER_RDMA_RX_BYTES_PER_QP;
+		break;
+	case MLX5_IB_OPCOUNTER_RDMA_RX_BYTES_PER_QP:
+		shared_fc_type = MLX5_IB_OPCOUNTER_RDMA_RX_PACKETS_PER_QP;
+		break;
 	default:
 		return false;
 	}
@@ -1105,7 +1183,12 @@ static int mlx5_ib_modify_stat(struct ib_device *device, u32 port,
 	return 0;
 }
 
-static void mlx5_ib_counter_init(struct rdma_counter *counter) {}
+static void mlx5_ib_counter_init(struct rdma_counter *counter)
+{
+	struct mlx5_rdma_counter *mcounter = to_mcounter(counter);
+
+	xa_init(&mcounter->qpn_opfc_xa);
+}
 
 static const struct ib_device_ops hw_stats_ops = {
 	.alloc_hw_port_stats = mlx5_ib_alloc_hw_port_stats,
diff --git a/drivers/infiniband/hw/mlx5/counters.h b/drivers/infiniband/hw/mlx5/counters.h
index f153901a43be..4c2421bcf876 100644
--- a/drivers/infiniband/hw/mlx5/counters.h
+++ b/drivers/infiniband/hw/mlx5/counters.h
@@ -9,8 +9,15 @@
 #include "mlx5_ib.h"
 
 
+struct mlx5_per_qp_opfc {
+	struct mlx5_ib_op_fc opfcs[MLX5_IB_OPCOUNTER_MAX];
+};
+
 struct mlx5_rdma_counter {
 	struct rdma_counter rdma_counter;
+
+	struct mlx5_fc *fc[MLX5_IB_OPCOUNTER_MAX];
+	struct xarray qpn_opfc_xa;
 };
 
 static inline struct mlx5_rdma_counter *
@@ -25,4 +32,6 @@ void mlx5_ib_counters_clear_description(struct ib_counters *counters);
 int mlx5_ib_flow_counters_set_data(struct ib_counters *ibcounters,
 				   struct mlx5_ib_create_flow *ucmd);
 u16 mlx5_ib_get_counters_id(struct mlx5_ib_dev *dev, u32 port_num);
+bool mlx5r_is_opfc_shared_and_in_use(struct mlx5_ib_op_fc *opfcs, u32 type,
+				     struct mlx5_ib_op_fc **opfc);
 #endif /* _MLX5_IB_COUNTERS_H */
diff --git a/drivers/infiniband/hw/mlx5/fs.c b/drivers/infiniband/hw/mlx5/fs.c
index 93b229e9aab3..3069090874a1 100644
--- a/drivers/infiniband/hw/mlx5/fs.c
+++ b/drivers/infiniband/hw/mlx5/fs.c
@@ -800,12 +800,17 @@ static struct mlx5_ib_flow_prio *get_flow_table(struct mlx5_ib_dev *dev,
 }
 
 enum {
+	RDMA_RX_ECN_OPCOUNTER_PER_QP_PRIO,
+	RDMA_RX_CNP_OPCOUNTER_PER_QP_PRIO,
+	RDMA_RX_PKTS_BYTES_OPCOUNTER_PER_QP_PRIO,
 	RDMA_RX_ECN_OPCOUNTER_PRIO,
 	RDMA_RX_CNP_OPCOUNTER_PRIO,
 	RDMA_RX_PKTS_BYTES_OPCOUNTER_PRIO,
 };
 
 enum {
+	RDMA_TX_CNP_OPCOUNTER_PER_QP_PRIO,
+	RDMA_TX_PKTS_BYTES_OPCOUNTER_PER_QP_PRIO,
 	RDMA_TX_CNP_OPCOUNTER_PRIO,
 	RDMA_TX_PKTS_BYTES_OPCOUNTER_PRIO,
 };
@@ -887,6 +892,12 @@ static struct mlx5_ib_flow_prio *get_opfc_prio(struct mlx5_ib_dev *dev,
 	case MLX5_IB_OPCOUNTER_RDMA_RX_BYTES:
 		prio_type = MLX5_IB_OPCOUNTER_RDMA_RX_PACKETS;
 		break;
+	case MLX5_IB_OPCOUNTER_RDMA_TX_BYTES_PER_QP:
+		prio_type = MLX5_IB_OPCOUNTER_RDMA_TX_PACKETS_PER_QP;
+		break;
+	case MLX5_IB_OPCOUNTER_RDMA_RX_BYTES_PER_QP:
+		prio_type = MLX5_IB_OPCOUNTER_RDMA_RX_PACKETS_PER_QP;
+		break;
 	default:
 		prio_type = type;
 	}
@@ -894,6 +905,315 @@ static struct mlx5_ib_flow_prio *get_opfc_prio(struct mlx5_ib_dev *dev,
 	return &dev->flow_db->opfcs[prio_type];
 }
 
+static void put_per_qp_prio(struct mlx5_ib_dev *dev,
+			    enum mlx5_ib_optional_counter_type type)
+{
+	enum mlx5_ib_optional_counter_type per_qp_type;
+	struct mlx5_ib_flow_prio *prio;
+
+	switch (type) {
+	case MLX5_IB_OPCOUNTER_CC_RX_CE_PKTS:
+		per_qp_type = MLX5_IB_OPCOUNTER_CC_RX_CE_PKTS_PER_QP;
+		break;
+	case MLX5_IB_OPCOUNTER_CC_RX_CNP_PKTS:
+		per_qp_type = MLX5_IB_OPCOUNTER_CC_RX_CNP_PKTS_PER_QP;
+		break;
+	case MLX5_IB_OPCOUNTER_CC_TX_CNP_PKTS:
+		per_qp_type = MLX5_IB_OPCOUNTER_CC_TX_CNP_PKTS_PER_QP;
+		break;
+	case MLX5_IB_OPCOUNTER_RDMA_TX_PACKETS:
+		per_qp_type = MLX5_IB_OPCOUNTER_RDMA_TX_PACKETS_PER_QP;
+		break;
+	case MLX5_IB_OPCOUNTER_RDMA_TX_BYTES:
+		per_qp_type = MLX5_IB_OPCOUNTER_RDMA_TX_BYTES_PER_QP;
+		break;
+	case MLX5_IB_OPCOUNTER_RDMA_RX_PACKETS:
+		per_qp_type = MLX5_IB_OPCOUNTER_RDMA_RX_PACKETS_PER_QP;
+		break;
+	case MLX5_IB_OPCOUNTER_RDMA_RX_BYTES:
+		per_qp_type = MLX5_IB_OPCOUNTER_RDMA_RX_BYTES_PER_QP;
+		break;
+	default:
+		return;
+	}
+
+	prio = get_opfc_prio(dev, per_qp_type);
+	put_flow_table(dev, prio, true);
+}
+
+static int get_per_qp_prio(struct mlx5_ib_dev *dev,
+			   enum mlx5_ib_optional_counter_type type)
+{
+	enum mlx5_ib_optional_counter_type per_qp_type;
+	enum mlx5_flow_namespace_type fn_type;
+	struct mlx5_flow_namespace *ns;
+	struct mlx5_ib_flow_prio *prio;
+	int priority;
+
+	switch (type) {
+	case MLX5_IB_OPCOUNTER_CC_RX_CE_PKTS:
+		fn_type = MLX5_FLOW_NAMESPACE_RDMA_RX_COUNTERS;
+		priority = RDMA_RX_ECN_OPCOUNTER_PER_QP_PRIO;
+		per_qp_type = MLX5_IB_OPCOUNTER_CC_RX_CE_PKTS_PER_QP;
+		break;
+	case MLX5_IB_OPCOUNTER_CC_RX_CNP_PKTS:
+		fn_type = MLX5_FLOW_NAMESPACE_RDMA_RX_COUNTERS;
+		priority = RDMA_RX_CNP_OPCOUNTER_PER_QP_PRIO;
+		per_qp_type = MLX5_IB_OPCOUNTER_CC_RX_CNP_PKTS_PER_QP;
+		break;
+	case MLX5_IB_OPCOUNTER_CC_TX_CNP_PKTS:
+		fn_type = MLX5_FLOW_NAMESPACE_RDMA_TX_COUNTERS;
+		priority = RDMA_TX_CNP_OPCOUNTER_PER_QP_PRIO;
+		per_qp_type = MLX5_IB_OPCOUNTER_CC_TX_CNP_PKTS_PER_QP;
+		break;
+	case MLX5_IB_OPCOUNTER_RDMA_TX_PACKETS:
+		fn_type = MLX5_FLOW_NAMESPACE_RDMA_TX_COUNTERS;
+		priority = RDMA_TX_PKTS_BYTES_OPCOUNTER_PER_QP_PRIO;
+		per_qp_type = MLX5_IB_OPCOUNTER_RDMA_TX_PACKETS_PER_QP;
+		break;
+	case MLX5_IB_OPCOUNTER_RDMA_TX_BYTES:
+		fn_type = MLX5_FLOW_NAMESPACE_RDMA_TX_COUNTERS;
+		priority = RDMA_TX_PKTS_BYTES_OPCOUNTER_PER_QP_PRIO;
+		per_qp_type = MLX5_IB_OPCOUNTER_RDMA_TX_BYTES_PER_QP;
+		break;
+	case MLX5_IB_OPCOUNTER_RDMA_RX_PACKETS:
+		fn_type = MLX5_FLOW_NAMESPACE_RDMA_RX_COUNTERS;
+		priority = RDMA_RX_PKTS_BYTES_OPCOUNTER_PER_QP_PRIO;
+		per_qp_type = MLX5_IB_OPCOUNTER_RDMA_RX_PACKETS_PER_QP;
+		break;
+	case MLX5_IB_OPCOUNTER_RDMA_RX_BYTES:
+		fn_type = MLX5_FLOW_NAMESPACE_RDMA_RX_COUNTERS;
+		priority = RDMA_RX_PKTS_BYTES_OPCOUNTER_PER_QP_PRIO;
+		per_qp_type = MLX5_IB_OPCOUNTER_RDMA_RX_BYTES_PER_QP;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	ns = mlx5_get_flow_namespace(dev->mdev, fn_type);
+	if (!ns)
+		return -EOPNOTSUPP;
+
+	prio = get_opfc_prio(dev, per_qp_type);
+	if (prio->flow_table)
+		return 0;
+
+	prio = _get_prio(dev, ns, prio, priority, MLX5_FS_MAX_POOL_SIZE, 1, 0, 0);
+	if (IS_ERR(prio))
+		return PTR_ERR(prio);
+
+	prio->refcount = 1;
+
+	return 0;
+}
+
+static struct mlx5_per_qp_opfc *
+get_per_qp_opfc(struct mlx5_rdma_counter *mcounter, u32 qp_num, bool *new)
+{
+	struct mlx5_per_qp_opfc *per_qp_opfc;
+
+	*new = false;
+
+	per_qp_opfc = xa_load(&mcounter->qpn_opfc_xa, qp_num);
+	if (per_qp_opfc)
+		return per_qp_opfc;
+	per_qp_opfc = kzalloc(sizeof(*per_qp_opfc), GFP_KERNEL);
+
+	if (!per_qp_opfc)
+		return NULL;
+
+	*new = true;
+	return per_qp_opfc;
+}
+
+static int add_op_fc_rules(struct mlx5_ib_dev *dev,
+			   struct mlx5_rdma_counter *mcounter,
+			   struct mlx5_per_qp_opfc *per_qp_opfc,
+			   struct mlx5_ib_flow_prio *prio,
+			   enum mlx5_ib_optional_counter_type type,
+			   u32 qp_num, u32 port_num)
+{
+	struct mlx5_ib_op_fc *opfc = &per_qp_opfc->opfcs[type], *in_use_opfc;
+	struct mlx5_flow_act flow_act = {};
+	struct mlx5_flow_destination dst;
+	struct mlx5_flow_spec *spec;
+	int i, err, spec_num;
+	bool is_tx;
+
+	if (opfc->fc)
+		return -EEXIST;
+
+	if (mlx5r_is_opfc_shared_and_in_use(per_qp_opfc->opfcs, type,
+					    &in_use_opfc)) {
+		opfc->fc = in_use_opfc->fc;
+		opfc->rule[0] = in_use_opfc->rule[0];
+		return 0;
+	}
+
+	opfc->fc = mcounter->fc[type];
+
+	spec = kcalloc(MAX_OPFC_RULES, sizeof(*spec), GFP_KERNEL);
+	if (!spec) {
+		err = -ENOMEM;
+		goto null_fc;
+	}
+
+	switch (type) {
+	case MLX5_IB_OPCOUNTER_CC_RX_CE_PKTS_PER_QP:
+		if (set_ecn_ce_spec(dev, port_num, &spec[0],
+				    MLX5_FS_IPV4_VERSION) ||
+		    set_ecn_ce_spec(dev, port_num, &spec[1],
+				    MLX5_FS_IPV6_VERSION)) {
+			err = -EOPNOTSUPP;
+			goto free_spec;
+		}
+		spec_num = 2;
+		is_tx = false;
+
+		MLX5_SET_TO_ONES(fte_match_param, spec[1].match_criteria,
+				 misc_parameters.bth_dst_qp);
+		MLX5_SET(fte_match_param, spec[1].match_value,
+			 misc_parameters.bth_dst_qp, qp_num);
+		spec[1].match_criteria_enable |= MLX5_MATCH_MISC_PARAMETERS;
+		break;
+	case MLX5_IB_OPCOUNTER_CC_RX_CNP_PKTS_PER_QP:
+		if (!MLX5_CAP_FLOWTABLE(
+			    dev->mdev,
+			    ft_field_support_2_nic_receive_rdma.bth_opcode) ||
+		    set_cnp_spec(dev, port_num, &spec[0])) {
+			err = -EOPNOTSUPP;
+			goto free_spec;
+		}
+		spec_num = 1;
+		is_tx = false;
+		break;
+	case MLX5_IB_OPCOUNTER_CC_TX_CNP_PKTS_PER_QP:
+		if (!MLX5_CAP_FLOWTABLE(
+			    dev->mdev,
+			    ft_field_support_2_nic_transmit_rdma.bth_opcode) ||
+		    set_cnp_spec(dev, port_num, &spec[0])) {
+			err = -EOPNOTSUPP;
+			goto free_spec;
+		}
+		spec_num = 1;
+		is_tx = true;
+		break;
+	case MLX5_IB_OPCOUNTER_RDMA_TX_PACKETS_PER_QP:
+	case MLX5_IB_OPCOUNTER_RDMA_TX_BYTES_PER_QP:
+		spec_num = 1;
+		is_tx = true;
+		break;
+	case MLX5_IB_OPCOUNTER_RDMA_RX_PACKETS_PER_QP:
+	case MLX5_IB_OPCOUNTER_RDMA_RX_BYTES_PER_QP:
+		spec_num = 1;
+		is_tx = false;
+		break;
+	default:
+		err = -EINVAL;
+		goto free_spec;
+	}
+
+	if (is_tx) {
+		MLX5_SET_TO_ONES(fte_match_param, spec->match_criteria,
+				 misc_parameters.source_sqn);
+		MLX5_SET(fte_match_param, spec->match_value,
+			 misc_parameters.source_sqn, qp_num);
+	} else {
+		MLX5_SET_TO_ONES(fte_match_param, spec->match_criteria,
+				 misc_parameters.bth_dst_qp);
+		MLX5_SET(fte_match_param, spec->match_value,
+			 misc_parameters.bth_dst_qp, qp_num);
+	}
+
+	spec->match_criteria_enable |= MLX5_MATCH_MISC_PARAMETERS;
+
+	dst.type = MLX5_FLOW_DESTINATION_TYPE_COUNTER;
+	dst.counter = opfc->fc;
+
+	flow_act.action =
+		MLX5_FLOW_CONTEXT_ACTION_COUNT | MLX5_FLOW_CONTEXT_ACTION_ALLOW;
+
+	for (i = 0; i < spec_num; i++) {
+		opfc->rule[i] = mlx5_add_flow_rules(prio->flow_table, &spec[i],
+						    &flow_act, &dst, 1);
+		if (IS_ERR(opfc->rule[i])) {
+			err = PTR_ERR(opfc->rule[i]);
+			goto del_rules;
+		}
+	}
+	prio->refcount += spec_num;
+
+	err = xa_err(xa_store(&mcounter->qpn_opfc_xa, qp_num, per_qp_opfc,
+			      GFP_KERNEL));
+	if (err)
+		goto del_rules;
+
+	kfree(spec);
+
+	return 0;
+
+del_rules:
+	while (i--)
+		mlx5_del_flow_rules(opfc->rule[i]);
+	put_flow_table(dev, prio, false);
+free_spec:
+	kfree(spec);
+null_fc:
+	opfc->fc = NULL;
+	return err;
+}
+
+static bool is_fc_shared_and_in_use(struct mlx5_rdma_counter *mcounter,
+				    u32 type, struct mlx5_fc **fc)
+{
+	u32 shared_fc_type;
+
+	switch (type) {
+	case MLX5_IB_OPCOUNTER_RDMA_TX_PACKETS_PER_QP:
+		shared_fc_type = MLX5_IB_OPCOUNTER_RDMA_TX_BYTES_PER_QP;
+		break;
+	case MLX5_IB_OPCOUNTER_RDMA_TX_BYTES_PER_QP:
+		shared_fc_type = MLX5_IB_OPCOUNTER_RDMA_TX_PACKETS_PER_QP;
+		break;
+	case MLX5_IB_OPCOUNTER_RDMA_RX_PACKETS_PER_QP:
+		shared_fc_type = MLX5_IB_OPCOUNTER_RDMA_RX_BYTES_PER_QP;
+		break;
+	case MLX5_IB_OPCOUNTER_RDMA_RX_BYTES_PER_QP:
+		shared_fc_type = MLX5_IB_OPCOUNTER_RDMA_RX_PACKETS_PER_QP;
+		break;
+	default:
+		return false;
+	}
+
+	*fc = mcounter->fc[shared_fc_type];
+	if (!(*fc))
+		return false;
+
+	return true;
+}
+
+void mlx5r_fs_destroy_fcs(struct mlx5_ib_dev *dev,
+			  struct rdma_counter *counter)
+{
+	struct mlx5_rdma_counter *mcounter = to_mcounter(counter);
+	struct mlx5_fc *in_use_fc;
+	int i;
+
+	for (i = MLX5_IB_OPCOUNTER_CC_RX_CE_PKTS_PER_QP;
+	     i <= MLX5_IB_OPCOUNTER_RDMA_RX_BYTES_PER_QP; i++) {
+		if (!mcounter->fc[i])
+			continue;
+
+		if (is_fc_shared_and_in_use(mcounter, i, &in_use_fc)) {
+			mcounter->fc[i] = NULL;
+			continue;
+		}
+
+		mlx5_fc_destroy(dev->mdev, mcounter->fc[i]);
+		mcounter->fc[i] = NULL;
+	}
+}
+
 int mlx5_ib_fs_add_op_fc(struct mlx5_ib_dev *dev, u32 port_num,
 			 struct mlx5_ib_op_fc *opfc,
 			 enum mlx5_ib_optional_counter_type type)
@@ -975,11 +1295,15 @@ int mlx5_ib_fs_add_op_fc(struct mlx5_ib_dev *dev, u32 port_num,
 
 	prio = get_opfc_prio(dev, type);
 	if (!prio->flow_table) {
+		err = get_per_qp_prio(dev, type);
+		if (err)
+			goto free;
+
 		prio = _get_prio(dev, ns, prio, priority,
 				 dev->num_ports * MAX_OPFC_RULES, 1, 0, 0);
 		if (IS_ERR(prio)) {
 			err = PTR_ERR(prio);
-			goto free;
+			goto put_prio;
 		}
 	}
 
@@ -1006,6 +1330,8 @@ int mlx5_ib_fs_add_op_fc(struct mlx5_ib_dev *dev, u32 port_num,
 	for (i -= 1; i >= 0; i--)
 		mlx5_del_flow_rules(opfc->rule[i]);
 	put_flow_table(dev, prio, false);
+put_prio:
+	put_per_qp_prio(dev, type);
 free:
 	kfree(spec);
 	return err;
@@ -1024,6 +1350,106 @@ void mlx5_ib_fs_remove_op_fc(struct mlx5_ib_dev *dev,
 		mlx5_del_flow_rules(opfc->rule[i]);
 		put_flow_table(dev, prio, true);
 	}
+
+	put_per_qp_prio(dev, type);
+}
+
+void mlx5r_fs_unbind_op_fc(struct ib_qp *qp, struct rdma_counter *counter)
+{
+	struct mlx5_rdma_counter *mcounter = to_mcounter(counter);
+	struct mlx5_ib_dev *dev = to_mdev(counter->device);
+	struct mlx5_per_qp_opfc *per_qp_opfc;
+	struct mlx5_ib_op_fc *in_use_opfc;
+	struct mlx5_ib_flow_prio *prio;
+	int i, j;
+
+	per_qp_opfc = xa_load(&mcounter->qpn_opfc_xa, qp->qp_num);
+	if (!per_qp_opfc)
+		return;
+
+	for (i = MLX5_IB_OPCOUNTER_CC_RX_CE_PKTS_PER_QP;
+	     i <= MLX5_IB_OPCOUNTER_RDMA_RX_BYTES_PER_QP; i++) {
+		if (!per_qp_opfc->opfcs[i].fc)
+			continue;
+
+		if (mlx5r_is_opfc_shared_and_in_use(per_qp_opfc->opfcs, i,
+						    &in_use_opfc)) {
+			per_qp_opfc->opfcs[i].fc = NULL;
+			continue;
+		}
+
+		for (j = 0; j < MAX_OPFC_RULES; j++) {
+			if (!per_qp_opfc->opfcs[i].rule[j])
+				continue;
+			mlx5_del_flow_rules(per_qp_opfc->opfcs[i].rule[j]);
+			prio = get_opfc_prio(dev, i);
+			put_flow_table(dev, prio, true);
+		}
+		per_qp_opfc->opfcs[i].fc = NULL;
+	}
+
+	kfree(per_qp_opfc);
+	xa_erase(&mcounter->qpn_opfc_xa, qp->qp_num);
+}
+
+int mlx5r_fs_bind_op_fc(struct ib_qp *qp, struct rdma_counter *counter,
+			u32 port)
+{
+	struct mlx5_rdma_counter *mcounter = to_mcounter(counter);
+	struct mlx5_ib_dev *dev = to_mdev(qp->device);
+	struct mlx5_per_qp_opfc *per_qp_opfc;
+	struct mlx5_ib_flow_prio *prio;
+	struct mlx5_ib_counters *cnts;
+	struct mlx5_ib_op_fc *opfc;
+	struct mlx5_fc *in_use_fc;
+	int i, err, per_qp_type;
+	bool new;
+
+	if (!counter->mode.bind_opcnt)
+		return 0;
+
+	cnts = &dev->port[port - 1].cnts;
+
+	for (i = 0; i <= MLX5_IB_OPCOUNTER_RDMA_RX_BYTES; i++) {
+		opfc = &cnts->opfcs[i];
+		if (!opfc->fc)
+			continue;
+
+		per_qp_type = i + MLX5_IB_OPCOUNTER_CC_RX_CE_PKTS_PER_QP;
+		prio = get_opfc_prio(dev, per_qp_type);
+		WARN_ON(!prio->flow_table);
+
+		if (is_fc_shared_and_in_use(mcounter, per_qp_type, &in_use_fc))
+			mcounter->fc[per_qp_type] = in_use_fc;
+
+		if (!mcounter->fc[per_qp_type]) {
+			mcounter->fc[per_qp_type] = mlx5_fc_create(dev->mdev,
+								   false);
+			if (IS_ERR(mcounter->fc[per_qp_type]))
+				return PTR_ERR(mcounter->fc[per_qp_type]);
+		}
+
+		per_qp_opfc = get_per_qp_opfc(mcounter, qp->qp_num, &new);
+		if (!per_qp_opfc) {
+			err = -ENOMEM;
+			goto free_fc;
+		}
+		err = add_op_fc_rules(dev, mcounter, per_qp_opfc, prio,
+				      per_qp_type, qp->qp_num, port);
+		if (err)
+			goto del_rules;
+	}
+
+	return 0;
+
+del_rules:
+	mlx5r_fs_unbind_op_fc(qp, counter);
+	if (new)
+		kfree(per_qp_opfc);
+free_fc:
+	if (xa_empty(&mcounter->qpn_opfc_xa))
+		mlx5r_fs_destroy_fcs(dev, counter);
+	return err;
 }
 
 static void set_underlay_qp(struct mlx5_ib_dev *dev,
diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
index 24b18942762c..84a1f07d46a7 100644
--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -299,6 +299,14 @@ enum mlx5_ib_optional_counter_type {
 	MLX5_IB_OPCOUNTER_RDMA_RX_PACKETS,
 	MLX5_IB_OPCOUNTER_RDMA_RX_BYTES,
 
+	MLX5_IB_OPCOUNTER_CC_RX_CE_PKTS_PER_QP,
+	MLX5_IB_OPCOUNTER_CC_RX_CNP_PKTS_PER_QP,
+	MLX5_IB_OPCOUNTER_CC_TX_CNP_PKTS_PER_QP,
+	MLX5_IB_OPCOUNTER_RDMA_TX_PACKETS_PER_QP,
+	MLX5_IB_OPCOUNTER_RDMA_TX_BYTES_PER_QP,
+	MLX5_IB_OPCOUNTER_RDMA_RX_PACKETS_PER_QP,
+	MLX5_IB_OPCOUNTER_RDMA_RX_BYTES_PER_QP,
+
 	MLX5_IB_OPCOUNTER_MAX,
 };
 
@@ -891,6 +899,14 @@ void mlx5_ib_fs_remove_op_fc(struct mlx5_ib_dev *dev,
 			     struct mlx5_ib_op_fc *opfc,
 			     enum mlx5_ib_optional_counter_type type);
 
+int mlx5r_fs_bind_op_fc(struct ib_qp *qp, struct rdma_counter *counter,
+			u32 port);
+
+void mlx5r_fs_unbind_op_fc(struct ib_qp *qp, struct rdma_counter *counter);
+
+void mlx5r_fs_destroy_fcs(struct mlx5_ib_dev *dev,
+			  struct rdma_counter *counter);
+
 struct mlx5_ib_multiport_info;
 
 struct mlx5_ib_multiport {
diff --git a/include/linux/mlx5/device.h b/include/linux/mlx5/device.h
index 63f0d9fb94b4..344124644697 100644
--- a/include/linux/mlx5/device.h
+++ b/include/linux/mlx5/device.h
@@ -1532,8 +1532,8 @@ static inline u16 mlx5_to_sw_pkey_sz(int pkey_sz)
 	return MLX5_MIN_PKEY_TABLE_SIZE << pkey_sz;
 }
 
-#define MLX5_RDMA_RX_NUM_COUNTERS_PRIOS 3
-#define MLX5_RDMA_TX_NUM_COUNTERS_PRIOS 2
+#define MLX5_RDMA_RX_NUM_COUNTERS_PRIOS 6
+#define MLX5_RDMA_TX_NUM_COUNTERS_PRIOS 4
 #define MLX5_BY_PASS_NUM_REGULAR_PRIOS 16
 #define MLX5_BY_PASS_NUM_DONT_TRAP_PRIOS 16
 #define MLX5_BY_PASS_NUM_MULTICAST_PRIOS 1
-- 
2.48.1


