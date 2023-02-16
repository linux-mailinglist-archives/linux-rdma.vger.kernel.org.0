Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40B8D698F73
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Feb 2023 10:13:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbjBPJNx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 16 Feb 2023 04:13:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbjBPJNx (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 16 Feb 2023 04:13:53 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36AE61A490
        for <linux-rdma@vger.kernel.org>; Thu, 16 Feb 2023 01:13:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D061061EDE
        for <linux-rdma@vger.kernel.org>; Thu, 16 Feb 2023 09:13:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9BAEC433EF;
        Thu, 16 Feb 2023 09:13:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676538831;
        bh=FT4Fib+1oVfphg29nhoqcb0tjxSHjNPGsZyynaa0wwA=;
        h=From:To:Cc:Subject:Date:From;
        b=Z2MSwW564XRS3qgaqxYsFFT1mMs5Iu2bBkp88SG10PS+OwMTnFWLFgo1iuzGHBTCE
         n2Mq6ou3cp4GrGil1+cYrSZV1KRfbrUtt04DoRj5iPjk1Y+CZns3dY0HIHLwGE5V0e
         dGS59fDaIfVU0DPpQwVHmwRJF58dzM8M9dEo4F4egctTcwMIPe+o1FLFpSXtb6nwP8
         f/Gg2eKwVOVWXNXBBuwhqn0J09oL+fZF8znQ2fUQlK7Y4zURXPeBQQYcL79EluF53+
         KrDjkkz2gAPN2/hw6USRL/VrW0uz2BrXM69cd8FtVjiuHrK1sCn22ZKT/AIa0BzLoQ
         rQLsnwvDnUPGg==
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Edward Srouji <edwards@nvidia.com>, linux-rdma@vger.kernel.org,
        Maor Gottlieb <maorg@nvidia.com>
Subject: [PATCH rdma-next] IB/mlx5: Extend debug control for CC parameters
Date:   Thu, 16 Feb 2023 11:13:45 +0200
Message-Id: <1dcc3440ee53c688f19f579a051ded81a2aaa70a.1676538714.git.leon@kernel.org>
X-Mailer: git-send-email 2.39.1
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

From: Edward Srouji <edwards@nvidia.com>

This patch adds rtt_resp_dscp to the current debug controllability of
congestion control (CC) parameters.
rtt_resp_dscp can be read or written through debugfs.
If set, its value overwrites the DSCP of the generated RTT response.

Signed-off-by: Edward Srouji <edwards@nvidia.com>
Reviewed-by: Maor Gottlieb <maorg@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/cong.c    | 28 +++++++++++++++++++++++++---
 drivers/infiniband/hw/mlx5/mlx5_ib.h |  2 ++
 include/linux/mlx5/mlx5_ifc.h        | 12 ++++++++++++
 3 files changed, 39 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/cong.c b/drivers/infiniband/hw/mlx5/cong.c
index 290ea8ac3838..f87531318feb 100644
--- a/drivers/infiniband/hw/mlx5/cong.c
+++ b/drivers/infiniband/hw/mlx5/cong.c
@@ -38,6 +38,7 @@
 enum mlx5_ib_cong_node_type {
 	MLX5_IB_RROCE_ECN_RP = 1,
 	MLX5_IB_RROCE_ECN_NP = 2,
+	MLX5_IB_RROCE_GENERAL = 3,
 };
 
 static const char * const mlx5_ib_dbg_cc_name[] = {
@@ -61,6 +62,8 @@ static const char * const mlx5_ib_dbg_cc_name[] = {
 	"np_cnp_dscp",
 	"np_cnp_prio_mode",
 	"np_cnp_prio",
+	"rtt_resp_dscp_valid",
+	"rtt_resp_dscp",
 };
 
 #define MLX5_IB_RP_CLAMP_TGT_RATE_ATTR			BIT(1)
@@ -84,14 +87,18 @@ static const char * const mlx5_ib_dbg_cc_name[] = {
 #define MLX5_IB_NP_CNP_DSCP_ATTR			BIT(3)
 #define MLX5_IB_NP_CNP_PRIO_MODE_ATTR			BIT(4)
 
+#define MLX5_IB_GENERAL_RTT_RESP_DSCP_ATTR		BIT(0)
+
 static enum mlx5_ib_cong_node_type
 mlx5_ib_param_to_node(enum mlx5_ib_dbg_cc_types param_offset)
 {
-	if (param_offset >= MLX5_IB_DBG_CC_RP_CLAMP_TGT_RATE &&
-	    param_offset <= MLX5_IB_DBG_CC_RP_GD)
+	if (param_offset <= MLX5_IB_DBG_CC_RP_GD)
 		return MLX5_IB_RROCE_ECN_RP;
-	else
+
+	if (param_offset <= MLX5_IB_DBG_CC_NP_CNP_PRIO)
 		return MLX5_IB_RROCE_ECN_NP;
+
+	return MLX5_IB_RROCE_GENERAL;
 }
 
 static u32 mlx5_get_cc_param_val(void *field, int offset)
@@ -157,6 +164,12 @@ static u32 mlx5_get_cc_param_val(void *field, int offset)
 	case MLX5_IB_DBG_CC_NP_CNP_PRIO:
 		return MLX5_GET(cong_control_r_roce_ecn_np, field,
 				cnp_802p_prio);
+	case MLX5_IB_DBG_CC_GENERAL_RTT_RESP_DSCP_VALID:
+		return MLX5_GET(cong_control_r_roce_general, field,
+				rtt_resp_dscp_valid);
+	case MLX5_IB_DBG_CC_GENERAL_RTT_RESP_DSCP:
+		return MLX5_GET(cong_control_r_roce_general, field,
+				rtt_resp_dscp);
 	default:
 		return 0;
 	}
@@ -264,6 +277,15 @@ static void mlx5_ib_set_cc_param_mask_val(void *field, int offset,
 		MLX5_SET(cong_control_r_roce_ecn_np, field, cnp_prio_mode, 0);
 		MLX5_SET(cong_control_r_roce_ecn_np, field, cnp_802p_prio, var);
 		break;
+	case MLX5_IB_DBG_CC_GENERAL_RTT_RESP_DSCP_VALID:
+		*attr_mask |= MLX5_IB_GENERAL_RTT_RESP_DSCP_ATTR;
+		MLX5_SET(cong_control_r_roce_general, field, rtt_resp_dscp_valid, var);
+		break;
+	case MLX5_IB_DBG_CC_GENERAL_RTT_RESP_DSCP:
+		*attr_mask |= MLX5_IB_GENERAL_RTT_RESP_DSCP_ATTR;
+		MLX5_SET(cong_control_r_roce_general, field, rtt_resp_dscp_valid, 1);
+		MLX5_SET(cong_control_r_roce_general, field, rtt_resp_dscp, var);
+		break;
 	}
 }
 
diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
index 6a21695eaa6e..e0e80bf31824 100644
--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -885,6 +885,8 @@ enum mlx5_ib_dbg_cc_types {
 	MLX5_IB_DBG_CC_NP_CNP_DSCP,
 	MLX5_IB_DBG_CC_NP_CNP_PRIO_MODE,
 	MLX5_IB_DBG_CC_NP_CNP_PRIO,
+	MLX5_IB_DBG_CC_GENERAL_RTT_RESP_DSCP_VALID,
+	MLX5_IB_DBG_CC_GENERAL_RTT_RESP_DSCP,
 	MLX5_IB_DBG_CC_MAX,
 };
 
diff --git a/include/linux/mlx5/mlx5_ifc.h b/include/linux/mlx5/mlx5_ifc.h
index 8bbf15433bb2..5203af3565e7 100644
--- a/include/linux/mlx5/mlx5_ifc.h
+++ b/include/linux/mlx5/mlx5_ifc.h
@@ -2151,6 +2151,17 @@ struct mlx5_ifc_cong_control_r_roce_ecn_rp_bits {
 	u8         reserved_at_360[0x4a0];
 };
 
+struct mlx5_ifc_cong_control_r_roce_general_bits {
+	u8         reserved_at_0[0x80];
+
+	u8         reserved_at_80[0x10];
+	u8         rtt_resp_dscp_valid[0x1];
+	u8         reserved_at_91[0x9];
+	u8         rtt_resp_dscp[0x6];
+
+	u8         reserved_at_a0[0x760];
+};
+
 struct mlx5_ifc_cong_control_802_1qau_rp_bits {
 	u8         reserved_at_0[0x80];
 
@@ -4296,6 +4307,7 @@ union mlx5_ifc_cong_control_roce_ecn_auto_bits {
 	struct mlx5_ifc_cong_control_802_1qau_rp_bits cong_control_802_1qau_rp;
 	struct mlx5_ifc_cong_control_r_roce_ecn_rp_bits cong_control_r_roce_ecn_rp;
 	struct mlx5_ifc_cong_control_r_roce_ecn_np_bits cong_control_r_roce_ecn_np;
+	struct mlx5_ifc_cong_control_r_roce_general_bits cong_control_r_roce_general;
 	u8         reserved_at_0[0x800];
 };
 
-- 
2.39.1

