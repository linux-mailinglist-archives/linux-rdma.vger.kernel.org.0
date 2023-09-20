Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 252517A7893
	for <lists+linux-rdma@lfdr.de>; Wed, 20 Sep 2023 12:08:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233864AbjITKIM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 20 Sep 2023 06:08:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234132AbjITKIK (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 20 Sep 2023 06:08:10 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 694F1DE
        for <linux-rdma@vger.kernel.org>; Wed, 20 Sep 2023 03:08:03 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AB42C433C8;
        Wed, 20 Sep 2023 10:08:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695204483;
        bh=o+qXj8W7DVoYQY75qK0NxoUqduddIC1gpz+smx2PevM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KRR6FXeT5AiW6/DkOLsjN6sdIp8u5kb5ntic7SMz0hxatwt6TDsYUDYi7SgGDW9fV
         Rk262MQwrobsyVIhMGPAl9nJTxfBT2cv0YJwPHOtglJZozGY3CLUamyL2Oso6jy/pM
         mAg5VH6irnF62svLk7PV/gfhb1uW4Hc8ud36kOpwT2XfHSoowPLa0ZYWIers4Ekwkx
         Dgk0xo2PxcTSJZjQfRCPfDoxiaCjvHhB26jcUeG1sxQNc9IVmSCW5k7DRNXRuYj0X/
         1UVCzAiMBZEheKzY3JMKjXF5fbpCh1+nnoeSW8mFUyUt7Ne7w/tRXaBdS4biS5M0Ub
         6+JN09mzPDVhg==
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Patrisious Haddad <phaddad@nvidia.com>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>, linux-rdma@vger.kernel.org,
        Mark Zhang <markzhang@nvidia.com>, netdev@vger.kernel.org,
        Or Har-Toov <ohartoov@nvidia.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Saeed Mahameed <saeedm@nvidia.com>
Subject: [PATCH rdma-next 3/6] IB/mlx5: Add support for 800G_8X lane speed
Date:   Wed, 20 Sep 2023 13:07:42 +0300
Message-ID: <26fd0b6e1fac071c3eb779657bb3d8ba47f47c4f.1695204156.git.leon@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1695204156.git.leon@kernel.org>
References: <cover.1695204156.git.leon@kernel.org>
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

Add a check for 800G_8X speed when querying PTYS and report it back
correctly when needed.

Signed-off-by: Patrisious Haddad <phaddad@nvidia.com>
Reviewed-by: Mark Zhang <markzhang@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/main.c              | 4 ++++
 drivers/net/ethernet/mellanox/mlx5/core/port.c | 1 +
 include/linux/mlx5/port.h                      | 1 +
 3 files changed, 6 insertions(+)

diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index f9286820ad3b..830dac95c163 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -482,6 +482,10 @@ static int translate_eth_ext_proto_oper(u32 eth_proto_oper, u16 *active_speed,
 		*active_width = IB_WIDTH_4X;
 		*active_speed = IB_SPEED_NDR;
 		break;
+	case MLX5E_PROT_MASK(MLX5E_800GAUI_8_800GBASE_CR8_KR8):
+		*active_width = IB_WIDTH_8X;
+		*active_speed = IB_SPEED_NDR;
+		break;
 	default:
 		return -EINVAL;
 	}
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/port.c b/drivers/net/ethernet/mellanox/mlx5/core/port.c
index be70d1f23a5d..43423543f34c 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/port.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/port.c
@@ -1102,6 +1102,7 @@ static const u32 mlx5e_ext_link_speed[MLX5E_EXT_LINK_MODES_NUMBER] = {
 	[MLX5E_100GAUI_1_100GBASE_CR_KR] = 100000,
 	[MLX5E_200GAUI_2_200GBASE_CR2_KR2] = 200000,
 	[MLX5E_400GAUI_4_400GBASE_CR4_KR4] = 400000,
+	[MLX5E_800GAUI_8_800GBASE_CR8_KR8] = 800000,
 };
 
 int mlx5_port_query_eth_proto(struct mlx5_core_dev *dev, u8 port, bool ext,
diff --git a/include/linux/mlx5/port.h b/include/linux/mlx5/port.h
index 98b2e1e149f9..794001ebd003 100644
--- a/include/linux/mlx5/port.h
+++ b/include/linux/mlx5/port.h
@@ -117,6 +117,7 @@ enum mlx5e_ext_link_mode {
 	MLX5E_200GAUI_2_200GBASE_CR2_KR2	= 13,
 	MLX5E_400GAUI_8				= 15,
 	MLX5E_400GAUI_4_400GBASE_CR4_KR4	= 16,
+	MLX5E_800GAUI_8_800GBASE_CR8_KR8	= 19,
 	MLX5E_EXT_LINK_MODES_NUMBER,
 };
 
-- 
2.41.0

