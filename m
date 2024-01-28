Return-Path: <linux-rdma+bounces-779-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D914483F4CE
	for <lists+linux-rdma@lfdr.de>; Sun, 28 Jan 2024 10:29:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 799411F21F30
	for <lists+linux-rdma@lfdr.de>; Sun, 28 Jan 2024 09:29:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3D21DF55;
	Sun, 28 Jan 2024 09:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qQ7AxISY"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88507DDAB
	for <linux-rdma@vger.kernel.org>; Sun, 28 Jan 2024 09:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706434171; cv=none; b=YKB+6/xRv8KUIdprCGUuKt/CW/3g7ucmNP3geal8FdUe3tNHzTKecZehMzHFYitZ+DmxNAEtBEpJ4JfUHOCjeU15DfS51+ee+msy9rfPzuYPG90DPO0t0pUYMPQJDBqoK+VEBjmyFj+SDRrsDQo/OjS6/U1bsjsVrjiwboEr2nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706434171; c=relaxed/simple;
	bh=bTHbnS9yo4CvNNusnF2P+/dKr8Iic7vbsx9Lh/ALNHU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M640anPuPJceiMwTOcQCjpFNfIGDGh3nY5LfVLBwgCn3uc+kB9/whjmM7hSJVaFT0Op1JdhhDGzaQ3pkm+cW2dhJJ85lidlj9Ppl6vMn4MBhGmm0fqj3WwEaTSNUhPUwQGv9anKp1P2MjUIzwlN1wQ153MiCYwXjsO8nciSY58M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qQ7AxISY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D49A0C433F1;
	Sun, 28 Jan 2024 09:29:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706434171;
	bh=bTHbnS9yo4CvNNusnF2P+/dKr8Iic7vbsx9Lh/ALNHU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qQ7AxISYq7edYzCrVREPPq9DAvXyOfV/gb1MYO3X5egRYX+rggc3PqB9P6Nia7JJM
	 SwMs8pK4kPPKOZCmifPIt8ovyCv7QZ0naX9iiaw74/5By42Lc7PYBb1LRVKW6JHbLs
	 nzJFw9EKebI10pLF5SpNcHunuiZs4Lk4enjJ/n5/yXe+WvDKLjAmmWN3SiwFIcOE82
	 f98Lut18GVRV3RumZLTWIN205hXJ2HhrlUoOyB0SYVy/xPMH1UU4/3T2fu6a3kcIH9
	 i+OaZ7Qc3BVfeHTPR+wQQpkhZnvM3spzCod03oYoUCzpYOhesU3mGCLxdJI1ILvdib
	 4wlzyT6PnF9xA==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Mark Zhang <markzhang@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	Edward Srouji <edwards@nvidia.com>,
	linux-rdma@vger.kernel.org,
	Maor Gottlieb <maorg@nvidia.com>,
	Michael Guralnik <michaelgur@nvidia.com>,
	Or Har-Toov <ohartoov@nvidia.com>,
	Tamar Mashiah <tmashiah@nvidia.com>,
	Yishai Hadas <yishaih@nvidia.com>
Subject: [PATCH rdma-next v1 2/6] IB/mlx5: Don't expose debugfs entries for RRoCE general parameters if not supported
Date: Sun, 28 Jan 2024 11:29:12 +0200
Message-ID: <e7ade70bad52b7468bdb1de4d41d5fad70c8b71c.1706433934.git.leon@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1706433934.git.leon@kernel.org>
References: <cover.1706433934.git.leon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mark Zhang <markzhang@nvidia.com>

debugfs entries for RRoCE general CC parameters must be exposed only when
they are supported, otherwise when accessing them there may be a syndrome
error in kernel log, for example:

$ cat /sys/kernel/debug/mlx5/0000:08:00.1/cc_params/rtt_resp_dscp
cat: '/sys/kernel/debug/mlx5/0000:08:00.1/cc_params/rtt_resp_dscp': Invalid argument
$ dmesg
 mlx5_core 0000:08:00.1: mlx5_cmd_out_err:805:(pid 1253): QUERY_CONG_PARAMS(0x824) op_mod(0x0) failed, status bad parameter(0x3), syndrome (0x325a82), err(-22)

Fixes: 66fb1d5df6ac ("IB/mlx5: Extend debug control for CC parameters")
Reviewed-by: Edward Srouji <edwards@nvidia.com>
Signed-off-by: Mark Zhang <markzhang@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/cong.c | 6 ++++++
 include/linux/mlx5/mlx5_ifc.h     | 2 +-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/mlx5/cong.c b/drivers/infiniband/hw/mlx5/cong.c
index f87531318feb..a78a067e3ce7 100644
--- a/drivers/infiniband/hw/mlx5/cong.c
+++ b/drivers/infiniband/hw/mlx5/cong.c
@@ -458,6 +458,12 @@ void mlx5_ib_init_cong_debugfs(struct mlx5_ib_dev *dev, u32 port_num)
 	dbg_cc_params->root = debugfs_create_dir("cc_params", mlx5_debugfs_get_dev_root(mdev));
 
 	for (i = 0; i < MLX5_IB_DBG_CC_MAX; i++) {
+		if ((i == MLX5_IB_DBG_CC_GENERAL_RTT_RESP_DSCP_VALID ||
+		     i == MLX5_IB_DBG_CC_GENERAL_RTT_RESP_DSCP))
+			if (!MLX5_CAP_GEN(mdev, roce) ||
+			    !MLX5_CAP_ROCE(mdev, roce_cc_general))
+				continue;
+
 		dbg_cc_params->params[i].offset = i;
 		dbg_cc_params->params[i].dev = dev;
 		dbg_cc_params->params[i].port_num = port_num;
diff --git a/include/linux/mlx5/mlx5_ifc.h b/include/linux/mlx5/mlx5_ifc.h
index bf5320b28b8b..2c10350bd422 100644
--- a/include/linux/mlx5/mlx5_ifc.h
+++ b/include/linux/mlx5/mlx5_ifc.h
@@ -1103,7 +1103,7 @@ struct mlx5_ifc_roce_cap_bits {
 	u8         sw_r_roce_src_udp_port[0x1];
 	u8         fl_rc_qp_when_roce_disabled[0x1];
 	u8         fl_rc_qp_when_roce_enabled[0x1];
-	u8         reserved_at_7[0x1];
+	u8         roce_cc_general[0x1];
 	u8	   qp_ooo_transmit_default[0x1];
 	u8         reserved_at_9[0x15];
 	u8	   qp_ts_format[0x2];
-- 
2.43.0


