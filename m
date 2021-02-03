Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80C3430DA7F
	for <lists+linux-rdma@lfdr.de>; Wed,  3 Feb 2021 14:03:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbhBCNCd (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 3 Feb 2021 08:02:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:48632 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229774AbhBCNC3 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 3 Feb 2021 08:02:29 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id CA59064F7E;
        Wed,  3 Feb 2021 13:01:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612357306;
        bh=HRL0QoZ9L6rPlVv7/UvQrrf6cahyPv53xk6e1SB+0RA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jBJEMCLH8K5H14ChJwTkI2dTnk/vv5Qc+aT8anUCVezh1gJQ7ee99Pdq7/EndAInt
         JWTk2a/Yb2bx1NhJGGRs6QBmFLhrI6BXkzFuq1tUHlooh1c32h6ooaRhtQNnkF5rvx
         fdzai/yB8fyW6aGsERrtaAv0BeMHK5GV1YJpnmUNi76t91L0UusLpfBa8viwW781ez
         RO7/08Z1vumWGA5edrJPXv9SloMfcTbtVnGZhwafGuL7urVHSOprqbScnKGSxdpF9Q
         TYxicHGEviXa/t9B9ea3XdaX/QFVjA0t+C6k+BmizQwIYF6J+j0XyV0WKP0m1V98+K
         QOTCUeaURwQJg==
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Parav Pandit <parav@nvidia.com>, linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next v1 2/5] IB/mlx5: Avoid calling query device for reading pkey table length
Date:   Wed,  3 Feb 2021 15:01:30 +0200
Message-Id: <20210203130133.4057329-3-leon@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210203130133.4057329-1-leon@kernel.org>
References: <20210203130133.4057329-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Parav Pandit <parav@nvidia.com>

Pkey table length for all the ports of the device is the same.
Currently get_ports_cap() reads and stores it for each port by querying
the device which reads more than just pkey table length.

For representor device ports which can be in range of hundreds, it
queries is for each such port and end up returning same value for all
the ports.

When in representor mode, modify QP accesses pkey port caps for a port
index that can be outside of the port_caps table.

Hence, simplify the logic to query the max pkey table length only once
during device initialization sequence.

Signed-off-by: Parav Pandit <parav@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/mad.c     |  2 +-
 drivers/infiniband/hw/mlx5/main.c    | 24 ++++++------------------
 drivers/infiniband/hw/mlx5/mlx5_ib.h |  2 +-
 drivers/infiniband/hw/mlx5/qp.c      | 17 ++++-------------
 4 files changed, 12 insertions(+), 33 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/mad.c b/drivers/infiniband/hw/mlx5/mad.c
index e9d0a5269582..cdb47a00e516 100644
--- a/drivers/infiniband/hw/mlx5/mad.c
+++ b/drivers/infiniband/hw/mlx5/mad.c
@@ -549,7 +549,7 @@ int mlx5_query_mad_ifc_port(struct ib_device *ibdev, u8 port,
 	props->port_cap_flags	= be32_to_cpup((__be32 *)(out_mad->data + 20));
 	props->gid_tbl_len	= out_mad->data[50];
 	props->max_msg_sz	= 1 << MLX5_CAP_GEN(mdev, log_max_msg);
-	props->pkey_tbl_len	= dev->port_caps[port - 1].pkey_table_len;
+	props->pkey_tbl_len	= dev->pkey_table_len;
 	props->bad_pkey_cntr	= be16_to_cpup((__be16 *)(out_mad->data + 46));
 	props->qkey_viol_cntr	= be16_to_cpup((__be16 *)(out_mad->data + 48));
 	props->active_width	= out_mad->data[31] & 0xf;
diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index d2f185ae2b9c..364dc3e6a2de 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -816,9 +816,7 @@ static int mlx5_ib_query_device(struct ib_device *ibdev,
 	if (err)
 		return err;
 
-	err = mlx5_query_max_pkeys(ibdev, &props->max_pkeys);
-	if (err)
-		return err;
+	props->max_pkeys = dev->pkey_table_len;
 
 	err = mlx5_query_vendor_id(ibdev, &props->vendor_id);
 	if (err)
@@ -2979,7 +2977,6 @@ static void get_ext_port_caps(struct mlx5_ib_dev *dev)
 
 static int __get_port_caps(struct mlx5_ib_dev *dev, u8 port)
 {
-	struct ib_device_attr *dprops = NULL;
 	struct ib_port_attr *pprops = NULL;
 	int err = -ENOMEM;
 
@@ -2987,16 +2984,6 @@ static int __get_port_caps(struct mlx5_ib_dev *dev, u8 port)
 	if (!pprops)
 		goto out;
 
-	dprops = kmalloc(sizeof(*dprops), GFP_KERNEL);
-	if (!dprops)
-		goto out;
-
-	err = mlx5_ib_query_device(&dev->ib_dev, dprops, NULL);
-	if (err) {
-		mlx5_ib_warn(dev, "query_device failed %d\n", err);
-		goto out;
-	}
-
 	err = mlx5_ib_query_port(&dev->ib_dev, port, pprops);
 	if (err) {
 		mlx5_ib_warn(dev, "query_port %d failed %d\n",
@@ -3004,15 +2991,12 @@ static int __get_port_caps(struct mlx5_ib_dev *dev, u8 port)
 		goto out;
 	}
 
-	dev->port_caps[port - 1].pkey_table_len = dprops->max_pkeys;
 	dev->port_caps[port - 1].gid_table_len = pprops->gid_tbl_len;
 	mlx5_ib_dbg(dev, "port %d: pkey_table_len %d, gid_table_len %d\n",
-		    port, dprops->max_pkeys, pprops->gid_tbl_len);
+		    port, dev->pkey_table_len, pprops->gid_tbl_len);
 
 out:
 	kfree(pprops);
-	kfree(dprops);
-
 	return err;
 }
 
@@ -3979,6 +3963,10 @@ static int mlx5_ib_stage_init_init(struct mlx5_ib_dev *dev)
 	if (err)
 		goto err_mp;
 
+	err = mlx5_query_max_pkeys(&dev->ib_dev, &dev->pkey_table_len);
+	if (err)
+		goto err_mp;
+
 	if (mlx5_use_mad_ifc(dev))
 		get_ext_port_caps(dev);
 
diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
index c2f91c15b973..36a92f3c29e3 100644
--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -1038,7 +1038,6 @@ struct mlx5_var_table {
 
 struct mlx5_port_caps {
 	int gid_table_len;
-	int pkey_table_len;
 	bool has_smi;
 	u8 ext_port_cap;
 };
@@ -1104,6 +1103,7 @@ struct mlx5_ib_dev {
 
 	struct xarray sig_mrs;
 	struct mlx5_port_caps port_caps[MLX5_MAX_PORTS];
+	u16 pkey_table_len;
 };
 
 static inline struct mlx5_ib_cq *to_mibcq(struct mlx5_core_cq *mcq)
diff --git a/drivers/infiniband/hw/mlx5/qp.c b/drivers/infiniband/hw/mlx5/qp.c
index 5274349dd998..475470237e0b 100644
--- a/drivers/infiniband/hw/mlx5/qp.c
+++ b/drivers/infiniband/hw/mlx5/qp.c
@@ -4231,7 +4231,6 @@ int mlx5_ib_modify_qp(struct ib_qp *ibqp, struct ib_qp_attr *attr,
 	enum ib_qp_type qp_type;
 	enum ib_qp_state cur_state, new_state;
 	int err = -EINVAL;
-	int port;
 
 	if (!mlx5_ib_modify_qp_allowed(dev, qp, ibqp->qp_type))
 		return -EOPNOTSUPP;
@@ -4276,10 +4275,6 @@ int mlx5_ib_modify_qp(struct ib_qp *ibqp, struct ib_qp_attr *attr,
 	cur_state = attr_mask & IB_QP_CUR_STATE ? attr->cur_qp_state : qp->state;
 	new_state = attr_mask & IB_QP_STATE ? attr->qp_state : cur_state;
 
-	if (!(cur_state == new_state && cur_state == IB_QPS_RESET)) {
-		port = attr_mask & IB_QP_PORT ? attr->port_num : qp->port;
-	}
-
 	if (qp->flags & IB_QP_CREATE_SOURCE_QPN) {
 		if (attr_mask & ~(IB_QP_STATE | IB_QP_CUR_STATE)) {
 			mlx5_ib_dbg(dev, "invalid attr_mask 0x%x when underlay QP is used\n",
@@ -4308,14 +4303,10 @@ int mlx5_ib_modify_qp(struct ib_qp *ibqp, struct ib_qp_attr *attr,
 		goto out;
 	}
 
-	if (attr_mask & IB_QP_PKEY_INDEX) {
-		port = attr_mask & IB_QP_PORT ? attr->port_num : qp->port;
-		if (attr->pkey_index >=
-		    dev->port_caps[port - 1].pkey_table_len) {
-			mlx5_ib_dbg(dev, "invalid pkey index %d\n",
-				    attr->pkey_index);
-			goto out;
-		}
+	if ((attr_mask & IB_QP_PKEY_INDEX) &&
+	    attr->pkey_index >= dev->pkey_table_len) {
+		mlx5_ib_dbg(dev, "invalid pkey index %d\n", attr->pkey_index);
+		goto out;
 	}
 
 	if (attr_mask & IB_QP_MAX_QP_RD_ATOMIC &&
-- 
2.29.2

