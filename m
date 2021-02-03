Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6ED9530DA81
	for <lists+linux-rdma@lfdr.de>; Wed,  3 Feb 2021 14:03:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231322AbhBCNCo (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 3 Feb 2021 08:02:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:48730 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229774AbhBCNCf (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 3 Feb 2021 08:02:35 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D613164F6C;
        Wed,  3 Feb 2021 13:01:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612357313;
        bh=AG7VjtbFK+l3OQzlwFA90MwUUda9Nr5l6ccHTEJQFaU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Qwcb43abSbfCmK8aATNtb7Q5HlgnDGdboZYgl0JBX4jPtqtPX45neA+gE/kFWNgth
         YF8+qdjbNSCx80xIo4OSlaiPAF1N+op0pMYW+IJ46kZex38zJKlzqCO00QEqJ6N+Cp
         8Z21Mcc9fdiRNG1OhZhVt3bnJy9Ia1WxxZUEG+1cmuH2sO7DSkgIrTBLduZeMmXkSw
         nxVY8ZGvtjfgoefNcDVC63dxND8GZ37wk4aOBWZIa1AJZTYIIk0LU+0RGeuRboyDKI
         ydRWxykk0F1JlwIaRwZdkRLd2C5cqG1qQmwCiv8P7yGK+tkIDmqzqi8n/EozHL1fbw
         pBJF0DhwvWiGQ==
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Parav Pandit <parav@nvidia.com>, linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next v1 4/5] RDMA/core: Introduce and use API to read port immutable data
Date:   Wed,  3 Feb 2021 15:01:32 +0200
Message-Id: <20210203130133.4057329-5-leon@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210203130133.4057329-1-leon@kernel.org>
References: <20210203130133.4057329-1-leon@kernel.org>
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
index 176f2a866f12..1e1e3edcb1d5 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -2964,41 +2964,6 @@ static void get_ext_port_caps(struct mlx5_ib_dev *dev)
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
@@ -3472,10 +3437,6 @@ static bool mlx5_ib_bind_slave_port(struct mlx5_ib_dev *ibdev,
 	if (err)
 		goto unbind;
 
-	err = get_port_caps(ibdev, mlx5_core_native_port_num(mpi->mdev));
-	if (err)
-		goto unbind;
-
 	err = mlx5_add_netdev_notifier(ibdev, port_num);
 	if (err) {
 		mlx5_ib_err(ibdev, "failed adding netdev notifier for port %u\n",
@@ -3553,11 +3514,9 @@ static int mlx5_ib_init_multiport_master(struct mlx5_ib_dev *dev)
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
@@ -3940,18 +3899,6 @@ static int mlx5_ib_stage_init_init(struct mlx5_ib_dev *dev)
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
index 36a92f3c29e3..0f567d570230 100644
--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -1037,7 +1037,6 @@ struct mlx5_var_table {
 };
 
 struct mlx5_port_caps {
-	int gid_table_len;
 	bool has_smi;
 	u8 ext_port_cap;
 };
diff --git a/drivers/infiniband/hw/mlx5/qp.c b/drivers/infiniband/hw/mlx5/qp.c
index 475470237e0b..358c44c5a8fc 100644
--- a/drivers/infiniband/hw/mlx5/qp.c
+++ b/drivers/infiniband/hw/mlx5/qp.c
@@ -3176,11 +3176,13 @@ static int mlx5_set_path(struct mlx5_ib_dev *dev, struct mlx5_ib_qp *qp,
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

