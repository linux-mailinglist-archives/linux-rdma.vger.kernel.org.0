Return-Path: <linux-rdma+bounces-8665-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39F2AA5F770
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Mar 2025 15:19:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D1CD3BD7BA
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Mar 2025 14:19:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55FDF267F48;
	Thu, 13 Mar 2025 14:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zplx73yy"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13653267F42;
	Thu, 13 Mar 2025 14:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741875553; cv=none; b=BhXSxQKsTRsXlp8IGhLP7iOIeJXmPNppL+eoOGMGHnL8pNwVUHQ8dFdwCcdQRfZLSqiXP+7mvNAhPjSmb/TIt6c3bvXT5K0va2cnGDrhd7tlvuPJ9z/SHwV5HjGd08BkeXQjiO4vpPA0wBQN7pIEtnTvFQyEPEUnujARyGE+/uU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741875553; c=relaxed/simple;
	bh=VFhiaTS9BnSbFxwkJ6xkz3ZMYx0zi10bM1slqQyyhmU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CXD6F0yp/cY4A1xevnmh1uBndWpF2RZr+9omIwp8NfCfTJr9sB+XxAZDGcZVtJ2uOjJNbAXjZJ3ZVizb5uo5W7+lYR6ipZAvzGZ82P4wtx6EMFvcJiYcsJKVlBst7KfhaqKjL/i+8WftR6iRCddqZnxmjDFjFyrilusuFNbzqGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zplx73yy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6121DC4CEE5;
	Thu, 13 Mar 2025 14:19:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741875552;
	bh=VFhiaTS9BnSbFxwkJ6xkz3ZMYx0zi10bM1slqQyyhmU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Zplx73yy//AwiJ10MQw0Ok8TypZfGKwQvF74gNg8ro/p2mEe8ojkryMkYVcQBZJud
	 wKc7vD0WH7kTxMqFoVaEbXYOVo9jWpJHfKZPTDLZClFLAOM23bWqDhvzIyshIYLDiJ
	 3T0M8Twwlcji4cofaToeLpFDv/Lx9CDB5JEGhhXlaIDRAIPkJ8ezCT5NMGgXx9iFIB
	 oeDFvVABDJe5LhevlxJdyMCDWn1gu9nq6ZMnmcNGIUQFdedivS27aWOOnV3IMw7eUG
	 rNk+JJDCKLabOzo/g1fBLlnGg5IZuNr67YrS3s1marYx/faDxmFfy1WGfhpEaf+Ha+
	 u/yObgmSAhFkA==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Patrisious Haddad <phaddad@nvidia.com>,
	linux-rdma@vger.kernel.org,
	Mark Bloch <mbloch@nvidia.com>,
	netdev@vger.kernel.org,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH rdma-next v1 1/6] RDMA/mlx5: Add optional counters for RDMA_TX/RX_packets/bytes
Date: Thu, 13 Mar 2025 16:18:41 +0200
Message-ID: <9f2753ad636f21704416df64b47395c8991d1123.1741875070.git.leon@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1741875070.git.leon@kernel.org>
References: <cover.1741875070.git.leon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Patrisious Haddad <phaddad@nvidia.com>

Add the following optional counters:
rdma_tx_packets,rdma_rx_bytes,rdma_rx_packets,rdma_tx_bytes.

Which counts all RDMA packets/bytes sent and received per link.

Note that since each direction packet and byte counter are shared,
the counter is only reset when both counters of that direction
are removed. But from user-perspective each can be enabled/disabled separately.

The counters can be enabled using:
sudo rdma stat set link rocep8s0f0/1 optional-counters rdma_tx_packets
And can be seen using:
rdma stat -j show link rocep8s0f0/1

Signed-off-by: Patrisious Haddad <phaddad@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/counters.c | 86 ++++++++++++++++++++++++++-
 drivers/infiniband/hw/mlx5/fs.c       | 46 +++++++++++++-
 drivers/infiniband/hw/mlx5/mlx5_ib.h  |  4 ++
 include/linux/mlx5/device.h           |  4 +-
 4 files changed, 133 insertions(+), 7 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/counters.c b/drivers/infiniband/hw/mlx5/counters.c
index 4f6c1968a2ee..e2a54c1dbc7a 100644
--- a/drivers/infiniband/hw/mlx5/counters.c
+++ b/drivers/infiniband/hw/mlx5/counters.c
@@ -140,6 +140,13 @@ static const struct mlx5_ib_counter rdmatx_cnp_op_cnts[] = {
 	INIT_OP_COUNTER(cc_tx_cnp_pkts, CC_TX_CNP_PKTS),
 };
 
+static const struct mlx5_ib_counter packets_op_cnts[] = {
+	INIT_OP_COUNTER(rdma_tx_packets, RDMA_TX_PACKETS),
+	INIT_OP_COUNTER(rdma_tx_bytes, RDMA_TX_BYTES),
+	INIT_OP_COUNTER(rdma_rx_packets, RDMA_RX_PACKETS),
+	INIT_OP_COUNTER(rdma_rx_bytes, RDMA_RX_BYTES),
+};
+
 static int mlx5_ib_read_counters(struct ib_counters *counters,
 				 struct ib_counters_read_attr *read_attr,
 				 struct uverbs_attr_bundle *attrs)
@@ -427,6 +434,15 @@ static int do_get_hw_stats(struct ib_device *ibdev,
 	return num_counters;
 }
 
+static bool is_rdma_bytes_counter(u32 type)
+{
+	if (type == MLX5_IB_OPCOUNTER_RDMA_TX_BYTES ||
+	    type == MLX5_IB_OPCOUNTER_RDMA_RX_BYTES)
+		return true;
+
+	return false;
+}
+
 static int do_get_op_stat(struct ib_device *ibdev,
 			  struct rdma_hw_stats *stats,
 			  u32 port_num, int index)
@@ -434,7 +450,7 @@ static int do_get_op_stat(struct ib_device *ibdev,
 	struct mlx5_ib_dev *dev = to_mdev(ibdev);
 	const struct mlx5_ib_counters *cnts;
 	const struct mlx5_ib_op_fc *opfcs;
-	u64 packets = 0, bytes;
+	u64 packets, bytes;
 	u32 type;
 	int ret;
 
@@ -453,8 +469,11 @@ static int do_get_op_stat(struct ib_device *ibdev,
 	if (ret)
 		return ret;
 
+	if (is_rdma_bytes_counter(type))
+		stats->value[index] = bytes;
+	else
+		stats->value[index] = packets;
 out:
-	stats->value[index] = packets;
 	return index;
 }
 
@@ -677,6 +696,12 @@ static void mlx5_ib_fill_counters(struct mlx5_ib_dev *dev,
 			descs[j].priv = &rdmatx_cnp_op_cnts[i].type;
 		}
 	}
+
+	for (i = 0; i < ARRAY_SIZE(packets_op_cnts); i++, j++) {
+		descs[j].name = packets_op_cnts[i].name;
+		descs[j].flags |= IB_STAT_FLAG_OPTIONAL;
+		descs[j].priv = &packets_op_cnts[i].type;
+	}
 }
 
 
@@ -727,6 +752,8 @@ static int __mlx5_ib_alloc_counters(struct mlx5_ib_dev *dev,
 
 	num_op_counters = ARRAY_SIZE(basic_op_cnts);
 
+	num_op_counters += ARRAY_SIZE(packets_op_cnts);
+
 	if (MLX5_CAP_FLOWTABLE(dev->mdev,
 			       ft_field_support_2_nic_receive_rdma.bth_opcode))
 		num_op_counters += ARRAY_SIZE(rdmarx_cnp_op_cnts);
@@ -756,10 +783,47 @@ static int __mlx5_ib_alloc_counters(struct mlx5_ib_dev *dev,
 	return -ENOMEM;
 }
 
+/*
+ * Checks if the given flow counter type should be sharing the same flow counter
+ * with another type and if it should, checks if that other type flow counter
+ * was already created, if both conditions are met return true and the counter
+ * else return false.
+ */
+static bool mlx5r_is_opfc_shared_and_in_use(struct mlx5_ib_op_fc *opfcs,
+					    u32 type,
+					    struct mlx5_ib_op_fc **opfc)
+{
+	u32 shared_fc_type;
+
+	switch (type) {
+	case MLX5_IB_OPCOUNTER_RDMA_TX_PACKETS:
+		shared_fc_type = MLX5_IB_OPCOUNTER_RDMA_TX_BYTES;
+		break;
+	case MLX5_IB_OPCOUNTER_RDMA_TX_BYTES:
+		shared_fc_type = MLX5_IB_OPCOUNTER_RDMA_TX_PACKETS;
+		break;
+	case MLX5_IB_OPCOUNTER_RDMA_RX_PACKETS:
+		shared_fc_type = MLX5_IB_OPCOUNTER_RDMA_RX_BYTES;
+		break;
+	case MLX5_IB_OPCOUNTER_RDMA_RX_BYTES:
+		shared_fc_type = MLX5_IB_OPCOUNTER_RDMA_RX_PACKETS;
+		break;
+	default:
+		return false;
+	}
+
+	*opfc = &opfcs[shared_fc_type];
+	if (!(*opfc)->fc)
+		return false;
+
+	return true;
+}
+
 static void mlx5_ib_dealloc_counters(struct mlx5_ib_dev *dev)
 {
 	u32 in[MLX5_ST_SZ_DW(dealloc_q_counter_in)] = {};
 	int num_cnt_ports = dev->num_ports;
+	struct mlx5_ib_op_fc *in_use_opfc;
 	int i, j;
 
 	if (is_mdev_switchdev_mode(dev->mdev))
@@ -781,11 +845,16 @@ static void mlx5_ib_dealloc_counters(struct mlx5_ib_dev *dev)
 			if (!dev->port[i].cnts.opfcs[j].fc)
 				continue;
 
+			if (mlx5r_is_opfc_shared_and_in_use(
+				    dev->port[i].cnts.opfcs, j, &in_use_opfc))
+				goto skip;
+
 			if (IS_ENABLED(CONFIG_INFINIBAND_USER_ACCESS))
 				mlx5_ib_fs_remove_op_fc(dev,
 					&dev->port[i].cnts.opfcs[j], j);
 			mlx5_fc_destroy(dev->mdev,
 					dev->port[i].cnts.opfcs[j].fc);
+skip:
 			dev->port[i].cnts.opfcs[j].fc = NULL;
 		}
 	}
@@ -979,8 +1048,8 @@ static int mlx5_ib_modify_stat(struct ib_device *device, u32 port,
 			       unsigned int index, bool enable)
 {
 	struct mlx5_ib_dev *dev = to_mdev(device);
+	struct mlx5_ib_op_fc *opfc, *in_use_opfc;
 	struct mlx5_ib_counters *cnts;
-	struct mlx5_ib_op_fc *opfc;
 	u32 num_hw_counters, type;
 	int ret;
 
@@ -1004,6 +1073,13 @@ static int mlx5_ib_modify_stat(struct ib_device *device, u32 port,
 		if (opfc->fc)
 			return -EEXIST;
 
+		if (mlx5r_is_opfc_shared_and_in_use(cnts->opfcs, type,
+						    &in_use_opfc)) {
+			opfc->fc = in_use_opfc->fc;
+			opfc->rule[0] = in_use_opfc->rule[0];
+			return 0;
+		}
+
 		opfc->fc = mlx5_fc_create(dev->mdev, false);
 		if (IS_ERR(opfc->fc))
 			return PTR_ERR(opfc->fc);
@@ -1019,8 +1095,12 @@ static int mlx5_ib_modify_stat(struct ib_device *device, u32 port,
 	if (!opfc->fc)
 		return -EINVAL;
 
+	if (mlx5r_is_opfc_shared_and_in_use(cnts->opfcs, type, &in_use_opfc))
+		goto out;
+
 	mlx5_ib_fs_remove_op_fc(dev, opfc, type);
 	mlx5_fc_destroy(dev->mdev, opfc->fc);
+out:
 	opfc->fc = NULL;
 	return 0;
 }
diff --git a/drivers/infiniband/hw/mlx5/fs.c b/drivers/infiniband/hw/mlx5/fs.c
index 6ae2801fa13f..93b229e9aab3 100644
--- a/drivers/infiniband/hw/mlx5/fs.c
+++ b/drivers/infiniband/hw/mlx5/fs.c
@@ -802,10 +802,12 @@ static struct mlx5_ib_flow_prio *get_flow_table(struct mlx5_ib_dev *dev,
 enum {
 	RDMA_RX_ECN_OPCOUNTER_PRIO,
 	RDMA_RX_CNP_OPCOUNTER_PRIO,
+	RDMA_RX_PKTS_BYTES_OPCOUNTER_PRIO,
 };
 
 enum {
 	RDMA_TX_CNP_OPCOUNTER_PRIO,
+	RDMA_TX_PKTS_BYTES_OPCOUNTER_PRIO,
 };
 
 static int set_vhca_port_spec(struct mlx5_ib_dev *dev, u32 port_num,
@@ -869,6 +871,29 @@ static int set_cnp_spec(struct mlx5_ib_dev *dev, u32 port_num,
 	return 0;
 }
 
+/* Returns the prio we should use for the given optional counter type,
+ * whereas for bytes type we use the packet type, since they share the same
+ * resources.
+ */
+static struct mlx5_ib_flow_prio *get_opfc_prio(struct mlx5_ib_dev *dev,
+					       u32 type)
+{
+	u32 prio_type;
+
+	switch (type) {
+	case MLX5_IB_OPCOUNTER_RDMA_TX_BYTES:
+		prio_type = MLX5_IB_OPCOUNTER_RDMA_TX_PACKETS;
+		break;
+	case MLX5_IB_OPCOUNTER_RDMA_RX_BYTES:
+		prio_type = MLX5_IB_OPCOUNTER_RDMA_RX_PACKETS;
+		break;
+	default:
+		prio_type = type;
+	}
+
+	return &dev->flow_db->opfcs[prio_type];
+}
+
 int mlx5_ib_fs_add_op_fc(struct mlx5_ib_dev *dev, u32 port_num,
 			 struct mlx5_ib_op_fc *opfc,
 			 enum mlx5_ib_optional_counter_type type)
@@ -923,6 +948,20 @@ int mlx5_ib_fs_add_op_fc(struct mlx5_ib_dev *dev, u32 port_num,
 		priority = RDMA_TX_CNP_OPCOUNTER_PRIO;
 		break;
 
+	case MLX5_IB_OPCOUNTER_RDMA_TX_PACKETS:
+	case MLX5_IB_OPCOUNTER_RDMA_TX_BYTES:
+		spec_num = 1;
+		fn_type = MLX5_FLOW_NAMESPACE_RDMA_TX_COUNTERS;
+		priority = RDMA_TX_PKTS_BYTES_OPCOUNTER_PRIO;
+		break;
+
+	case MLX5_IB_OPCOUNTER_RDMA_RX_PACKETS:
+	case MLX5_IB_OPCOUNTER_RDMA_RX_BYTES:
+		spec_num = 1;
+		fn_type = MLX5_FLOW_NAMESPACE_RDMA_RX_COUNTERS;
+		priority = RDMA_RX_PKTS_BYTES_OPCOUNTER_PRIO;
+		break;
+
 	default:
 		err = -EOPNOTSUPP;
 		goto free;
@@ -934,7 +973,7 @@ int mlx5_ib_fs_add_op_fc(struct mlx5_ib_dev *dev, u32 port_num,
 		goto free;
 	}
 
-	prio = &dev->flow_db->opfcs[type];
+	prio = get_opfc_prio(dev, type);
 	if (!prio->flow_table) {
 		prio = _get_prio(dev, ns, prio, priority,
 				 dev->num_ports * MAX_OPFC_RULES, 1, 0, 0);
@@ -976,11 +1015,14 @@ void mlx5_ib_fs_remove_op_fc(struct mlx5_ib_dev *dev,
 			     struct mlx5_ib_op_fc *opfc,
 			     enum mlx5_ib_optional_counter_type type)
 {
+	struct mlx5_ib_flow_prio *prio;
 	int i;
 
+	prio = get_opfc_prio(dev, type);
+
 	for (i = 0; i < MAX_OPFC_RULES && opfc->rule[i]; i++) {
 		mlx5_del_flow_rules(opfc->rule[i]);
-		put_flow_table(dev, &dev->flow_db->opfcs[type], true);
+		put_flow_table(dev, prio, true);
 	}
 }
 
diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
index ccaaef20f50d..26397eb08684 100644
--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -294,6 +294,10 @@ enum mlx5_ib_optional_counter_type {
 	MLX5_IB_OPCOUNTER_CC_RX_CE_PKTS,
 	MLX5_IB_OPCOUNTER_CC_RX_CNP_PKTS,
 	MLX5_IB_OPCOUNTER_CC_TX_CNP_PKTS,
+	MLX5_IB_OPCOUNTER_RDMA_TX_PACKETS,
+	MLX5_IB_OPCOUNTER_RDMA_TX_BYTES,
+	MLX5_IB_OPCOUNTER_RDMA_RX_PACKETS,
+	MLX5_IB_OPCOUNTER_RDMA_RX_BYTES,
 
 	MLX5_IB_OPCOUNTER_MAX,
 };
diff --git a/include/linux/mlx5/device.h b/include/linux/mlx5/device.h
index 8fe56d0362c6..63f0d9fb94b4 100644
--- a/include/linux/mlx5/device.h
+++ b/include/linux/mlx5/device.h
@@ -1532,8 +1532,8 @@ static inline u16 mlx5_to_sw_pkey_sz(int pkey_sz)
 	return MLX5_MIN_PKEY_TABLE_SIZE << pkey_sz;
 }
 
-#define MLX5_RDMA_RX_NUM_COUNTERS_PRIOS 2
-#define MLX5_RDMA_TX_NUM_COUNTERS_PRIOS 1
+#define MLX5_RDMA_RX_NUM_COUNTERS_PRIOS 3
+#define MLX5_RDMA_TX_NUM_COUNTERS_PRIOS 2
 #define MLX5_BY_PASS_NUM_REGULAR_PRIOS 16
 #define MLX5_BY_PASS_NUM_DONT_TRAP_PRIOS 16
 #define MLX5_BY_PASS_NUM_MULTICAST_PRIOS 1
-- 
2.48.1


