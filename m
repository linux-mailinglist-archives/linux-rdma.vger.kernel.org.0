Return-Path: <linux-rdma+bounces-12323-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C651B0B49A
	for <lists+linux-rdma@lfdr.de>; Sun, 20 Jul 2025 11:37:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93FC83B993B
	for <lists+linux-rdma@lfdr.de>; Sun, 20 Jul 2025 09:37:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A93E81D5ACE;
	Sun, 20 Jul 2025 09:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vDe3Txaa"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 692701B2186
	for <linux-rdma@vger.kernel.org>; Sun, 20 Jul 2025 09:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753004251; cv=none; b=FRgh0/s8qkrE+dmhIvgAcgmx4euOmESVC/+54yD0wPdV4mb6a1/iw+yRij6Pu75/2TsALoNVG3Cxpk9SUs0OeJXyqQ+ml2MvmZKXu6CRLyqRZPGyU4klYvWWowTUTtZqB78L+RtwjKMpASqWEffvJNDPekIvtp4TXYYdjtftXP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753004251; c=relaxed/simple;
	bh=ABnvC7JN2lC9gtbRxEUmnDoc9vzfTgsRZp+d1MvMANA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ooINlE1lab/O98XyOs3YJPPShD9Kb/0yiR8USPmQrTlOKL/gFm7VmywkVU8UyhczQxGgfC1hRK+wJN/o2OipnCHRW3SFBlwW2TdtAFJ6Jwyl/sE/nGIcFW4OoUAQlGF2A5CXwHq4H2uVSQHhud1nX6pXv0F6begZ2iqZQIkvvpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vDe3Txaa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F02AFC4CEE7;
	Sun, 20 Jul 2025 09:37:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753004250;
	bh=ABnvC7JN2lC9gtbRxEUmnDoc9vzfTgsRZp+d1MvMANA=;
	h=From:To:Cc:Subject:Date:From;
	b=vDe3TxaaEr9XvREyWRXwOhnyMUED0fhKlUI71sjAWC2Zg5LGJqnTsZbaO22odXzLK
	 TV6D4boylT7u7W+SGAUp85a2+WdHSNxIsyy6sNMZ3IrEmyBJG3KuD47MClhQLXcad8
	 0kcgWoz/Oprttbitb5tYX+u/JTQKFwTAFK4ciKT1ejWj7kAdo0+bQAmeMORWaJ0Rb2
	 OGxYJiR+zWe2oI9zaGywPvwgCfAZVFtJJBMLyNEtwQBkYhMu8FCgi0c9TMCsTtQJ9A
	 6Bv4iMgOF23/owDX7amTlGesQYzucY2NuhupIL8p0pydsIpLenBiXznDzCByadRgZO
	 hZn9xnyO3szuA==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Patrisious Haddad <phaddad@nvidia.com>,
	Edward Srouji <edwards@nvidia.com>,
	linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next] RDMA/mlx5: Refactor optional counters steering code
Date: Sun, 20 Jul 2025 12:37:24 +0300
Message-ID: <9854d1fdb140e4a6552b7a2fd1a028cfe488a935.1753004208.git.leon@kernel.org>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Patrisious Haddad <phaddad@nvidia.com>

Currently there isn't a clear layer separation between the counters and
the steering code, whereas the steering code is doing redundant access
to the counter struct.

Separate the fs.c and counters.c, where fs code won't access or be
aware of counter structs but only the objects it needs.

As a result, move mlx5_rdma_counter struct from the header file to be
an internal struct for the counters file only.

Signed-off-by: Patrisious Haddad <phaddad@nvidia.com>
Reviewed-by: Edward Srouji <edwards@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/counters.c | 30 +++++++++--
 drivers/infiniband/hw/mlx5/counters.h | 13 -----
 drivers/infiniband/hw/mlx5/fs.c       | 77 +++++++++++++--------------
 drivers/infiniband/hw/mlx5/mlx5_ib.h  |  9 ++--
 4 files changed, 67 insertions(+), 62 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/counters.c b/drivers/infiniband/hw/mlx5/counters.c
index b847084dcd998..368fbacee342b 100644
--- a/drivers/infiniband/hw/mlx5/counters.c
+++ b/drivers/infiniband/hw/mlx5/counters.c
@@ -16,6 +16,18 @@ struct mlx5_ib_counter {
 	u32 type;
 };
 
+struct mlx5_rdma_counter {
+	struct rdma_counter rdma_counter;
+
+	struct mlx5_fc *fc[MLX5_IB_OPCOUNTER_MAX];
+	struct xarray qpn_opfc_xa;
+};
+
+static struct mlx5_rdma_counter *to_mcounter(struct rdma_counter *counter)
+{
+	return container_of(counter, struct mlx5_rdma_counter, rdma_counter);
+}
+
 #define INIT_Q_COUNTER(_name)		\
 	{ .name = #_name, .offset = MLX5_BYTE_OFF(query_q_counter_out, _name)}
 
@@ -602,7 +614,7 @@ static int mlx5_ib_counter_dealloc(struct rdma_counter *counter)
 		return 0;
 
 	WARN_ON(!xa_empty(&mcounter->qpn_opfc_xa));
-	mlx5r_fs_destroy_fcs(dev, counter);
+	mlx5r_fs_destroy_fcs(dev, mcounter->fc);
 	MLX5_SET(dealloc_q_counter_in, in, opcode,
 		 MLX5_CMD_OP_DEALLOC_Q_COUNTER);
 	MLX5_SET(dealloc_q_counter_in, in, counter_set_id, counter->id);
@@ -612,6 +624,7 @@ static int mlx5_ib_counter_dealloc(struct rdma_counter *counter)
 static int mlx5_ib_counter_bind_qp(struct rdma_counter *counter,
 				   struct ib_qp *qp, u32 port)
 {
+	struct mlx5_rdma_counter *mcounter = to_mcounter(counter);
 	struct mlx5_ib_dev *dev = to_mdev(qp->device);
 	bool new = false;
 	int err;
@@ -635,7 +648,11 @@ static int mlx5_ib_counter_bind_qp(struct rdma_counter *counter,
 	if (err)
 		goto fail_set_counter;
 
-	err = mlx5r_fs_bind_op_fc(qp, counter, port);
+	if (!counter->mode.bind_opcnt)
+		return 0;
+
+	err = mlx5r_fs_bind_op_fc(qp, mcounter->fc, &mcounter->qpn_opfc_xa,
+				  port);
 	if (err)
 		goto fail_bind_op_fc;
 
@@ -655,9 +672,12 @@ static int mlx5_ib_counter_bind_qp(struct rdma_counter *counter,
 static int mlx5_ib_counter_unbind_qp(struct ib_qp *qp, u32 port)
 {
 	struct rdma_counter *counter = qp->counter;
+	struct mlx5_rdma_counter *mcounter;
 	int err;
 
-	mlx5r_fs_unbind_op_fc(qp, counter);
+	mcounter = to_mcounter(counter);
+
+	mlx5r_fs_unbind_op_fc(qp, &mcounter->qpn_opfc_xa);
 
 	err = mlx5_ib_qp_set_counter(qp, NULL);
 	if (err)
@@ -666,7 +686,9 @@ static int mlx5_ib_counter_unbind_qp(struct ib_qp *qp, u32 port)
 	return 0;
 
 fail_set_counter:
-	mlx5r_fs_bind_op_fc(qp, counter, port);
+	if (counter->mode.bind_opcnt)
+		mlx5r_fs_bind_op_fc(qp, mcounter->fc,
+				    &mcounter->qpn_opfc_xa, port);
 	return err;
 }
 
diff --git a/drivers/infiniband/hw/mlx5/counters.h b/drivers/infiniband/hw/mlx5/counters.h
index bd03cee420148..a04e7dd59455f 100644
--- a/drivers/infiniband/hw/mlx5/counters.h
+++ b/drivers/infiniband/hw/mlx5/counters.h
@@ -8,19 +8,6 @@
 
 #include "mlx5_ib.h"
 
-struct mlx5_rdma_counter {
-	struct rdma_counter rdma_counter;
-
-	struct mlx5_fc *fc[MLX5_IB_OPCOUNTER_MAX];
-	struct xarray qpn_opfc_xa;
-};
-
-static inline struct mlx5_rdma_counter *
-to_mcounter(struct rdma_counter *counter)
-{
-	return container_of(counter, struct mlx5_rdma_counter, rdma_counter);
-}
-
 int mlx5_ib_counters_init(struct mlx5_ib_dev *dev);
 void mlx5_ib_counters_cleanup(struct mlx5_ib_dev *dev);
 void mlx5_ib_counters_clear_description(struct ib_counters *counters);
diff --git a/drivers/infiniband/hw/mlx5/fs.c b/drivers/infiniband/hw/mlx5/fs.c
index bab2f58240c9a..b0f7663c24c1e 100644
--- a/drivers/infiniband/hw/mlx5/fs.c
+++ b/drivers/infiniband/hw/mlx5/fs.c
@@ -1012,14 +1012,14 @@ static int get_per_qp_prio(struct mlx5_ib_dev *dev,
 	return 0;
 }
 
-static struct mlx5_per_qp_opfc *
-get_per_qp_opfc(struct mlx5_rdma_counter *mcounter, u32 qp_num, bool *new)
+static struct mlx5_per_qp_opfc *get_per_qp_opfc(struct xarray *qpn_opfc_xa,
+						u32 qp_num, bool *new)
 {
 	struct mlx5_per_qp_opfc *per_qp_opfc;
 
 	*new = false;
 
-	per_qp_opfc = xa_load(&mcounter->qpn_opfc_xa, qp_num);
+	per_qp_opfc = xa_load(qpn_opfc_xa, qp_num);
 	if (per_qp_opfc)
 		return per_qp_opfc;
 	per_qp_opfc = kzalloc(sizeof(*per_qp_opfc), GFP_KERNEL);
@@ -1032,7 +1032,8 @@ get_per_qp_opfc(struct mlx5_rdma_counter *mcounter, u32 qp_num, bool *new)
 }
 
 static int add_op_fc_rules(struct mlx5_ib_dev *dev,
-			   struct mlx5_rdma_counter *mcounter,
+			   struct mlx5_fc *fc_arr[MLX5_IB_OPCOUNTER_MAX],
+			   struct xarray *qpn_opfc_xa,
 			   struct mlx5_per_qp_opfc *per_qp_opfc,
 			   struct mlx5_ib_flow_prio *prio,
 			   enum mlx5_ib_optional_counter_type type,
@@ -1055,7 +1056,7 @@ static int add_op_fc_rules(struct mlx5_ib_dev *dev,
 		return 0;
 	}
 
-	opfc->fc = mcounter->fc[type];
+	opfc->fc = fc_arr[type];
 
 	spec = kcalloc(MAX_OPFC_RULES, sizeof(*spec), GFP_KERNEL);
 	if (!spec) {
@@ -1148,8 +1149,7 @@ static int add_op_fc_rules(struct mlx5_ib_dev *dev,
 	}
 	prio->refcount += spec_num;
 
-	err = xa_err(xa_store(&mcounter->qpn_opfc_xa, qp_num, per_qp_opfc,
-			      GFP_KERNEL));
+	err = xa_err(xa_store(qpn_opfc_xa, qp_num, per_qp_opfc, GFP_KERNEL));
 	if (err)
 		goto del_rules;
 
@@ -1168,8 +1168,9 @@ static int add_op_fc_rules(struct mlx5_ib_dev *dev,
 	return err;
 }
 
-static bool is_fc_shared_and_in_use(struct mlx5_rdma_counter *mcounter,
-				    u32 type, struct mlx5_fc **fc)
+static bool
+is_fc_shared_and_in_use(struct mlx5_fc *fc_arr[MLX5_IB_OPCOUNTER_MAX], u32 type,
+			struct mlx5_fc **fc)
 {
 	u32 shared_fc_type;
 
@@ -1190,7 +1191,7 @@ static bool is_fc_shared_and_in_use(struct mlx5_rdma_counter *mcounter,
 		return false;
 	}
 
-	*fc = mcounter->fc[shared_fc_type];
+	*fc = fc_arr[shared_fc_type];
 	if (!(*fc))
 		return false;
 
@@ -1198,24 +1199,23 @@ static bool is_fc_shared_and_in_use(struct mlx5_rdma_counter *mcounter,
 }
 
 void mlx5r_fs_destroy_fcs(struct mlx5_ib_dev *dev,
-			  struct rdma_counter *counter)
+			  struct mlx5_fc *fc_arr[MLX5_IB_OPCOUNTER_MAX])
 {
-	struct mlx5_rdma_counter *mcounter = to_mcounter(counter);
 	struct mlx5_fc *in_use_fc;
 	int i;
 
 	for (i = MLX5_IB_OPCOUNTER_CC_RX_CE_PKTS_PER_QP;
 	     i <= MLX5_IB_OPCOUNTER_RDMA_RX_BYTES_PER_QP; i++) {
-		if (!mcounter->fc[i])
+		if (!fc_arr[i])
 			continue;
 
-		if (is_fc_shared_and_in_use(mcounter, i, &in_use_fc)) {
-			mcounter->fc[i] = NULL;
+		if (is_fc_shared_and_in_use(fc_arr, i, &in_use_fc)) {
+			fc_arr[i] = NULL;
 			continue;
 		}
 
-		mlx5_fc_destroy(dev->mdev, mcounter->fc[i]);
-		mcounter->fc[i] = NULL;
+		mlx5_fc_destroy(dev->mdev, fc_arr[i]);
+		fc_arr[i] = NULL;
 	}
 }
 
@@ -1359,16 +1359,15 @@ void mlx5_ib_fs_remove_op_fc(struct mlx5_ib_dev *dev,
 	put_per_qp_prio(dev, type);
 }
 
-void mlx5r_fs_unbind_op_fc(struct ib_qp *qp, struct rdma_counter *counter)
+void mlx5r_fs_unbind_op_fc(struct ib_qp *qp, struct xarray *qpn_opfc_xa)
 {
-	struct mlx5_rdma_counter *mcounter = to_mcounter(counter);
-	struct mlx5_ib_dev *dev = to_mdev(counter->device);
+	struct mlx5_ib_dev *dev = to_mdev(qp->device);
 	struct mlx5_per_qp_opfc *per_qp_opfc;
 	struct mlx5_ib_op_fc *in_use_opfc;
 	struct mlx5_ib_flow_prio *prio;
 	int i, j;
 
-	per_qp_opfc = xa_load(&mcounter->qpn_opfc_xa, qp->qp_num);
+	per_qp_opfc = xa_load(qpn_opfc_xa, qp->qp_num);
 	if (!per_qp_opfc)
 		return;
 
@@ -1394,13 +1393,13 @@ void mlx5r_fs_unbind_op_fc(struct ib_qp *qp, struct rdma_counter *counter)
 	}
 
 	kfree(per_qp_opfc);
-	xa_erase(&mcounter->qpn_opfc_xa, qp->qp_num);
+	xa_erase(qpn_opfc_xa, qp->qp_num);
 }
 
-int mlx5r_fs_bind_op_fc(struct ib_qp *qp, struct rdma_counter *counter,
-			u32 port)
+int mlx5r_fs_bind_op_fc(struct ib_qp *qp,
+			struct mlx5_fc *fc_arr[MLX5_IB_OPCOUNTER_MAX],
+			struct xarray *qpn_opfc_xa, u32 port)
 {
-	struct mlx5_rdma_counter *mcounter = to_mcounter(counter);
 	struct mlx5_ib_dev *dev = to_mdev(qp->device);
 	struct mlx5_per_qp_opfc *per_qp_opfc;
 	struct mlx5_ib_flow_prio *prio;
@@ -1410,9 +1409,6 @@ int mlx5r_fs_bind_op_fc(struct ib_qp *qp, struct rdma_counter *counter,
 	int i, err, per_qp_type;
 	bool new;
 
-	if (!counter->mode.bind_opcnt)
-		return 0;
-
 	cnts = &dev->port[port - 1].cnts;
 
 	for (i = 0; i <= MLX5_IB_OPCOUNTER_RDMA_RX_BYTES; i++) {
@@ -1424,23 +1420,22 @@ int mlx5r_fs_bind_op_fc(struct ib_qp *qp, struct rdma_counter *counter,
 		prio = get_opfc_prio(dev, per_qp_type);
 		WARN_ON(!prio->flow_table);
 
-		if (is_fc_shared_and_in_use(mcounter, per_qp_type, &in_use_fc))
-			mcounter->fc[per_qp_type] = in_use_fc;
+		if (is_fc_shared_and_in_use(fc_arr, per_qp_type, &in_use_fc))
+			fc_arr[per_qp_type] = in_use_fc;
 
-		if (!mcounter->fc[per_qp_type]) {
-			mcounter->fc[per_qp_type] = mlx5_fc_create(dev->mdev,
-								   false);
-			if (IS_ERR(mcounter->fc[per_qp_type]))
-				return PTR_ERR(mcounter->fc[per_qp_type]);
+		if (!fc_arr[per_qp_type]) {
+			fc_arr[per_qp_type] = mlx5_fc_create(dev->mdev, false);
+			if (IS_ERR(fc_arr[per_qp_type]))
+				return PTR_ERR(fc_arr[per_qp_type]);
 		}
 
-		per_qp_opfc = get_per_qp_opfc(mcounter, qp->qp_num, &new);
+		per_qp_opfc = get_per_qp_opfc(qpn_opfc_xa, qp->qp_num, &new);
 		if (!per_qp_opfc) {
 			err = -ENOMEM;
 			goto free_fc;
 		}
-		err = add_op_fc_rules(dev, mcounter, per_qp_opfc, prio,
-				      per_qp_type, qp->qp_num, port);
+		err = add_op_fc_rules(dev, fc_arr, qpn_opfc_xa, per_qp_opfc,
+				      prio, per_qp_type, qp->qp_num, port);
 		if (err)
 			goto del_rules;
 	}
@@ -1448,12 +1443,12 @@ int mlx5r_fs_bind_op_fc(struct ib_qp *qp, struct rdma_counter *counter,
 	return 0;
 
 del_rules:
-	mlx5r_fs_unbind_op_fc(qp, counter);
+	mlx5r_fs_unbind_op_fc(qp, qpn_opfc_xa);
 	if (new)
 		kfree(per_qp_opfc);
 free_fc:
-	if (xa_empty(&mcounter->qpn_opfc_xa))
-		mlx5r_fs_destroy_fcs(dev, counter);
+	if (xa_empty(qpn_opfc_xa))
+		mlx5r_fs_destroy_fcs(dev, fc_arr);
 	return err;
 }
 
diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
index 9fe7a197614af..185d6e67e8ae3 100644
--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -894,13 +894,14 @@ void mlx5_ib_fs_remove_op_fc(struct mlx5_ib_dev *dev,
 			     struct mlx5_ib_op_fc *opfc,
 			     enum mlx5_ib_optional_counter_type type);
 
-int mlx5r_fs_bind_op_fc(struct ib_qp *qp, struct rdma_counter *counter,
-			u32 port);
+int mlx5r_fs_bind_op_fc(struct ib_qp *qp,
+			struct mlx5_fc *fc_arr[MLX5_IB_OPCOUNTER_MAX],
+			struct xarray *qpn_opfc_xa, u32 port);
 
-void mlx5r_fs_unbind_op_fc(struct ib_qp *qp, struct rdma_counter *counter);
+void mlx5r_fs_unbind_op_fc(struct ib_qp *qp, struct xarray *qpn_opfc_xa);
 
 void mlx5r_fs_destroy_fcs(struct mlx5_ib_dev *dev,
-			  struct rdma_counter *counter);
+			  struct mlx5_fc *fc_arr[MLX5_IB_OPCOUNTER_MAX]);
 
 struct mlx5_ib_multiport_info;
 
-- 
2.50.1


