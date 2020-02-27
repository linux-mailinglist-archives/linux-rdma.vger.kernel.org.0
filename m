Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 65CB61717DA
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Feb 2020 13:52:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728964AbgB0Mwv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 27 Feb 2020 07:52:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:43526 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728977AbgB0Mwv (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 27 Feb 2020 07:52:51 -0500
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CBD8324693;
        Thu, 27 Feb 2020 12:52:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582807970;
        bh=ux9hp3/OZsj3x1r7t/Q1wperuF5t61j+gv4ItPmKVrQ=;
        h=From:To:Cc:Subject:Date:From;
        b=Ka4lwgajqyeZPGGU7AW646El820zWvS8x/GPVWvcAH0NVL+QekWiaSbZx6JyNf7zD
         S3AGwImi0nGgZjsRIwd37QS8/mnYzj7nmhrIMjCORkft4dTdMs0qeRFo4dnuNdIJ80
         4zSHFTHW6yW6GQKB+lZDtpY8a4cKqcrxK12h17c4=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Parav Pandit <parav@mellanox.com>, linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next] IB/mlx5: Add np_min_time_between_cnps and rp_max_rate debug params
Date:   Thu, 27 Feb 2020 14:52:46 +0200
Message-Id: <20200227125246.99472-1-leon@kernel.org>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Parav Pandit <parav@mellanox.com>

Add two debugfs parameters described below.

np_min_time_between_cnps - Minimum time between sending CNPs from the
                           port.
                           Unit = microseconds.
                           Default = 0 (no min wait time; generated
                           based on incoming ECN marked packets).

rp_max_rate - Maximum rate at which reaction point node can transmit.
              Once this limit is reached, RP is no longer rate limited.
              Unit = Mbits/sec
              Default = 0 (full speed)

Signed-off-by: Parav Pandit <parav@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/hw/mlx5/cong.c    | 20 ++++++++++++++++++++
 drivers/infiniband/hw/mlx5/mlx5_ib.h |  2 ++
 2 files changed, 22 insertions(+)

diff --git a/drivers/infiniband/hw/mlx5/cong.c b/drivers/infiniband/hw/mlx5/cong.c
index 8ba439fabf7f..de4da92b81a6 100644
--- a/drivers/infiniband/hw/mlx5/cong.c
+++ b/drivers/infiniband/hw/mlx5/cong.c
@@ -47,6 +47,7 @@ static const char * const mlx5_ib_dbg_cc_name[] = {
 	"rp_byte_reset",
 	"rp_threshold",
 	"rp_ai_rate",
+	"rp_max_rate",
 	"rp_hai_rate",
 	"rp_min_dec_fac",
 	"rp_min_rate",
@@ -56,6 +57,7 @@ static const char * const mlx5_ib_dbg_cc_name[] = {
 	"rp_rate_reduce_monitor_period",
 	"rp_initial_alpha_value",
 	"rp_gd",
+	"np_min_time_between_cnps",
 	"np_cnp_dscp",
 	"np_cnp_prio_mode",
 	"np_cnp_prio",
@@ -66,6 +68,7 @@ static const char * const mlx5_ib_dbg_cc_name[] = {
 #define MLX5_IB_RP_TIME_RESET_ATTR			BIT(3)
 #define MLX5_IB_RP_BYTE_RESET_ATTR			BIT(4)
 #define MLX5_IB_RP_THRESHOLD_ATTR			BIT(5)
+#define MLX5_IB_RP_MAX_RATE_ATTR			BIT(6)
 #define MLX5_IB_RP_AI_RATE_ATTR				BIT(7)
 #define MLX5_IB_RP_HAI_RATE_ATTR			BIT(8)
 #define MLX5_IB_RP_MIN_DEC_FAC_ATTR			BIT(9)
@@ -77,6 +80,7 @@ static const char * const mlx5_ib_dbg_cc_name[] = {
 #define MLX5_IB_RP_INITIAL_ALPHA_VALUE_ATTR		BIT(15)
 #define MLX5_IB_RP_GD_ATTR				BIT(16)
 
+#define MLX5_IB_NP_MIN_TIME_BETWEEN_CNPS_ATTR		BIT(2)
 #define MLX5_IB_NP_CNP_DSCP_ATTR			BIT(3)
 #define MLX5_IB_NP_CNP_PRIO_MODE_ATTR			BIT(4)
 
@@ -111,6 +115,9 @@ static u32 mlx5_get_cc_param_val(void *field, int offset)
 	case MLX5_IB_DBG_CC_RP_AI_RATE:
 		return MLX5_GET(cong_control_r_roce_ecn_rp, field,
 				rpg_ai_rate);
+	case MLX5_IB_DBG_CC_RP_MAX_RATE:
+		return MLX5_GET(cong_control_r_roce_ecn_rp, field,
+				rpg_max_rate);
 	case MLX5_IB_DBG_CC_RP_HAI_RATE:
 		return MLX5_GET(cong_control_r_roce_ecn_rp, field,
 				rpg_hai_rate);
@@ -138,6 +145,9 @@ static u32 mlx5_get_cc_param_val(void *field, int offset)
 	case MLX5_IB_DBG_CC_RP_GD:
 		return MLX5_GET(cong_control_r_roce_ecn_rp, field,
 				rpg_gd);
+	case MLX5_IB_DBG_CC_NP_MIN_TIME_BETWEEN_CNPS:
+		return MLX5_GET(cong_control_r_roce_ecn_np, field,
+				min_time_between_cnps);
 	case MLX5_IB_DBG_CC_NP_CNP_DSCP:
 		return MLX5_GET(cong_control_r_roce_ecn_np, field,
 				cnp_dscp);
@@ -186,6 +196,11 @@ static void mlx5_ib_set_cc_param_mask_val(void *field, int offset,
 		MLX5_SET(cong_control_r_roce_ecn_rp, field,
 			 rpg_ai_rate, var);
 		break;
+	case MLX5_IB_DBG_CC_RP_MAX_RATE:
+		*attr_mask |= MLX5_IB_RP_MAX_RATE_ATTR;
+		MLX5_SET(cong_control_r_roce_ecn_rp, field,
+			 rpg_max_rate, var);
+		break;
 	case MLX5_IB_DBG_CC_RP_HAI_RATE:
 		*attr_mask |= MLX5_IB_RP_HAI_RATE_ATTR;
 		MLX5_SET(cong_control_r_roce_ecn_rp, field,
@@ -231,6 +246,11 @@ static void mlx5_ib_set_cc_param_mask_val(void *field, int offset,
 		MLX5_SET(cong_control_r_roce_ecn_rp, field,
 			 rpg_gd, var);
 		break;
+	case MLX5_IB_DBG_CC_NP_MIN_TIME_BETWEEN_CNPS:
+		*attr_mask |= MLX5_IB_NP_MIN_TIME_BETWEEN_CNPS_ATTR;
+		MLX5_SET(cong_control_r_roce_ecn_np, field,
+			 min_time_between_cnps, var);
+		break;
 	case MLX5_IB_DBG_CC_NP_CNP_DSCP:
 		*attr_mask |= MLX5_IB_NP_CNP_DSCP_ATTR;
 		MLX5_SET(cong_control_r_roce_ecn_np, field, cnp_dscp, var);
diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
index e57db925bb5c..d843bec8704a 100644
--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -809,6 +809,7 @@ enum mlx5_ib_dbg_cc_types {
 	MLX5_IB_DBG_CC_RP_BYTE_RESET,
 	MLX5_IB_DBG_CC_RP_THRESHOLD,
 	MLX5_IB_DBG_CC_RP_AI_RATE,
+	MLX5_IB_DBG_CC_RP_MAX_RATE,
 	MLX5_IB_DBG_CC_RP_HAI_RATE,
 	MLX5_IB_DBG_CC_RP_MIN_DEC_FAC,
 	MLX5_IB_DBG_CC_RP_MIN_RATE,
@@ -818,6 +819,7 @@ enum mlx5_ib_dbg_cc_types {
 	MLX5_IB_DBG_CC_RP_RATE_REDUCE_MONITOR_PERIOD,
 	MLX5_IB_DBG_CC_RP_INITIAL_ALPHA_VALUE,
 	MLX5_IB_DBG_CC_RP_GD,
+	MLX5_IB_DBG_CC_NP_MIN_TIME_BETWEEN_CNPS,
 	MLX5_IB_DBG_CC_NP_CNP_DSCP,
 	MLX5_IB_DBG_CC_NP_CNP_PRIO_MODE,
 	MLX5_IB_DBG_CC_NP_CNP_PRIO,
-- 
2.24.1

