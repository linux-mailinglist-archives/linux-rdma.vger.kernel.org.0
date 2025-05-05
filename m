Return-Path: <linux-rdma+bounces-10030-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2486BAAADBF
	for <lists+linux-rdma@lfdr.de>; Tue,  6 May 2025 04:41:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 423A7173C93
	for <lists+linux-rdma@lfdr.de>; Tue,  6 May 2025 02:38:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E83B130EEAE;
	Mon,  5 May 2025 23:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LkEeVeLb"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27959385402;
	Mon,  5 May 2025 23:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746487424; cv=none; b=SBT0u/4CfB2v958HIcsxrFI7l0L181O8Tqq1RQbm0H97Sd36LgLQFWSWOhx0ugWzM5rdItbxlv2Gqz8knDjHA0AufNRifzYOL15QW1Uat8HqAW7STOEvN/Qafi4ypNaSA9UWlNfte4dH9b1Gl+aw2i5/MUx1azsag66MRnnEjPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746487424; c=relaxed/simple;
	bh=fzSzdTe7U8gOqg5CSe06w5il22KPV5S86Hppe8x/Dxg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MeKQq5H+RXhsS/XzzZ2asi5EIKbERoDe8BIh5PTcmzuugJGeNqmS1C99lvimqgs1UGSZLXeephV9vX6g23V0oLFwqjWcs8Ga65k3aAvbc6BoFAsmGClR4CrkT+Y41ZVmGaO4EOd7Uj0spTQaf2jdsefmd/HSG07idH8f+xOeng4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LkEeVeLb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BB2DC4CEED;
	Mon,  5 May 2025 23:23:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746487423;
	bh=fzSzdTe7U8gOqg5CSe06w5il22KPV5S86Hppe8x/Dxg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LkEeVeLbCEv6cqn8LznVLHO+DyUHm2hpurZeKAeOjGEONI2OBhawuP3E2OkVJY4nX
	 JrRpFVxJo566W1hX4v7Ogwg1ib5cdpdOpE1j8qe3AfunkcHpBDgN3fOsj287FzLb9Y
	 fBGHM6jw6Rtl2HoMF+tE5/bPPj8Ml+KHHZ7pDVFPdsrZZv+WKMv7XaFW/PhAk+M+PI
	 7rb4WZJBnV2An3qZvjA5DGeFp70+wAoKTo8595WqHudueCXzaDW+Vkh60yyFnhJQoI
	 n3dfoK0vxOHuAAZKqAk0/SLjbEweLiS9+vHroFii24A0l6f4i4pyMILbucR1ue2Len
	 6jdfGHXeQqOVA==
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
Subject: [PATCH AUTOSEL 5.4 63/79] net/mlx5e: set the tx_queue_len for pfifo_fast
Date: Mon,  5 May 2025 19:21:35 -0400
Message-Id: <20250505232151.2698893-63-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505232151.2698893-1-sashal@kernel.org>
References: <20250505232151.2698893-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.293
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
index a40fecfdb10ca..26a9d38d1e2a7 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
@@ -1470,6 +1470,8 @@ static void mlx5e_build_rep_netdev(struct net_device *netdev)
 	}
 
 	netdev->watchdog_timeo    = 15 * HZ;
+	if (mlx5_core_is_ecpf(mdev))
+		netdev->tx_queue_len = 1 << MLX5E_REP_PARAMS_DEF_LOG_SQ_SIZE;
 
 	netdev->features       |= NETIF_F_NETNS_LOCAL;
 
-- 
2.39.5


