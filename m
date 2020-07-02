Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7517C211DE8
	for <lists+linux-rdma@lfdr.de>; Thu,  2 Jul 2020 10:18:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726819AbgGBIS2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 2 Jul 2020 04:18:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:46400 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726042AbgGBIS2 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 2 Jul 2020 04:18:28 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 55D7420772;
        Thu,  2 Jul 2020 08:18:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593677905;
        bh=mEDMR/agmXPwPGO29dQ2kgWvIx+qOD2PxwGt2q86XbY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jjerVtxgAAIsjlXeIr0we+wZgBzm+x/D0LJxcczYznHIo4K+wkwaWocbPcf+d8gsn
         uyc6b8gryfLbF3gg95qpINNnFuFRvPn6c0IhMOZGGbYKCLezPmRaV0P/KQ+nRfkzUt
         vxu/cDJ19kubW1n+V+C6o15ccupO57eUYEJAO7Ik=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>, linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next 3/6] RDMA/mlx5: Separate counters from main.c
Date:   Thu,  2 Jul 2020 11:18:06 +0300
Message-Id: <20200702081809.423482-4-leon@kernel.org>
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

There are number of counters types supported in mlx5_ib: HW counters,
congestion counters, Q-counters and flow counters. Almost all supporting
code was placed in main.c that made almost impossible to maintain the
code anymore. Let's create separate code namespace for the counters
to easy future generalization effort.

Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/hw/mlx5/Makefile   |   1 +
 drivers/infiniband/hw/mlx5/cmd.c      |  12 -
 drivers/infiniband/hw/mlx5/cmd.h      |   1 -
 drivers/infiniband/hw/mlx5/counters.c | 709 ++++++++++++++++++++++++++
 drivers/infiniband/hw/mlx5/counters.h |  17 +
 drivers/infiniband/hw/mlx5/main.c     | 701 +------------------------
 drivers/infiniband/hw/mlx5/mlx5_ib.h  |   3 -
 drivers/infiniband/hw/mlx5/qp.c       |   1 +
 drivers/infiniband/hw/mlx5/qp.h       |   1 +
 9 files changed, 737 insertions(+), 709 deletions(-)
 create mode 100644 drivers/infiniband/hw/mlx5/counters.c
 create mode 100644 drivers/infiniband/hw/mlx5/counters.h

diff --git a/drivers/infiniband/hw/mlx5/Makefile b/drivers/infiniband/hw/mlx5/Makefile
index 9838719aacb9..34eaceb293b4 100644
--- a/drivers/infiniband/hw/mlx5/Makefile
+++ b/drivers/infiniband/hw/mlx5/Makefile
@@ -4,6 +4,7 @@ obj-$(CONFIG_MLX5_INFINIBAND) += mlx5_ib.o
 mlx5_ib-y := ah.o \
 	     cmd.o \
 	     cong.o \
+	     counters.o \
 	     cq.o \
 	     doorbell.o \
 	     gsi.o \
diff --git a/drivers/infiniband/hw/mlx5/cmd.c b/drivers/infiniband/hw/mlx5/cmd.c
index cc24c711e92a..ebb2f108b64f 100644
--- a/drivers/infiniband/hw/mlx5/cmd.c
+++ b/drivers/infiniband/hw/mlx5/cmd.c
@@ -148,18 +148,6 @@ void mlx5_cmd_dealloc_memic(struct mlx5_dm *dm, phys_addr_t addr, u64 length)
 	spin_unlock(&dm->lock);
 }
 
-int mlx5_cmd_query_ext_ppcnt_counters(struct mlx5_core_dev *dev, void *out)
-{
-	u32 in[MLX5_ST_SZ_DW(ppcnt_reg)] = {};
-	int sz = MLX5_ST_SZ_BYTES(ppcnt_reg);
-
-	MLX5_SET(ppcnt_reg, in, local_port, 1);
-
-	MLX5_SET(ppcnt_reg, in, grp, MLX5_ETHERNET_EXTENDED_COUNTERS_GROUP);
-	return  mlx5_core_access_reg(dev, in, sz, out, sz, MLX5_REG_PPCNT,
-				     0, 0);
-}
-
 void mlx5_cmd_destroy_tir(struct mlx5_core_dev *dev, u32 tirn, u16 uid)
 {
 	u32 in[MLX5_ST_SZ_DW(destroy_tir_in)] = {};
diff --git a/drivers/infiniband/hw/mlx5/cmd.h b/drivers/infiniband/hw/mlx5/cmd.h
index f4d8558db434..1d192a8ca87d 100644
--- a/drivers/infiniband/hw/mlx5/cmd.h
+++ b/drivers/infiniband/hw/mlx5/cmd.h
@@ -41,7 +41,6 @@ int mlx5_cmd_dump_fill_mkey(struct mlx5_core_dev *dev, u32 *mkey);
 int mlx5_cmd_null_mkey(struct mlx5_core_dev *dev, u32 *null_mkey);
 int mlx5_cmd_query_cong_params(struct mlx5_core_dev *dev, int cong_point,
 			       void *out);
-int mlx5_cmd_query_ext_ppcnt_counters(struct mlx5_core_dev *dev, void *out);
 int mlx5_cmd_alloc_memic(struct mlx5_dm *dm, phys_addr_t *addr,
 			 u64 length, u32 alignment);
 void mlx5_cmd_dealloc_memic(struct mlx5_dm *dm, phys_addr_t addr, u64 length);
diff --git a/drivers/infiniband/hw/mlx5/counters.c b/drivers/infiniband/hw/mlx5/counters.c
new file mode 100644
index 000000000000..145f3cb40ccb
--- /dev/null
+++ b/drivers/infiniband/hw/mlx5/counters.c
@@ -0,0 +1,709 @@
+// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
+/*
+ * Copyright (c) 2013-2020, Mellanox Technologies inc. All rights reserved.
+ */
+
+#include "mlx5_ib.h"
+#include <linux/mlx5/eswitch.h>
+#include "counters.h"
+#include "ib_rep.h"
+#include "qp.h"
+
+struct mlx5_ib_counter {
+	const char *name;
+	size_t offset;
+};
+
+#define INIT_Q_COUNTER(_name)		\
+	{ .name = #_name, .offset = MLX5_BYTE_OFF(query_q_counter_out, _name)}
+
+static const struct mlx5_ib_counter basic_q_cnts[] = {
+	INIT_Q_COUNTER(rx_write_requests),
+	INIT_Q_COUNTER(rx_read_requests),
+	INIT_Q_COUNTER(rx_atomic_requests),
+	INIT_Q_COUNTER(out_of_buffer),
+};
+
+static const struct mlx5_ib_counter out_of_seq_q_cnts[] = {
+	INIT_Q_COUNTER(out_of_sequence),
+};
+
+static const struct mlx5_ib_counter retrans_q_cnts[] = {
+	INIT_Q_COUNTER(duplicate_request),
+	INIT_Q_COUNTER(rnr_nak_retry_err),
+	INIT_Q_COUNTER(packet_seq_err),
+	INIT_Q_COUNTER(implied_nak_seq_err),
+	INIT_Q_COUNTER(local_ack_timeout_err),
+};
+
+#define INIT_CONG_COUNTER(_name)		\
+	{ .name = #_name, .offset =	\
+		MLX5_BYTE_OFF(query_cong_statistics_out, _name ## _high)}
+
+static const struct mlx5_ib_counter cong_cnts[] = {
+	INIT_CONG_COUNTER(rp_cnp_ignored),
+	INIT_CONG_COUNTER(rp_cnp_handled),
+	INIT_CONG_COUNTER(np_ecn_marked_roce_packets),
+	INIT_CONG_COUNTER(np_cnp_sent),
+};
+
+static const struct mlx5_ib_counter extended_err_cnts[] = {
+	INIT_Q_COUNTER(resp_local_length_error),
+	INIT_Q_COUNTER(resp_cqe_error),
+	INIT_Q_COUNTER(req_cqe_error),
+	INIT_Q_COUNTER(req_remote_invalid_request),
+	INIT_Q_COUNTER(req_remote_access_errors),
+	INIT_Q_COUNTER(resp_remote_access_errors),
+	INIT_Q_COUNTER(resp_cqe_flush_error),
+	INIT_Q_COUNTER(req_cqe_flush_error),
+};
+
+static const struct mlx5_ib_counter roce_accl_cnts[] = {
+	INIT_Q_COUNTER(roce_adp_retrans),
+	INIT_Q_COUNTER(roce_adp_retrans_to),
+	INIT_Q_COUNTER(roce_slow_restart),
+	INIT_Q_COUNTER(roce_slow_restart_cnps),
+	INIT_Q_COUNTER(roce_slow_restart_trans),
+};
+
+#define INIT_EXT_PPCNT_COUNTER(_name)		\
+	{ .name = #_name, .offset =	\
+	MLX5_BYTE_OFF(ppcnt_reg, \
+		      counter_set.eth_extended_cntrs_grp_data_layout._name##_high)}
+
+static const struct mlx5_ib_counter ext_ppcnt_cnts[] = {
+	INIT_EXT_PPCNT_COUNTER(rx_icrc_encapsulated),
+};
+
+static int mlx5_ib_read_counters(struct ib_counters *counters,
+				 struct ib_counters_read_attr *read_attr,
+				 struct uverbs_attr_bundle *attrs)
+{
+	struct mlx5_ib_mcounters *mcounters = to_mcounters(counters);
+	struct mlx5_read_counters_attr mread_attr = {};
+	struct mlx5_ib_flow_counters_desc *desc;
+	int ret, i;
+
+	mutex_lock(&mcounters->mcntrs_mutex);
+	if (mcounters->cntrs_max_index > read_attr->ncounters) {
+		ret = -EINVAL;
+		goto err_bound;
+	}
+
+	mread_attr.out = kcalloc(mcounters->counters_num, sizeof(u64),
+				 GFP_KERNEL);
+	if (!mread_attr.out) {
+		ret = -ENOMEM;
+		goto err_bound;
+	}
+
+	mread_attr.hw_cntrs_hndl = mcounters->hw_cntrs_hndl;
+	mread_attr.flags = read_attr->flags;
+	ret = mcounters->read_counters(counters->device, &mread_attr);
+	if (ret)
+		goto err_read;
+
+	/* do the pass over the counters data array to assign according to the
+	 * descriptions and indexing pairs
+	 */
+	desc = mcounters->counters_data;
+	for (i = 0; i < mcounters->ncounters; i++)
+		read_attr->counters_buff[desc[i].index] += mread_attr.out[desc[i].description];
+
+err_read:
+	kfree(mread_attr.out);
+err_bound:
+	mutex_unlock(&mcounters->mcntrs_mutex);
+	return ret;
+}
+
+static void mlx5_ib_destroy_counters(struct ib_counters *counters)
+{
+	struct mlx5_ib_mcounters *mcounters = to_mcounters(counters);
+
+	mlx5_ib_counters_clear_description(counters);
+	if (mcounters->hw_cntrs_hndl)
+		mlx5_fc_destroy(to_mdev(counters->device)->mdev,
+				mcounters->hw_cntrs_hndl);
+}
+
+static int mlx5_ib_create_counters(struct ib_counters *counters,
+				   struct uverbs_attr_bundle *attrs)
+{
+	struct mlx5_ib_mcounters *mcounters = to_mcounters(counters);
+
+	mutex_init(&mcounters->mcntrs_mutex);
+	return 0;
+}
+
+
+static bool is_mdev_switchdev_mode(const struct mlx5_core_dev *mdev)
+{
+	return MLX5_ESWITCH_MANAGER(mdev) &&
+	       mlx5_ib_eswitch_mode(mdev->priv.eswitch) ==
+		       MLX5_ESWITCH_OFFLOADS;
+}
+
+static const struct mlx5_ib_counters *get_counters(struct mlx5_ib_dev *dev,
+						   u8 port_num)
+{
+	return is_mdev_switchdev_mode(dev->mdev) ? &dev->port[0].cnts :
+						   &dev->port[port_num].cnts;
+}
+
+/**
+ * mlx5_ib_get_counters_id - Returns counters id to use for device+port
+ * @dev:	Pointer to mlx5 IB device
+ * @port_num:	Zero based port number
+ *
+ * mlx5_ib_get_counters_id() Returns counters set id to use for given
+ * device port combination in switchdev and non switchdev mode of the
+ * parent device.
+ */
+u16 mlx5_ib_get_counters_id(struct mlx5_ib_dev *dev, u8 port_num)
+{
+	const struct mlx5_ib_counters *cnts = get_counters(dev, port_num);
+
+	return cnts->set_id;
+}
+
+static struct rdma_hw_stats *mlx5_ib_alloc_hw_stats(struct ib_device *ibdev,
+						    u8 port_num)
+{
+	struct mlx5_ib_dev *dev = to_mdev(ibdev);
+	const struct mlx5_ib_counters *cnts;
+	bool is_switchdev = is_mdev_switchdev_mode(dev->mdev);
+
+	if ((is_switchdev && port_num) || (!is_switchdev && !port_num))
+		return NULL;
+
+	cnts = get_counters(dev, port_num - 1);
+
+	return rdma_alloc_hw_stats_struct(cnts->names,
+					  cnts->num_q_counters +
+					  cnts->num_cong_counters +
+					  cnts->num_ext_ppcnt_counters,
+					  RDMA_HW_STATS_DEFAULT_LIFESPAN);
+}
+
+static int mlx5_ib_query_q_counters(struct mlx5_core_dev *mdev,
+				    const struct mlx5_ib_counters *cnts,
+				    struct rdma_hw_stats *stats,
+				    u16 set_id)
+{
+	u32 out[MLX5_ST_SZ_DW(query_q_counter_out)] = {};
+	u32 in[MLX5_ST_SZ_DW(query_q_counter_in)] = {};
+	__be32 val;
+	int ret, i;
+
+	MLX5_SET(query_q_counter_in, in, opcode, MLX5_CMD_OP_QUERY_Q_COUNTER);
+	MLX5_SET(query_q_counter_in, in, counter_set_id, set_id);
+	ret = mlx5_cmd_exec_inout(mdev, query_q_counter, in, out);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < cnts->num_q_counters; i++) {
+		val = *(__be32 *)((void *)out + cnts->offsets[i]);
+		stats->value[i] = (u64)be32_to_cpu(val);
+	}
+
+	return 0;
+}
+
+static int mlx5_ib_query_ext_ppcnt_counters(struct mlx5_ib_dev *dev,
+					    const struct mlx5_ib_counters *cnts,
+					    struct rdma_hw_stats *stats)
+{
+	int offset = cnts->num_q_counters + cnts->num_cong_counters;
+	u32 in[MLX5_ST_SZ_DW(ppcnt_reg)] = {};
+	int sz = MLX5_ST_SZ_BYTES(ppcnt_reg);
+	int ret, i;
+	void *out;
+
+	out = kvzalloc(sz, GFP_KERNEL);
+	if (!out)
+		return -ENOMEM;
+
+	MLX5_SET(ppcnt_reg, in, local_port, 1);
+	MLX5_SET(ppcnt_reg, in, grp, MLX5_ETHERNET_EXTENDED_COUNTERS_GROUP);
+	ret = mlx5_core_access_reg(dev->mdev, in, sz, out, sz, MLX5_REG_PPCNT,
+				   0, 0);
+	if (ret)
+		goto free;
+
+	for (i = 0; i < cnts->num_ext_ppcnt_counters; i++)
+		stats->value[i + offset] =
+			be64_to_cpup((__be64 *)(out +
+				    cnts->offsets[i + offset]));
+free:
+	kvfree(out);
+	return ret;
+}
+
+static int mlx5_ib_get_hw_stats(struct ib_device *ibdev,
+				struct rdma_hw_stats *stats,
+				u8 port_num, int index)
+{
+	struct mlx5_ib_dev *dev = to_mdev(ibdev);
+	const struct mlx5_ib_counters *cnts = get_counters(dev, port_num - 1);
+	struct mlx5_core_dev *mdev;
+	int ret, num_counters;
+	u8 mdev_port_num;
+
+	if (!stats)
+		return -EINVAL;
+
+	num_counters = cnts->num_q_counters +
+		       cnts->num_cong_counters +
+		       cnts->num_ext_ppcnt_counters;
+
+	/* q_counters are per IB device, query the master mdev */
+	ret = mlx5_ib_query_q_counters(dev->mdev, cnts, stats, cnts->set_id);
+	if (ret)
+		return ret;
+
+	if (MLX5_CAP_PCAM_FEATURE(dev->mdev, rx_icrc_encapsulated_counter)) {
+		ret =  mlx5_ib_query_ext_ppcnt_counters(dev, cnts, stats);
+		if (ret)
+			return ret;
+	}
+
+	if (MLX5_CAP_GEN(dev->mdev, cc_query_allowed)) {
+		mdev = mlx5_ib_get_native_port_mdev(dev, port_num,
+						    &mdev_port_num);
+		if (!mdev) {
+			/* If port is not affiliated yet, its in down state
+			 * which doesn't have any counters yet, so it would be
+			 * zero. So no need to read from the HCA.
+			 */
+			goto done;
+		}
+		ret = mlx5_lag_query_cong_counters(dev->mdev,
+						   stats->value +
+						   cnts->num_q_counters,
+						   cnts->num_cong_counters,
+						   cnts->offsets +
+						   cnts->num_q_counters);
+
+		mlx5_ib_put_native_port_mdev(dev, port_num);
+		if (ret)
+			return ret;
+	}
+
+done:
+	return num_counters;
+}
+
+static struct rdma_hw_stats *
+mlx5_ib_counter_alloc_stats(struct rdma_counter *counter)
+{
+	struct mlx5_ib_dev *dev = to_mdev(counter->device);
+	const struct mlx5_ib_counters *cnts =
+		get_counters(dev, counter->port - 1);
+
+	return rdma_alloc_hw_stats_struct(cnts->names,
+					  cnts->num_q_counters +
+					  cnts->num_cong_counters +
+					  cnts->num_ext_ppcnt_counters,
+					  RDMA_HW_STATS_DEFAULT_LIFESPAN);
+}
+
+static int mlx5_ib_counter_update_stats(struct rdma_counter *counter)
+{
+	struct mlx5_ib_dev *dev = to_mdev(counter->device);
+	const struct mlx5_ib_counters *cnts =
+		get_counters(dev, counter->port - 1);
+
+	return mlx5_ib_query_q_counters(dev->mdev, cnts,
+					counter->stats, counter->id);
+}
+
+static int mlx5_ib_counter_dealloc(struct rdma_counter *counter)
+{
+	struct mlx5_ib_dev *dev = to_mdev(counter->device);
+	u32 in[MLX5_ST_SZ_DW(dealloc_q_counter_in)] = {};
+
+	if (!counter->id)
+		return 0;
+
+	MLX5_SET(dealloc_q_counter_in, in, opcode,
+		 MLX5_CMD_OP_DEALLOC_Q_COUNTER);
+	MLX5_SET(dealloc_q_counter_in, in, counter_set_id, counter->id);
+	return mlx5_cmd_exec_in(dev->mdev, dealloc_q_counter, in);
+}
+
+static int mlx5_ib_counter_bind_qp(struct rdma_counter *counter,
+				   struct ib_qp *qp)
+{
+	struct mlx5_ib_dev *dev = to_mdev(qp->device);
+	int err;
+
+	if (!counter->id) {
+		u32 out[MLX5_ST_SZ_DW(alloc_q_counter_out)] = {};
+		u32 in[MLX5_ST_SZ_DW(alloc_q_counter_in)] = {};
+
+		MLX5_SET(alloc_q_counter_in, in, opcode,
+			 MLX5_CMD_OP_ALLOC_Q_COUNTER);
+		MLX5_SET(alloc_q_counter_in, in, uid, MLX5_SHARED_RESOURCE_UID);
+		err = mlx5_cmd_exec_inout(dev->mdev, alloc_q_counter, in, out);
+		if (err)
+			return err;
+		counter->id =
+			MLX5_GET(alloc_q_counter_out, out, counter_set_id);
+	}
+
+	err = mlx5_ib_qp_set_counter(qp, counter);
+	if (err)
+		goto fail_set_counter;
+
+	return 0;
+
+fail_set_counter:
+	mlx5_ib_counter_dealloc(counter);
+	counter->id = 0;
+
+	return err;
+}
+
+static int mlx5_ib_counter_unbind_qp(struct ib_qp *qp)
+{
+	return mlx5_ib_qp_set_counter(qp, NULL);
+}
+
+
+static void mlx5_ib_fill_counters(struct mlx5_ib_dev *dev,
+				  const char **names,
+				  size_t *offsets)
+{
+	int i;
+	int j = 0;
+
+	for (i = 0; i < ARRAY_SIZE(basic_q_cnts); i++, j++) {
+		names[j] = basic_q_cnts[i].name;
+		offsets[j] = basic_q_cnts[i].offset;
+	}
+
+	if (MLX5_CAP_GEN(dev->mdev, out_of_seq_cnt)) {
+		for (i = 0; i < ARRAY_SIZE(out_of_seq_q_cnts); i++, j++) {
+			names[j] = out_of_seq_q_cnts[i].name;
+			offsets[j] = out_of_seq_q_cnts[i].offset;
+		}
+	}
+
+	if (MLX5_CAP_GEN(dev->mdev, retransmission_q_counters)) {
+		for (i = 0; i < ARRAY_SIZE(retrans_q_cnts); i++, j++) {
+			names[j] = retrans_q_cnts[i].name;
+			offsets[j] = retrans_q_cnts[i].offset;
+		}
+	}
+
+	if (MLX5_CAP_GEN(dev->mdev, enhanced_error_q_counters)) {
+		for (i = 0; i < ARRAY_SIZE(extended_err_cnts); i++, j++) {
+			names[j] = extended_err_cnts[i].name;
+			offsets[j] = extended_err_cnts[i].offset;
+		}
+	}
+
+	if (MLX5_CAP_GEN(dev->mdev, roce_accl)) {
+		for (i = 0; i < ARRAY_SIZE(roce_accl_cnts); i++, j++) {
+			names[j] = roce_accl_cnts[i].name;
+			offsets[j] = roce_accl_cnts[i].offset;
+		}
+	}
+
+	if (MLX5_CAP_GEN(dev->mdev, cc_query_allowed)) {
+		for (i = 0; i < ARRAY_SIZE(cong_cnts); i++, j++) {
+			names[j] = cong_cnts[i].name;
+			offsets[j] = cong_cnts[i].offset;
+		}
+	}
+
+	if (MLX5_CAP_PCAM_FEATURE(dev->mdev, rx_icrc_encapsulated_counter)) {
+		for (i = 0; i < ARRAY_SIZE(ext_ppcnt_cnts); i++, j++) {
+			names[j] = ext_ppcnt_cnts[i].name;
+			offsets[j] = ext_ppcnt_cnts[i].offset;
+		}
+	}
+}
+
+
+static int __mlx5_ib_alloc_counters(struct mlx5_ib_dev *dev,
+				    struct mlx5_ib_counters *cnts)
+{
+	u32 num_counters;
+
+	num_counters = ARRAY_SIZE(basic_q_cnts);
+
+	if (MLX5_CAP_GEN(dev->mdev, out_of_seq_cnt))
+		num_counters += ARRAY_SIZE(out_of_seq_q_cnts);
+
+	if (MLX5_CAP_GEN(dev->mdev, retransmission_q_counters))
+		num_counters += ARRAY_SIZE(retrans_q_cnts);
+
+	if (MLX5_CAP_GEN(dev->mdev, enhanced_error_q_counters))
+		num_counters += ARRAY_SIZE(extended_err_cnts);
+
+	if (MLX5_CAP_GEN(dev->mdev, roce_accl))
+		num_counters += ARRAY_SIZE(roce_accl_cnts);
+
+	cnts->num_q_counters = num_counters;
+
+	if (MLX5_CAP_GEN(dev->mdev, cc_query_allowed)) {
+		cnts->num_cong_counters = ARRAY_SIZE(cong_cnts);
+		num_counters += ARRAY_SIZE(cong_cnts);
+	}
+	if (MLX5_CAP_PCAM_FEATURE(dev->mdev, rx_icrc_encapsulated_counter)) {
+		cnts->num_ext_ppcnt_counters = ARRAY_SIZE(ext_ppcnt_cnts);
+		num_counters += ARRAY_SIZE(ext_ppcnt_cnts);
+	}
+	cnts->names = kcalloc(num_counters, sizeof(cnts->names), GFP_KERNEL);
+	if (!cnts->names)
+		return -ENOMEM;
+
+	cnts->offsets = kcalloc(num_counters,
+				sizeof(cnts->offsets), GFP_KERNEL);
+	if (!cnts->offsets)
+		goto err_names;
+
+	return 0;
+
+err_names:
+	kfree(cnts->names);
+	cnts->names = NULL;
+	return -ENOMEM;
+}
+
+static void mlx5_ib_dealloc_counters(struct mlx5_ib_dev *dev)
+{
+	u32 in[MLX5_ST_SZ_DW(dealloc_q_counter_in)] = {};
+	int num_cnt_ports;
+	int i;
+
+	num_cnt_ports = is_mdev_switchdev_mode(dev->mdev) ? 1 : dev->num_ports;
+
+	MLX5_SET(dealloc_q_counter_in, in, opcode,
+		 MLX5_CMD_OP_DEALLOC_Q_COUNTER);
+
+	for (i = 0; i < num_cnt_ports; i++) {
+		if (dev->port[i].cnts.set_id) {
+			MLX5_SET(dealloc_q_counter_in, in, counter_set_id,
+				 dev->port[i].cnts.set_id);
+			mlx5_cmd_exec_in(dev->mdev, dealloc_q_counter, in);
+		}
+		kfree(dev->port[i].cnts.names);
+		kfree(dev->port[i].cnts.offsets);
+	}
+}
+
+static int mlx5_ib_alloc_counters(struct mlx5_ib_dev *dev)
+{
+	u32 out[MLX5_ST_SZ_DW(alloc_q_counter_out)] = {};
+	u32 in[MLX5_ST_SZ_DW(alloc_q_counter_in)] = {};
+	int num_cnt_ports;
+	int err = 0;
+	int i;
+	bool is_shared;
+
+	MLX5_SET(alloc_q_counter_in, in, opcode, MLX5_CMD_OP_ALLOC_Q_COUNTER);
+	is_shared = MLX5_CAP_GEN(dev->mdev, log_max_uctx) != 0;
+	num_cnt_ports = is_mdev_switchdev_mode(dev->mdev) ? 1 : dev->num_ports;
+
+	for (i = 0; i < num_cnt_ports; i++) {
+		err = __mlx5_ib_alloc_counters(dev, &dev->port[i].cnts);
+		if (err)
+			goto err_alloc;
+
+		mlx5_ib_fill_counters(dev, dev->port[i].cnts.names,
+				      dev->port[i].cnts.offsets);
+
+		MLX5_SET(alloc_q_counter_in, in, uid,
+			 is_shared ? MLX5_SHARED_RESOURCE_UID : 0);
+
+		err = mlx5_cmd_exec_inout(dev->mdev, alloc_q_counter, in, out);
+		if (err) {
+			mlx5_ib_warn(dev,
+				     "couldn't allocate queue counter for port %d, err %d\n",
+				     i + 1, err);
+			goto err_alloc;
+		}
+
+		dev->port[i].cnts.set_id =
+			MLX5_GET(alloc_q_counter_out, out, counter_set_id);
+	}
+	return 0;
+
+err_alloc:
+	mlx5_ib_dealloc_counters(dev);
+	return err;
+}
+
+static int read_flow_counters(struct ib_device *ibdev,
+			      struct mlx5_read_counters_attr *read_attr)
+{
+	struct mlx5_fc *fc = read_attr->hw_cntrs_hndl;
+	struct mlx5_ib_dev *dev = to_mdev(ibdev);
+
+	return mlx5_fc_query(dev->mdev, fc,
+			     &read_attr->out[IB_COUNTER_PACKETS],
+			     &read_attr->out[IB_COUNTER_BYTES]);
+}
+
+/* flow counters currently expose two counters packets and bytes */
+#define FLOW_COUNTERS_NUM 2
+static int counters_set_description(
+	struct ib_counters *counters, enum mlx5_ib_counters_type counters_type,
+	struct mlx5_ib_flow_counters_desc *desc_data, u32 ncounters)
+{
+	struct mlx5_ib_mcounters *mcounters = to_mcounters(counters);
+	u32 cntrs_max_index = 0;
+	int i;
+
+	if (counters_type != MLX5_IB_COUNTERS_FLOW)
+		return -EINVAL;
+
+	/* init the fields for the object */
+	mcounters->type = counters_type;
+	mcounters->read_counters = read_flow_counters;
+	mcounters->counters_num = FLOW_COUNTERS_NUM;
+	mcounters->ncounters = ncounters;
+	/* each counter entry have both description and index pair */
+	for (i = 0; i < ncounters; i++) {
+		if (desc_data[i].description > IB_COUNTER_BYTES)
+			return -EINVAL;
+
+		if (cntrs_max_index <= desc_data[i].index)
+			cntrs_max_index = desc_data[i].index + 1;
+	}
+
+	mutex_lock(&mcounters->mcntrs_mutex);
+	mcounters->counters_data = desc_data;
+	mcounters->cntrs_max_index = cntrs_max_index;
+	mutex_unlock(&mcounters->mcntrs_mutex);
+
+	return 0;
+}
+
+#define MAX_COUNTERS_NUM (USHRT_MAX / (sizeof(u32) * 2))
+int mlx5_ib_flow_counters_set_data(struct ib_counters *ibcounters,
+				   struct mlx5_ib_create_flow *ucmd)
+{
+	struct mlx5_ib_mcounters *mcounters = to_mcounters(ibcounters);
+	struct mlx5_ib_flow_counters_data *cntrs_data = NULL;
+	struct mlx5_ib_flow_counters_desc *desc_data = NULL;
+	bool hw_hndl = false;
+	int ret = 0;
+
+	if (ucmd && ucmd->ncounters_data != 0) {
+		cntrs_data = ucmd->data;
+		if (cntrs_data->ncounters > MAX_COUNTERS_NUM)
+			return -EINVAL;
+
+		desc_data = kcalloc(cntrs_data->ncounters,
+				    sizeof(*desc_data),
+				    GFP_KERNEL);
+		if (!desc_data)
+			return  -ENOMEM;
+
+		if (copy_from_user(desc_data,
+				   u64_to_user_ptr(cntrs_data->counters_data),
+				   sizeof(*desc_data) * cntrs_data->ncounters)) {
+			ret = -EFAULT;
+			goto free;
+		}
+	}
+
+	if (!mcounters->hw_cntrs_hndl) {
+		mcounters->hw_cntrs_hndl = mlx5_fc_create(
+			to_mdev(ibcounters->device)->mdev, false);
+		if (IS_ERR(mcounters->hw_cntrs_hndl)) {
+			ret = PTR_ERR(mcounters->hw_cntrs_hndl);
+			goto free;
+		}
+		hw_hndl = true;
+	}
+
+	if (desc_data) {
+		/* counters already bound to at least one flow */
+		if (mcounters->cntrs_max_index) {
+			ret = -EINVAL;
+			goto free_hndl;
+		}
+
+		ret = counters_set_description(ibcounters,
+					       MLX5_IB_COUNTERS_FLOW,
+					       desc_data,
+					       cntrs_data->ncounters);
+		if (ret)
+			goto free_hndl;
+
+	} else if (!mcounters->cntrs_max_index) {
+		/* counters not bound yet, must have udata passed */
+		ret = -EINVAL;
+		goto free_hndl;
+	}
+
+	return 0;
+
+free_hndl:
+	if (hw_hndl) {
+		mlx5_fc_destroy(to_mdev(ibcounters->device)->mdev,
+				mcounters->hw_cntrs_hndl);
+		mcounters->hw_cntrs_hndl = NULL;
+	}
+free:
+	kfree(desc_data);
+	return ret;
+}
+
+void mlx5_ib_counters_clear_description(struct ib_counters *counters)
+{
+	struct mlx5_ib_mcounters *mcounters;
+
+	if (!counters || atomic_read(&counters->usecnt) != 1)
+		return;
+
+	mcounters = to_mcounters(counters);
+
+	mutex_lock(&mcounters->mcntrs_mutex);
+	kfree(mcounters->counters_data);
+	mcounters->counters_data = NULL;
+	mcounters->cntrs_max_index = 0;
+	mutex_unlock(&mcounters->mcntrs_mutex);
+}
+
+static const struct ib_device_ops hw_stats_ops = {
+	.alloc_hw_stats = mlx5_ib_alloc_hw_stats,
+	.get_hw_stats = mlx5_ib_get_hw_stats,
+	.counter_bind_qp = mlx5_ib_counter_bind_qp,
+	.counter_unbind_qp = mlx5_ib_counter_unbind_qp,
+	.counter_dealloc = mlx5_ib_counter_dealloc,
+	.counter_alloc_stats = mlx5_ib_counter_alloc_stats,
+	.counter_update_stats = mlx5_ib_counter_update_stats,
+};
+
+static const struct ib_device_ops counters_ops = {
+	.create_counters = mlx5_ib_create_counters,
+	.destroy_counters = mlx5_ib_destroy_counters,
+	.read_counters = mlx5_ib_read_counters,
+
+	INIT_RDMA_OBJ_SIZE(ib_counters, mlx5_ib_mcounters, ibcntrs),
+};
+
+int mlx5_ib_counters_init(struct mlx5_ib_dev *dev)
+{
+	ib_set_device_ops(&dev->ib_dev, &counters_ops);
+
+	if (!MLX5_CAP_GEN(dev->mdev, max_qp_cnt))
+		return 0;
+
+	ib_set_device_ops(&dev->ib_dev, &hw_stats_ops);
+	return mlx5_ib_alloc_counters(dev);
+}
+
+void mlx5_ib_counters_cleanup(struct mlx5_ib_dev *dev)
+{
+	if (!MLX5_CAP_GEN(dev->mdev, max_qp_cnt))
+		return;
+
+	mlx5_ib_dealloc_counters(dev);
+}
diff --git a/drivers/infiniband/hw/mlx5/counters.h b/drivers/infiniband/hw/mlx5/counters.h
new file mode 100644
index 000000000000..1aa30c2f3f4d
--- /dev/null
+++ b/drivers/infiniband/hw/mlx5/counters.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB */
+/*
+ * Copyright (c) 2013-2020, Mellanox Technologies inc. All rights reserved.
+ */
+
+#ifndef _MLX5_IB_COUNTERS_H
+#define _MLX5_IB_COUNTERS_H
+
+#include "mlx5_ib.h"
+
+int mlx5_ib_counters_init(struct mlx5_ib_dev *dev);
+void mlx5_ib_counters_cleanup(struct mlx5_ib_dev *dev);
+void mlx5_ib_counters_clear_description(struct ib_counters *counters);
+int mlx5_ib_flow_counters_set_data(struct ib_counters *ibcounters,
+				   struct mlx5_ib_create_flow *ucmd);
+u16 mlx5_ib_get_counters_id(struct mlx5_ib_dev *dev, u8 port_num);
+#endif /* _MLX5_IB_COUNTERS_H */
diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index 3f9588676ebf..389f57e4c261 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -36,6 +36,7 @@
 #include "qp.h"
 #include "wr.h"
 #include "restrack.h"
+#include "counters.h"
 #include <linux/mlx5/fs_helpers.h>
 #include <linux/mlx5/accel.h>
 #include <rdma/uverbs_std_types.h>
@@ -3249,17 +3250,6 @@ static void put_flow_table(struct mlx5_ib_dev *dev,
 	}
 }
 
-static void counters_clear_description(struct ib_counters *counters)
-{
-	struct mlx5_ib_mcounters *mcounters = to_mcounters(counters);
-
-	mutex_lock(&mcounters->mcntrs_mutex);
-	kfree(mcounters->counters_data);
-	mcounters->counters_data = NULL;
-	mcounters->cntrs_max_index = 0;
-	mutex_unlock(&mcounters->mcntrs_mutex);
-}
-
 static int mlx5_ib_destroy_flow(struct ib_flow *flow_id)
 {
 	struct mlx5_ib_flow_handler *handler = container_of(flow_id,
@@ -3279,10 +3269,7 @@ static int mlx5_ib_destroy_flow(struct ib_flow *flow_id)
 
 	mlx5_del_flow_rules(handler->rule);
 	put_flow_table(dev, handler->prio, true);
-	if (handler->ibcounters &&
-	    atomic_read(&handler->ibcounters->usecnt) == 1)
-		counters_clear_description(handler->ibcounters);
-
+	mlx5_ib_counters_clear_description(handler->ibcounters);
 	mutex_unlock(&dev->flow_db->lock);
 	if (handler->flow_matcher)
 		atomic_dec(&handler->flow_matcher->usecnt);
@@ -3436,125 +3423,6 @@ static void set_underlay_qp(struct mlx5_ib_dev *dev,
 	}
 }
 
-static int read_flow_counters(struct ib_device *ibdev,
-			      struct mlx5_read_counters_attr *read_attr)
-{
-	struct mlx5_fc *fc = read_attr->hw_cntrs_hndl;
-	struct mlx5_ib_dev *dev = to_mdev(ibdev);
-
-	return mlx5_fc_query(dev->mdev, fc,
-			     &read_attr->out[IB_COUNTER_PACKETS],
-			     &read_attr->out[IB_COUNTER_BYTES]);
-}
-
-/* flow counters currently expose two counters packets and bytes */
-#define FLOW_COUNTERS_NUM 2
-static int counters_set_description(struct ib_counters *counters,
-				    enum mlx5_ib_counters_type counters_type,
-				    struct mlx5_ib_flow_counters_desc *desc_data,
-				    u32 ncounters)
-{
-	struct mlx5_ib_mcounters *mcounters = to_mcounters(counters);
-	u32 cntrs_max_index = 0;
-	int i;
-
-	if (counters_type != MLX5_IB_COUNTERS_FLOW)
-		return -EINVAL;
-
-	/* init the fields for the object */
-	mcounters->type = counters_type;
-	mcounters->read_counters = read_flow_counters;
-	mcounters->counters_num = FLOW_COUNTERS_NUM;
-	mcounters->ncounters = ncounters;
-	/* each counter entry have both description and index pair */
-	for (i = 0; i < ncounters; i++) {
-		if (desc_data[i].description > IB_COUNTER_BYTES)
-			return -EINVAL;
-
-		if (cntrs_max_index <= desc_data[i].index)
-			cntrs_max_index = desc_data[i].index + 1;
-	}
-
-	mutex_lock(&mcounters->mcntrs_mutex);
-	mcounters->counters_data = desc_data;
-	mcounters->cntrs_max_index = cntrs_max_index;
-	mutex_unlock(&mcounters->mcntrs_mutex);
-
-	return 0;
-}
-
-#define MAX_COUNTERS_NUM (USHRT_MAX / (sizeof(u32) * 2))
-static int flow_counters_set_data(struct ib_counters *ibcounters,
-				  struct mlx5_ib_create_flow *ucmd)
-{
-	struct mlx5_ib_mcounters *mcounters = to_mcounters(ibcounters);
-	struct mlx5_ib_flow_counters_data *cntrs_data = NULL;
-	struct mlx5_ib_flow_counters_desc *desc_data = NULL;
-	bool hw_hndl = false;
-	int ret = 0;
-
-	if (ucmd && ucmd->ncounters_data != 0) {
-		cntrs_data = ucmd->data;
-		if (cntrs_data->ncounters > MAX_COUNTERS_NUM)
-			return -EINVAL;
-
-		desc_data = kcalloc(cntrs_data->ncounters,
-				    sizeof(*desc_data),
-				    GFP_KERNEL);
-		if (!desc_data)
-			return  -ENOMEM;
-
-		if (copy_from_user(desc_data,
-				   u64_to_user_ptr(cntrs_data->counters_data),
-				   sizeof(*desc_data) * cntrs_data->ncounters)) {
-			ret = -EFAULT;
-			goto free;
-		}
-	}
-
-	if (!mcounters->hw_cntrs_hndl) {
-		mcounters->hw_cntrs_hndl = mlx5_fc_create(
-			to_mdev(ibcounters->device)->mdev, false);
-		if (IS_ERR(mcounters->hw_cntrs_hndl)) {
-			ret = PTR_ERR(mcounters->hw_cntrs_hndl);
-			goto free;
-		}
-		hw_hndl = true;
-	}
-
-	if (desc_data) {
-		/* counters already bound to at least one flow */
-		if (mcounters->cntrs_max_index) {
-			ret = -EINVAL;
-			goto free_hndl;
-		}
-
-		ret = counters_set_description(ibcounters,
-					       MLX5_IB_COUNTERS_FLOW,
-					       desc_data,
-					       cntrs_data->ncounters);
-		if (ret)
-			goto free_hndl;
-
-	} else if (!mcounters->cntrs_max_index) {
-		/* counters not bound yet, must have udata passed */
-		ret = -EINVAL;
-		goto free_hndl;
-	}
-
-	return 0;
-
-free_hndl:
-	if (hw_hndl) {
-		mlx5_fc_destroy(to_mdev(ibcounters->device)->mdev,
-				mcounters->hw_cntrs_hndl);
-		mcounters->hw_cntrs_hndl = NULL;
-	}
-free:
-	kfree(desc_data);
-	return ret;
-}
-
 static void mlx5_ib_set_rule_source_port(struct mlx5_ib_dev *dev,
 					 struct mlx5_flow_spec *spec,
 					 struct mlx5_eswitch_rep *rep)
@@ -3664,7 +3532,7 @@ static struct mlx5_ib_flow_handler *_create_flow_rule(struct mlx5_ib_dev *dev,
 	if (flow_act.action & MLX5_FLOW_CONTEXT_ACTION_COUNT) {
 		struct mlx5_ib_mcounters *mcounters;
 
-		err = flow_counters_set_data(flow_act.counters, ucmd);
+		err = mlx5_ib_flow_counters_set_data(flow_act.counters, ucmd);
 		if (err)
 			goto free;
 
@@ -3714,9 +3582,7 @@ static struct mlx5_ib_flow_handler *_create_flow_rule(struct mlx5_ib_dev *dev,
 	ft_prio->flow_table = ft;
 free:
 	if (err && handler) {
-		if (handler->ibcounters &&
-		    atomic_read(&handler->ibcounters->usecnt) == 1)
-			counters_clear_description(handler->ibcounters);
+		mlx5_ib_counters_clear_description(handler->ibcounters);
 		kfree(handler);
 	}
 	kvfree(spec);
@@ -5311,466 +5177,6 @@ static void mlx5_disable_eth(struct mlx5_ib_dev *dev)
 	mlx5_nic_vport_disable_roce(dev->mdev);
 }
 
-struct mlx5_ib_counter {
-	const char *name;
-	size_t offset;
-};
-
-#define INIT_Q_COUNTER(_name)		\
-	{ .name = #_name, .offset = MLX5_BYTE_OFF(query_q_counter_out, _name)}
-
-static const struct mlx5_ib_counter basic_q_cnts[] = {
-	INIT_Q_COUNTER(rx_write_requests),
-	INIT_Q_COUNTER(rx_read_requests),
-	INIT_Q_COUNTER(rx_atomic_requests),
-	INIT_Q_COUNTER(out_of_buffer),
-};
-
-static const struct mlx5_ib_counter out_of_seq_q_cnts[] = {
-	INIT_Q_COUNTER(out_of_sequence),
-};
-
-static const struct mlx5_ib_counter retrans_q_cnts[] = {
-	INIT_Q_COUNTER(duplicate_request),
-	INIT_Q_COUNTER(rnr_nak_retry_err),
-	INIT_Q_COUNTER(packet_seq_err),
-	INIT_Q_COUNTER(implied_nak_seq_err),
-	INIT_Q_COUNTER(local_ack_timeout_err),
-};
-
-#define INIT_CONG_COUNTER(_name)		\
-	{ .name = #_name, .offset =	\
-		MLX5_BYTE_OFF(query_cong_statistics_out, _name ## _high)}
-
-static const struct mlx5_ib_counter cong_cnts[] = {
-	INIT_CONG_COUNTER(rp_cnp_ignored),
-	INIT_CONG_COUNTER(rp_cnp_handled),
-	INIT_CONG_COUNTER(np_ecn_marked_roce_packets),
-	INIT_CONG_COUNTER(np_cnp_sent),
-};
-
-static const struct mlx5_ib_counter extended_err_cnts[] = {
-	INIT_Q_COUNTER(resp_local_length_error),
-	INIT_Q_COUNTER(resp_cqe_error),
-	INIT_Q_COUNTER(req_cqe_error),
-	INIT_Q_COUNTER(req_remote_invalid_request),
-	INIT_Q_COUNTER(req_remote_access_errors),
-	INIT_Q_COUNTER(resp_remote_access_errors),
-	INIT_Q_COUNTER(resp_cqe_flush_error),
-	INIT_Q_COUNTER(req_cqe_flush_error),
-};
-
-static const struct mlx5_ib_counter roce_accl_cnts[] = {
-	INIT_Q_COUNTER(roce_adp_retrans),
-	INIT_Q_COUNTER(roce_adp_retrans_to),
-	INIT_Q_COUNTER(roce_slow_restart),
-	INIT_Q_COUNTER(roce_slow_restart_cnps),
-	INIT_Q_COUNTER(roce_slow_restart_trans),
-};
-
-#define INIT_EXT_PPCNT_COUNTER(_name)		\
-	{ .name = #_name, .offset =	\
-	MLX5_BYTE_OFF(ppcnt_reg, \
-		      counter_set.eth_extended_cntrs_grp_data_layout._name##_high)}
-
-static const struct mlx5_ib_counter ext_ppcnt_cnts[] = {
-	INIT_EXT_PPCNT_COUNTER(rx_icrc_encapsulated),
-};
-
-static bool is_mdev_switchdev_mode(const struct mlx5_core_dev *mdev)
-{
-	return MLX5_ESWITCH_MANAGER(mdev) &&
-	       mlx5_ib_eswitch_mode(mdev->priv.eswitch) ==
-		       MLX5_ESWITCH_OFFLOADS;
-}
-
-static void mlx5_ib_dealloc_counters(struct mlx5_ib_dev *dev)
-{
-	u32 in[MLX5_ST_SZ_DW(dealloc_q_counter_in)] = {};
-	int num_cnt_ports;
-	int i;
-
-	num_cnt_ports = is_mdev_switchdev_mode(dev->mdev) ? 1 : dev->num_ports;
-
-	MLX5_SET(dealloc_q_counter_in, in, opcode,
-		 MLX5_CMD_OP_DEALLOC_Q_COUNTER);
-
-	for (i = 0; i < num_cnt_ports; i++) {
-		if (dev->port[i].cnts.set_id) {
-			MLX5_SET(dealloc_q_counter_in, in, counter_set_id,
-				 dev->port[i].cnts.set_id);
-			mlx5_cmd_exec_in(dev->mdev, dealloc_q_counter, in);
-		}
-		kfree(dev->port[i].cnts.names);
-		kfree(dev->port[i].cnts.offsets);
-	}
-}
-
-static int __mlx5_ib_alloc_counters(struct mlx5_ib_dev *dev,
-				    struct mlx5_ib_counters *cnts)
-{
-	u32 num_counters;
-
-	num_counters = ARRAY_SIZE(basic_q_cnts);
-
-	if (MLX5_CAP_GEN(dev->mdev, out_of_seq_cnt))
-		num_counters += ARRAY_SIZE(out_of_seq_q_cnts);
-
-	if (MLX5_CAP_GEN(dev->mdev, retransmission_q_counters))
-		num_counters += ARRAY_SIZE(retrans_q_cnts);
-
-	if (MLX5_CAP_GEN(dev->mdev, enhanced_error_q_counters))
-		num_counters += ARRAY_SIZE(extended_err_cnts);
-
-	if (MLX5_CAP_GEN(dev->mdev, roce_accl))
-		num_counters += ARRAY_SIZE(roce_accl_cnts);
-
-	cnts->num_q_counters = num_counters;
-
-	if (MLX5_CAP_GEN(dev->mdev, cc_query_allowed)) {
-		cnts->num_cong_counters = ARRAY_SIZE(cong_cnts);
-		num_counters += ARRAY_SIZE(cong_cnts);
-	}
-	if (MLX5_CAP_PCAM_FEATURE(dev->mdev, rx_icrc_encapsulated_counter)) {
-		cnts->num_ext_ppcnt_counters = ARRAY_SIZE(ext_ppcnt_cnts);
-		num_counters += ARRAY_SIZE(ext_ppcnt_cnts);
-	}
-	cnts->names = kcalloc(num_counters, sizeof(cnts->names), GFP_KERNEL);
-	if (!cnts->names)
-		return -ENOMEM;
-
-	cnts->offsets = kcalloc(num_counters,
-				sizeof(cnts->offsets), GFP_KERNEL);
-	if (!cnts->offsets)
-		goto err_names;
-
-	return 0;
-
-err_names:
-	kfree(cnts->names);
-	cnts->names = NULL;
-	return -ENOMEM;
-}
-
-static void mlx5_ib_fill_counters(struct mlx5_ib_dev *dev,
-				  const char **names,
-				  size_t *offsets)
-{
-	int i;
-	int j = 0;
-
-	for (i = 0; i < ARRAY_SIZE(basic_q_cnts); i++, j++) {
-		names[j] = basic_q_cnts[i].name;
-		offsets[j] = basic_q_cnts[i].offset;
-	}
-
-	if (MLX5_CAP_GEN(dev->mdev, out_of_seq_cnt)) {
-		for (i = 0; i < ARRAY_SIZE(out_of_seq_q_cnts); i++, j++) {
-			names[j] = out_of_seq_q_cnts[i].name;
-			offsets[j] = out_of_seq_q_cnts[i].offset;
-		}
-	}
-
-	if (MLX5_CAP_GEN(dev->mdev, retransmission_q_counters)) {
-		for (i = 0; i < ARRAY_SIZE(retrans_q_cnts); i++, j++) {
-			names[j] = retrans_q_cnts[i].name;
-			offsets[j] = retrans_q_cnts[i].offset;
-		}
-	}
-
-	if (MLX5_CAP_GEN(dev->mdev, enhanced_error_q_counters)) {
-		for (i = 0; i < ARRAY_SIZE(extended_err_cnts); i++, j++) {
-			names[j] = extended_err_cnts[i].name;
-			offsets[j] = extended_err_cnts[i].offset;
-		}
-	}
-
-	if (MLX5_CAP_GEN(dev->mdev, roce_accl)) {
-		for (i = 0; i < ARRAY_SIZE(roce_accl_cnts); i++, j++) {
-			names[j] = roce_accl_cnts[i].name;
-			offsets[j] = roce_accl_cnts[i].offset;
-		}
-	}
-
-	if (MLX5_CAP_GEN(dev->mdev, cc_query_allowed)) {
-		for (i = 0; i < ARRAY_SIZE(cong_cnts); i++, j++) {
-			names[j] = cong_cnts[i].name;
-			offsets[j] = cong_cnts[i].offset;
-		}
-	}
-
-	if (MLX5_CAP_PCAM_FEATURE(dev->mdev, rx_icrc_encapsulated_counter)) {
-		for (i = 0; i < ARRAY_SIZE(ext_ppcnt_cnts); i++, j++) {
-			names[j] = ext_ppcnt_cnts[i].name;
-			offsets[j] = ext_ppcnt_cnts[i].offset;
-		}
-	}
-}
-
-static int mlx5_ib_alloc_counters(struct mlx5_ib_dev *dev)
-{
-	u32 out[MLX5_ST_SZ_DW(alloc_q_counter_out)] = {};
-	u32 in[MLX5_ST_SZ_DW(alloc_q_counter_in)] = {};
-	int num_cnt_ports;
-	int err = 0;
-	int i;
-	bool is_shared;
-
-	MLX5_SET(alloc_q_counter_in, in, opcode, MLX5_CMD_OP_ALLOC_Q_COUNTER);
-	is_shared = MLX5_CAP_GEN(dev->mdev, log_max_uctx) != 0;
-	num_cnt_ports = is_mdev_switchdev_mode(dev->mdev) ? 1 : dev->num_ports;
-
-	for (i = 0; i < num_cnt_ports; i++) {
-		err = __mlx5_ib_alloc_counters(dev, &dev->port[i].cnts);
-		if (err)
-			goto err_alloc;
-
-		mlx5_ib_fill_counters(dev, dev->port[i].cnts.names,
-				      dev->port[i].cnts.offsets);
-
-		MLX5_SET(alloc_q_counter_in, in, uid,
-			 is_shared ? MLX5_SHARED_RESOURCE_UID : 0);
-
-		err = mlx5_cmd_exec_inout(dev->mdev, alloc_q_counter, in, out);
-		if (err) {
-			mlx5_ib_warn(dev,
-				     "couldn't allocate queue counter for port %d, err %d\n",
-				     i + 1, err);
-			goto err_alloc;
-		}
-
-		dev->port[i].cnts.set_id =
-			MLX5_GET(alloc_q_counter_out, out, counter_set_id);
-	}
-	return 0;
-
-err_alloc:
-	mlx5_ib_dealloc_counters(dev);
-	return err;
-}
-
-static const struct mlx5_ib_counters *get_counters(struct mlx5_ib_dev *dev,
-						   u8 port_num)
-{
-	return is_mdev_switchdev_mode(dev->mdev) ? &dev->port[0].cnts :
-						   &dev->port[port_num].cnts;
-}
-
-/**
- * mlx5_ib_get_counters_id - Returns counters id to use for device+port
- * @dev:	Pointer to mlx5 IB device
- * @port_num:	Zero based port number
- *
- * mlx5_ib_get_counters_id() Returns counters set id to use for given
- * device port combination in switchdev and non switchdev mode of the
- * parent device.
- */
-u16 mlx5_ib_get_counters_id(struct mlx5_ib_dev *dev, u8 port_num)
-{
-	const struct mlx5_ib_counters *cnts = get_counters(dev, port_num);
-
-	return cnts->set_id;
-}
-
-static struct rdma_hw_stats *mlx5_ib_alloc_hw_stats(struct ib_device *ibdev,
-						    u8 port_num)
-{
-	struct mlx5_ib_dev *dev = to_mdev(ibdev);
-	const struct mlx5_ib_counters *cnts;
-	bool is_switchdev = is_mdev_switchdev_mode(dev->mdev);
-
-	if ((is_switchdev && port_num) || (!is_switchdev && !port_num))
-		return NULL;
-
-	cnts = get_counters(dev, port_num - 1);
-
-	return rdma_alloc_hw_stats_struct(cnts->names,
-					  cnts->num_q_counters +
-					  cnts->num_cong_counters +
-					  cnts->num_ext_ppcnt_counters,
-					  RDMA_HW_STATS_DEFAULT_LIFESPAN);
-}
-
-static int mlx5_ib_query_q_counters(struct mlx5_core_dev *mdev,
-				    const struct mlx5_ib_counters *cnts,
-				    struct rdma_hw_stats *stats,
-				    u16 set_id)
-{
-	u32 out[MLX5_ST_SZ_DW(query_q_counter_out)] = {};
-	u32 in[MLX5_ST_SZ_DW(query_q_counter_in)] = {};
-	__be32 val;
-	int ret, i;
-
-	MLX5_SET(query_q_counter_in, in, opcode, MLX5_CMD_OP_QUERY_Q_COUNTER);
-	MLX5_SET(query_q_counter_in, in, counter_set_id, set_id);
-	ret = mlx5_cmd_exec_inout(mdev, query_q_counter, in, out);
-	if (ret)
-		return ret;
-
-	for (i = 0; i < cnts->num_q_counters; i++) {
-		val = *(__be32 *)((void *)out + cnts->offsets[i]);
-		stats->value[i] = (u64)be32_to_cpu(val);
-	}
-
-	return 0;
-}
-
-static int mlx5_ib_query_ext_ppcnt_counters(struct mlx5_ib_dev *dev,
-					    const struct mlx5_ib_counters *cnts,
-					    struct rdma_hw_stats *stats)
-{
-	int offset = cnts->num_q_counters + cnts->num_cong_counters;
-	int sz = MLX5_ST_SZ_BYTES(ppcnt_reg);
-	int ret, i;
-	void *out;
-
-	out = kvzalloc(sz, GFP_KERNEL);
-	if (!out)
-		return -ENOMEM;
-
-	ret = mlx5_cmd_query_ext_ppcnt_counters(dev->mdev, out);
-	if (ret)
-		goto free;
-
-	for (i = 0; i < cnts->num_ext_ppcnt_counters; i++)
-		stats->value[i + offset] =
-			be64_to_cpup((__be64 *)(out +
-				    cnts->offsets[i + offset]));
-free:
-	kvfree(out);
-	return ret;
-}
-
-static int mlx5_ib_get_hw_stats(struct ib_device *ibdev,
-				struct rdma_hw_stats *stats,
-				u8 port_num, int index)
-{
-	struct mlx5_ib_dev *dev = to_mdev(ibdev);
-	const struct mlx5_ib_counters *cnts = get_counters(dev, port_num - 1);
-	struct mlx5_core_dev *mdev;
-	int ret, num_counters;
-	u8 mdev_port_num;
-
-	if (!stats)
-		return -EINVAL;
-
-	num_counters = cnts->num_q_counters +
-		       cnts->num_cong_counters +
-		       cnts->num_ext_ppcnt_counters;
-
-	/* q_counters are per IB device, query the master mdev */
-	ret = mlx5_ib_query_q_counters(dev->mdev, cnts, stats, cnts->set_id);
-	if (ret)
-		return ret;
-
-	if (MLX5_CAP_PCAM_FEATURE(dev->mdev, rx_icrc_encapsulated_counter)) {
-		ret =  mlx5_ib_query_ext_ppcnt_counters(dev, cnts, stats);
-		if (ret)
-			return ret;
-	}
-
-	if (MLX5_CAP_GEN(dev->mdev, cc_query_allowed)) {
-		mdev = mlx5_ib_get_native_port_mdev(dev, port_num,
-						    &mdev_port_num);
-		if (!mdev) {
-			/* If port is not affiliated yet, its in down state
-			 * which doesn't have any counters yet, so it would be
-			 * zero. So no need to read from the HCA.
-			 */
-			goto done;
-		}
-		ret = mlx5_lag_query_cong_counters(dev->mdev,
-						   stats->value +
-						   cnts->num_q_counters,
-						   cnts->num_cong_counters,
-						   cnts->offsets +
-						   cnts->num_q_counters);
-
-		mlx5_ib_put_native_port_mdev(dev, port_num);
-		if (ret)
-			return ret;
-	}
-
-done:
-	return num_counters;
-}
-
-static struct rdma_hw_stats *
-mlx5_ib_counter_alloc_stats(struct rdma_counter *counter)
-{
-	struct mlx5_ib_dev *dev = to_mdev(counter->device);
-	const struct mlx5_ib_counters *cnts =
-		get_counters(dev, counter->port - 1);
-
-	return rdma_alloc_hw_stats_struct(cnts->names,
-					  cnts->num_q_counters +
-					  cnts->num_cong_counters +
-					  cnts->num_ext_ppcnt_counters,
-					  RDMA_HW_STATS_DEFAULT_LIFESPAN);
-}
-
-static int mlx5_ib_counter_update_stats(struct rdma_counter *counter)
-{
-	struct mlx5_ib_dev *dev = to_mdev(counter->device);
-	const struct mlx5_ib_counters *cnts =
-		get_counters(dev, counter->port - 1);
-
-	return mlx5_ib_query_q_counters(dev->mdev, cnts,
-					counter->stats, counter->id);
-}
-
-static int mlx5_ib_counter_dealloc(struct rdma_counter *counter)
-{
-	struct mlx5_ib_dev *dev = to_mdev(counter->device);
-	u32 in[MLX5_ST_SZ_DW(dealloc_q_counter_in)] = {};
-
-	if (!counter->id)
-		return 0;
-
-	MLX5_SET(dealloc_q_counter_in, in, opcode,
-		 MLX5_CMD_OP_DEALLOC_Q_COUNTER);
-	MLX5_SET(dealloc_q_counter_in, in, counter_set_id, counter->id);
-	return mlx5_cmd_exec_in(dev->mdev, dealloc_q_counter, in);
-}
-
-static int mlx5_ib_counter_bind_qp(struct rdma_counter *counter,
-				   struct ib_qp *qp)
-{
-	struct mlx5_ib_dev *dev = to_mdev(qp->device);
-	int err;
-
-	if (!counter->id) {
-		u32 out[MLX5_ST_SZ_DW(alloc_q_counter_out)] = {};
-		u32 in[MLX5_ST_SZ_DW(alloc_q_counter_in)] = {};
-
-		MLX5_SET(alloc_q_counter_in, in, opcode,
-			 MLX5_CMD_OP_ALLOC_Q_COUNTER);
-		MLX5_SET(alloc_q_counter_in, in, uid, MLX5_SHARED_RESOURCE_UID);
-		err = mlx5_cmd_exec_inout(dev->mdev, alloc_q_counter, in, out);
-		if (err)
-			return err;
-		counter->id =
-			MLX5_GET(alloc_q_counter_out, out, counter_set_id);
-	}
-
-	err = mlx5_ib_qp_set_counter(qp, counter);
-	if (err)
-		goto fail_set_counter;
-
-	return 0;
-
-fail_set_counter:
-	mlx5_ib_counter_dealloc(counter);
-	counter->id = 0;
-
-	return err;
-}
-
-static int mlx5_ib_counter_unbind_qp(struct ib_qp *qp)
-{
-	return mlx5_ib_qp_set_counter(qp, NULL);
-}
-
 static int mlx5_ib_rn_get_params(struct ib_device *device, u8 port_num,
 				 enum rdma_netdev_t type,
 				 struct rdma_netdev_alloc_params *params)
@@ -6390,67 +5796,6 @@ static const struct uapi_definition mlx5_ib_defs[] = {
 	{}
 };
 
-static int mlx5_ib_read_counters(struct ib_counters *counters,
-				 struct ib_counters_read_attr *read_attr,
-				 struct uverbs_attr_bundle *attrs)
-{
-	struct mlx5_ib_mcounters *mcounters = to_mcounters(counters);
-	struct mlx5_read_counters_attr mread_attr = {};
-	struct mlx5_ib_flow_counters_desc *desc;
-	int ret, i;
-
-	mutex_lock(&mcounters->mcntrs_mutex);
-	if (mcounters->cntrs_max_index > read_attr->ncounters) {
-		ret = -EINVAL;
-		goto err_bound;
-	}
-
-	mread_attr.out = kcalloc(mcounters->counters_num, sizeof(u64),
-				 GFP_KERNEL);
-	if (!mread_attr.out) {
-		ret = -ENOMEM;
-		goto err_bound;
-	}
-
-	mread_attr.hw_cntrs_hndl = mcounters->hw_cntrs_hndl;
-	mread_attr.flags = read_attr->flags;
-	ret = mcounters->read_counters(counters->device, &mread_attr);
-	if (ret)
-		goto err_read;
-
-	/* do the pass over the counters data array to assign according to the
-	 * descriptions and indexing pairs
-	 */
-	desc = mcounters->counters_data;
-	for (i = 0; i < mcounters->ncounters; i++)
-		read_attr->counters_buff[desc[i].index] += mread_attr.out[desc[i].description];
-
-err_read:
-	kfree(mread_attr.out);
-err_bound:
-	mutex_unlock(&mcounters->mcntrs_mutex);
-	return ret;
-}
-
-static void mlx5_ib_destroy_counters(struct ib_counters *counters)
-{
-	struct mlx5_ib_mcounters *mcounters = to_mcounters(counters);
-
-	counters_clear_description(counters);
-	if (mcounters->hw_cntrs_hndl)
-		mlx5_fc_destroy(to_mdev(counters->device)->mdev,
-				mcounters->hw_cntrs_hndl);
-}
-
-static int mlx5_ib_create_counters(struct ib_counters *counters,
-				   struct uverbs_attr_bundle *attrs)
-{
-	struct mlx5_ib_mcounters *mcounters = to_mcounters(counters);
-
-	mutex_init(&mcounters->mcntrs_mutex);
-	return 0;
-}
-
 static void mlx5_ib_stage_init_cleanup(struct mlx5_ib_dev *dev)
 {
 	mlx5_ib_cleanup_multiport_master(dev);
@@ -6571,7 +5916,6 @@ static const struct ib_device_ops mlx5_ib_dev_ops = {
 	.attach_mcast = mlx5_ib_mcg_attach,
 	.check_mr_status = mlx5_ib_check_mr_status,
 	.create_ah = mlx5_ib_create_ah,
-	.create_counters = mlx5_ib_create_counters,
 	.create_cq = mlx5_ib_create_cq,
 	.create_flow = mlx5_ib_create_flow,
 	.create_qp = mlx5_ib_create_qp,
@@ -6581,7 +5925,6 @@ static const struct ib_device_ops mlx5_ib_dev_ops = {
 	.del_gid = mlx5_ib_del_gid,
 	.dereg_mr = mlx5_ib_dereg_mr,
 	.destroy_ah = mlx5_ib_destroy_ah,
-	.destroy_counters = mlx5_ib_destroy_counters,
 	.destroy_cq = mlx5_ib_destroy_cq,
 	.destroy_flow = mlx5_ib_destroy_flow,
 	.destroy_flow_action = mlx5_ib_destroy_flow_action,
@@ -6616,7 +5959,6 @@ static const struct ib_device_ops mlx5_ib_dev_ops = {
 	.query_qp = mlx5_ib_query_qp,
 	.query_srq = mlx5_ib_query_srq,
 	.query_ucontext = mlx5_ib_query_ucontext,
-	.read_counters = mlx5_ib_read_counters,
 	.reg_user_mr = mlx5_ib_reg_user_mr,
 	.req_notify_cq = mlx5_ib_arm_cq,
 	.rereg_user_mr = mlx5_ib_rereg_user_mr,
@@ -6935,33 +6277,6 @@ static void mlx5_ib_stage_odp_cleanup(struct mlx5_ib_dev *dev)
 	mlx5_ib_odp_cleanup_one(dev);
 }
 
-static const struct ib_device_ops mlx5_ib_dev_hw_stats_ops = {
-	.alloc_hw_stats = mlx5_ib_alloc_hw_stats,
-	.get_hw_stats = mlx5_ib_get_hw_stats,
-	.counter_bind_qp = mlx5_ib_counter_bind_qp,
-	.counter_unbind_qp = mlx5_ib_counter_unbind_qp,
-	.counter_dealloc = mlx5_ib_counter_dealloc,
-	.counter_alloc_stats = mlx5_ib_counter_alloc_stats,
-	.counter_update_stats = mlx5_ib_counter_update_stats,
-};
-
-static int mlx5_ib_stage_counters_init(struct mlx5_ib_dev *dev)
-{
-	if (MLX5_CAP_GEN(dev->mdev, max_qp_cnt)) {
-		ib_set_device_ops(&dev->ib_dev, &mlx5_ib_dev_hw_stats_ops);
-
-		return mlx5_ib_alloc_counters(dev);
-	}
-
-	return 0;
-}
-
-static void mlx5_ib_stage_counters_cleanup(struct mlx5_ib_dev *dev)
-{
-	if (MLX5_CAP_GEN(dev->mdev, max_qp_cnt))
-		mlx5_ib_dealloc_counters(dev);
-}
-
 static int mlx5_ib_stage_cong_debugfs_init(struct mlx5_ib_dev *dev)
 {
 	mlx5_ib_init_cong_debugfs(dev,
@@ -7153,8 +6468,8 @@ static const struct mlx5_ib_profile pf_profile = {
 		     mlx5_ib_stage_odp_init,
 		     mlx5_ib_stage_odp_cleanup),
 	STAGE_CREATE(MLX5_IB_STAGE_COUNTERS,
-		     mlx5_ib_stage_counters_init,
-		     mlx5_ib_stage_counters_cleanup),
+		     mlx5_ib_counters_init,
+		     mlx5_ib_counters_cleanup),
 	STAGE_CREATE(MLX5_IB_STAGE_CONG_DEBUGFS,
 		     mlx5_ib_stage_cong_debugfs_init,
 		     mlx5_ib_stage_cong_debugfs_cleanup),
@@ -7213,8 +6528,8 @@ const struct mlx5_ib_profile raw_eth_profile = {
 		     mlx5_ib_stage_dev_notifier_init,
 		     mlx5_ib_stage_dev_notifier_cleanup),
 	STAGE_CREATE(MLX5_IB_STAGE_COUNTERS,
-		     mlx5_ib_stage_counters_init,
-		     mlx5_ib_stage_counters_cleanup),
+		     mlx5_ib_counters_init,
+		     mlx5_ib_counters_cleanup),
 	STAGE_CREATE(MLX5_IB_STAGE_CONG_DEBUGFS,
 		     mlx5_ib_stage_cong_debugfs_init,
 		     mlx5_ib_stage_cong_debugfs_cleanup),
diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
index 733259567fad..fbf1bc0129be 100644
--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -1487,9 +1487,6 @@ int bfregn_to_uar_index(struct mlx5_ib_dev *dev,
 			struct mlx5_bfreg_info *bfregi, u32 bfregn,
 			bool dyn_bfreg);
 
-int mlx5_ib_qp_set_counter(struct ib_qp *qp, struct rdma_counter *counter);
-u16 mlx5_ib_get_counters_id(struct mlx5_ib_dev *dev, u8 port_num);
-
 static inline bool mlx5_ib_can_use_umr(struct mlx5_ib_dev *dev,
 				       bool do_modify_atomic, int access_flags)
 {
diff --git a/drivers/infiniband/hw/mlx5/qp.c b/drivers/infiniband/hw/mlx5/qp.c
index 0ae73f4e28a3..c1ba7792d7ad 100644
--- a/drivers/infiniband/hw/mlx5/qp.c
+++ b/drivers/infiniband/hw/mlx5/qp.c
@@ -38,6 +38,7 @@
 #include <linux/mlx5/fs.h>
 #include "mlx5_ib.h"
 #include "ib_rep.h"
+#include "counters.h"
 #include "cmd.h"
 #include "qp.h"
 #include "wr.h"
diff --git a/drivers/infiniband/hw/mlx5/qp.h b/drivers/infiniband/hw/mlx5/qp.h
index 82ea2b94dfa6..ba899df44c5b 100644
--- a/drivers/infiniband/hw/mlx5/qp.h
+++ b/drivers/infiniband/hw/mlx5/qp.h
@@ -43,4 +43,5 @@ void mlx5_core_res_put(struct mlx5_core_rsc_common *res);
 
 int mlx5_core_xrcd_alloc(struct mlx5_ib_dev *dev, u32 *xrcdn);
 int mlx5_core_xrcd_dealloc(struct mlx5_ib_dev *dev, u32 xrcdn);
+int mlx5_ib_qp_set_counter(struct ib_qp *qp, struct rdma_counter *counter);
 #endif /* _MLX5_IB_QP_H */
-- 
2.26.2

