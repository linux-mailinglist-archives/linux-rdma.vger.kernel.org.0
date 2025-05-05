Return-Path: <linux-rdma+bounces-10043-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D24E8AAB205
	for <lists+linux-rdma@lfdr.de>; Tue,  6 May 2025 06:11:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D5003A6F0B
	for <lists+linux-rdma@lfdr.de>; Tue,  6 May 2025 04:05:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E42B336606;
	Tue,  6 May 2025 00:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nYquS4II"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FDAA2D3F8E;
	Mon,  5 May 2025 22:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485604; cv=none; b=d1uHZO/aFYd1eVHK3WpTfuAYaL3SHppWkEwxPBLP80OsaPa9er9eVpdz/lDyy4x8HSauVF6g0aHo2yBQqSb48OOplw6UF1mslz22qKQizlEa5i5qy/SRuQ88my5TO+KJbxLr5c5+TdNj98pMfup3CsI9fxvRw6MNpPeZgalEyHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485604; c=relaxed/simple;
	bh=CetfJIbeQxqv4yBRvTwQlTG7mgijiurlfSPO2AauUUU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eGjWeHMFtTSl8B/M5mCUNA9iREx6kwzboxZVPM0u0whVROZ1D+z1b/VKMAyDY59w2OyMEE+aLEY0RDe1aLqRxQl1W/kPF4ztqxYFYeCIhVlQEfWpi/5JM/E38WpOcTO+37mNEIl/lew3LYe6+3ddshuhz/lso9pvpgATfmIztZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nYquS4II; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE09BC4CEED;
	Mon,  5 May 2025 22:53:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485604;
	bh=CetfJIbeQxqv4yBRvTwQlTG7mgijiurlfSPO2AauUUU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nYquS4II2NKrArPztuH9a63qsVEyt0XbAYKIZgIef3eoff/7JvnyFdNgyJuroeCDV
	 wKf68MEWdCkpXwo/qpRtJTqecboiZzAyxC4ubvnzZ6QXL2Cc7amesPdw+86eDk/zG3
	 x2uMjtgV3ovuzg6JWZxZIVACNYkgRZpo9OJE4dJSbmFylbZBjmRD0zRNYBPicZXEmH
	 cQE5FFvGbkcdnC52lQckle/lNE3MgbxLLCHYcqnh6PD70EkezSHMDs+SqSjU0pgl0Z
	 Yq7aGHigytdYiyg+lTan4CDaopOdUpKrA/cc0KdtdZet7sW8dp8XbdTtKvtQ+xSLcM
	 dC6XPsQd5zuPA==
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
Subject: [PATCH AUTOSEL 6.12 382/486] net/mlx5e: reduce rep rxq depth to 256 for ECPF
Date: Mon,  5 May 2025 18:37:38 -0400
Message-Id: <20250505223922.2682012-382-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505223922.2682012-1-sashal@kernel.org>
References: <20250505223922.2682012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.26
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
index fd1f460b7be65..18ec392d17404 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
@@ -65,6 +65,7 @@
 #define MLX5E_REP_PARAMS_DEF_LOG_SQ_SIZE \
 	max(0x7, MLX5E_PARAMS_MINIMUM_LOG_SQ_SIZE)
 #define MLX5E_REP_PARAMS_DEF_NUM_CHANNELS 1
+#define MLX5E_REP_PARAMS_DEF_LOG_RQ_SIZE 0x8
 
 static const char mlx5e_rep_driver_name[] = "mlx5e_rep";
 
@@ -854,6 +855,8 @@ static void mlx5e_build_rep_params(struct net_device *netdev)
 
 	/* RQ */
 	mlx5e_build_rq_params(mdev, params);
+	if (!mlx5e_is_uplink_rep(priv) && mlx5_core_is_ecpf(mdev))
+		params->log_rq_mtu_frames = MLX5E_REP_PARAMS_DEF_LOG_RQ_SIZE;
 
 	/* If netdev is already registered (e.g. move from nic profile to uplink,
 	 * RTNL lock must be held before triggering netdev notifiers.
-- 
2.39.5


