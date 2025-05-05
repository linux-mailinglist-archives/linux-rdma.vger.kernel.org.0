Return-Path: <linux-rdma+bounces-10058-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 55BC6AAB48E
	for <lists+linux-rdma@lfdr.de>; Tue,  6 May 2025 07:09:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F3E61BC7398
	for <lists+linux-rdma@lfdr.de>; Tue,  6 May 2025 05:05:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34C84343480;
	Tue,  6 May 2025 00:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d+QmuSal"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17FD52F15F9;
	Mon,  5 May 2025 23:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486735; cv=none; b=p4lfXxl23yXHoR1E/JuPmQtR5gsg6lumv9Xwmr7Kt9nczmz4OF97+KGl71BUJsrp/t/s3ZemuZ/MNWHWV9DZhct0hrsU/YhtfqZyoUfrpZSwOE9CWSh7i+YbhDSpSQcj/RdQu430vLgfxM4BpmlBDT+dSOsbmOVPsE6C7+gvv7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486735; c=relaxed/simple;
	bh=fozbL4ARgGVcyBRnHM/0p/+P3J3KrYx0j2BVNXpNOgA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hQ6lc6pcCzhVDvHT2y8P4BMv2J9KYkHLGkCdp9n2Lzac6WrtPrChvhqGycM/UeIsNPX60+dvOPgH6JyZfUb4zpnJS0NCKa1BEt0Sm9BrjKcgqPujYgqJ2za7bGqaTa2EfSVtY5DgPOhh4abdXq5C2M+RJfZ/aBBIKv8+U2C8pDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d+QmuSal; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5506C4CEEE;
	Mon,  5 May 2025 23:12:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486734;
	bh=fozbL4ARgGVcyBRnHM/0p/+P3J3KrYx0j2BVNXpNOgA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=d+QmuSalCwC5qYANEhVkdl/EgEor0zI5+X4wKU4ZhS/+7FgBX/A8oCr/CA7AA7wPc
	 pGmUYw+4yYBTImixIQz2y+TqZhX9sXwhtIaC3NFz0aCbomBkWvzLSDn3/O9GpXqXA9
	 g/kYs6H1T5qQw2SFNQs61FjPI308jQz25JAS2F862toQ5iY9L6NLMvmxkXC4YNbuG/
	 FUnluxrjiYAh5LJrWopN/tCZLVX5m2bJpLBbTGVV/kx9J+qd/l9RamekudVZIzbJ3i
	 uwRdGVXE8NBZ8oo/8H8RzJNfGWh/VJhOq9mfXQviRf3jABFUpKdtXnBLFP37Ybqx5z
	 IKvp8d1TyMX8g==
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
Subject: [PATCH AUTOSEL 6.1 175/212] net/mlx5e: set the tx_queue_len for pfifo_fast
Date: Mon,  5 May 2025 19:05:47 -0400
Message-Id: <20250505230624.2692522-175-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505230624.2692522-1-sashal@kernel.org>
References: <20250505230624.2692522-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.136
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
index 5aeca9534f15a..837524d1d2258 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
@@ -726,6 +726,8 @@ static void mlx5e_build_rep_netdev(struct net_device *netdev,
 	netdev->ethtool_ops = &mlx5e_rep_ethtool_ops;
 
 	netdev->watchdog_timeo    = 15 * HZ;
+	if (mlx5_core_is_ecpf(mdev))
+		netdev->tx_queue_len = 1 << MLX5E_REP_PARAMS_DEF_LOG_SQ_SIZE;
 
 #if IS_ENABLED(CONFIG_MLX5_CLS_ACT)
 	netdev->hw_features    |= NETIF_F_HW_TC;
-- 
2.39.5


