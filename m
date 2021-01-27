Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 076B7305FBF
	for <lists+linux-rdma@lfdr.de>; Wed, 27 Jan 2021 16:35:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235516AbhA0PfT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 27 Jan 2021 10:35:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:56472 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235521AbhA0PDi (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 27 Jan 2021 10:03:38 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 957EC217A0;
        Wed, 27 Jan 2021 15:00:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611759651;
        bh=qoxzpFDpyiJSulFLbzk41f+WZkeW35YWyhGpTOhq61g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CYKWUZNPv5mHwdLOJcsCnM8QOgdflCCVOUKkYvVFt0SgR9HMYqUL5v2XpWEcEVEAU
         /R5uRoXseN6VkbG5QtOe+21jjUAnbZ8nXDFU0lR9Wpl6OkA8my0yY+D0Vk2ep/Ns2/
         XNEaWCrQNC+E/xuyzI+Oi2CHQZtu10Gg8FQQfMKlCpnO6WDymxcJtfkvBLEkpPa85N
         BKeBlxWTFblhvj5boIdF3wLvQzG5W0L06oVVbDEsEJWYfpiI7W5ubAm+rr8LFgKUtj
         AbRZcLN+qbAm3mTGwPY9pf7RMM7mRFV034vU6bv97jtCjDAi3Q76ALtwYP72XiC5RA
         OssOhY7eUbs8g==
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Parav Pandit <parav@nvidia.com>, linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next 05/10] RDMA/core: Introduce and use API to read port immutable data
Date:   Wed, 27 Jan 2021 17:00:05 +0200
Message-Id: <20210127150010.1876121-6-leon@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210127150010.1876121-1-leon@kernel.org>
References: <20210127150010.1876121-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Parav Pandit <parav@nvidia.com>

Currently mlx5 driver caches port GID table length for 2 ports.
It is also cached by IB core as port immutable data.

When mlx5 representor ports are present, which are usually more than 2,
invalid access to port_caps array can happen while validating the GID
table length which is only for 2 ports.

To avoid this, take help of the IB cores port immutable data by exposing
an API to read the port immutable fields.

Remove mlx5 driver's internal cache, thereby reduce code and data.

Signed-off-by: Parav Pandit <parav@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/core/device.c     | 14 +++++++
 drivers/infiniband/hw/mlx5/main.c    | 55 +---------------------------
 drivers/infiniband/hw/mlx5/mlx5_ib.h |  1 -
 drivers/infiniband/hw/mlx5/qp.c      |  8 ++--
 include/rdma/ib_verbs.h              |  3 ++
 5 files changed, 23 insertions(+), 58 deletions(-)

diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index c895d7bfa512..051c018fb73c 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -848,6 +848,20 @@ static int setup_port_data(struct ib_device *device)
 	return 0;
 }

+/**
+ * ib_port_immutable_read() - Read rdma port's immutable data
+ * @dev - IB device
+ * @port - port number whose immutable data to read. It starts with index 1 and
+ *         valid upto including rdma_end_port().
+ */
+const struct ib_port_immutable*
+ib_port_immutable_read(struct ib_device *dev, unsigned int port)
+{
+	WARN_ON(!rdma_is_port_valid(dev, port));
+	return &dev->port_data[port].immutable;
+}
+EXPORT_SYMBOL(ib_port_immutable_read);
+
 void ib_get_device_fw_str(struct ib_device *dev, char *str)
 {
 	if (dev->ops.get_dev_fw_str)
diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index 5a7f8fa2f452..742e565309f8 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -2988,41 +2988,6 @@ static void get_ext_port_caps(struct mlx5_ib_dev *dev)
 		mlx5_query_ext_port_caps(dev, port);
 }

-static int __get_port_caps(struct mlx5_ib_dev *dev, u8 port)
-{
-	struct ib_port_attr *pprops = NULL;
-	int err = -ENOMEM;
-
-	pprops = kzalloc(sizeof(*pprops), GFP_KERNEL);
-	if (!pprops)
-		goto out;
-
-	err = mlx5_ib_query_port(&dev->ib_dev, port, pprops);
-	if (err) {
-		mlx5_ib_warn(dev, "query_port %d failed %d\n",
-			     port, err);
-		goto out;
-	}
-
-	dev->port_caps[port - 1].gid_table_len = pprops->gid_tbl_len;
-	mlx5_ib_dbg(dev, "port %d: pkey_table_len %d, gid_table_len %d\n",
-		    port, dev->pkey_table_len, pprops->gid_tbl_len);
-
-out:
-	kfree(pprops);
-	return err;
-}
-
-static int get_port_caps(struct mlx5_ib_dev *dev, u8 port)
-{
-	/* For representors use port 1, is this is the only native
-	 * port
-	 */
-	if (dev->is_rep)
-		return __get_port_caps(dev, 1);
-	return __get_port_caps(dev, port);
-}
-
 static u8 mlx5_get_umr_fence(u8 umr_fence_cap)
 {
 	switch (umr_fence_cap) {
@@ -3496,10 +3461,6 @@ static bool mlx5_ib_bind_slave_port(struct mlx5_ib_dev *ibdev,
 	if (err)
 		goto unbind;

-	err = get_port_caps(ibdev, mlx5_core_native_port_num(mpi->mdev));
-	if (err)
-		goto unbind;
-
 	err = mlx5_add_netdev_notifier(ibdev, port_num);
 	if (err) {
 		mlx5_ib_err(ibdev, "failed adding netdev notifier for port %u\n",
@@ -3577,11 +3538,9 @@ static int mlx5_ib_init_multiport_master(struct mlx5_ib_dev *dev)
 				break;
 			}
 		}
-		if (!bound) {
-			get_port_caps(dev, i + 1);
+		if (!bound)
 			mlx5_ib_dbg(dev, "no free port found for port %d\n",
 				    i + 1);
-		}
 	}

 	list_add_tail(&dev->ib_dev_list, &mlx5_ib_dev_list);
@@ -3964,18 +3923,6 @@ static int mlx5_ib_stage_init_init(struct mlx5_ib_dev *dev)
 	if (err)
 		goto err_mp;

-	if (!mlx5_core_mp_enabled(mdev)) {
-		for (i = 1; i <= dev->num_ports; i++) {
-			err = get_port_caps(dev, i);
-			if (err)
-				break;
-		}
-	} else {
-		err = get_port_caps(dev, mlx5_core_native_port_num(mdev));
-	}
-	if (err)
-		goto err_mp;
-
 	err = mlx5_query_max_pkeys(&dev->ib_dev, &dev->pkey_table_len);
 	if (err)
 		goto err_mp;
diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
index c0c5e0043b3e..69c45adb2518 100644
--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -1034,7 +1034,6 @@ struct mlx5_var_table {
 };

 struct mlx5_port_caps {
-	int gid_table_len;
 	bool has_smi;
 	u8 ext_port_cap;
 };
diff --git a/drivers/infiniband/hw/mlx5/qp.c b/drivers/infiniband/hw/mlx5/qp.c
index b65720a05a18..abdb73fdbec2 100644
--- a/drivers/infiniband/hw/mlx5/qp.c
+++ b/drivers/infiniband/hw/mlx5/qp.c
@@ -3177,11 +3177,13 @@ static int mlx5_set_path(struct mlx5_ib_dev *dev, struct mlx5_ib_qp *qp,
 			 alt ? attr->alt_pkey_index : attr->pkey_index);

 	if (ah_flags & IB_AH_GRH) {
-		if (grh->sgid_index >=
-		    dev->port_caps[port - 1].gid_table_len) {
+		const struct ib_port_immutable *immutable;
+
+		immutable = ib_port_immutable_read(&dev->ib_dev, port);
+		if (grh->sgid_index >= immutable->gid_tbl_len) {
 			pr_err("sgid_index (%u) too large. max is %d\n",
 			       grh->sgid_index,
-			       dev->port_caps[port - 1].gid_table_len);
+			       immutable->gid_tbl_len);
 			return -EINVAL;
 		}
 	}
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 62e574c50555..ca28fca5736b 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -4674,4 +4674,7 @@ static inline u32 rdma_calc_flow_label(u32 lqpn, u32 rqpn)

 	return (u32)(v & IB_GRH_FLOWLABEL_MASK);
 }
+
+const struct ib_port_immutable*
+ib_port_immutable_read(struct ib_device *dev, unsigned int port);
 #endif /* IB_VERBS_H */
--
2.29.2

