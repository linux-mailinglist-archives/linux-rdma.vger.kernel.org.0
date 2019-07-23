Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D0F60712E9
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Jul 2019 09:31:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732607AbfGWHba (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 23 Jul 2019 03:31:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:54934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731234AbfGWHba (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 23 Jul 2019 03:31:30 -0400
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C01EB21911;
        Tue, 23 Jul 2019 07:31:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563867089;
        bh=Kr53SDG7ZRslfm61Q4jmrzsGFVVmtQGdvV72H+gdI4c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rdcIpEbko2XkVz+h/3fIumqjcnZwGOVEuhzBD5HDbLZYmUkuhKL/qfNKLiEkjtgXC
         ViNbh5lNal5bL5a3LPTWk8VjZ1EHHODBeYwUteJp0PsHXWB2rIYUtyleWEKDueC3mi
         oRXsNGWuoH4mnMMTUDcfhNYM6qxdrGjWx0S9rQ2g=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Daniel Jurgens <danielj@mellanox.com>,
        Parav Pandit <parav@mellanox.com>
Subject: [PATCH rdma-next 2/2] IB/mlx5: Support per device q counters in switchdev mode
Date:   Tue, 23 Jul 2019 10:31:17 +0300
Message-Id: <20190723073117.7175-3-leon@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190723073117.7175-1-leon@kernel.org>
References: <20190723073117.7175-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Parav Pandit <parav@mellanox.com>

When parent mlx5_core_dev is in switchdev mode, q_counters are not
applicable to multiple non uplink vports.
Hence, have make them limited to device level.

While at it, correct __mlx5_ib_qp_set_counter() and
__mlx5_ib_modify_qp() to use u16 set_id as defined by the device.

Signed-off-by: Parav Pandit <parav@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/hw/mlx5/main.c    | 55 +++++++++++++++++++++++-----
 drivers/infiniband/hw/mlx5/mlx5_ib.h |  1 +
 drivers/infiniband/hw/mlx5/qp.c      | 25 +++++++------
 3 files changed, 60 insertions(+), 21 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index 4cfb55ac0ed7..4a3d700cd783 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -5322,11 +5322,21 @@ static const struct mlx5_ib_counter ext_ppcnt_cnts[] = {
 	INIT_EXT_PPCNT_COUNTER(rx_icrc_encapsulated),
 };
 
+static bool is_mdev_switchdev_mode(const struct mlx5_core_dev *mdev)
+{
+	return MLX5_ESWITCH_MANAGER(mdev) &&
+	       mlx5_ib_eswitch_mode(mdev->priv.eswitch) ==
+		       MLX5_ESWITCH_OFFLOADS;
+}
+
 static void mlx5_ib_dealloc_counters(struct mlx5_ib_dev *dev)
 {
+	int num_cnt_ports;
 	int i;
 
-	for (i = 0; i < dev->num_ports; i++) {
+	num_cnt_ports = is_mdev_switchdev_mode(dev->mdev) ? 1 : dev->num_ports;
+
+	for (i = 0; i < num_cnt_ports; i++) {
 		if (dev->port[i].cnts.set_id_valid)
 			mlx5_core_dealloc_q_counter(dev->mdev,
 						    dev->port[i].cnts.set_id);
@@ -5428,13 +5438,15 @@ static void mlx5_ib_fill_counters(struct mlx5_ib_dev *dev,
 
 static int mlx5_ib_alloc_counters(struct mlx5_ib_dev *dev)
 {
+	int num_cnt_ports;
 	int err = 0;
 	int i;
 	bool is_shared;
 
 	is_shared = MLX5_CAP_GEN(dev->mdev, log_max_uctx) != 0;
+	num_cnt_ports = is_mdev_switchdev_mode(dev->mdev) ? 1 : dev->num_ports;
 
-	for (i = 0; i < dev->num_ports; i++) {
+	for (i = 0; i < num_cnt_ports; i++) {
 		err = __mlx5_ib_alloc_counters(dev, &dev->port[i].cnts);
 		if (err)
 			goto err_alloc;
@@ -5454,7 +5466,6 @@ static int mlx5_ib_alloc_counters(struct mlx5_ib_dev *dev)
 		}
 		dev->port[i].cnts.set_id_valid = true;
 	}
-
 	return 0;
 
 err_alloc:
@@ -5462,16 +5473,41 @@ static int mlx5_ib_alloc_counters(struct mlx5_ib_dev *dev)
 	return err;
 }
 
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
 static struct rdma_hw_stats *mlx5_ib_alloc_hw_stats(struct ib_device *ibdev,
 						    u8 port_num)
 {
 	struct mlx5_ib_dev *dev = to_mdev(ibdev);
-	const struct mlx5_ib_counters *cnts = &dev->port[port_num - 1].cnts;
+	const struct mlx5_ib_counters *cnts;
+	bool is_switchdev = is_mdev_switchdev_mode(dev->mdev);
 
-	/* We support only per port stats */
-	if (port_num == 0)
+	if ((is_switchdev && port_num) || (!is_switchdev && !port_num))
 		return NULL;
 
+	cnts = get_counters(dev, port_num - 1);
+
 	return rdma_alloc_hw_stats_struct(cnts->names,
 					  cnts->num_q_counters +
 					  cnts->num_cong_counters +
@@ -5538,7 +5574,7 @@ static int mlx5_ib_get_hw_stats(struct ib_device *ibdev,
 				u8 port_num, int index)
 {
 	struct mlx5_ib_dev *dev = to_mdev(ibdev);
-	struct mlx5_ib_counters *cnts = &dev->port[port_num - 1].cnts;
+	const struct mlx5_ib_counters *cnts = get_counters(dev, port_num - 1);
 	struct mlx5_core_dev *mdev;
 	int ret, num_counters;
 	u8 mdev_port_num;
@@ -5592,7 +5628,7 @@ mlx5_ib_counter_alloc_stats(struct rdma_counter *counter)
 {
 	struct mlx5_ib_dev *dev = to_mdev(counter->device);
 	const struct mlx5_ib_counters *cnts =
-			&dev->port[counter->port - 1].cnts;
+		get_counters(dev, counter->port - 1);
 
 	/* Q counters are in the beginning of all counters */
 	return rdma_alloc_hw_stats_struct(cnts->names,
@@ -5603,7 +5639,8 @@ mlx5_ib_counter_alloc_stats(struct rdma_counter *counter)
 static int mlx5_ib_counter_update_stats(struct rdma_counter *counter)
 {
 	struct mlx5_ib_dev *dev = to_mdev(counter->device);
-	struct mlx5_ib_counters *cnts = &dev->port[counter->port - 1].cnts;
+	const struct mlx5_ib_counters *cnts =
+		get_counters(dev, counter->port - 1);
 
 	return mlx5_ib_query_q_counters(dev->mdev, cnts,
 					counter->stats, counter->id);
diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
index f6a53455bf8b..cb41a7e6255a 100644
--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -1475,4 +1475,5 @@ int bfregn_to_uar_index(struct mlx5_ib_dev *dev,
 			bool dyn_bfreg);
 
 int mlx5_ib_qp_set_counter(struct ib_qp *qp, struct rdma_counter *counter);
+u16 mlx5_ib_get_counters_id(struct mlx5_ib_dev *dev, u8 port_num);
 #endif /* MLX5_IB_H */
diff --git a/drivers/infiniband/hw/mlx5/qp.c b/drivers/infiniband/hw/mlx5/qp.c
index 379328b2598f..e96dcdfd6c3a 100644
--- a/drivers/infiniband/hw/mlx5/qp.c
+++ b/drivers/infiniband/hw/mlx5/qp.c
@@ -3386,19 +3386,16 @@ static int __mlx5_ib_qp_set_counter(struct ib_qp *qp,
 	struct mlx5_ib_dev *dev = to_mdev(qp->device);
 	struct mlx5_ib_qp *mqp = to_mqp(qp);
 	struct mlx5_qp_context context = {};
-	struct mlx5_ib_port *mibport = NULL;
 	struct mlx5_ib_qp_base *base;
 	u32 set_id;
 
 	if (!MLX5_CAP_GEN(dev->mdev, rts2rts_qp_counters_set_id))
 		return 0;
 
-	if (counter) {
+	if (counter)
 		set_id = counter->id;
-	} else {
-		mibport = &dev->port[mqp->port - 1];
-		set_id = mibport->cnts.set_id;
-	}
+	else
+		set_id = mlx5_ib_get_counters_id(dev, mqp->port - 1);
 
 	base = &mqp->trans_qp.base;
 	context.qp_counter_set_usr_page &= cpu_to_be32(0xffffff);
@@ -3459,7 +3456,6 @@ static int __mlx5_ib_modify_qp(struct ib_qp *ibqp,
 	struct mlx5_ib_cq *send_cq, *recv_cq;
 	struct mlx5_qp_context *context;
 	struct mlx5_ib_pd *pd;
-	struct mlx5_ib_port *mibport = NULL;
 	enum mlx5_qp_state mlx5_cur, mlx5_new;
 	enum mlx5_qp_optpar optpar;
 	u32 set_id = 0;
@@ -3624,11 +3620,10 @@ static int __mlx5_ib_modify_qp(struct ib_qp *ibqp,
 		if (qp->flags & MLX5_IB_QP_UNDERLAY)
 			port_num = 0;
 
-		mibport = &dev->port[port_num];
 		if (ibqp->counter)
 			set_id = ibqp->counter->id;
 		else
-			set_id = mibport->cnts.set_id;
+			set_id = mlx5_ib_get_counters_id(dev, port_num);
 		context->qp_counter_set_usr_page |=
 			cpu_to_be32(set_id << 24);
 	}
@@ -3817,6 +3812,8 @@ static int mlx5_ib_modify_dct(struct ib_qp *ibqp, struct ib_qp_attr *attr,
 
 	dctc = MLX5_ADDR_OF(create_dct_in, qp->dct.in, dct_context_entry);
 	if (cur_state == IB_QPS_RESET && new_state == IB_QPS_INIT) {
+		u16 set_id;
+
 		required |= IB_QP_ACCESS_FLAGS | IB_QP_PKEY_INDEX | IB_QP_PORT;
 		if (!is_valid_mask(attr_mask, required, 0))
 			return -EINVAL;
@@ -3843,7 +3840,9 @@ static int mlx5_ib_modify_dct(struct ib_qp *ibqp, struct ib_qp_attr *attr,
 		}
 		MLX5_SET(dctc, dctc, pkey_index, attr->pkey_index);
 		MLX5_SET(dctc, dctc, port, attr->port_num);
-		MLX5_SET(dctc, dctc, counter_set_id, dev->port[attr->port_num - 1].cnts.set_id);
+
+		set_id = mlx5_ib_get_counters_id(dev, attr->port_num - 1);
+		MLX5_SET(dctc, dctc, counter_set_id, set_id);
 
 	} else if (cur_state == IB_QPS_INIT && new_state == IB_QPS_RTR) {
 		struct mlx5_ib_modify_qp_resp resp = {};
@@ -6331,11 +6330,13 @@ int mlx5_ib_modify_wq(struct ib_wq *wq, struct ib_wq_attr *wq_attr,
 	}
 
 	if (curr_wq_state == IB_WQS_RESET && wq_state == IB_WQS_RDY) {
+		u16 set_id;
+
+		set_id = mlx5_ib_get_counters_id(dev, 0);
 		if (MLX5_CAP_GEN(dev->mdev, modify_rq_counter_set_id)) {
 			MLX5_SET64(modify_rq_in, in, modify_bitmask,
 				   MLX5_MODIFY_RQ_IN_MODIFY_BITMASK_RQ_COUNTER_SET_ID);
-			MLX5_SET(rqc, rqc, counter_set_id,
-				 dev->port->cnts.set_id);
+			MLX5_SET(rqc, rqc, counter_set_id, set_id);
 		} else
 			dev_info_once(
 				&dev->ib_dev.dev,
-- 
2.20.1

