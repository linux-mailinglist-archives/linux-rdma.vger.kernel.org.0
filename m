Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61689771E9A
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Aug 2023 12:45:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231193AbjHGKpt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 7 Aug 2023 06:45:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231760AbjHGKpq (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 7 Aug 2023 06:45:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DBF71984
        for <linux-rdma@vger.kernel.org>; Mon,  7 Aug 2023 03:45:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9904B617C1
        for <linux-rdma@vger.kernel.org>; Mon,  7 Aug 2023 10:45:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 754FAC43395;
        Mon,  7 Aug 2023 10:45:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691405113;
        bh=BMFj+9zNjfKUJ6hB1RqKiMDaPx2hLLtpoVHmPOneA8s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ALw7DyMBTKwVfd4dEZIENLooKCGIOibJv5MQtUt76NvcxhZNtBgSl6CALDYb9foYt
         1MYieOttUzKzBNo7e49w2UNZCDd73AoMc9z71/qhVQUstE2kow/SnvDmAeLBHG7omz
         UQUnp1KPapCQwpdbE2mNZLOGkxJ4UpcxDNS7ggUz6xzuiRmf9C/+R/lkCf0wh1KV0G
         J5/scpXGl10dduKUs98VOAhuQ8I5+84hPcUrv2eDXEz7L9JVIVXPkwPgfitC97rCsd
         UKIDUCPt9xmI0i+QJFqnykBnJu7ahvqaZCCgN6NeaiKz6Dl/XMpm0j9H9FCNhpyvUE
         4vJqQvyzF1T7A==
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>, Jakub Kicinski <kuba@kernel.org>
Cc:     Patrisious Haddad <phaddad@nvidia.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, linux-rdma@vger.kernel.org,
        Maor Gottlieb <maorg@nvidia.com>,
        Mark Zhang <markzhang@nvidia.com>, netdev@vger.kernel.org,
        Paolo Abeni <pabeni@redhat.com>, Raed Salem <raeds@nvidia.com>,
        Saeed Mahameed <saeedm@nvidia.com>
Subject: [PATCH mlx5-next 12/14] RDMA/mlx5: Implement MACsec gid addition and deletion
Date:   Mon,  7 Aug 2023 13:44:21 +0300
Message-ID: <a7b5ca2068b0d7e54f100d5f138b7822b7bbb695.1691403485.git.leon@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1691403485.git.leon@kernel.org>
References: <cover.1691403485.git.leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Patrisious Haddad <phaddad@nvidia.com>

Handle MACsec IP ambiguity issue, since mlx5 hw can't support
programming both the MACsec and the physical gid when they have the same
IP address, because it wouldn't know to whom to steer the traffic.
Hence in such case we delete the physical gid from the hw gid table,
which would then cause all traffic sent over it to fail, and we'll only
be able to send traffic over the MACsec gid.

Signed-off-by: Patrisious Haddad <phaddad@nvidia.com>
Reviewed-by: Raed Salem <raeds@nvidia.com>
Reviewed-by: Mark Zhang <markzhang@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/Makefile           |   1 +
 drivers/infiniband/hw/mlx5/macsec.c           | 155 ++++++++++++++++++
 drivers/infiniband/hw/mlx5/macsec.h           |  25 +++
 drivers/infiniband/hw/mlx5/main.c             |  37 ++++-
 drivers/infiniband/hw/mlx5/mlx5_ib.h          |   7 +
 .../mellanox/mlx5/core/en_accel/macsec.c      |  31 ----
 .../mellanox/mlx5/core/en_accel/macsec.h      |   2 -
 include/linux/mlx5/driver.h                   |  44 +++++
 8 files changed, 260 insertions(+), 42 deletions(-)
 create mode 100644 drivers/infiniband/hw/mlx5/macsec.c
 create mode 100644 drivers/infiniband/hw/mlx5/macsec.h

diff --git a/drivers/infiniband/hw/mlx5/Makefile b/drivers/infiniband/hw/mlx5/Makefile
index 612ee8190a2d..72a526236c2e 100644
--- a/drivers/infiniband/hw/mlx5/Makefile
+++ b/drivers/infiniband/hw/mlx5/Makefile
@@ -28,3 +28,4 @@ mlx5_ib-$(CONFIG_INFINIBAND_USER_ACCESS) += devx.o \
 					    fs.o \
 					    qos.o \
 					    std_types.o
+mlx5_ib-$(CONFIG_MLX5_MACSEC) += macsec.o
diff --git a/drivers/infiniband/hw/mlx5/macsec.c b/drivers/infiniband/hw/mlx5/macsec.c
new file mode 100644
index 000000000000..349ad13af75d
--- /dev/null
+++ b/drivers/infiniband/hw/mlx5/macsec.c
@@ -0,0 +1,155 @@
+// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
+/* Copyright (c) 2022, NVIDIA CORPORATION & AFFILIATES. */
+
+#include "macsec.h"
+
+struct mlx5_reserved_gids {
+	int macsec_index;
+	const struct ib_gid_attr *physical_gid;
+};
+
+int mlx5r_macsec_alloc_gids(struct mlx5_ib_dev *dev)
+{
+	int i, j, max_gids;
+
+	if (!mlx5_is_macsec_roce_supported(dev->mdev)) {
+		mlx5_ib_dbg(dev, "RoCE MACsec not supported due to capabilities\n");
+		return 0;
+	}
+
+	max_gids = MLX5_CAP_ROCE(dev->mdev, roce_address_table_size);
+	for (i = 0; i < dev->num_ports; i++) {
+		dev->port[i].reserved_gids = kcalloc(max_gids,
+						     sizeof(*dev->port[i].reserved_gids),
+						     GFP_KERNEL);
+		if (!dev->port[i].reserved_gids)
+			goto err;
+
+		for (j = 0; j < max_gids; j++)
+			dev->port[i].reserved_gids[j].macsec_index = -1;
+	}
+
+	return 0;
+err:
+	while (i >= 0) {
+		kfree(dev->port[i].reserved_gids);
+		i--;
+	}
+	return -ENOMEM;
+}
+
+void mlx5r_macsec_dealloc_gids(struct mlx5_ib_dev *dev)
+{
+	int i;
+
+	if (!mlx5_is_macsec_roce_supported(dev->mdev))
+		mlx5_ib_dbg(dev, "RoCE MACsec not supported due to capabilities\n");
+
+	for (i = 0; i < dev->num_ports; i++)
+		kfree(dev->port[i].reserved_gids);
+}
+
+int mlx5r_add_gid_macsec_operations(const struct ib_gid_attr *attr)
+{
+	struct mlx5_ib_dev *dev = to_mdev(attr->device);
+	const struct ib_gid_attr *physical_gid;
+	struct mlx5_reserved_gids *mgids;
+	struct net_device *ndev;
+	int ret = 0;
+
+	if (attr->gid_type != IB_GID_TYPE_ROCE_UDP_ENCAP)
+		return 0;
+
+	if (!mlx5_is_macsec_roce_supported(dev->mdev)) {
+		mlx5_ib_dbg(dev, "RoCE MACsec not supported due to capabilities\n");
+		return 0;
+	}
+
+	rcu_read_lock();
+	ndev = rcu_dereference(attr->ndev);
+	if (!ndev) {
+		rcu_read_unlock();
+		return -ENODEV;
+	}
+
+	if (!netif_is_macsec(ndev) || !macsec_netdev_is_offloaded(ndev)) {
+		rcu_read_unlock();
+		return 0;
+	}
+	rcu_read_unlock();
+
+	physical_gid = rdma_find_gid(attr->device, &attr->gid,
+				     attr->gid_type, NULL);
+	if (IS_ERR(physical_gid))
+		return 0;
+
+	ret = set_roce_addr(to_mdev(physical_gid->device),
+			    physical_gid->port_num,
+			    physical_gid->index, NULL,
+			    physical_gid);
+	if (ret)
+		goto gid_err;
+
+	mgids = &dev->port[attr->port_num - 1].reserved_gids[physical_gid->index];
+	mgids->macsec_index = attr->index;
+	mgids->physical_gid = physical_gid;
+
+	return 0;
+
+gid_err:
+	rdma_put_gid_attr(physical_gid);
+	return ret;
+}
+
+void mlx5r_del_gid_macsec_operations(const struct ib_gid_attr *attr)
+{
+	struct mlx5_ib_dev *dev = to_mdev(attr->device);
+	struct mlx5_reserved_gids *mgids;
+	struct net_device *ndev;
+	int i, max_gids;
+
+	if (attr->gid_type != IB_GID_TYPE_ROCE_UDP_ENCAP)
+		return;
+
+	if (!mlx5_is_macsec_roce_supported(dev->mdev)) {
+		mlx5_ib_dbg(dev, "RoCE MACsec not supported due to capabilities\n");
+		return;
+	}
+
+	mgids = &dev->port[attr->port_num - 1].reserved_gids[attr->index];
+	if (mgids->macsec_index != -1) { /* Checking if physical gid has ambiguous IP */
+		rdma_put_gid_attr(mgids->physical_gid);
+		mgids->macsec_index = -1;
+		return;
+	}
+
+	rcu_read_lock();
+	ndev = rcu_dereference(attr->ndev);
+	if (!ndev) {
+		rcu_read_unlock();
+		return;
+	}
+
+	if (!netif_is_macsec(ndev) || !macsec_netdev_is_offloaded(ndev)) {
+		rcu_read_unlock();
+		return;
+	}
+	rcu_read_unlock();
+
+	max_gids = MLX5_CAP_ROCE(dev->mdev, roce_address_table_size);
+	for (i = 0; i < max_gids; i++) { /* Checking if macsec gid has ambiguous IP */
+		mgids = &dev->port[attr->port_num - 1].reserved_gids[i];
+		if (mgids->macsec_index == attr->index) {
+			const struct ib_gid_attr *physical_gid = mgids->physical_gid;
+
+			set_roce_addr(to_mdev(physical_gid->device),
+				      physical_gid->port_num,
+				      physical_gid->index,
+				      &physical_gid->gid, physical_gid);
+
+			rdma_put_gid_attr(physical_gid);
+			mgids->macsec_index = -1;
+			break;
+		}
+	}
+}
diff --git a/drivers/infiniband/hw/mlx5/macsec.h b/drivers/infiniband/hw/mlx5/macsec.h
new file mode 100644
index 000000000000..b60f8f046d6f
--- /dev/null
+++ b/drivers/infiniband/hw/mlx5/macsec.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB */
+/* Copyright (c) 2022, NVIDIA CORPORATION & AFFILIATES. */
+
+#ifndef __MLX5_MACSEC_H__
+#define __MLX5_MACSEC_H__
+
+#include <net/macsec.h>
+#include <rdma/ib_cache.h>
+#include <rdma/ib_addr.h>
+#include "mlx5_ib.h"
+
+#ifdef CONFIG_MLX5_MACSEC
+struct mlx5_reserved_gids;
+
+int mlx5r_add_gid_macsec_operations(const struct ib_gid_attr *attr);
+void mlx5r_del_gid_macsec_operations(const struct ib_gid_attr *attr);
+int mlx5r_macsec_alloc_gids(struct mlx5_ib_dev *dev);
+void mlx5r_macsec_dealloc_gids(struct mlx5_ib_dev *dev);
+#else
+static inline int mlx5r_add_gid_macsec_operations(const struct ib_gid_attr *attr) { return 0; }
+static inline void mlx5r_del_gid_macsec_operations(const struct ib_gid_attr *attr) {}
+static inline int mlx5r_macsec_alloc_gids(struct mlx5_ib_dev *dev) { return 0; }
+static inline void mlx5r_macsec_dealloc_gids(struct mlx5_ib_dev *dev) {}
+#endif
+#endif /* __MLX5_MACSEC_H__ */
diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index f0b394ed7452..f463cf8b7501 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -46,6 +46,7 @@
 #include <rdma/uverbs_ioctl.h>
 #include <rdma/mlx5_user_ioctl_verbs.h>
 #include <rdma/mlx5_user_ioctl_cmds.h>
+#include "macsec.h"
 
 #define UVERBS_MODULE_NAME mlx5_ib
 #include <rdma/uverbs_named_ioctl.h>
@@ -564,9 +565,9 @@ static int mlx5_query_port_roce(struct ib_device *device, u32 port_num,
 	return err;
 }
 
-static int set_roce_addr(struct mlx5_ib_dev *dev, u32 port_num,
-			 unsigned int index, const union ib_gid *gid,
-			 const struct ib_gid_attr *attr)
+int set_roce_addr(struct mlx5_ib_dev *dev, u32 port_num,
+		  unsigned int index, const union ib_gid *gid,
+		  const struct ib_gid_attr *attr)
 {
 	enum ib_gid_type gid_type;
 	u16 vlan_id = 0xffff;
@@ -607,6 +608,12 @@ static int set_roce_addr(struct mlx5_ib_dev *dev, u32 port_num,
 static int mlx5_ib_add_gid(const struct ib_gid_attr *attr,
 			   __always_unused void **context)
 {
+	int ret;
+
+	ret = mlx5r_add_gid_macsec_operations(attr);
+	if (ret)
+		return ret;
+
 	return set_roce_addr(to_mdev(attr->device), attr->port_num,
 			     attr->index, &attr->gid, attr);
 }
@@ -614,8 +621,15 @@ static int mlx5_ib_add_gid(const struct ib_gid_attr *attr,
 static int mlx5_ib_del_gid(const struct ib_gid_attr *attr,
 			   __always_unused void **context)
 {
-	return set_roce_addr(to_mdev(attr->device), attr->port_num,
-			     attr->index, NULL, attr);
+	int ret;
+
+	ret = set_roce_addr(to_mdev(attr->device), attr->port_num,
+			    attr->index, NULL, attr);
+	if (ret)
+		return ret;
+
+	mlx5r_del_gid_macsec_operations(attr);
+	return 0;
 }
 
 __be16 mlx5_get_roce_udp_sport_min(const struct mlx5_ib_dev *dev,
@@ -3644,13 +3658,13 @@ static void mlx5_ib_stage_init_cleanup(struct mlx5_ib_dev *dev)
 	mutex_destroy(&dev->cap_mask_mutex);
 	WARN_ON(!xa_empty(&dev->sig_mrs));
 	WARN_ON(!bitmap_empty(dev->dm.memic_alloc_pages, MLX5_MAX_MEMIC_PAGES));
+	mlx5r_macsec_dealloc_gids(dev);
 }
 
 static int mlx5_ib_stage_init_init(struct mlx5_ib_dev *dev)
 {
 	struct mlx5_core_dev *mdev = dev->mdev;
-	int err;
-	int i;
+	int err, i;
 
 	dev->ib_dev.node_type = RDMA_NODE_IB_CA;
 	dev->ib_dev.local_dma_lkey = 0 /* not supported for now */;
@@ -3670,10 +3684,14 @@ static int mlx5_ib_stage_init_init(struct mlx5_ib_dev *dev)
 	if (err)
 		return err;
 
-	err = mlx5_ib_init_multiport_master(dev);
+	err = mlx5r_macsec_alloc_gids(dev);
 	if (err)
 		return err;
 
+	err = mlx5_ib_init_multiport_master(dev);
+	if (err)
+		goto err;
+
 	err = set_has_smi_cap(dev);
 	if (err)
 		goto err_mp;
@@ -3697,7 +3715,8 @@ static int mlx5_ib_stage_init_init(struct mlx5_ib_dev *dev)
 	spin_lock_init(&dev->dm.lock);
 	dev->dm.dev = mdev;
 	return 0;
-
+err:
+	mlx5r_macsec_dealloc_gids(dev);
 err_mp:
 	mlx5_ib_cleanup_multiport_master(dev);
 	return err;
diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
index 9c33d960af3c..a4b940b5035f 100644
--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -26,6 +26,7 @@
 
 #include "srq.h"
 #include "qp.h"
+#include "macsec.h"
 
 #define mlx5_ib_dbg(_dev, format, arg...)                                      \
 	dev_dbg(&(_dev)->ib_dev.dev, "%s:%d:(pid %d): " format, __func__,      \
@@ -870,6 +871,9 @@ struct mlx5_ib_port {
 	struct mlx5_ib_dbg_cc_params *dbg_cc_params;
 	struct mlx5_roce roce;
 	struct mlx5_eswitch_rep		*rep;
+#ifdef CONFIG_MLX5_MACSEC
+	struct mlx5_reserved_gids *reserved_gids;
+#endif
 };
 
 struct mlx5_ib_dbg_param {
@@ -1648,4 +1652,7 @@ static inline bool mlx5_umem_needs_ats(struct mlx5_ib_dev *dev,
 	return access_flags & IB_ACCESS_RELAXED_ORDERING;
 }
 
+int set_roce_addr(struct mlx5_ib_dev *dev, u32 port_num,
+		  unsigned int index, const union ib_gid *gid,
+		  const struct ib_gid_attr *attr);
 #endif /* MLX5_IB_H */
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec.c
index b4f3f4f10af3..c9c1db971652 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec.c
@@ -1607,37 +1607,6 @@ static void mlx5e_macsec_aso_cleanup(struct mlx5e_macsec_aso *aso, struct mlx5_c
 	mlx5_core_dealloc_pd(mdev, aso->pdn);
 }
 
-bool mlx5e_is_macsec_device(const struct mlx5_core_dev *mdev)
-{
-	if (!(MLX5_CAP_GEN_64(mdev, general_obj_types) &
-	    MLX5_GENERAL_OBJ_TYPES_CAP_MACSEC_OFFLOAD))
-		return false;
-
-	if (!MLX5_CAP_GEN(mdev, log_max_dek))
-		return false;
-
-	if (!MLX5_CAP_MACSEC(mdev, log_max_macsec_offload))
-		return false;
-
-	if (!MLX5_CAP_FLOWTABLE_NIC_RX(mdev, macsec_decrypt) ||
-	    !MLX5_CAP_FLOWTABLE_NIC_RX(mdev, reformat_remove_macsec))
-		return false;
-
-	if (!MLX5_CAP_FLOWTABLE_NIC_TX(mdev, macsec_encrypt) ||
-	    !MLX5_CAP_FLOWTABLE_NIC_TX(mdev, reformat_add_macsec))
-		return false;
-
-	if (!MLX5_CAP_MACSEC(mdev, macsec_crypto_esp_aes_gcm_128_encrypt) &&
-	    !MLX5_CAP_MACSEC(mdev, macsec_crypto_esp_aes_gcm_256_encrypt))
-		return false;
-
-	if (!MLX5_CAP_MACSEC(mdev, macsec_crypto_esp_aes_gcm_128_decrypt) &&
-	    !MLX5_CAP_MACSEC(mdev, macsec_crypto_esp_aes_gcm_256_decrypt))
-		return false;
-
-	return true;
-}
-
 static const struct macsec_ops macsec_offload_ops = {
 	.mdo_add_txsa = mlx5e_macsec_add_txsa,
 	.mdo_upd_txsa = mlx5e_macsec_upd_txsa,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec.h b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec.h
index 2ecd769585f4..27df72e23106 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec.h
@@ -36,7 +36,6 @@ static inline bool mlx5e_macsec_is_rx_flow(struct mlx5_cqe64 *cqe)
 
 void mlx5e_macsec_offload_handle_rx_skb(struct net_device *netdev, struct sk_buff *skb,
 					struct mlx5_cqe64 *cqe);
-bool mlx5e_is_macsec_device(const struct mlx5_core_dev *mdev);
 
 #else
 
@@ -49,7 +48,6 @@ static inline void mlx5e_macsec_offload_handle_rx_skb(struct net_device *netdev,
 						      struct sk_buff *skb,
 						      struct mlx5_cqe64 *cqe)
 {}
-static inline bool mlx5e_is_macsec_device(const struct mlx5_core_dev *mdev) { return false; }
 #endif  /* CONFIG_MLX5_MACSEC */
 
 #endif	/* __MLX5_ACCEL_EN_MACSEC_H__ */
diff --git a/include/linux/mlx5/driver.h b/include/linux/mlx5/driver.h
index c3c64bcae4fa..848993823ba5 100644
--- a/include/linux/mlx5/driver.h
+++ b/include/linux/mlx5/driver.h
@@ -1328,6 +1328,50 @@ static inline bool mlx5_get_roce_state(struct mlx5_core_dev *dev)
 	return mlx5_is_roce_on(dev);
 }
 
+static inline bool mlx5e_is_macsec_device(const struct mlx5_core_dev *mdev)
+{
+	if (!(MLX5_CAP_GEN_64(mdev, general_obj_types) &
+	    MLX5_GENERAL_OBJ_TYPES_CAP_MACSEC_OFFLOAD))
+		return false;
+
+	if (!MLX5_CAP_GEN(mdev, log_max_dek))
+		return false;
+
+	if (!MLX5_CAP_MACSEC(mdev, log_max_macsec_offload))
+		return false;
+
+	if (!MLX5_CAP_FLOWTABLE_NIC_RX(mdev, macsec_decrypt) ||
+	    !MLX5_CAP_FLOWTABLE_NIC_RX(mdev, reformat_remove_macsec))
+		return false;
+
+	if (!MLX5_CAP_FLOWTABLE_NIC_TX(mdev, macsec_encrypt) ||
+	    !MLX5_CAP_FLOWTABLE_NIC_TX(mdev, reformat_add_macsec))
+		return false;
+
+	if (!MLX5_CAP_MACSEC(mdev, macsec_crypto_esp_aes_gcm_128_encrypt) &&
+	    !MLX5_CAP_MACSEC(mdev, macsec_crypto_esp_aes_gcm_256_encrypt))
+		return false;
+
+	if (!MLX5_CAP_MACSEC(mdev, macsec_crypto_esp_aes_gcm_128_decrypt) &&
+	    !MLX5_CAP_MACSEC(mdev, macsec_crypto_esp_aes_gcm_256_decrypt))
+		return false;
+
+	return true;
+}
+
+#define NIC_RDMA_BOTH_DIRS_CAPS (MLX5_FT_NIC_RX_2_NIC_RX_RDMA | MLX5_FT_NIC_TX_RDMA_2_NIC_TX)
+
+static inline bool mlx5_is_macsec_roce_supported(struct mlx5_core_dev *mdev)
+{
+	if (((MLX5_CAP_GEN_2(mdev, flow_table_type_2_type) &
+	     NIC_RDMA_BOTH_DIRS_CAPS) != NIC_RDMA_BOTH_DIRS_CAPS) ||
+	     !MLX5_CAP_FLOWTABLE_RDMA_TX(mdev, max_modify_header_actions) ||
+	     !mlx5e_is_macsec_device(mdev))
+		return false;
+
+	return true;
+}
+
 enum {
 	MLX5_OCTWORD = 16,
 };
-- 
2.41.0

