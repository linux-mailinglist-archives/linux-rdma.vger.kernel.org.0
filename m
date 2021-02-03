Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01DC130DA7E
	for <lists+linux-rdma@lfdr.de>; Wed,  3 Feb 2021 14:03:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbhBCNCc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 3 Feb 2021 08:02:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:48570 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229567AbhBCNCZ (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 3 Feb 2021 08:02:25 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4FD9B60203;
        Wed,  3 Feb 2021 13:01:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612357303;
        bh=FvlApsH9ouIY4ELNUAP4rhbMbyZ/ueGEkGEiOyhrm3Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KKte7Gh3dYr/ulEp8cxDZ9g+QM7TDVE+0Ir16xTFAneWfsdKCX4yporgFkCIeHAaU
         ghKAQxgIOovcI/LDHV4i9espC+YRYLkI8CXkYqB51eQqtVOVMTMICE39lz4A97YmCt
         OJu1c/IJhaAW9AK58mjChCaZmKLmbbgsv951JhHyXYY23gEVLITB5wH0d5sm1jPNBC
         buE145YP0F5uKRr/yQTFhDOnThNSvP1wjBbtnj8AGkymelMzYGGMf51NN6SE96KBbp
         oewdcRN3yOJ5L0wIkV0fhtXktnFUFVFEEQNiPoDUIzmM+X72D9c4cDH4I113gtwDy1
         yEFcwwVreTd9Q==
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Parav Pandit <parav@nvidia.com>, linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next v1 1/5] IB/mlx5: Move mlx5_port_caps from mlx5_core_dev to mlx5_ib_dev
Date:   Wed,  3 Feb 2021 15:01:29 +0200
Message-Id: <20210203130133.4057329-2-leon@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210203130133.4057329-1-leon@kernel.org>
References: <20210203130133.4057329-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Parav Pandit <parav@nvidia.com>

mlx5_port_caps are RDMA specific capabilities. These are not used by the
mlx5_core_device at all. Move them to mlx5_ib_dev where it is used and reduce
the scope of it to multiple drivers.

Signed-off-by: Parav Pandit <parav@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/mad.c     |  8 ++++----
 drivers/infiniband/hw/mlx5/main.c    | 14 ++++++--------
 drivers/infiniband/hw/mlx5/mlx5_ib.h |  8 ++++++++
 drivers/infiniband/hw/mlx5/qp.c      |  6 +++---
 drivers/infiniband/hw/mlx5/wr.c      |  2 +-
 include/linux/mlx5/driver.h          |  8 --------
 6 files changed, 22 insertions(+), 24 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/mad.c b/drivers/infiniband/hw/mlx5/mad.c
index 53dec6063245..e9d0a5269582 100644
--- a/drivers/infiniband/hw/mlx5/mad.c
+++ b/drivers/infiniband/hw/mlx5/mad.c
@@ -48,7 +48,7 @@ static bool can_do_mad_ifc(struct mlx5_ib_dev *dev, u8 port_num,
 	if (in_mad->mad_hdr.mgmt_class != IB_MGMT_CLASS_SUBN_LID_ROUTED &&
 	    in_mad->mad_hdr.mgmt_class != IB_MGMT_CLASS_SUBN_DIRECTED_ROUTE)
 		return true;
-	return dev->mdev->port_caps[port_num - 1].has_smi;
+	return dev->port_caps[port_num - 1].has_smi;
 }

 static int mlx5_MAD_IFC(struct mlx5_ib_dev *dev, int ignore_mkey,
@@ -299,7 +299,7 @@ int mlx5_query_ext_port_caps(struct mlx5_ib_dev *dev, u8 port)

 	packet_error = be16_to_cpu(out_mad->status);

-	dev->mdev->port_caps[port - 1].ext_port_cap = (!err && !packet_error) ?
+	dev->port_caps[port - 1].ext_port_cap = (!err && !packet_error) ?
 		MLX_EXT_PORT_CAP_FLAG_EXTENDED_PORT_INFO : 0;

 out:
@@ -549,7 +549,7 @@ int mlx5_query_mad_ifc_port(struct ib_device *ibdev, u8 port,
 	props->port_cap_flags	= be32_to_cpup((__be32 *)(out_mad->data + 20));
 	props->gid_tbl_len	= out_mad->data[50];
 	props->max_msg_sz	= 1 << MLX5_CAP_GEN(mdev, log_max_msg);
-	props->pkey_tbl_len	= mdev->port_caps[port - 1].pkey_table_len;
+	props->pkey_tbl_len	= dev->port_caps[port - 1].pkey_table_len;
 	props->bad_pkey_cntr	= be16_to_cpup((__be16 *)(out_mad->data + 46));
 	props->qkey_viol_cntr	= be16_to_cpup((__be16 *)(out_mad->data + 48));
 	props->active_width	= out_mad->data[31] & 0xf;
@@ -589,7 +589,7 @@ int mlx5_query_mad_ifc_port(struct ib_device *ibdev, u8 port,

 	/* If reported active speed is QDR, check if is FDR-10 */
 	if (props->active_speed == 4) {
-		if (mdev->port_caps[port - 1].ext_port_cap &
+		if (dev->port_caps[port - 1].ext_port_cap &
 		    MLX_EXT_PORT_CAP_FLAG_EXTENDED_PORT_INFO) {
 			init_query_mad(in_mad);
 			in_mad->attr_id = MLX5_ATTR_EXTENDED_PORT_INFO;
diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index 40fb86db3376..d2f185ae2b9c 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -2946,8 +2946,8 @@ static int set_has_smi_cap(struct mlx5_ib_dev *dev)
 	int err;
 	int port;

-	for (port = 1; port <= ARRAY_SIZE(dev->mdev->port_caps); port++) {
-		dev->mdev->port_caps[port - 1].has_smi = false;
+	for (port = 1; port <= ARRAY_SIZE(dev->port_caps); port++) {
+		dev->port_caps[port - 1].has_smi = false;
 		if (MLX5_CAP_GEN(dev->mdev, port_type) ==
 		    MLX5_CAP_PORT_TYPE_IB) {
 			if (MLX5_CAP_GEN(dev->mdev, ib_virt)) {
@@ -2959,10 +2959,10 @@ static int set_has_smi_cap(struct mlx5_ib_dev *dev)
 						    port, err);
 					return err;
 				}
-				dev->mdev->port_caps[port - 1].has_smi =
+				dev->port_caps[port - 1].has_smi =
 					vport_ctx.has_smi;
 			} else {
-				dev->mdev->port_caps[port - 1].has_smi = true;
+				dev->port_caps[port - 1].has_smi = true;
 			}
 		}
 	}
@@ -3004,10 +3004,8 @@ static int __get_port_caps(struct mlx5_ib_dev *dev, u8 port)
 		goto out;
 	}

-	dev->mdev->port_caps[port - 1].pkey_table_len =
-					dprops->max_pkeys;
-	dev->mdev->port_caps[port - 1].gid_table_len =
-					pprops->gid_tbl_len;
+	dev->port_caps[port - 1].pkey_table_len = dprops->max_pkeys;
+	dev->port_caps[port - 1].gid_table_len = pprops->gid_tbl_len;
 	mlx5_ib_dbg(dev, "port %d: pkey_table_len %d, gid_table_len %d\n",
 		    port, dprops->max_pkeys, pprops->gid_tbl_len);

diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
index 2fd2927abe45..c2f91c15b973 100644
--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -1036,6 +1036,13 @@ struct mlx5_var_table {
 	u64 num_var_hw_entries;
 };

+struct mlx5_port_caps {
+	int gid_table_len;
+	int pkey_table_len;
+	bool has_smi;
+	u8 ext_port_cap;
+};
+
 struct mlx5_ib_dev {
 	struct ib_device		ib_dev;
 	struct mlx5_core_dev		*mdev;
@@ -1096,6 +1103,7 @@ struct mlx5_ib_dev {
 	struct mlx5_var_table var_table;

 	struct xarray sig_mrs;
+	struct mlx5_port_caps port_caps[MLX5_MAX_PORTS];
 };

 static inline struct mlx5_ib_cq *to_mibcq(struct mlx5_core_cq *mcq)
diff --git a/drivers/infiniband/hw/mlx5/qp.c b/drivers/infiniband/hw/mlx5/qp.c
index 88be94215708..5274349dd998 100644
--- a/drivers/infiniband/hw/mlx5/qp.c
+++ b/drivers/infiniband/hw/mlx5/qp.c
@@ -3177,10 +3177,10 @@ static int mlx5_set_path(struct mlx5_ib_dev *dev, struct mlx5_ib_qp *qp,

 	if (ah_flags & IB_AH_GRH) {
 		if (grh->sgid_index >=
-		    dev->mdev->port_caps[port - 1].gid_table_len) {
+		    dev->port_caps[port - 1].gid_table_len) {
 			pr_err("sgid_index (%u) too large. max is %d\n",
 			       grh->sgid_index,
-			       dev->mdev->port_caps[port - 1].gid_table_len);
+			       dev->port_caps[port - 1].gid_table_len);
 			return -EINVAL;
 		}
 	}
@@ -4311,7 +4311,7 @@ int mlx5_ib_modify_qp(struct ib_qp *ibqp, struct ib_qp_attr *attr,
 	if (attr_mask & IB_QP_PKEY_INDEX) {
 		port = attr_mask & IB_QP_PORT ? attr->port_num : qp->port;
 		if (attr->pkey_index >=
-		    dev->mdev->port_caps[port - 1].pkey_table_len) {
+		    dev->port_caps[port - 1].pkey_table_len) {
 			mlx5_ib_dbg(dev, "invalid pkey index %d\n",
 				    attr->pkey_index);
 			goto out;
diff --git a/drivers/infiniband/hw/mlx5/wr.c b/drivers/infiniband/hw/mlx5/wr.c
index d6038fb6c50c..cf2852cba45c 100644
--- a/drivers/infiniband/hw/mlx5/wr.c
+++ b/drivers/infiniband/hw/mlx5/wr.c
@@ -1369,7 +1369,7 @@ int mlx5_ib_post_send(struct ib_qp *ibqp, const struct ib_send_wr *wr,
 			handle_qpt_uc(wr, &seg, &size);
 			break;
 		case IB_QPT_SMI:
-			if (unlikely(!mdev->port_caps[qp->port - 1].has_smi)) {
+			if (unlikely(!dev->port_caps[qp->port - 1].has_smi)) {
 				mlx5_ib_warn(dev, "Send SMP MADs is not allowed\n");
 				err = -EPERM;
 				*bad_wr = wr;
diff --git a/include/linux/mlx5/driver.h b/include/linux/mlx5/driver.h
index f93bfe7473aa..11558c2e99f0 100644
--- a/include/linux/mlx5/driver.h
+++ b/include/linux/mlx5/driver.h
@@ -305,13 +305,6 @@ struct mlx5_cmd {
 	struct mlx5_cmd_stats *stats;
 };

-struct mlx5_port_caps {
-	int	gid_table_len;
-	int	pkey_table_len;
-	u8	ext_port_cap;
-	bool	has_smi;
-};
-
 struct mlx5_cmd_mailbox {
 	void	       *buf;
 	dma_addr_t	dma;
@@ -694,7 +687,6 @@ struct mlx5_core_dev {
 	u8			rev_id;
 	char			board_id[MLX5_BOARD_ID_LEN];
 	struct mlx5_cmd		cmd;
-	struct mlx5_port_caps	port_caps[MLX5_MAX_PORTS];
 	struct {
 		u32 hca_cur[MLX5_CAP_NUM][MLX5_UN_SZ_DW(hca_cap_union)];
 		u32 hca_max[MLX5_CAP_NUM][MLX5_UN_SZ_DW(hca_cap_union)];
--
2.29.2

