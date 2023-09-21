Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 769CF7A97BD
	for <lists+linux-rdma@lfdr.de>; Thu, 21 Sep 2023 19:27:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230093AbjIUR10 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 21 Sep 2023 13:27:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229854AbjIUR05 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 21 Sep 2023 13:26:57 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E78D212B
        for <linux-rdma@vger.kernel.org>; Thu, 21 Sep 2023 10:02:39 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0259BC4E662;
        Thu, 21 Sep 2023 12:11:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695298262;
        bh=LJeEZiQFuaOyNrJrVDaZTpW+PV2WcnmWrqmXE4pIdCA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PyygfKNdSKO8CwnEUnHtbB9MJCeSMIbFfBbEHrfXnR34FRE+c69xuFIcLDc+K9LDc
         hvHDFAlAZlyz9OAYmKtI8ZG7RUDKiWQCpqxPMgMwTOhxcwUglbIPzr+a3/eddfouhU
         Dxuv16iot9bTzUWgFwCwyoefWNEYxz+Gh3VaYrlbEI2m0LjCv5dnyc8zKfbsT1mwvB
         OYG/ssy5hsM9p4xGENbbO1HnGfyhWwR+Sgs8b0BRPBCQIeZwduiOPXI5+n1RxdBGKF
         I8vhPLYSLIh9cHJEskS6e0fdfOgCrL5f0pD48kHQXYldEJPufDxQycbclf3k4f/6o8
         6O05Tl6uVm3bQ==
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
Subject: [PATCH mlx5-next 5/9] net/mlx5: Implement alias object allow and create functions
Date:   Thu, 21 Sep 2023 15:10:31 +0300
Message-ID: <f45a9c85319fa783186b8988abcd64955b5f2a0c.1695296682.git.leon@kernel.org>
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

Add functions which allow one vhca to access another vhca object,
and functions that creates an alias object or destroys it.

Together they can be used to create cross vhca flow table that is able
jump from the steering domain that is managed by one vport,
to the steering domain on a different vport.

Signed-off-by: Patrisious Haddad <phaddad@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/cmd.c | 70 +++++++++++++++++++
 .../ethernet/mellanox/mlx5/core/mlx5_core.h   | 22 ++++++
 2 files changed, 92 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/cmd.c b/drivers/net/ethernet/mellanox/mlx5/core/cmd.c
index afb348579577..7671c5727ed1 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/cmd.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/cmd.c
@@ -525,6 +525,7 @@ static int mlx5_internal_err_ret_value(struct mlx5_core_dev *dev, u16 op,
 	case MLX5_CMD_OP_SAVE_VHCA_STATE:
 	case MLX5_CMD_OP_LOAD_VHCA_STATE:
 	case MLX5_CMD_OP_SYNC_CRYPTO:
+	case MLX5_CMD_OP_ALLOW_OTHER_VHCA_ACCESS:
 		*status = MLX5_DRIVER_STATUS_ABORTED;
 		*synd = MLX5_DRIVER_SYND;
 		return -ENOLINK;
@@ -728,6 +729,7 @@ const char *mlx5_command_str(int command)
 	MLX5_COMMAND_STR_CASE(SAVE_VHCA_STATE);
 	MLX5_COMMAND_STR_CASE(LOAD_VHCA_STATE);
 	MLX5_COMMAND_STR_CASE(SYNC_CRYPTO);
+	MLX5_COMMAND_STR_CASE(ALLOW_OTHER_VHCA_ACCESS);
 	default: return "unknown command opcode";
 	}
 }
@@ -2090,6 +2092,74 @@ int mlx5_cmd_exec_cb(struct mlx5_async_ctx *ctx, void *in, int in_size,
 }
 EXPORT_SYMBOL(mlx5_cmd_exec_cb);
 
+int mlx5_cmd_allow_other_vhca_access(struct mlx5_core_dev *dev,
+				     struct mlx5_cmd_allow_other_vhca_access_attr *attr)
+{
+	u32 out[MLX5_ST_SZ_DW(allow_other_vhca_access_out)] = {};
+	u32 in[MLX5_ST_SZ_DW(allow_other_vhca_access_in)] = {};
+	void *key;
+
+	MLX5_SET(allow_other_vhca_access_in,
+		 in, opcode, MLX5_CMD_OP_ALLOW_OTHER_VHCA_ACCESS);
+	MLX5_SET(allow_other_vhca_access_in,
+		 in, object_type_to_be_accessed, attr->obj_type);
+	MLX5_SET(allow_other_vhca_access_in,
+		 in, object_id_to_be_accessed, attr->obj_id);
+
+	key = MLX5_ADDR_OF(allow_other_vhca_access_in, in, access_key);
+	memcpy(key, attr->access_key, sizeof(attr->access_key));
+
+	return mlx5_cmd_exec(dev, in, sizeof(in), out, sizeof(out));
+}
+
+int mlx5_cmd_alias_obj_create(struct mlx5_core_dev *dev,
+			      struct mlx5_cmd_alias_obj_create_attr *alias_attr,
+			      u32 *obj_id)
+{
+	u32 out[MLX5_ST_SZ_DW(general_obj_out_cmd_hdr)] = {};
+	u32 in[MLX5_ST_SZ_DW(create_alias_obj_in)] = {};
+	void *param;
+	void *attr;
+	void *key;
+	int ret;
+
+	attr = MLX5_ADDR_OF(create_alias_obj_in, in, hdr);
+	MLX5_SET(general_obj_in_cmd_hdr,
+		 attr, opcode, MLX5_CMD_OP_CREATE_GENERAL_OBJECT);
+	MLX5_SET(general_obj_in_cmd_hdr,
+		 attr, obj_type, alias_attr->obj_type);
+	param = MLX5_ADDR_OF(general_obj_in_cmd_hdr, in, op_param);
+	MLX5_SET(general_obj_create_param, param, alias_object, 1);
+
+	attr = MLX5_ADDR_OF(create_alias_obj_in, in, alias_ctx);
+	MLX5_SET(alias_context, attr, vhca_id_to_be_accessed, alias_attr->vhca_id);
+	MLX5_SET(alias_context, attr, object_id_to_be_accessed, alias_attr->obj_id);
+
+	key = MLX5_ADDR_OF(alias_context, attr, access_key);
+	memcpy(key, alias_attr->access_key, sizeof(alias_attr->access_key));
+
+	ret = mlx5_cmd_exec(dev, in, sizeof(in), out, sizeof(out));
+	if (ret)
+		return ret;
+
+	*obj_id = MLX5_GET(general_obj_out_cmd_hdr, out, obj_id);
+
+	return 0;
+}
+
+int mlx5_cmd_alias_obj_destroy(struct mlx5_core_dev *dev, u32 obj_id,
+			       u16 obj_type)
+{
+	u32 out[MLX5_ST_SZ_DW(general_obj_out_cmd_hdr)] = {};
+	u32 in[MLX5_ST_SZ_DW(general_obj_in_cmd_hdr)] = {};
+
+	MLX5_SET(general_obj_in_cmd_hdr, in, opcode, MLX5_CMD_OP_DESTROY_GENERAL_OBJECT);
+	MLX5_SET(general_obj_in_cmd_hdr, in, obj_type, obj_type);
+	MLX5_SET(general_obj_in_cmd_hdr, in, obj_id, obj_id);
+
+	return mlx5_cmd_exec(dev, in, sizeof(in), out, sizeof(out));
+}
+
 static void destroy_msg_cache(struct mlx5_core_dev *dev)
 {
 	struct cmd_msg_cache *ch;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h b/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h
index 124352459c23..19ffd1816474 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h
@@ -97,6 +97,22 @@ do {								\
 			     __func__, __LINE__, current->pid,	\
 			     ##__VA_ARGS__)
 
+#define ACCESS_KEY_LEN  32
+#define FT_ID_FT_TYPE_OFFSET 24
+
+struct mlx5_cmd_allow_other_vhca_access_attr {
+	u16 obj_type;
+	u32 obj_id;
+	u8 access_key[ACCESS_KEY_LEN];
+};
+
+struct mlx5_cmd_alias_obj_create_attr {
+	u32 obj_id;
+	u16 vhca_id;
+	u16 obj_type;
+	u8 access_key[ACCESS_KEY_LEN];
+};
+
 static inline void mlx5_printk(struct mlx5_core_dev *dev, int level, const char *format, ...)
 {
 	struct device *device = dev->device;
@@ -343,6 +359,12 @@ bool mlx5_eth_supported(struct mlx5_core_dev *dev);
 bool mlx5_rdma_supported(struct mlx5_core_dev *dev);
 bool mlx5_vnet_supported(struct mlx5_core_dev *dev);
 bool mlx5_same_hw_devs(struct mlx5_core_dev *dev, struct mlx5_core_dev *peer_dev);
+int mlx5_cmd_allow_other_vhca_access(struct mlx5_core_dev *dev,
+				     struct mlx5_cmd_allow_other_vhca_access_attr *attr);
+int mlx5_cmd_alias_obj_create(struct mlx5_core_dev *dev,
+			      struct mlx5_cmd_alias_obj_create_attr *alias_attr,
+			      u32 *obj_id);
+int mlx5_cmd_alias_obj_destroy(struct mlx5_core_dev *dev, u32 obj_id, u16 obj_type);
 
 static inline u16 mlx5_core_ec_vf_vport_base(const struct mlx5_core_dev *dev)
 {
-- 
2.41.0

