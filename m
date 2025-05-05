Return-Path: <linux-rdma+bounces-10064-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E0A7AAB541
	for <lists+linux-rdma@lfdr.de>; Tue,  6 May 2025 07:25:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2BAD502A1B
	for <lists+linux-rdma@lfdr.de>; Tue,  6 May 2025 05:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57718496E9D;
	Tue,  6 May 2025 00:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FY52MbnK"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F39B52F5F86;
	Mon,  5 May 2025 23:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746487045; cv=none; b=hTW3+uDjsLqA2P4Xun49i3Am5f354fbow+vj07queds2mny36L3HYlYs2Ecjh2K6eqlZWEI5nDlQqlMC5j87N56s+qSpgz+TRA5y1qDCk5AXMltfEF9rU8GfZSwAc1lxTlJFBS/Ho2owvka9Jm/28Rhc7Nugtp4lu2pTQ/Oj+fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746487045; c=relaxed/simple;
	bh=jxorT5kC7+ch9b4vT4OAtlzC+qRhXbPQIT2KwokeOtQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gAdD6vGWYglx5HB05ngXeeyM/U1Pfae0nSnbPVDo27UamNrktZJ4GhaBbVm/PsjEpN95G2fRPEktL9IM4THlZeN0a9mAGTW/mqLItA/JzJ7QsMzxsOtQhNGfW9+zjgQoS0m8XbGQvQCXZ6prNa1+TbpLad8PCbiL02Leu7ke4x8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FY52MbnK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52A73C4CEED;
	Mon,  5 May 2025 23:17:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746487044;
	bh=jxorT5kC7+ch9b4vT4OAtlzC+qRhXbPQIT2KwokeOtQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FY52MbnK8wSDBIAbSnVm754zyjCuvwF//uAKU54Fp/uOWfvyCqJH+g78BPwBCfuOd
	 3o2S1blG8dSNOdgD9YwdwE2Fvxic5ki2nI8SUyPtxNofI463E6BUXw1xFt1YuCtUAO
	 a/6YOwgAY+UZksbpLkh27CuLjmwwJHkWVa2dYnR4XeP3tB/r+6SryKUgP+pv0ztFG6
	 w4mAcD9eW6JRgwFjxSMVfRsJg8s3fyrmwI1ZxuryEalsnTse4bOvZDRwFIBJHte0SR
	 vA5lRbWhxpU0+1l/d7brYh4pv2rhqluYxZ/ijentmQc62BqujJYKz7RkJQeQ3gfefx
	 4IxVpUrUapxqA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: William Tu <witu@nvidia.com>,
	Daniel Jurgens <danielj@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	saeedm@nvidia.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 124/153] net/mlx5e: set the tx_queue_len for pfifo_fast
Date: Mon,  5 May 2025 19:12:51 -0400
Message-Id: <20250505231320.2695319-124-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505231320.2695319-1-sashal@kernel.org>
References: <20250505231320.2695319-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.181
Content-Transfer-Encoding: 8bit

From: William Tu <witu@nvidia.com>

[ Upstream commit a38cc5706fb9f7dc4ee3a443f61de13ce1e410ed ]

By default, the mq netdev creates a pfifo_fast qdisc. On a
system with 16 core, the pfifo_fast with 3 bands consumes
16 * 3 * 8 (size of pointer) * 1024 (default tx queue len)
= 393KB. The patch sets the tx qlen to representor default
value, 128 (1<<MLX5E_REP_PARAMS_DEF_LOG_SQ_SIZE), which
consumes 16 * 3 * 8 * 128 = 49KB, saving 344KB for each
representor at ECPF.

Signed-off-by: William Tu <witu@nvidia.com>
Reviewed-by: Daniel Jurgens <danielj@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Link: https://patch.msgid.link/20250209101716.112774-9-tariqt@nvidia.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_rep.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
index de168d8cf33f7..3c8bfedeafffd 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
@@ -642,6 +642,8 @@ static void mlx5e_build_rep_netdev(struct net_device *netdev,
 	netdev->ethtool_ops = &mlx5e_rep_ethtool_ops;
 
 	netdev->watchdog_timeo    = 15 * HZ;
+	if (mlx5_core_is_ecpf(mdev))
+		netdev->tx_queue_len = 1 << MLX5E_REP_PARAMS_DEF_LOG_SQ_SIZE;
 
 #if IS_ENABLED(CONFIG_MLX5_CLS_ACT)
 	netdev->hw_features    |= NETIF_F_HW_TC;
-- 
2.39.5


