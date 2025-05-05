Return-Path: <linux-rdma+bounces-10017-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF9FBAAAFA7
	for <lists+linux-rdma@lfdr.de>; Tue,  6 May 2025 05:21:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D1047B4F0A
	for <lists+linux-rdma@lfdr.de>; Tue,  6 May 2025 03:15:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E50D3C2E32;
	Mon,  5 May 2025 23:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lU01cAuz"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A02923881A0;
	Mon,  5 May 2025 23:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486736; cv=none; b=Ifl82uIknZeLdg/OWo1bdwSs4xLJUaBZhieUMYxnbGN/AxCGuDjDMtoqSGC7poliIRES8kMvZikttc1X3mWyW+PaL8J7pom/hSUeSWBEAgO2e81RYflh14Wwb6+EyT8FygbRkDasecjyBiOpIS/r7l32h8YW6aDz15TyOjU5AXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486736; c=relaxed/simple;
	bh=hiKBaxF6RN2nc1EUeWeuIkjft2VUiBmJi4Gmg5IKtJ8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NpIL70BUfjr+bqzw45moZ5pa8Dy+amxDuvegMk37RTCIBNjvw/Bbsddt/BdkEzFMOZY5TKxELpdXRLrckN8uVlo/eL8avv68Or7jBrp/GbjFk4rkwXtFAJ9PBEWQU/n+WaGJ0ZlKH4CqnK4iTtFoyNbd0qpE8aBM2jFSV/wA9+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lU01cAuz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC667C4CEE4;
	Mon,  5 May 2025 23:12:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486736;
	bh=hiKBaxF6RN2nc1EUeWeuIkjft2VUiBmJi4Gmg5IKtJ8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lU01cAuzDXFvZ8ewhHHPX9CYEJRHDI3B5zj3NtuMFav9VXTvipHWH32UPVMh8gb+F
	 RzU1bZZQOnVT66yS0qPasCw8sOD0YXtbNEd9O9Olt/Mb5DAy61hD9Ym1KLpFn3dgw8
	 RiG0IgGy1qryu0Z/LVHMBy/z7HPQW1ho9kCaG2pMBXQ4ZDJUB+80dYUECgtd+j105X
	 uRCLBYJvrj3Mq/w6Cz98LApkIzZ49qNOqaYmoZVqAhvZkYtu2JRwFzbmSwBicYO0Zg
	 s/vGEQ3g7nVqlgT9yM+Jx290gWnPkbQKToL3Bz81OYtOfolThPGkKyLDZf5W9EoITL
	 OdtGr9VlP6N2Q==
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
Subject: [PATCH AUTOSEL 6.1 176/212] net/mlx5e: reduce rep rxq depth to 256 for ECPF
Date: Mon,  5 May 2025 19:05:48 -0400
Message-Id: <20250505230624.2692522-176-sashal@kernel.org>
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
index 837524d1d2258..b4980245b50b2 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
@@ -61,6 +61,7 @@
 #define MLX5E_REP_PARAMS_DEF_LOG_SQ_SIZE \
 	max(0x7, MLX5E_PARAMS_MINIMUM_LOG_SQ_SIZE)
 #define MLX5E_REP_PARAMS_DEF_NUM_CHANNELS 1
+#define MLX5E_REP_PARAMS_DEF_LOG_RQ_SIZE 0x8
 
 static const char mlx5e_rep_driver_name[] = "mlx5e_rep";
 
@@ -705,6 +706,8 @@ static void mlx5e_build_rep_params(struct net_device *netdev)
 
 	/* RQ */
 	mlx5e_build_rq_params(mdev, params);
+	if (!mlx5e_is_uplink_rep(priv) && mlx5_core_is_ecpf(mdev))
+		params->log_rq_mtu_frames = MLX5E_REP_PARAMS_DEF_LOG_RQ_SIZE;
 
 	/* CQ moderation params */
 	params->rx_dim_enabled = MLX5_CAP_GEN(mdev, cq_moderation);
-- 
2.39.5


