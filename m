Return-Path: <linux-rdma+bounces-10049-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2011FAAB32B
	for <lists+linux-rdma@lfdr.de>; Tue,  6 May 2025 06:39:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD17C7A2F88
	for <lists+linux-rdma@lfdr.de>; Tue,  6 May 2025 04:38:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AD45233736;
	Tue,  6 May 2025 00:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mL+oehhH"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3D65395296;
	Mon,  5 May 2025 23:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486275; cv=none; b=BDsaqAjGdhJL7vzdXIXCPwklXhh7VmbLOPaqzoABCbTnwjK7XGtX0/C8+rmI8bp+YuQUWcO9DLzSNXDRV5mPcrJXC8GKsCNGwLnBjLGIK6m1ldn2F4TfA3aw0f5+pfm/gE8FtFdo9y4ZXnaGIne1/A8GpFV45wavoiyUCaI5Sp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486275; c=relaxed/simple;
	bh=8kA8JRXs1KDgIIR+ppzDaByKNcv0ETNJB6rU65G5qIc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AD5rOHtNToXB+1FHOPtZIIBFb9OswVoOx8XMtw7TweBCrmAt7mNIsxNIhYBb388XALrXrx1wy+4dUAOaXdFVGoIBtTS0otKQ5uZhyjLaIzds+udth6zf37O1+ZR7sU7O4juewhzoD54JoAZxJGOdCNaMyLVp3np1ARPtHtysxO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mL+oehhH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15C37C4CEEE;
	Mon,  5 May 2025 23:04:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486274;
	bh=8kA8JRXs1KDgIIR+ppzDaByKNcv0ETNJB6rU65G5qIc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mL+oehhHwBUbbcr9+UQkfhqXmSCE5HMOxHyB7Acuo8LQ+bEvROLpfqQSNHwbl6Ffh
	 ZkiJohmtZJe/BTQ79JhHYKuLI/1cvR368RQ0WVRtUP1Qzpy2zAxWRQeBGXM/t1rl/V
	 LIj7pJ0j62G1GkJNC7IYzpUQnWSSTq1wGGIxDwAvwQA9DvlSWkkBGvEG1Dx961lwa0
	 dSsSmFhT4BOpNKRBKJB9r2M0HAEacha2Y/0ZC01TzDqID4XzdxqlN+7CVWWO7o/26q
	 dWKZjKCm6YoBLUDDOZ0bdHdFv6KagCLDyd0/mJDsGbqrd8+8TSgaq/8/WK87naCX06
	 94VwvghNCvDQA==
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
Subject: [PATCH AUTOSEL 6.6 234/294] net/mlx5e: reduce rep rxq depth to 256 for ECPF
Date: Mon,  5 May 2025 18:55:34 -0400
Message-Id: <20250505225634.2688578-234-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505225634.2688578-1-sashal@kernel.org>
References: <20250505225634.2688578-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.89
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
index 39d8e63e8856d..851c499faa795 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
@@ -63,6 +63,7 @@
 #define MLX5E_REP_PARAMS_DEF_LOG_SQ_SIZE \
 	max(0x7, MLX5E_PARAMS_MINIMUM_LOG_SQ_SIZE)
 #define MLX5E_REP_PARAMS_DEF_NUM_CHANNELS 1
+#define MLX5E_REP_PARAMS_DEF_LOG_RQ_SIZE 0x8
 
 static const char mlx5e_rep_driver_name[] = "mlx5e_rep";
 
@@ -798,6 +799,8 @@ static void mlx5e_build_rep_params(struct net_device *netdev)
 
 	/* RQ */
 	mlx5e_build_rq_params(mdev, params);
+	if (!mlx5e_is_uplink_rep(priv) && mlx5_core_is_ecpf(mdev))
+		params->log_rq_mtu_frames = MLX5E_REP_PARAMS_DEF_LOG_RQ_SIZE;
 
 	/* If netdev is already registered (e.g. move from nic profile to uplink,
 	 * RTNL lock must be held before triggering netdev notifiers.
-- 
2.39.5


