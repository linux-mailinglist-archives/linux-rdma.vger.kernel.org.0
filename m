Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09DC67A9699
	for <lists+linux-rdma@lfdr.de>; Thu, 21 Sep 2023 19:11:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbjIURBG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 21 Sep 2023 13:01:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbjIURAr (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 21 Sep 2023 13:00:47 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2FB41FC2
        for <linux-rdma@vger.kernel.org>; Thu, 21 Sep 2023 09:59:38 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCC4DC4E670;
        Thu, 21 Sep 2023 12:11:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695298285;
        bh=hL5SyeCT7YzpIfTKOD8Vfi4NtP654EsGBZVUNH6YgtM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VlPwsJ0su1rb+AQA+P0OXW99GMKkOtw6q1F5gUqNQ4/4wUclOuJ4Xd4lvk6ztMS/3
         y0MYMSxuHF3FaCckr9XAdDkSkC25MDem8UjD1lvsMugpshJAkfCX16cpaubkEqrXVc
         rcKy1y9+4QLqYXtLnlUROkq7EQ/ywmxh7I0yoihHm4kiQB6gF1J2nFHEz7Dr3gX6bX
         oatIOoj3whIjcUvx+wE6PYB/OQzg04QNIXgk9qnbrmTp178Iv+V+lYAeYhJya0rcjl
         0vL7++12YbwNhqeOH15zXtq9CH53m8d3YKJKA5EhIEOUkrgMSYg7SVJ/GgTwxEvSVv
         AZl6/3+DDPXLA==
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Patrisious Haddad <phaddad@nvidia.com>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>, linux-rdma@vger.kernel.org,
        Mark Bloch <mbloch@nvidia.com>, netdev@vger.kernel.org,
        Paolo Abeni <pabeni@redhat.com>,
        Saeed Mahameed <saeedm@nvidia.com>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Simon Horman <horms@kernel.org>
Subject: [PATCH mlx5-next 9/9] net/mlx5: Handle IPsec steering upon master unbind/bind
Date:   Thu, 21 Sep 2023 15:10:35 +0300
Message-ID: <8434e88912c588affe51b34669900382a132e873.1695296682.git.leon@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1695296682.git.leon@kernel.org>
References: <cover.1695296682.git.leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Patrisious Haddad <phaddad@nvidia.com>

When the master device is unbinded, make sure to clean up all of the
steering rules or flow tables that were created over the master, in
order to allow proper unbinding of master, and for ethernet traffic
to continue to work independently.

Upon bringing master device back up and attaching the slave to it,
checks if the slave already has IPsec configured and if so reconfigure
the rules needed to support RoCE traffic.

Note that while master device is unbound, the user is unable to
configure IPsec again, since they are in a kind of illegal state in
which they are in MPV mode but the slave has no master.

However if IPsec was configured before hand, it will continue to work
for ethernet traffic while master is unbound, and would continue to
work for all traffic when the master is bound back again.

Signed-off-by: Patrisious Haddad <phaddad@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en.h  |   7 ++
 .../mellanox/mlx5/core/en_accel/ipsec.c       |   1 +
 .../mellanox/mlx5/core/en_accel/ipsec.h       |  24 +++-
 .../mellanox/mlx5/core/en_accel/ipsec_fs.c    | 111 +++++++++++++++++-
 .../mlx5/core/en_accel/ipsec_offload.c        |   3 +-
 .../net/ethernet/mellanox/mlx5/core/en_main.c |  28 ++++-
 .../mellanox/mlx5/core/lib/ipsec_fs_roce.c    |  79 +++++++++----
 .../mellanox/mlx5/core/lib/ipsec_fs_roce.h    |   4 +-
 8 files changed, 225 insertions(+), 32 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en.h b/drivers/net/ethernet/mellanox/mlx5/core/en.h
index 44785a209466..2b3254e33fe5 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en.h
@@ -168,6 +168,13 @@ struct page_pool;
 #define mlx5e_state_dereference(priv, p) \
 	rcu_dereference_protected((p), lockdep_is_held(&(priv)->state_lock))
 
+enum mlx5e_devcom_events {
+	MPV_DEVCOM_MASTER_UP,
+	MPV_DEVCOM_MASTER_DOWN,
+	MPV_DEVCOM_IPSEC_MASTER_UP,
+	MPV_DEVCOM_IPSEC_MASTER_DOWN,
+};
+
 static inline u8 mlx5e_get_num_lag_ports(struct mlx5_core_dev *mdev)
 {
 	if (mlx5_lag_is_lacp_owner(mdev))
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c
index 49354bc036ad..62f9c19f1028 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c
@@ -850,6 +850,7 @@ void mlx5e_ipsec_init(struct mlx5e_priv *priv)
 
 	xa_init_flags(&ipsec->sadb, XA_FLAGS_ALLOC);
 	ipsec->mdev = priv->mdev;
+	init_completion(&ipsec->comp);
 	ipsec->wq = alloc_workqueue("mlx5e_ipsec: %s", WQ_UNBOUND, 0,
 				    priv->netdev->name);
 	if (!ipsec->wq)
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.h b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.h
index dc8e539dc20e..8f4a37bceaf4 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.h
@@ -43,8 +43,6 @@
 #define MLX5E_IPSEC_SADB_RX_BITS 10
 #define MLX5E_IPSEC_ESN_SCOPE_MID 0x80000000L
 
-#define MPV_DEVCOM_MASTER_UP 1
-
 struct aes_gcm_keymat {
 	u64   seq_iv;
 
@@ -224,12 +222,20 @@ struct mlx5e_ipsec_tx_create_attr {
 	enum mlx5_flow_namespace_type chains_ns;
 };
 
+struct mlx5e_ipsec_mpv_work {
+	int event;
+	struct work_struct work;
+	struct mlx5e_priv *slave_priv;
+	struct mlx5e_priv *master_priv;
+};
+
 struct mlx5e_ipsec {
 	struct mlx5_core_dev *mdev;
 	struct xarray sadb;
 	struct mlx5e_ipsec_sw_stats sw_stats;
 	struct mlx5e_ipsec_hw_stats hw_stats;
 	struct workqueue_struct *wq;
+	struct completion comp;
 	struct mlx5e_flow_steering *fs;
 	struct mlx5e_ipsec_rx *rx_ipv4;
 	struct mlx5e_ipsec_rx *rx_ipv6;
@@ -241,6 +247,7 @@ struct mlx5e_ipsec {
 	struct notifier_block netevent_nb;
 	struct mlx5_ipsec_fs *roce;
 	u8 is_uplink_rep: 1;
+	struct mlx5e_ipsec_mpv_work mpv_work;
 };
 
 struct mlx5e_ipsec_esn_state {
@@ -331,6 +338,10 @@ void mlx5e_accel_ipsec_fs_read_stats(struct mlx5e_priv *priv,
 
 void mlx5e_ipsec_build_accel_xfrm_attrs(struct mlx5e_ipsec_sa_entry *sa_entry,
 					struct mlx5_accel_esp_xfrm_attrs *attrs);
+void mlx5e_ipsec_handle_mpv_event(int event, struct mlx5e_priv *slave_priv,
+				  struct mlx5e_priv *master_priv);
+void mlx5e_ipsec_send_event(struct mlx5e_priv *priv, int event);
+
 static inline struct mlx5_core_dev *
 mlx5e_ipsec_sa2dev(struct mlx5e_ipsec_sa_entry *sa_entry)
 {
@@ -366,6 +377,15 @@ static inline u32 mlx5_ipsec_device_caps(struct mlx5_core_dev *mdev)
 {
 	return 0;
 }
+
+static inline void mlx5e_ipsec_handle_mpv_event(int event, struct mlx5e_priv *slave_priv,
+						struct mlx5e_priv *master_priv)
+{
+}
+
+static inline void mlx5e_ipsec_send_event(struct mlx5e_priv *priv, int event)
+{
+}
 #endif
 
 #endif	/* __MLX5E_IPSEC_H__ */
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c
index 86f1542b3ab7..ef4dfc8442a9 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c
@@ -229,6 +229,83 @@ static int ipsec_miss_create(struct mlx5_core_dev *mdev,
 	return err;
 }
 
+static void handle_ipsec_rx_bringup(struct mlx5e_ipsec *ipsec, u32 family)
+{
+	struct mlx5e_ipsec_rx *rx = ipsec_rx(ipsec, family, XFRM_DEV_OFFLOAD_PACKET);
+	struct mlx5_flow_namespace *ns = mlx5e_fs_get_ns(ipsec->fs, false);
+	struct mlx5_flow_destination old_dest, new_dest;
+
+	old_dest = mlx5_ttc_get_default_dest(mlx5e_fs_get_ttc(ipsec->fs, false),
+					     family2tt(family));
+
+	mlx5_ipsec_fs_roce_rx_create(ipsec->mdev, ipsec->roce, ns, &old_dest, family,
+				     MLX5E_ACCEL_FS_ESP_FT_ROCE_LEVEL, MLX5E_NIC_PRIO);
+
+	new_dest.ft = mlx5_ipsec_fs_roce_ft_get(ipsec->roce, family);
+	new_dest.type = MLX5_FLOW_DESTINATION_TYPE_FLOW_TABLE;
+	mlx5_modify_rule_destination(rx->status.rule, &new_dest, &old_dest);
+	mlx5_modify_rule_destination(rx->sa.rule, &new_dest, &old_dest);
+}
+
+static void handle_ipsec_rx_cleanup(struct mlx5e_ipsec *ipsec, u32 family)
+{
+	struct mlx5e_ipsec_rx *rx = ipsec_rx(ipsec, family, XFRM_DEV_OFFLOAD_PACKET);
+	struct mlx5_flow_destination old_dest, new_dest;
+
+	old_dest.ft = mlx5_ipsec_fs_roce_ft_get(ipsec->roce, family);
+	old_dest.type = MLX5_FLOW_DESTINATION_TYPE_FLOW_TABLE;
+	new_dest = mlx5_ttc_get_default_dest(mlx5e_fs_get_ttc(ipsec->fs, false),
+					     family2tt(family));
+	mlx5_modify_rule_destination(rx->sa.rule, &new_dest, &old_dest);
+	mlx5_modify_rule_destination(rx->status.rule, &new_dest, &old_dest);
+
+	mlx5_ipsec_fs_roce_rx_destroy(ipsec->roce, family, ipsec->mdev);
+}
+
+static void ipsec_mpv_work_handler(struct work_struct *_work)
+{
+	struct mlx5e_ipsec_mpv_work *work = container_of(_work, struct mlx5e_ipsec_mpv_work, work);
+	struct mlx5e_ipsec *ipsec = work->slave_priv->ipsec;
+
+	switch (work->event) {
+	case MPV_DEVCOM_IPSEC_MASTER_UP:
+		mutex_lock(&ipsec->tx->ft.mutex);
+		if (ipsec->tx->ft.refcnt)
+			mlx5_ipsec_fs_roce_tx_create(ipsec->mdev, ipsec->roce, ipsec->tx->ft.pol,
+						     true);
+		mutex_unlock(&ipsec->tx->ft.mutex);
+
+		mutex_lock(&ipsec->rx_ipv4->ft.mutex);
+		if (ipsec->rx_ipv4->ft.refcnt)
+			handle_ipsec_rx_bringup(ipsec, AF_INET);
+		mutex_unlock(&ipsec->rx_ipv4->ft.mutex);
+
+		mutex_lock(&ipsec->rx_ipv6->ft.mutex);
+		if (ipsec->rx_ipv6->ft.refcnt)
+			handle_ipsec_rx_bringup(ipsec, AF_INET6);
+		mutex_unlock(&ipsec->rx_ipv6->ft.mutex);
+		break;
+	case MPV_DEVCOM_IPSEC_MASTER_DOWN:
+		mutex_lock(&ipsec->tx->ft.mutex);
+		if (ipsec->tx->ft.refcnt)
+			mlx5_ipsec_fs_roce_tx_destroy(ipsec->roce, ipsec->mdev);
+		mutex_unlock(&ipsec->tx->ft.mutex);
+
+		mutex_lock(&ipsec->rx_ipv4->ft.mutex);
+		if (ipsec->rx_ipv4->ft.refcnt)
+			handle_ipsec_rx_cleanup(ipsec, AF_INET);
+		mutex_unlock(&ipsec->rx_ipv4->ft.mutex);
+
+		mutex_lock(&ipsec->rx_ipv6->ft.mutex);
+		if (ipsec->rx_ipv6->ft.refcnt)
+			handle_ipsec_rx_cleanup(ipsec, AF_INET6);
+		mutex_unlock(&ipsec->rx_ipv6->ft.mutex);
+		break;
+	}
+
+	complete(&work->master_priv->ipsec->comp);
+}
+
 static void ipsec_rx_ft_disconnect(struct mlx5e_ipsec *ipsec, u32 family)
 {
 	struct mlx5_ttc_table *ttc = mlx5e_fs_get_ttc(ipsec->fs, false);
@@ -665,7 +742,7 @@ static int tx_create(struct mlx5e_ipsec *ipsec, struct mlx5e_ipsec_tx *tx,
 	}
 
 connect_roce:
-	err = mlx5_ipsec_fs_roce_tx_create(mdev, roce, tx->ft.pol);
+	err = mlx5_ipsec_fs_roce_tx_create(mdev, roce, tx->ft.pol, false);
 	if (err)
 		goto err_roce;
 	return 0;
@@ -1942,6 +2019,8 @@ int mlx5e_accel_ipsec_fs_init(struct mlx5e_ipsec *ipsec,
 		xa_init_flags(&ipsec->rx_esw->ipsec_obj_id_map, XA_FLAGS_ALLOC1);
 	} else if (mlx5_ipsec_device_caps(mdev) & MLX5_IPSEC_CAP_ROCE) {
 		ipsec->roce = mlx5_ipsec_fs_roce_init(mdev, devcom);
+	} else {
+		mlx5_core_warn(mdev, "IPsec was initialized without RoCE support\n");
 	}
 
 	return 0;
@@ -1988,3 +2067,33 @@ bool mlx5e_ipsec_fs_tunnel_enabled(struct mlx5e_ipsec_sa_entry *sa_entry)
 
 	return rx->allow_tunnel_mode;
 }
+
+void mlx5e_ipsec_handle_mpv_event(int event, struct mlx5e_priv *slave_priv,
+				  struct mlx5e_priv *master_priv)
+{
+	struct mlx5e_ipsec_mpv_work *work;
+
+	reinit_completion(&master_priv->ipsec->comp);
+
+	if (!slave_priv->ipsec) {
+		complete(&master_priv->ipsec->comp);
+		return;
+	}
+
+	work = &slave_priv->ipsec->mpv_work;
+
+	INIT_WORK(&work->work, ipsec_mpv_work_handler);
+	work->event = event;
+	work->slave_priv = slave_priv;
+	work->master_priv = master_priv;
+	queue_work(slave_priv->ipsec->wq, &work->work);
+}
+
+void mlx5e_ipsec_send_event(struct mlx5e_priv *priv, int event)
+{
+	if (!priv->ipsec)
+		return; /* IPsec not supported */
+
+	mlx5_devcom_send_event(priv->devcom, event, event, priv);
+	wait_for_completion(&priv->ipsec->comp);
+}
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_offload.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_offload.c
index 3245d1c9d539..a91f772dc981 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_offload.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_offload.c
@@ -5,6 +5,7 @@
 #include "en.h"
 #include "ipsec.h"
 #include "lib/crypto.h"
+#include "lib/ipsec_fs_roce.h"
 
 enum {
 	MLX5_IPSEC_ASO_REMOVE_FLOW_PKT_CNT_OFFSET,
@@ -63,7 +64,7 @@ u32 mlx5_ipsec_device_caps(struct mlx5_core_dev *mdev)
 			caps |= MLX5_IPSEC_CAP_ESPINUDP;
 	}
 
-	if (mlx5_get_roce_state(mdev) &&
+	if (mlx5_get_roce_state(mdev) && mlx5_ipsec_fs_is_mpv_roce_supported(mdev) &&
 	    MLX5_CAP_GEN_2(mdev, flow_table_type_2_type) & MLX5_FT_NIC_RX_2_NIC_RX_RDMA &&
 	    MLX5_CAP_GEN_2(mdev, flow_table_type_2_type) & MLX5_FT_NIC_TX_RDMA_2_NIC_TX)
 		caps |= MLX5_IPSEC_CAP_ROCE;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index f8054da590c9..44113ab82363 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -183,7 +183,20 @@ static int mlx5e_devcom_event_mpv(int event, void *my_data, void *event_data)
 {
 	struct mlx5e_priv *slave_priv = my_data;
 
-	mlx5_devcom_comp_set_ready(slave_priv->devcom, true);
+	switch (event) {
+	case MPV_DEVCOM_MASTER_UP:
+		mlx5_devcom_comp_set_ready(slave_priv->devcom, true);
+		break;
+	case MPV_DEVCOM_MASTER_DOWN:
+		/* no need for comp set ready false since we unregister after
+		 * and it hurts cleanup flow.
+		 */
+		break;
+	case MPV_DEVCOM_IPSEC_MASTER_UP:
+	case MPV_DEVCOM_IPSEC_MASTER_DOWN:
+		mlx5e_ipsec_handle_mpv_event(event, my_data, event_data);
+		break;
+	}
 
 	return 0;
 }
@@ -198,15 +211,26 @@ static int mlx5e_devcom_init_mpv(struct mlx5e_priv *priv, u64 *data)
 	if (IS_ERR_OR_NULL(priv->devcom))
 		return -EOPNOTSUPP;
 
-	if (mlx5_core_is_mp_master(priv->mdev))
+	if (mlx5_core_is_mp_master(priv->mdev)) {
 		mlx5_devcom_send_event(priv->devcom, MPV_DEVCOM_MASTER_UP,
 				       MPV_DEVCOM_MASTER_UP, priv);
+		mlx5e_ipsec_send_event(priv, MPV_DEVCOM_IPSEC_MASTER_UP);
+	}
 
 	return 0;
 }
 
 static void mlx5e_devcom_cleanup_mpv(struct mlx5e_priv *priv)
 {
+	if (IS_ERR_OR_NULL(priv->devcom))
+		return;
+
+	if (mlx5_core_is_mp_master(priv->mdev)) {
+		mlx5_devcom_send_event(priv->devcom, MPV_DEVCOM_MASTER_DOWN,
+				       MPV_DEVCOM_MASTER_DOWN, priv);
+		mlx5e_ipsec_send_event(priv, MPV_DEVCOM_IPSEC_MASTER_DOWN);
+	}
+
 	mlx5_devcom_unregister_component(priv->devcom);
 }
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/ipsec_fs_roce.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/ipsec_fs_roce.c
index cce2193608cd..234cd00f71a1 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/ipsec_fs_roce.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/ipsec_fs_roce.c
@@ -23,6 +23,7 @@ struct mlx5_ipsec_rx_roce {
 	struct mlx5_flow_handle *nic_master_rule;
 	struct mlx5_flow_table *goto_alias_ft;
 	u32 alias_id;
+	char key[ACCESS_KEY_LEN];
 
 	struct mlx5_flow_table *ft_rdma;
 	struct mlx5_flow_namespace *ns_rdma;
@@ -34,6 +35,7 @@ struct mlx5_ipsec_tx_roce {
 	struct mlx5_flow_handle *rule;
 	struct mlx5_flow_table *goto_alias_ft;
 	u32 alias_id;
+	char key[ACCESS_KEY_LEN];
 	struct mlx5_flow_namespace *ns;
 };
 
@@ -54,37 +56,40 @@ static void ipsec_fs_roce_setup_udp_dport(struct mlx5_flow_spec *spec,
 	MLX5_SET(fte_match_param, spec->match_value, outer_headers.udp_dport, dport);
 }
 
-static bool ipsec_fs_create_alias_supported(struct mlx5_core_dev *mdev,
-					    struct mlx5_core_dev *master_mdev)
+static bool ipsec_fs_create_alias_supported_one(struct mlx5_core_dev *mdev)
 {
-	u64 obj_allowed_m = MLX5_CAP_GEN_2_64(master_mdev, allowed_object_for_other_vhca_access);
-	u32 obj_supp_m = MLX5_CAP_GEN_2(master_mdev, cross_vhca_object_to_object_supported);
 	u64 obj_allowed = MLX5_CAP_GEN_2_64(mdev, allowed_object_for_other_vhca_access);
 	u32 obj_supp = MLX5_CAP_GEN_2(mdev, cross_vhca_object_to_object_supported);
 
 	if (!(obj_supp &
-	    MLX5_CROSS_VHCA_OBJ_TO_OBJ_SUPPORTED_LOCAL_FLOW_TABLE_TO_REMOTE_FLOW_TABLE_MISS) ||
-	    !(obj_supp_m &
 	    MLX5_CROSS_VHCA_OBJ_TO_OBJ_SUPPORTED_LOCAL_FLOW_TABLE_TO_REMOTE_FLOW_TABLE_MISS))
 		return false;
 
-	if (!(obj_allowed & MLX5_ALLOWED_OBJ_FOR_OTHER_VHCA_ACCESS_FLOW_TABLE) ||
-	    !(obj_allowed_m & MLX5_ALLOWED_OBJ_FOR_OTHER_VHCA_ACCESS_FLOW_TABLE))
+	if (!(obj_allowed & MLX5_ALLOWED_OBJ_FOR_OTHER_VHCA_ACCESS_FLOW_TABLE))
 		return false;
 
 	return true;
 }
 
+static bool ipsec_fs_create_alias_supported(struct mlx5_core_dev *mdev,
+					    struct mlx5_core_dev *master_mdev)
+{
+	if (ipsec_fs_create_alias_supported_one(mdev) &&
+	    ipsec_fs_create_alias_supported_one(master_mdev))
+		return true;
+
+	return false;
+}
+
 static int ipsec_fs_create_aliased_ft(struct mlx5_core_dev *ibv_owner,
 				      struct mlx5_core_dev *ibv_allowed,
 				      struct mlx5_flow_table *ft,
-				      u32 *obj_id)
+				      u32 *obj_id, char *alias_key, bool from_event)
 {
 	u32 aliased_object_id = (ft->type << FT_ID_FT_TYPE_OFFSET) | ft->id;
 	u16 vhca_id_to_be_accessed = MLX5_CAP_GEN(ibv_owner, vhca_id);
 	struct mlx5_cmd_allow_other_vhca_access_attr allow_attr = {};
 	struct mlx5_cmd_alias_obj_create_attr alias_attr = {};
-	char key[ACCESS_KEY_LEN];
 	int ret;
 	int i;
 
@@ -92,20 +97,23 @@ static int ipsec_fs_create_aliased_ft(struct mlx5_core_dev *ibv_owner,
 		return -EOPNOTSUPP;
 
 	for (i = 0; i < ACCESS_KEY_LEN; i++)
-		key[i] = get_random_u64() & 0xFF;
+		if (!from_event)
+			alias_key[i] = get_random_u64() & 0xFF;
 
-	memcpy(allow_attr.access_key, key, ACCESS_KEY_LEN);
+	memcpy(allow_attr.access_key, alias_key, ACCESS_KEY_LEN);
 	allow_attr.obj_type = MLX5_GENERAL_OBJECT_TYPES_FLOW_TABLE_ALIAS;
 	allow_attr.obj_id = aliased_object_id;
 
-	ret = mlx5_cmd_allow_other_vhca_access(ibv_owner, &allow_attr);
-	if (ret) {
-		mlx5_core_err(ibv_owner, "Failed to allow other vhca access err=%d\n",
-			      ret);
-		return ret;
+	if (!from_event) {
+		ret = mlx5_cmd_allow_other_vhca_access(ibv_owner, &allow_attr);
+		if (ret) {
+			mlx5_core_err(ibv_owner, "Failed to allow other vhca access err=%d\n",
+				      ret);
+			return ret;
+		}
 	}
 
-	memcpy(alias_attr.access_key, key, ACCESS_KEY_LEN);
+	memcpy(alias_attr.access_key, alias_key, ACCESS_KEY_LEN);
 	alias_attr.obj_id = aliased_object_id;
 	alias_attr.obj_type = MLX5_GENERAL_OBJECT_TYPES_FLOW_TABLE_ALIAS;
 	alias_attr.vhca_id = vhca_id_to_be_accessed;
@@ -268,7 +276,8 @@ static int ipsec_fs_roce_tx_mpv_rule_setup(struct mlx5_core_dev *mdev,
 static int ipsec_fs_roce_tx_mpv_create_ft(struct mlx5_core_dev *mdev,
 					  struct mlx5_ipsec_tx_roce *roce,
 					  struct mlx5_flow_table *pol_ft,
-					  struct mlx5e_priv *peer_priv)
+					  struct mlx5e_priv *peer_priv,
+					  bool from_event)
 {
 	struct mlx5_flow_namespace *roce_ns, *nic_ns;
 	struct mlx5_flow_table_attr ft_attr = {};
@@ -284,7 +293,8 @@ static int ipsec_fs_roce_tx_mpv_create_ft(struct mlx5_core_dev *mdev,
 	if (!nic_ns)
 		return -EOPNOTSUPP;
 
-	err = ipsec_fs_create_aliased_ft(mdev, peer_priv->mdev, pol_ft, &roce->alias_id);
+	err = ipsec_fs_create_aliased_ft(mdev, peer_priv->mdev, pol_ft, &roce->alias_id, roce->key,
+					 from_event);
 	if (err)
 		return err;
 
@@ -365,7 +375,7 @@ static int ipsec_fs_roce_tx_mpv_create_group_rules(struct mlx5_core_dev *mdev,
 static int ipsec_fs_roce_tx_mpv_create(struct mlx5_core_dev *mdev,
 				       struct mlx5_ipsec_fs *ipsec_roce,
 				       struct mlx5_flow_table *pol_ft,
-				       u32 *in)
+				       u32 *in, bool from_event)
 {
 	struct mlx5_devcom_comp_dev *tmp = NULL;
 	struct mlx5_ipsec_tx_roce *roce;
@@ -383,7 +393,7 @@ static int ipsec_fs_roce_tx_mpv_create(struct mlx5_core_dev *mdev,
 
 	roce = &ipsec_roce->tx;
 
-	err = ipsec_fs_roce_tx_mpv_create_ft(mdev, roce, pol_ft, peer_priv);
+	err = ipsec_fs_roce_tx_mpv_create_ft(mdev, roce, pol_ft, peer_priv, from_event);
 	if (err) {
 		mlx5_core_err(mdev, "Fail to create RoCE IPsec tables err=%d\n", err);
 		goto release_peer;
@@ -503,7 +513,7 @@ static int ipsec_fs_roce_rx_mpv_create(struct mlx5_core_dev *mdev,
 	roce->nic_master_group = g;
 
 	err = ipsec_fs_create_aliased_ft(peer_priv->mdev, mdev, roce->nic_master_ft,
-					 &roce->alias_id);
+					 &roce->alias_id, roce->key, false);
 	if (err) {
 		mlx5_core_err(mdev, "Fail to create RoCE IPsec rx alias FT err=%d\n", err);
 		goto destroy_group;
@@ -555,6 +565,9 @@ void mlx5_ipsec_fs_roce_tx_destroy(struct mlx5_ipsec_fs *ipsec_roce,
 
 	tx_roce = &ipsec_roce->tx;
 
+	if (!tx_roce->ft)
+		return; /* Incase RoCE was cleaned from MPV event flow */
+
 	mlx5_del_flow_rules(tx_roce->rule);
 	mlx5_destroy_flow_group(tx_roce->g);
 	mlx5_destroy_flow_table(tx_roce->ft);
@@ -575,11 +588,13 @@ void mlx5_ipsec_fs_roce_tx_destroy(struct mlx5_ipsec_fs *ipsec_roce,
 	mlx5_cmd_alias_obj_destroy(peer_priv->mdev, tx_roce->alias_id,
 				   MLX5_GENERAL_OBJECT_TYPES_FLOW_TABLE_ALIAS);
 	mlx5_devcom_for_each_peer_end(*ipsec_roce->devcom);
+	tx_roce->ft = NULL;
 }
 
 int mlx5_ipsec_fs_roce_tx_create(struct mlx5_core_dev *mdev,
 				 struct mlx5_ipsec_fs *ipsec_roce,
-				 struct mlx5_flow_table *pol_ft)
+				 struct mlx5_flow_table *pol_ft,
+				 bool from_event)
 {
 	struct mlx5_flow_table_attr ft_attr = {};
 	struct mlx5_ipsec_tx_roce *roce;
@@ -599,7 +614,7 @@ int mlx5_ipsec_fs_roce_tx_create(struct mlx5_core_dev *mdev,
 		return -ENOMEM;
 
 	if (mlx5_core_is_mp_slave(mdev)) {
-		err = ipsec_fs_roce_tx_mpv_create(mdev, ipsec_roce, pol_ft, in);
+		err = ipsec_fs_roce_tx_mpv_create(mdev, ipsec_roce, pol_ft, in, from_event);
 		goto free_in;
 	}
 
@@ -668,6 +683,8 @@ void mlx5_ipsec_fs_roce_rx_destroy(struct mlx5_ipsec_fs *ipsec_roce, u32 family,
 
 	rx_roce = (family == AF_INET) ? &ipsec_roce->ipv4_rx :
 					&ipsec_roce->ipv6_rx;
+	if (!rx_roce->ft)
+		return; /* Incase RoCE was cleaned from MPV event flow */
 
 	if (is_mpv_slave)
 		mlx5_del_flow_rules(rx_roce->nic_master_rule);
@@ -679,6 +696,7 @@ void mlx5_ipsec_fs_roce_rx_destroy(struct mlx5_ipsec_fs *ipsec_roce, u32 family,
 	mlx5_destroy_flow_group(rx_roce->roce_miss.group);
 	mlx5_destroy_flow_group(rx_roce->g);
 	mlx5_destroy_flow_table(rx_roce->ft);
+	rx_roce->ft = NULL;
 }
 
 int mlx5_ipsec_fs_roce_rx_create(struct mlx5_core_dev *mdev,
@@ -798,6 +816,17 @@ int mlx5_ipsec_fs_roce_rx_create(struct mlx5_core_dev *mdev,
 	return err;
 }
 
+bool mlx5_ipsec_fs_is_mpv_roce_supported(struct mlx5_core_dev *mdev)
+{
+	if (!mlx5_core_mp_enabled(mdev))
+		return true;
+
+	if (ipsec_fs_create_alias_supported_one(mdev))
+		return true;
+
+	return false;
+}
+
 void mlx5_ipsec_fs_roce_cleanup(struct mlx5_ipsec_fs *ipsec_roce)
 {
 	kfree(ipsec_roce);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/ipsec_fs_roce.h b/drivers/net/ethernet/mellanox/mlx5/core/lib/ipsec_fs_roce.h
index 435a480400e5..2a1af78309fe 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/ipsec_fs_roce.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/ipsec_fs_roce.h
@@ -21,9 +21,11 @@ void mlx5_ipsec_fs_roce_tx_destroy(struct mlx5_ipsec_fs *ipsec_roce,
 				   struct mlx5_core_dev *mdev);
 int mlx5_ipsec_fs_roce_tx_create(struct mlx5_core_dev *mdev,
 				 struct mlx5_ipsec_fs *ipsec_roce,
-				 struct mlx5_flow_table *pol_ft);
+				 struct mlx5_flow_table *pol_ft,
+				 bool from_event);
 void mlx5_ipsec_fs_roce_cleanup(struct mlx5_ipsec_fs *ipsec_roce);
 struct mlx5_ipsec_fs *mlx5_ipsec_fs_roce_init(struct mlx5_core_dev *mdev,
 					      struct mlx5_devcom_comp_dev **devcom);
+bool mlx5_ipsec_fs_is_mpv_roce_supported(struct mlx5_core_dev *mdev);
 
 #endif /* __MLX5_LIB_IPSEC_H__ */
-- 
2.41.0

