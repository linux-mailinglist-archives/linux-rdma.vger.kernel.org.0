Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50BC0775559
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Aug 2023 10:30:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231953AbjHIIav (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 9 Aug 2023 04:30:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231956AbjHIIau (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 9 Aug 2023 04:30:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88C281FD5
        for <linux-rdma@vger.kernel.org>; Wed,  9 Aug 2023 01:30:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5B83463068
        for <linux-rdma@vger.kernel.org>; Wed,  9 Aug 2023 08:30:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B484C433C7;
        Wed,  9 Aug 2023 08:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691569835;
        bh=5X9GkzFeahjhr+v8WuOah3JXr9xMYf4rNiBzcoWu00g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Chzv5G/tSMY0y+V3pB5mY8+Fq08NANP3pHBj4lUjLbdN1IQtYOCfwO4BmL7lSreMH
         SDYu5rmAqkqEs/0QG5lNTpaSL6AGQMbysgqTPGNivWoGG/BMNa/LBgQhSrBnJ6OvII
         uJ3To5s1jjl4Eac505VYkfUbYkZudUD1H++sakBGM4mzidpHLcHkoDPICAxQwNRp2Q
         vwQn3iWYeIHtPxoMkbHekJF1SWC2nYJnnr1eCP21Z6I1G66v/sxsmEit8pbNd2KkLj
         2TwFMlSWvu/Kt5HhS2igfVnVWM4mi5lw42meV1dwaWoZgmF0g4uUVlwv1F/Cu5x04e
         ZHZ5ANkKV0X0w==
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>, Jakub Kicinski <kuba@kernel.org>
Cc:     Patrisious Haddad <phaddad@nvidia.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, linux-rdma@vger.kernel.org,
        Maor Gottlieb <maorg@nvidia.com>,
        Mark Zhang <markzhang@nvidia.com>, netdev@vger.kernel.org,
        Paolo Abeni <pabeni@redhat.com>, Raed Salem <raeds@nvidia.com>,
        Saeed Mahameed <saeedm@nvidia.com>
Subject: [PATCH mlx5-next v1 13/14] net/mlx5: Add RoCE MACsec steering infrastructure in core
Date:   Wed,  9 Aug 2023 11:29:25 +0300
Message-ID: <ba60937852239a0cf4b11333104fd88103a70fd9.1691569414.git.leon@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1691569414.git.leon@kernel.org>
References: <cover.1691569414.git.leon@kernel.org>
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

Adds all the core steering helper functions that are needed in order
to setup RoCE steering rules which includes both the RX and TX rules
addition and deletion.
As well as exporting the function to be ready to use from the IB driver
where we expose functions to allow deletion of all rules, which is
needed when a GID is deleted, or a deletion of a specific rule when an SA
is deleted, and a similar manner for the rules addition.

These functions are used in a later patch by IB driver to trigger the
rules addition/deletion when needed.

Signed-off-by: Patrisious Haddad <phaddad@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/fs_cmd.c  |   1 +
 .../mellanox/mlx5/core/lib/macsec_fs.c        | 399 +++++++++++++++++-
 include/linux/mlx5/device.h                   |   2 +
 include/linux/mlx5/driver.h                   |   2 +
 include/linux/mlx5/macsec.h                   |  32 ++
 5 files changed, 427 insertions(+), 9 deletions(-)
 create mode 100644 include/linux/mlx5/macsec.h

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fs_cmd.c b/drivers/net/ethernet/mellanox/mlx5/core/fs_cmd.c
index aab7059bf6e9..51c13d8cc55e 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fs_cmd.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fs_cmd.c
@@ -967,6 +967,7 @@ static int mlx5_cmd_modify_header_alloc(struct mlx5_flow_root_namespace *ns,
 		max_actions = MLX5_CAP_ESW_INGRESS_ACL(dev, max_modify_header_actions);
 		table_type = FS_FT_ESW_INGRESS_ACL;
 		break;
+	case MLX5_FLOW_NAMESPACE_RDMA_TX_MACSEC:
 	case MLX5_FLOW_NAMESPACE_RDMA_TX:
 		max_actions = MLX5_CAP_FLOWTABLE_RDMA_TX(dev, max_modify_header_actions);
 		table_type = FS_FT_RDMA_TX;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/macsec_fs.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/macsec_fs.c
index be909b613288..4a078113e292 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/macsec_fs.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/macsec_fs.c
@@ -4,6 +4,8 @@
 #include <net/macsec.h>
 #include <linux/mlx5/qp.h>
 #include <linux/if_vlan.h>
+#include <linux/mlx5/fs_helpers.h>
+#include <linux/mlx5/macsec.h>
 #include "fs_core.h"
 #include "lib/macsec_fs.h"
 #include "mlx5_core.h"
@@ -46,6 +48,10 @@
 /* MACsec RX flow steering */
 #define MLX5_ETH_WQE_FT_META_MACSEC_MASK 0x3E
 
+/* MACsec fs_id handling for steering */
+#define macsec_fs_set_tx_fs_id(fs_id) (MLX5_ETH_WQE_FT_META_MACSEC | (fs_id) << 2)
+#define macsec_fs_set_rx_fs_id(fs_id) ((fs_id) | BIT(30))
+
 struct mlx5_sectag_header {
 	__be16 ethertype;
 	u8 tci_an;
@@ -54,6 +60,14 @@ struct mlx5_sectag_header {
 	u8 sci[MACSEC_SCI_LEN]; /* optional */
 }  __packed;
 
+struct mlx5_roce_macsec_tx_rule {
+	u32 fs_id;
+	u16 gid_idx;
+	struct list_head entry;
+	struct mlx5_flow_handle *rule;
+	struct mlx5_modify_hdr *meta_modhdr;
+};
+
 struct mlx5_macsec_tx_rule {
 	struct mlx5_flow_handle *rule;
 	struct mlx5_pkt_reformat *pkt_reformat;
@@ -104,6 +118,14 @@ struct mlx5_macsec_tx {
 	struct mlx5_flow_table *ft_rdma_tx;
 };
 
+struct mlx5_roce_macsec_rx_rule {
+	u32 fs_id;
+	u16 gid_idx;
+	struct mlx5_flow_handle *op;
+	struct mlx5_flow_handle *ip;
+	struct list_head entry;
+};
+
 struct mlx5_macsec_rx_rule {
 	struct mlx5_flow_handle *rule[RX_NUM_OF_RULES_PER_SA];
 	struct mlx5_modify_hdr *meta_modhdr;
@@ -575,7 +597,7 @@ static int macsec_fs_tx_setup_fte(struct mlx5_macsec_fs *macsec_fs,
 	MLX5_SET(fte_match_param, spec->match_criteria, misc_parameters_2.metadata_reg_a,
 		 MLX5_ETH_WQE_FT_META_MACSEC_MASK);
 	MLX5_SET(fte_match_param, spec->match_value, misc_parameters_2.metadata_reg_a,
-		 MLX5_ETH_WQE_FT_META_MACSEC | id << 2);
+		 macsec_fs_set_tx_fs_id(id));
 
 	*fs_id = id;
 	flow_act->crypto.type = MLX5_FLOW_CONTEXT_ENCRYPT_DECRYPT_TYPE_MACSEC;
@@ -777,7 +799,7 @@ static void macsec_fs_tx_del_rule(struct mlx5_macsec_fs *macsec_fs,
 static union mlx5_macsec_rule *
 macsec_fs_tx_add_rule(struct mlx5_macsec_fs *macsec_fs,
 		      const struct macsec_context *macsec_ctx,
-		      struct mlx5_macsec_rule_attrs *attrs)
+		      struct mlx5_macsec_rule_attrs *attrs, u32 *fs_id)
 {
 	char reformatbf[MLX5_MACSEC_TAG_LEN + MACSEC_SCI_LEN];
 	struct mlx5_pkt_reformat_params reformat_params = {};
@@ -792,7 +814,6 @@ macsec_fs_tx_add_rule(struct mlx5_macsec_fs *macsec_fs,
 	struct mlx5_flow_spec *spec;
 	size_t reformat_size;
 	int err = 0;
-	u32 fs_id;
 
 	tx_tables = &tx_fs->tables;
 
@@ -832,7 +853,7 @@ macsec_fs_tx_add_rule(struct mlx5_macsec_fs *macsec_fs,
 	}
 	tx_rule->pkt_reformat = flow_act.pkt_reformat;
 
-	err = macsec_fs_tx_setup_fte(macsec_fs, spec, &flow_act, attrs->macsec_obj_id, &fs_id);
+	err = macsec_fs_tx_setup_fte(macsec_fs, spec, &flow_act, attrs->macsec_obj_id, fs_id);
 	if (err) {
 		mlx5_core_err(mdev,
 			      "Failed to add packet reformat for MACsec TX crypto rule, err=%d\n",
@@ -840,7 +861,7 @@ macsec_fs_tx_add_rule(struct mlx5_macsec_fs *macsec_fs,
 		goto err;
 	}
 
-	tx_rule->fs_id = fs_id;
+	tx_rule->fs_id = *fs_id;
 
 	flow_act.action = MLX5_FLOW_CONTEXT_ACTION_FWD_DEST |
 			  MLX5_FLOW_CONTEXT_ACTION_CRYPTO_ENCRYPT |
@@ -855,7 +876,7 @@ macsec_fs_tx_add_rule(struct mlx5_macsec_fs *macsec_fs,
 	}
 	tx_rule->rule = rule;
 
-	err = macsec_fs_id_add(&macsec_fs->macsec_devices_list, fs_id, macsec_ctx->secy->netdev,
+	err = macsec_fs_id_add(&macsec_fs->macsec_devices_list, *fs_id, macsec_ctx->secy->netdev,
 			       &macsec_fs->sci_hash, attrs->sci, true);
 	if (err) {
 		mlx5_core_err(mdev, "Failed to save fs_id, err=%d\n", err);
@@ -1744,7 +1765,7 @@ macsec_fs_rx_add_rule(struct mlx5_macsec_fs *macsec_fs,
 	/* Set bit[15-0] fs id */
 	MLX5_SET(set_action_in, action, action_type, MLX5_ACTION_TYPE_SET);
 	MLX5_SET(set_action_in, action, field, MLX5_ACTION_IN_FIELD_METADATA_REG_B);
-	MLX5_SET(set_action_in, action, data, MLX5_MACSEC_RX_METADAT_HANDLE(fs_id) | BIT(30));
+	MLX5_SET(set_action_in, action, data, macsec_fs_set_rx_fs_id(fs_id));
 	MLX5_SET(set_action_in, action, offset, 0);
 	MLX5_SET(set_action_in, action, length, 32);
 
@@ -1903,6 +1924,114 @@ static void macsec_fs_rx_cleanup(struct mlx5_macsec_fs *macsec_fs)
 	macsec_fs->rx_fs = NULL;
 }
 
+static void set_ipaddr_spec_v4(struct sockaddr_in *in, struct mlx5_flow_spec *spec, bool is_dst_ip)
+{
+	MLX5_SET(fte_match_param, spec->match_value,
+		 outer_headers.ip_version, MLX5_FS_IPV4_VERSION);
+
+	if (is_dst_ip) {
+		MLX5_SET_TO_ONES(fte_match_param, spec->match_criteria,
+				 outer_headers.dst_ipv4_dst_ipv6.ipv4_layout.ipv4);
+		memcpy(MLX5_ADDR_OF(fte_match_param, spec->match_value,
+				    outer_headers.dst_ipv4_dst_ipv6.ipv4_layout.ipv4),
+		       &in->sin_addr.s_addr, 4);
+	} else {
+		MLX5_SET_TO_ONES(fte_match_param, spec->match_criteria,
+				 outer_headers.src_ipv4_src_ipv6.ipv4_layout.ipv4);
+		memcpy(MLX5_ADDR_OF(fte_match_param, spec->match_value,
+				    outer_headers.src_ipv4_src_ipv6.ipv4_layout.ipv4),
+		       &in->sin_addr.s_addr, 4);
+	}
+}
+
+static void set_ipaddr_spec_v6(struct sockaddr_in6 *in6, struct mlx5_flow_spec *spec,
+			       bool is_dst_ip)
+{
+	MLX5_SET(fte_match_param, spec->match_value,
+		 outer_headers.ip_version, MLX5_FS_IPV6_VERSION);
+
+	if (is_dst_ip) {
+		memset(MLX5_ADDR_OF(fte_match_param, spec->match_criteria,
+				    outer_headers.dst_ipv4_dst_ipv6.ipv6_layout.ipv6),
+		       0xff, 16);
+		memcpy(MLX5_ADDR_OF(fte_match_param, spec->match_value,
+				    outer_headers.dst_ipv4_dst_ipv6.ipv6_layout.ipv6),
+		       &in6->sin6_addr, 16);
+	} else {
+		memset(MLX5_ADDR_OF(fte_match_param, spec->match_criteria,
+				    outer_headers.src_ipv4_src_ipv6.ipv6_layout.ipv6),
+		       0xff, 16);
+		memcpy(MLX5_ADDR_OF(fte_match_param, spec->match_value,
+				    outer_headers.src_ipv4_src_ipv6.ipv6_layout.ipv6),
+		       &in6->sin6_addr, 16);
+	}
+}
+
+static void set_ipaddr_spec(const struct sockaddr *addr,
+			    struct mlx5_flow_spec *spec, bool is_dst_ip)
+{
+	struct sockaddr_in6 *in6;
+
+	spec->match_criteria_enable |= MLX5_MATCH_OUTER_HEADERS;
+	MLX5_SET_TO_ONES(fte_match_param, spec->match_criteria,
+			 outer_headers.ip_version);
+
+	if (addr->sa_family == AF_INET) {
+		struct sockaddr_in *in = (struct sockaddr_in *)addr;
+
+		set_ipaddr_spec_v4(in, spec, is_dst_ip);
+		return;
+	}
+
+	in6 = (struct sockaddr_in6 *)addr;
+	set_ipaddr_spec_v6(in6, spec, is_dst_ip);
+}
+
+static void macsec_fs_del_roce_rule_rx(struct mlx5_roce_macsec_rx_rule *rx_rule)
+{
+	mlx5_del_flow_rules(rx_rule->op);
+	mlx5_del_flow_rules(rx_rule->ip);
+	list_del(&rx_rule->entry);
+	kfree(rx_rule);
+}
+
+static void macsec_fs_del_roce_rules_rx(struct mlx5_macsec_fs *macsec_fs, u32 fs_id,
+					struct list_head *rx_rules_list)
+{
+	struct mlx5_roce_macsec_rx_rule *rx_rule, *next;
+
+	if (!mlx5_is_macsec_roce_supported(macsec_fs->mdev))
+		return;
+
+	list_for_each_entry_safe(rx_rule, next, rx_rules_list, entry) {
+		if (rx_rule->fs_id == fs_id)
+			macsec_fs_del_roce_rule_rx(rx_rule);
+	}
+}
+
+static void macsec_fs_del_roce_rule_tx(struct mlx5_core_dev *mdev,
+				       struct mlx5_roce_macsec_tx_rule *tx_rule)
+{
+	mlx5_del_flow_rules(tx_rule->rule);
+	mlx5_modify_header_dealloc(mdev, tx_rule->meta_modhdr);
+	list_del(&tx_rule->entry);
+	kfree(tx_rule);
+}
+
+static void macsec_fs_del_roce_rules_tx(struct mlx5_macsec_fs *macsec_fs, u32 fs_id,
+					struct list_head *tx_rules_list)
+{
+	struct mlx5_roce_macsec_tx_rule *tx_rule, *next;
+
+	if (!mlx5_is_macsec_roce_supported(macsec_fs->mdev))
+		return;
+
+	list_for_each_entry_safe(tx_rule, next, tx_rules_list, entry) {
+		if (tx_rule->fs_id == fs_id)
+			macsec_fs_del_roce_rule_tx(macsec_fs->mdev, tx_rule);
+	}
+}
+
 void mlx5_macsec_fs_get_stats_fill(struct mlx5_macsec_fs *macsec_fs, void *macsec_stats)
 {
 	struct mlx5_macsec_stats *stats = (struct mlx5_macsec_stats *)macsec_stats;
@@ -1955,20 +2084,270 @@ mlx5_macsec_fs_add_rule(struct mlx5_macsec_fs *macsec_fs,
 			struct mlx5_macsec_rule_attrs *attrs,
 			u32 *sa_fs_id)
 {
-	return (attrs->action == MLX5_ACCEL_MACSEC_ACTION_ENCRYPT) ?
-		macsec_fs_tx_add_rule(macsec_fs, macsec_ctx, attrs) :
+	struct mlx5_macsec_event_data data = {.macsec_fs = macsec_fs,
+					      .macdev = macsec_ctx->secy->netdev,
+					      .is_tx =
+					      (attrs->action == MLX5_ACCEL_MACSEC_ACTION_ENCRYPT)
+	};
+	union mlx5_macsec_rule *macsec_rule;
+	u32 tx_new_fs_id;
+
+	macsec_rule = (attrs->action == MLX5_ACCEL_MACSEC_ACTION_ENCRYPT) ?
+		macsec_fs_tx_add_rule(macsec_fs, macsec_ctx, attrs, &tx_new_fs_id) :
 		macsec_fs_rx_add_rule(macsec_fs, macsec_ctx, attrs, *sa_fs_id);
+
+	data.fs_id = (data.is_tx) ? tx_new_fs_id : *sa_fs_id;
+	if (macsec_rule)
+		blocking_notifier_call_chain(&macsec_fs->mdev->macsec_nh,
+					     MLX5_DRIVER_EVENT_MACSEC_SA_ADDED,
+					     &data);
+
+	return macsec_rule;
 }
 
 void mlx5_macsec_fs_del_rule(struct mlx5_macsec_fs *macsec_fs,
 			     union mlx5_macsec_rule *macsec_rule,
 			     int action, void *macdev, u32 sa_fs_id)
 {
+	struct mlx5_macsec_event_data data = {.macsec_fs = macsec_fs,
+					      .macdev = macdev,
+					      .is_tx = (action == MLX5_ACCEL_MACSEC_ACTION_ENCRYPT)
+	};
+
+	data.fs_id = (data.is_tx) ? macsec_rule->tx_rule.fs_id : sa_fs_id;
+	blocking_notifier_call_chain(&macsec_fs->mdev->macsec_nh,
+				     MLX5_DRIVER_EVENT_MACSEC_SA_DELETED,
+				     &data);
+
 	(action == MLX5_ACCEL_MACSEC_ACTION_ENCRYPT) ?
 		macsec_fs_tx_del_rule(macsec_fs, &macsec_rule->tx_rule, macdev) :
 		macsec_fs_rx_del_rule(macsec_fs, &macsec_rule->rx_rule, macdev, sa_fs_id);
 }
 
+static int mlx5_macsec_fs_add_roce_rule_rx(struct mlx5_macsec_fs *macsec_fs, u32 fs_id, u16 gid_idx,
+					   const struct sockaddr *addr,
+					   struct list_head *rx_rules_list)
+{
+	struct mlx5_macsec_rx *rx_fs = macsec_fs->rx_fs;
+	struct mlx5_roce_macsec_rx_rule *rx_rule;
+	struct mlx5_flow_destination dest = {};
+	struct mlx5_flow_act flow_act = {};
+	struct mlx5_flow_handle *new_rule;
+	struct mlx5_flow_spec *spec;
+	int err = 0;
+
+	spec = kvzalloc(sizeof(*spec), GFP_KERNEL);
+	if (!spec)
+		return -ENOMEM;
+
+	rx_rule = kzalloc(sizeof(*rx_rule), GFP_KERNEL);
+	if (!rx_rule) {
+		err = -ENOMEM;
+		goto out;
+	}
+
+	set_ipaddr_spec(addr, spec, true);
+
+	flow_act.action = MLX5_FLOW_CONTEXT_ACTION_FWD_DEST;
+	dest.ft = rx_fs->roce.ft_macsec_op_check;
+	dest.type = MLX5_FLOW_DESTINATION_TYPE_FLOW_TABLE;
+	new_rule = mlx5_add_flow_rules(rx_fs->roce.ft_ip_check, spec, &flow_act,
+				       &dest, 1);
+	if (IS_ERR(new_rule)) {
+		err = PTR_ERR(new_rule);
+		goto ip_rule_err;
+	}
+	rx_rule->ip = new_rule;
+
+	memset(&flow_act, 0, sizeof(flow_act));
+	memset(spec, 0, sizeof(*spec));
+
+	spec->match_criteria_enable |= MLX5_MATCH_MISC_PARAMETERS_2;
+	MLX5_SET_TO_ONES(fte_match_param, spec->match_criteria, misc_parameters_2.metadata_reg_c_5);
+	MLX5_SET(fte_match_param, spec->match_value, misc_parameters_2.metadata_reg_c_5,
+		 macsec_fs_set_rx_fs_id(fs_id));
+	flow_act.action = MLX5_FLOW_CONTEXT_ACTION_ALLOW;
+	new_rule = mlx5_add_flow_rules(rx_fs->roce.ft_macsec_op_check, spec, &flow_act,
+				       NULL, 0);
+	if (IS_ERR(new_rule)) {
+		err = PTR_ERR(new_rule);
+		goto op_rule_err;
+	}
+	rx_rule->op = new_rule;
+	rx_rule->gid_idx = gid_idx;
+	rx_rule->fs_id = fs_id;
+	list_add_tail(&rx_rule->entry, rx_rules_list);
+
+	goto out;
+
+op_rule_err:
+	mlx5_del_flow_rules(rx_rule->ip);
+	rx_rule->ip = NULL;
+ip_rule_err:
+	kfree(rx_rule);
+out:
+	kvfree(spec);
+	return err;
+}
+
+static int mlx5_macsec_fs_add_roce_rule_tx(struct mlx5_macsec_fs *macsec_fs, u32 fs_id, u16 gid_idx,
+					   const struct sockaddr *addr,
+					   struct list_head *tx_rules_list)
+{
+	u8 action[MLX5_UN_SZ_BYTES(set_add_copy_action_in_auto)] = {};
+	struct mlx5_macsec_tx *tx_fs = macsec_fs->tx_fs;
+	struct mlx5_core_dev *mdev = macsec_fs->mdev;
+	struct mlx5_modify_hdr *modify_hdr = NULL;
+	struct mlx5_roce_macsec_tx_rule *tx_rule;
+	struct mlx5_flow_destination dest = {};
+	struct mlx5_flow_act flow_act = {};
+	struct mlx5_flow_handle *new_rule;
+	struct mlx5_flow_spec *spec;
+	int err = 0;
+
+	spec = kvzalloc(sizeof(*spec), GFP_KERNEL);
+	if (!spec)
+		return -ENOMEM;
+
+	tx_rule = kzalloc(sizeof(*tx_rule), GFP_KERNEL);
+	if (!tx_rule) {
+		err = -ENOMEM;
+		goto out;
+	}
+
+	set_ipaddr_spec(addr, spec, false);
+
+	MLX5_SET(set_action_in, action, action_type, MLX5_ACTION_TYPE_SET);
+	MLX5_SET(set_action_in, action, field, MLX5_ACTION_IN_FIELD_METADATA_REG_A);
+	MLX5_SET(set_action_in, action, data, macsec_fs_set_tx_fs_id(fs_id));
+	MLX5_SET(set_action_in, action, offset, 0);
+	MLX5_SET(set_action_in, action, length, 32);
+
+	modify_hdr = mlx5_modify_header_alloc(mdev, MLX5_FLOW_NAMESPACE_RDMA_TX_MACSEC,
+					      1, action);
+	if (IS_ERR(modify_hdr)) {
+		err = PTR_ERR(modify_hdr);
+		mlx5_core_err(mdev, "Fail to alloc ROCE MACsec set modify_header_id err=%d\n",
+			      err);
+		modify_hdr = NULL;
+		goto modify_hdr_err;
+	}
+	tx_rule->meta_modhdr = modify_hdr;
+
+	flow_act.modify_hdr = modify_hdr;
+	flow_act.action = MLX5_FLOW_CONTEXT_ACTION_FWD_DEST | MLX5_FLOW_CONTEXT_ACTION_MOD_HDR;
+
+	dest.type = MLX5_FLOW_DESTINATION_TYPE_TABLE_TYPE;
+	dest.ft = tx_fs->tables.ft_crypto.t;
+	new_rule = mlx5_add_flow_rules(tx_fs->ft_rdma_tx, spec, &flow_act, &dest, 1);
+	if (IS_ERR(new_rule)) {
+		err = PTR_ERR(new_rule);
+		mlx5_core_err(mdev, "Failed to add ROCE TX rule, err=%d\n", err);
+		goto rule_err;
+	}
+	tx_rule->rule = new_rule;
+	tx_rule->gid_idx = gid_idx;
+	tx_rule->fs_id = fs_id;
+	list_add_tail(&tx_rule->entry, tx_rules_list);
+
+	goto out;
+
+rule_err:
+	mlx5_modify_header_dealloc(mdev, tx_rule->meta_modhdr);
+modify_hdr_err:
+	kfree(tx_rule);
+out:
+	kvfree(spec);
+	return err;
+}
+
+void mlx5_macsec_del_roce_rule(u16 gid_idx, struct mlx5_macsec_fs *macsec_fs,
+			       struct list_head *tx_rules_list, struct list_head *rx_rules_list)
+{
+	struct mlx5_roce_macsec_rx_rule *rx_rule, *next_rx;
+	struct mlx5_roce_macsec_tx_rule *tx_rule, *next_tx;
+
+	list_for_each_entry_safe(tx_rule, next_tx, tx_rules_list, entry) {
+		if (tx_rule->gid_idx == gid_idx)
+			macsec_fs_del_roce_rule_tx(macsec_fs->mdev, tx_rule);
+	}
+
+	list_for_each_entry_safe(rx_rule, next_rx, rx_rules_list, entry) {
+		if (rx_rule->gid_idx == gid_idx)
+			macsec_fs_del_roce_rule_rx(rx_rule);
+	}
+}
+EXPORT_SYMBOL_GPL(mlx5_macsec_del_roce_rule);
+
+int mlx5_macsec_add_roce_rule(void *macdev, const struct sockaddr *addr, u16 gid_idx,
+			      struct list_head *tx_rules_list, struct list_head *rx_rules_list,
+			      struct mlx5_macsec_fs *macsec_fs)
+{
+	struct mlx5_macsec_device *iter, *macsec_device = NULL;
+	struct mlx5_core_dev *mdev = macsec_fs->mdev;
+	struct mlx5_fs_id *fs_id_iter;
+	unsigned long index = 0;
+	int err;
+
+	list_for_each_entry(iter, &macsec_fs->macsec_devices_list, macsec_devices_list_entry) {
+		if (iter->macdev == macdev) {
+			macsec_device = iter;
+			break;
+		}
+	}
+
+	if (!macsec_device)
+		return 0;
+
+	xa_for_each(&macsec_device->tx_id_xa, index, fs_id_iter) {
+		err = mlx5_macsec_fs_add_roce_rule_tx(macsec_fs, fs_id_iter->id, gid_idx, addr,
+						      tx_rules_list);
+		if (err) {
+			mlx5_core_err(mdev, "MACsec offload: Failed to add roce TX rule\n");
+			goto out;
+		}
+	}
+
+	index = 0;
+	xa_for_each(&macsec_device->rx_id_xa, index, fs_id_iter) {
+		err = mlx5_macsec_fs_add_roce_rule_rx(macsec_fs, fs_id_iter->id, gid_idx, addr,
+						      rx_rules_list);
+		if (err) {
+			mlx5_core_err(mdev, "MACsec offload: Failed to add roce TX rule\n");
+			goto out;
+		}
+	}
+
+	return 0;
+out:
+	mlx5_macsec_del_roce_rule(gid_idx, macsec_fs, tx_rules_list, rx_rules_list);
+	return err;
+}
+EXPORT_SYMBOL_GPL(mlx5_macsec_add_roce_rule);
+
+void mlx5_macsec_add_roce_sa_rules(u32 fs_id, const struct sockaddr *addr, u16 gid_idx,
+				   struct list_head *tx_rules_list,
+				   struct list_head *rx_rules_list,
+				   struct mlx5_macsec_fs *macsec_fs, bool is_tx)
+{
+	(is_tx) ?
+		mlx5_macsec_fs_add_roce_rule_tx(macsec_fs, fs_id, gid_idx, addr,
+						tx_rules_list) :
+		mlx5_macsec_fs_add_roce_rule_rx(macsec_fs, fs_id, gid_idx, addr,
+						rx_rules_list);
+}
+EXPORT_SYMBOL_GPL(mlx5_macsec_add_roce_sa_rules);
+
+void mlx5_macsec_del_roce_sa_rules(u32 fs_id, struct mlx5_macsec_fs *macsec_fs,
+				   struct list_head *tx_rules_list,
+				   struct list_head *rx_rules_list, bool is_tx)
+{
+	(is_tx) ?
+		macsec_fs_del_roce_rules_tx(macsec_fs, fs_id, tx_rules_list) :
+		macsec_fs_del_roce_rules_rx(macsec_fs, fs_id, rx_rules_list);
+}
+EXPORT_SYMBOL_GPL(mlx5_macsec_del_roce_sa_rules);
+
 void mlx5_macsec_fs_cleanup(struct mlx5_macsec_fs *macsec_fs)
 {
 	macsec_fs_rx_cleanup(macsec_fs);
@@ -2016,6 +2395,8 @@ mlx5_macsec_fs_init(struct mlx5_core_dev *mdev)
 		goto tx_cleanup;
 	}
 
+	BLOCKING_INIT_NOTIFIER_HEAD(&mdev->macsec_nh);
+
 	return macsec_fs;
 
 tx_cleanup:
diff --git a/include/linux/mlx5/device.h b/include/linux/mlx5/device.h
index 80cc12a9a531..ca93a5ef9dac 100644
--- a/include/linux/mlx5/device.h
+++ b/include/linux/mlx5/device.h
@@ -364,6 +364,8 @@ enum mlx5_event {
 enum mlx5_driver_event {
 	MLX5_DRIVER_EVENT_TYPE_TRAP = 0,
 	MLX5_DRIVER_EVENT_UPLINK_NETDEV,
+	MLX5_DRIVER_EVENT_MACSEC_SA_ADDED,
+	MLX5_DRIVER_EVENT_MACSEC_SA_DELETED,
 };
 
 enum {
diff --git a/include/linux/mlx5/driver.h b/include/linux/mlx5/driver.h
index c1b88a1112cc..848993823ba5 100644
--- a/include/linux/mlx5/driver.h
+++ b/include/linux/mlx5/driver.h
@@ -810,6 +810,8 @@ struct mlx5_core_dev {
 	u64			num_block_ipsec;
 #ifdef CONFIG_MLX5_MACSEC
 	struct mlx5_macsec_fs *macsec_fs;
+	/* MACsec notifier chain to sync MACsec core and IB database */
+	struct blocking_notifier_head macsec_nh;
 #endif
 };
 
diff --git a/include/linux/mlx5/macsec.h b/include/linux/mlx5/macsec.h
new file mode 100644
index 000000000000..f7ff4c2a95d0
--- /dev/null
+++ b/include/linux/mlx5/macsec.h
@@ -0,0 +1,32 @@
+/* SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB */
+/* Copyright (c) 2022, NVIDIA CORPORATION & AFFILIATES. */
+
+#ifndef MLX5_MACSEC_H
+#define MLX5_MACSEC_H
+
+#ifdef CONFIG_MLX5_MACSEC
+struct mlx5_macsec_event_data {
+	struct mlx5_macsec_fs *macsec_fs;
+	void *macdev;
+	u32 fs_id;
+	bool is_tx;
+};
+
+int mlx5_macsec_add_roce_rule(void *macdev, const struct sockaddr *addr, u16 gid_idx,
+			      struct list_head *tx_rules_list, struct list_head *rx_rules_list,
+			      struct mlx5_macsec_fs *macsec_fs);
+
+void mlx5_macsec_del_roce_rule(u16 gid_idx, struct mlx5_macsec_fs *macsec_fs,
+			       struct list_head *tx_rules_list, struct list_head *rx_rules_list);
+
+void mlx5_macsec_add_roce_sa_rules(u32 fs_id, const struct sockaddr *addr, u16 gid_idx,
+				   struct list_head *tx_rules_list,
+				   struct list_head *rx_rules_list,
+				   struct mlx5_macsec_fs *macsec_fs, bool is_tx);
+
+void mlx5_macsec_del_roce_sa_rules(u32 fs_id, struct mlx5_macsec_fs *macsec_fs,
+				   struct list_head *tx_rules_list,
+				   struct list_head *rx_rules_list, bool is_tx);
+
+#endif
+#endif /* MLX5_MACSEC_H */
-- 
2.41.0

