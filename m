Return-Path: <linux-rdma+bounces-10032-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A91DAAADDA
	for <lists+linux-rdma@lfdr.de>; Tue,  6 May 2025 04:44:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54E5E3B77D0
	for <lists+linux-rdma@lfdr.de>; Tue,  6 May 2025 02:39:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C95AB401337;
	Mon,  5 May 2025 23:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p4FW6KIF"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83E07385426;
	Mon,  5 May 2025 23:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746487426; cv=none; b=eNfp9vcU5HUrKeMVwkTvL1s65tTQdFA1NtzFtKkINq7mz+H3gE73YAcXcFRiDiH1bZbD90b3knvP1vshnCm87w2xnahymzTAAYLVbUDn/4OkrOU1W9WMRF2eOelNAXRcpCquPdeDN3LbKVsjen1bnY5kfyXhnZtFm3822kmwln4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746487426; c=relaxed/simple;
	bh=j7RuD0oweaGhyvg5Wfr347HLY1yzuaNKvhLk+beBfik=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=t7nh1KTvFCdzT88u4UcVDQWv7+UK/0fwEvuK+XGKtPY4aeYtglLmaS6Zd91e+RGm45NV2rB2kyHvsyXUECdksBb46v5FVs4y6Zy1/OU2S4398djj6pG147EQvhyLmAuK+1XhMMH6J5hl4NkPg81Ufyxte5DlpLkGKrM8NtWGMnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p4FW6KIF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 639FEC4CEEE;
	Mon,  5 May 2025 23:23:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746487425;
	bh=j7RuD0oweaGhyvg5Wfr347HLY1yzuaNKvhLk+beBfik=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=p4FW6KIFZtTy8wV6axdMC1U3g9G7U5XJUtGXDEx//yCSNCB61Qhk3ZTSXllQriZzv
	 TvoybLtQUTQf0UuGxAbbo76ToJpRPQ3CocjGXf9ke/9yEIjWyFUXyPl73lRxrqQgBd
	 ATZf4a23zH+BfUhocyQNk7cyvvPn16p9M1cuC5kxm71G/Ywu6ME7iR1UmMV+xHGb4R
	 8b22I+ZRzh43AQ08Ytjo+VwwTlNgyU9HQ7sDCwN2hkTYO7a0zUTuc95oTJQicjb50C
	 6eDn7dACtI5iwIDasWWzA9Prk0PS0VI2MW0X+TnT7/kbl5XzfW2qgJOaLZfiL7WqTI
	 sfQ0b/JjtvSRw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: William Tu <witu@nvidia.com>,
	Bodong Wang <bodong@nvidia.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 64/79] net/mlx5e: reduce rep rxq depth to 256 for ECPF
Date: Mon,  5 May 2025 19:21:36 -0400
Message-Id: <20250505232151.2698893-64-sashal@kernel.org>
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

[ Upstream commit b9cc8f9d700867aaa77aedddfea85e53d5e5d584 ]

By experiments, a single queue representor netdev consumes kernel
memory around 2.8MB, and 1.8MB out of the 2.8MB is due to page
pool for the RXQ. Scaling to a thousand representors consumes 2.8GB,
which becomes a memory pressure issue for embedded devices such as
BlueField-2 16GB / BlueField-3 32GB memory.

Since representor netdevs mostly handles miss traffic, and ideally,
most of the traffic will be offloaded, reduce the default non-uplink
rep netdev's RXQ default depth from 1024 to 256 if mdev is ecpf eswitch
manager. This saves around 1MB of memory per regular RQ,
(1024 - 256) * 2KB, allocated from page pool.

With rxq depth of 256, the netlink page pool tool reports
$./tools/net/ynl/cli.py --spec Documentation/netlink/specs/netdev.yaml \
	 --dump page-pool-get
 {'id': 277,
  'ifindex': 9,
  'inflight': 128,
  'inflight-mem': 786432,
  'napi-id': 775}]

This is due to mtu 1500 + headroom consumes half pages, so 256 rxq
entries consumes around 128 pages (thus create a page pool with
size 128), shown above at inflight.

Note that each netdev has multiple types of RQs, including
Regular RQ, XSK, PTP, Drop, Trap RQ. Since non-uplink representor
only supports regular rq, this patch only changes the regular RQ's
default depth.

Signed-off-by: William Tu <witu@nvidia.com>
Reviewed-by: Bodong Wang <bodong@nvidia.com>
Reviewed-by: Saeed Mahameed <saeedm@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Link: https://patch.msgid.link/20250209101716.112774-8-tariqt@nvidia.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_rep.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
index 26a9d38d1e2a7..479304afdada2 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
@@ -53,6 +53,7 @@
 #define MLX5E_REP_PARAMS_DEF_LOG_SQ_SIZE \
         max(0x7, MLX5E_PARAMS_MINIMUM_LOG_SQ_SIZE)
 #define MLX5E_REP_PARAMS_DEF_NUM_CHANNELS 1
+#define MLX5E_REP_PARAMS_DEF_LOG_RQ_SIZE 0x8
 
 static const char mlx5e_rep_driver_name[] = "mlx5e_rep";
 
@@ -1430,6 +1431,8 @@ static void mlx5e_build_rep_params(struct net_device *netdev)
 
 	/* RQ */
 	mlx5e_build_rq_params(mdev, params);
+	if (!mlx5e_is_uplink_rep(priv) && mlx5_core_is_ecpf(mdev))
+		params->log_rq_mtu_frames = MLX5E_REP_PARAMS_DEF_LOG_RQ_SIZE;
 
 	/* CQ moderation params */
 	params->rx_dim_enabled = MLX5_CAP_GEN(mdev, cq_moderation);
-- 
2.39.5


