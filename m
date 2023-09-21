Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E45A7A96AC
	for <lists+linux-rdma@lfdr.de>; Thu, 21 Sep 2023 19:11:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbjIURCH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 21 Sep 2023 13:02:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbjIURCA (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 21 Sep 2023 13:02:00 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5886C173E
        for <linux-rdma@vger.kernel.org>; Thu, 21 Sep 2023 10:00:55 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E720C4E666;
        Thu, 21 Sep 2023 12:11:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695298280;
        bh=MwYRBNuDIKtuwPlprN1eygpUkSepifoTrEjLPdJHJO0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OwAGhJ1DiY1PyKLdDXB+adneX2XZC6Ho7W1xH1IcJNysZx/sRMXxNWEzD/pwVBQFM
         Vku8pQF3XHTYQdU2qtd/jSxcwQ8KWgOsRorrR9KX/OvSU1H/R0qHjbRbBcUxjZMpbi
         VZVwrTDZuHo8ui/mm0BapqJcDvwsUxhOhJdkzJ2Ty739N23nip88E6drpv9D6V5szY
         O1j0OxMikBnkNRX4EyLSr6PAdlYMr8RZdxhRLits158lckY8i48DfWI49/rOdMXML4
         cWtippWuszxtaPV8NBAOS1ryaSNj3DVGiEIYHGX0hHYQAffoDl0yaCsO4PRloe5BI0
         y1fSOvG5T6UNw==
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
Subject: [PATCH mlx5-next 6/9] net/mlx5: Add create alias flow table function to ipsec roce
Date:   Thu, 21 Sep 2023 15:10:32 +0300
Message-ID: <36e15ef41586f2a9aacc65b935de18391eef5607.1695296682.git.leon@kernel.org>
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

Implements functions which creates an alias flow table, and check
if alias flow table creation is even supported, and if successful
returns the created alias flow table object id.

This function would be used in later patches to allow jumping from
one vhca to another, in order to add support for MPV mode.

Signed-off-by: Patrisious Haddad <phaddad@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 .../mellanox/mlx5/core/lib/ipsec_fs_roce.c    | 66 +++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/ipsec_fs_roce.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/ipsec_fs_roce.c
index 6176680c470c..648f3d7ab68b 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/ipsec_fs_roce.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/ipsec_fs_roce.c
@@ -4,6 +4,7 @@
 #include "fs_core.h"
 #include "lib/ipsec_fs_roce.h"
 #include "mlx5_core.h"
+#include <linux/random.h>
 
 struct mlx5_ipsec_miss {
 	struct mlx5_flow_group *group;
@@ -44,6 +45,71 @@ static void ipsec_fs_roce_setup_udp_dport(struct mlx5_flow_spec *spec,
 	MLX5_SET(fte_match_param, spec->match_value, outer_headers.udp_dport, dport);
 }
 
+static bool ipsec_fs_create_alias_supported(struct mlx5_core_dev *mdev,
+					    struct mlx5_core_dev *master_mdev)
+{
+	u64 obj_allowed_m = MLX5_CAP_GEN_2_64(master_mdev, allowed_object_for_other_vhca_access);
+	u32 obj_supp_m = MLX5_CAP_GEN_2(master_mdev, cross_vhca_object_to_object_supported);
+	u64 obj_allowed = MLX5_CAP_GEN_2_64(mdev, allowed_object_for_other_vhca_access);
+	u32 obj_supp = MLX5_CAP_GEN_2(mdev, cross_vhca_object_to_object_supported);
+
+	if (!(obj_supp &
+	    MLX5_CROSS_VHCA_OBJ_TO_OBJ_SUPPORTED_LOCAL_FLOW_TABLE_TO_REMOTE_FLOW_TABLE_MISS) ||
+	    !(obj_supp_m &
+	    MLX5_CROSS_VHCA_OBJ_TO_OBJ_SUPPORTED_LOCAL_FLOW_TABLE_TO_REMOTE_FLOW_TABLE_MISS))
+		return false;
+
+	if (!(obj_allowed & MLX5_ALLOWED_OBJ_FOR_OTHER_VHCA_ACCESS_FLOW_TABLE) ||
+	    !(obj_allowed_m & MLX5_ALLOWED_OBJ_FOR_OTHER_VHCA_ACCESS_FLOW_TABLE))
+		return false;
+
+	return true;
+}
+
+static int ipsec_fs_create_aliased_ft(struct mlx5_core_dev *ibv_owner,
+				      struct mlx5_core_dev *ibv_allowed,
+				      struct mlx5_flow_table *ft,
+				      u32 *obj_id)
+{
+	u32 aliased_object_id = (ft->type << FT_ID_FT_TYPE_OFFSET) | ft->id;
+	u16 vhca_id_to_be_accessed = MLX5_CAP_GEN(ibv_owner, vhca_id);
+	struct mlx5_cmd_allow_other_vhca_access_attr allow_attr = {};
+	struct mlx5_cmd_alias_obj_create_attr alias_attr = {};
+	char key[ACCESS_KEY_LEN];
+	int ret;
+	int i;
+
+	if (!ipsec_fs_create_alias_supported(ibv_owner, ibv_allowed))
+		return -EOPNOTSUPP;
+
+	for (i = 0; i < ACCESS_KEY_LEN; i++)
+		key[i] = get_random_u64() & 0xFF;
+
+	memcpy(allow_attr.access_key, key, ACCESS_KEY_LEN);
+	allow_attr.obj_type = MLX5_GENERAL_OBJECT_TYPES_FLOW_TABLE_ALIAS;
+	allow_attr.obj_id = aliased_object_id;
+
+	ret = mlx5_cmd_allow_other_vhca_access(ibv_owner, &allow_attr);
+	if (ret) {
+		mlx5_core_err(ibv_owner, "Failed to allow other vhca access err=%d\n",
+			      ret);
+		return ret;
+	}
+
+	memcpy(alias_attr.access_key, key, ACCESS_KEY_LEN);
+	alias_attr.obj_id = aliased_object_id;
+	alias_attr.obj_type = MLX5_GENERAL_OBJECT_TYPES_FLOW_TABLE_ALIAS;
+	alias_attr.vhca_id = vhca_id_to_be_accessed;
+	ret = mlx5_cmd_alias_obj_create(ibv_allowed, &alias_attr, obj_id);
+	if (ret) {
+		mlx5_core_err(ibv_allowed, "Failed to create alias object err=%d\n",
+			      ret);
+		return ret;
+	}
+
+	return 0;
+}
+
 static int
 ipsec_fs_roce_rx_rule_setup(struct mlx5_core_dev *mdev,
 			    struct mlx5_flow_destination *default_dst,
-- 
2.41.0

