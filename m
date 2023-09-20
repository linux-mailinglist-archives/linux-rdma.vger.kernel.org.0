Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1153D7A7897
	for <lists+linux-rdma@lfdr.de>; Wed, 20 Sep 2023 12:08:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233629AbjITKI0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 20 Sep 2023 06:08:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234122AbjITKIZ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 20 Sep 2023 06:08:25 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B147F94
        for <linux-rdma@vger.kernel.org>; Wed, 20 Sep 2023 03:08:19 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2ABCC433C9;
        Wed, 20 Sep 2023 10:08:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695204499;
        bh=nM2JZKt2cwScGFOnX9WSpTvISbSkR2tPaohBnwD2i38=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZTgRAXYHDAuTFhNIix4CUH7nZCwcSbCjDJzv91b12zKpapwPnt2d8jqPe4/w/OH8Y
         PROimOwtctoPm/vZPD9JKQMQtuxHQWG42O7eGY5g+ph91Eyq3Sf99YlxDoU1lX+JrF
         y0c1AMqLcukY8cPrpSVrspfPUwKoeZGamoN5iLHCWcecAf0Drw36vEfbP4xt4pmsmm
         fGHj7VJ1+90ZgdyQLwQ3oQ1KVT+WZ0C/eJbD22nFnHckym206kfqLisQA1EdBRzxXk
         GEcW54Paz7JhK5J/Toi3Via/HT26/PCNhWf2BiY4qcgP1ytu52+6QTfqdnRiivwIxr
         76RIseFM42qhg==
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Patrisious Haddad <phaddad@nvidia.com>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>, linux-rdma@vger.kernel.org,
        Mark Zhang <markzhang@nvidia.com>, netdev@vger.kernel.org,
        Or Har-Toov <ohartoov@nvidia.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Saeed Mahameed <saeedm@nvidia.com>
Subject: [PATCH rdma-next 4/6] IB/mlx5: Rename 400G_8X speed to comply to naming convention
Date:   Wed, 20 Sep 2023 13:07:43 +0300
Message-ID: <ac98447cac8379a43fbdb36d56e5fb2b741a97ff.1695204156.git.leon@kernel.org>
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

Rename 400G_8X speed to comply to naming convention.

Signed-off-by: Patrisious Haddad <phaddad@nvidia.com>
Reviewed-by: Mark Zhang <markzhang@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/main.c              | 2 +-
 drivers/net/ethernet/mellanox/mlx5/core/port.c | 2 +-
 include/linux/mlx5/port.h                      | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index 830dac95c163..026f6c04f81e 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -474,7 +474,7 @@ static int translate_eth_ext_proto_oper(u32 eth_proto_oper, u16 *active_speed,
 		*active_width = IB_WIDTH_2X;
 		*active_speed = IB_SPEED_NDR;
 		break;
-	case MLX5E_PROT_MASK(MLX5E_400GAUI_8):
+	case MLX5E_PROT_MASK(MLX5E_400GAUI_8_400GBASE_CR8):
 		*active_width = IB_WIDTH_8X;
 		*active_speed = IB_SPEED_HDR;
 		break;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/port.c b/drivers/net/ethernet/mellanox/mlx5/core/port.c
index 43423543f34c..7d8c732818f2 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/port.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/port.c
@@ -1098,7 +1098,7 @@ static const u32 mlx5e_ext_link_speed[MLX5E_EXT_LINK_MODES_NUMBER] = {
 	[MLX5E_CAUI_4_100GBASE_CR4_KR4] = 100000,
 	[MLX5E_100GAUI_2_100GBASE_CR2_KR2] = 100000,
 	[MLX5E_200GAUI_4_200GBASE_CR4_KR4] = 200000,
-	[MLX5E_400GAUI_8] = 400000,
+	[MLX5E_400GAUI_8_400GBASE_CR8] = 400000,
 	[MLX5E_100GAUI_1_100GBASE_CR_KR] = 100000,
 	[MLX5E_200GAUI_2_200GBASE_CR2_KR2] = 200000,
 	[MLX5E_400GAUI_4_400GBASE_CR4_KR4] = 400000,
diff --git a/include/linux/mlx5/port.h b/include/linux/mlx5/port.h
index 794001ebd003..26092c78a985 100644
--- a/include/linux/mlx5/port.h
+++ b/include/linux/mlx5/port.h
@@ -115,7 +115,7 @@ enum mlx5e_ext_link_mode {
 	MLX5E_100GAUI_1_100GBASE_CR_KR		= 11,
 	MLX5E_200GAUI_4_200GBASE_CR4_KR4	= 12,
 	MLX5E_200GAUI_2_200GBASE_CR2_KR2	= 13,
-	MLX5E_400GAUI_8				= 15,
+	MLX5E_400GAUI_8_400GBASE_CR8		= 15,
 	MLX5E_400GAUI_4_400GBASE_CR4_KR4	= 16,
 	MLX5E_800GAUI_8_800GBASE_CR8_KR8	= 19,
 	MLX5E_EXT_LINK_MODES_NUMBER,
-- 
2.41.0

