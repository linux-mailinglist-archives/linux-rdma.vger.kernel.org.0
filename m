Return-Path: <linux-rdma+bounces-10027-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6942EAAB026
	for <lists+linux-rdma@lfdr.de>; Tue,  6 May 2025 05:32:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D98D1B67B94
	for <lists+linux-rdma@lfdr.de>; Tue,  6 May 2025 03:32:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCA443F0CF4;
	Mon,  5 May 2025 23:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AmcgVSAa"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 494783B5B33;
	Mon,  5 May 2025 23:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746487278; cv=none; b=ZexGUBWTx1l9hcbYnYQ3aQZmSYHRsKjV5hbg/e+hDJho3NjVwHU0DqedfNNoBUVOkDxUvinuXCrGMH8c2ErVMvf2iXoeXvSwBVrdhSRUNemGuIWCL9lHlzWRYhLV47rjiSoNQMnijMQKV3BTKUQC0Vcue3MunQvTHogDeBBpCQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746487278; c=relaxed/simple;
	bh=S/Cte9p8InZJ+f6lS7sOvVDP07xinm5aSDVWCNHDwsk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GTGqBiURQYBcgEG6pCR7kLHUzOsPxX/2lerI2N/mw2kauBSZxDa7nDiLyvNsjX3vXG8tbUubXvK2oY7svXUs2YlH1DfR5uSyPMc5g5hLjcncCS6EnyZqEymyy667LRkSYREmNmGrIel3cZNVMS3N6/aMsS/9hBrWAVmMwOItux8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AmcgVSAa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FB8CC4CEE4;
	Mon,  5 May 2025 23:21:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746487277;
	bh=S/Cte9p8InZJ+f6lS7sOvVDP07xinm5aSDVWCNHDwsk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AmcgVSAaAcwud/rsF0ZNAmpBSWRlrPokt60aJhdOKf2TWQ55gq5Ldj8eZsXU0EEAW
	 AGcFhm/09+nIABkk05xMkD9li9Wa0GYASEiKLDEH7YdjhmOH/XVm8o3rwXZpR0IgzT
	 5+gmqq91COR83pl1DTdpzsVJkBNEMNBQ7UW/2Pg0RhE4+ul3OfHyUzWbWEMPRmj1FM
	 aIHLJVBfiVzEqs7j+4Z3y6ctkRZn4L/mafTcC7tzXTKlk4sR3fQm9SArGFRB1osyW8
	 EUFrq5W7od5xZwRdGALTB/Xel1/CUFfDPPwvK3z+K54r1AMR1As+HeqzCiDSleilYZ
	 TYyJ6aMps/9yg==
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
Subject: [PATCH AUTOSEL 5.10 094/114] net/mlx5e: set the tx_queue_len for pfifo_fast
Date: Mon,  5 May 2025 19:17:57 -0400
Message-Id: <20250505231817.2697367-94-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505231817.2697367-1-sashal@kernel.org>
References: <20250505231817.2697367-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.237
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
index 6512bb231e7e0..8eb7288f820a4 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
@@ -740,6 +740,8 @@ static void mlx5e_build_rep_netdev(struct net_device *netdev)
 	}
 
 	netdev->watchdog_timeo    = 15 * HZ;
+	if (mlx5_core_is_ecpf(mdev))
+		netdev->tx_queue_len = 1 << MLX5E_REP_PARAMS_DEF_LOG_SQ_SIZE;
 
 	netdev->features       |= NETIF_F_NETNS_LOCAL;
 
-- 
2.39.5


