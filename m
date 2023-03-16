Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C85DC6BD119
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Mar 2023 14:41:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230227AbjCPNlI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 16 Mar 2023 09:41:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230355AbjCPNlE (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 16 Mar 2023 09:41:04 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 669AEC081E
        for <linux-rdma@vger.kernel.org>; Thu, 16 Mar 2023 06:41:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EB7E6B82147
        for <linux-rdma@vger.kernel.org>; Thu, 16 Mar 2023 13:40:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D5E6C433EF;
        Thu, 16 Mar 2023 13:40:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678974057;
        bh=mu6/GRVyafyitPBe1rJN7OPvuNFGbwL9xnOxLT7uOes=;
        h=From:To:Cc:Subject:Date:From;
        b=hXLcPx7tDpUexQ6jVE+8QuDGQ4WDj2XichOFGvcfeUYM+b7QRMdBIvjioP8sMgSsG
         ZSJQ1UB4dwQDCCJvveCmgklCg2Y4CuS/Tb4KBNl08gn9iobvvMUA4gN49QMpe2cHaQ
         MHWfSCWYR6kCAKkHCaQsI+8dSwJXsotEcuLd3igfu1gk1J/IJA+eVRXbx07rWUpN3e
         ApWqshoVjfhxlXUtKTqko0nIxqPgjAEldh6CgntpBsPbbnOxZIZ6FYInKC+H4iek82
         dritxETX9xINGhN96v2WMHawcKC+yeP5jnGDPml9e7ym3BRuPzOAo+HUueaTXW8xPo
         vtDxCVHQgh4UA==
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Maher Sanalla <msanalla@nvidia.com>, Aya Levin <ayal@mellanox.com>,
        Aya Levin <ayal@nvidia.com>, linux-rdma@vger.kernel.org,
        Saeed Mahameed <saeedm@nvidia.com>
Subject: [PATCH rdma-rc] IB/mlx5: Add support for 400G_8X lane speed
Date:   Thu, 16 Mar 2023 15:40:49 +0200
Message-Id: <ec9040548d119d22557d6a4b4070d6f421701fd4.1678973994.git.leon@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Maher Sanalla <msanalla@nvidia.com>

Currently, when driver queries PTYS to report which link speed is being
used on its RoCE ports, it does not check the case of having 400Gbps
transmitted over 8 lanes. Thus it fails to report the said speed and
instead it defaults to report 10G over 4 lanes.

Add a check for the said speed when querying PTYS and report it back
correctly when needed.

Fixes: 08e8676f1607 ("IB/mlx5: Add support for 50Gbps per lane link modes")
Signed-off-by: Maher Sanalla <msanalla@nvidia.com>
Reviewed-by: Aya Levin <ayal@nvidia.com>
Reviewed-by: Saeed Mahameed <saeedm@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/main.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index 5e5ed1c8299d..f0b394ed7452 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -442,6 +442,10 @@ static int translate_eth_ext_proto_oper(u32 eth_proto_oper, u16 *active_speed,
 		*active_width = IB_WIDTH_2X;
 		*active_speed = IB_SPEED_NDR;
 		break;
+	case MLX5E_PROT_MASK(MLX5E_400GAUI_8):
+		*active_width = IB_WIDTH_8X;
+		*active_speed = IB_SPEED_HDR;
+		break;
 	case MLX5E_PROT_MASK(MLX5E_400GAUI_4_400GBASE_CR4_KR4):
 		*active_width = IB_WIDTH_4X;
 		*active_speed = IB_SPEED_NDR;
-- 
2.39.2

