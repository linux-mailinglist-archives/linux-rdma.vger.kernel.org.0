Return-Path: <linux-rdma+bounces-14043-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B936FC09890
	for <lists+linux-rdma@lfdr.de>; Sat, 25 Oct 2025 18:33:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F33B3AC8D0
	for <lists+linux-rdma@lfdr.de>; Sat, 25 Oct 2025 16:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8098A304BC1;
	Sat, 25 Oct 2025 16:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ccVn/F8P"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 362973054D1;
	Sat, 25 Oct 2025 16:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761409323; cv=none; b=Yi3tQJ41peLDE+/i46JS6xrjJLLp4PZ1t3IJZG2uTE0ItWRPJDn5vgCPTfTj8EW3WHktnd6oB82MAsGq3q+o2scNNhgZIj0awwPiLXNDCaYN/AMO+83mEE7yLgRFJR4OQfB5AQ3UwKYvGa2AndZWdYtFX9GlvRxhufymYw8TURY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761409323; c=relaxed/simple;
	bh=BymGNPj82NaSFZQ2tSGRk2+TuheCQrfQdfZVGqDguuY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O2ybpPUV8ByqUZrbOMyvn3Wvnn8MlzZ92oerYa458eBv44FSo/ku2QTjJB0K8DONN9cwsH8pZuqPdDDcEpoweLBeZDKH7MFkqIVTQFtcvhvfWUSEvcpOH/zzHSqwnTqUunO+l0IXkuWmtCi+01xAOIn7TfS68ehne5+tOVtXAx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ccVn/F8P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAB71C2BCB8;
	Sat, 25 Oct 2025 16:22:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761409323;
	bh=BymGNPj82NaSFZQ2tSGRk2+TuheCQrfQdfZVGqDguuY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ccVn/F8PQLXJIvD5+umydTKp462BojBiCWfuj2KMaBBhsMIbRrNJDvSPsuTAhQZu/
	 W0pmwom++rKoQxgeBWQIdx8FWBr6EyQMlb190mN4WgsHAJ8ogI13cE4n6cZZpcB/S0
	 3Fx6UY2/aKpOVCvQCyEQ1St9XTu2ePzQ2laXthyPZc3A2i5HkkqGVZ5DMe2EkY2YSo
	 yOXiDN9vRMm04fEH1X6+Xl5yPrAAiO1U7J7T8T3UvDnJ1WT8kjCBczKnWwWHwl+40C
	 RYDR0CvLtrS9chl7DWIb/RcmSad7VWr1mz9ICqLY+5l7iRJl24qZkSwG8WNxj6wDjt
	 ArfXXI+S8IE1A==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Jianbo Liu <jianbol@nvidia.com>,
	Cosmin Ratiu <cratiu@nvidia.com>,
	Jiri Pirko <jiri@nvidia.com>,
	Dragos Tatulea <dtatulea@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	saeedm@nvidia.com,
	mbloch@nvidia.com,
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org
Subject: [PATCH AUTOSEL 6.17] net/mlx5e: Prevent entering switchdev mode with inconsistent netns
Date: Sat, 25 Oct 2025 11:58:30 -0400
Message-ID: <20251025160905.3857885-279-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251025160905.3857885-1-sashal@kernel.org>
References: <20251025160905.3857885-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.17.5
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Jianbo Liu <jianbol@nvidia.com>

[ Upstream commit 06fdc45f16c392dc3394c67e7c17ae63935715d3 ]

When a PF enters switchdev mode, its netdevice becomes the uplink
representor but remains in its current network namespace. All other
representors (VFs, SFs) are created in the netns of the devlink
instance.

If the PF's netns has been moved and differs from the devlink's netns,
enabling switchdev mode would create a state where the OVS control
plane (ovs-vsctl) cannot manage the switch because the PF uplink
representor and the other representors are split across different
namespaces.

To prevent this inconsistent configuration, block the request to enter
switchdev mode if the PF netdevice's netns does not match the netns of
its devlink instance.

As part of this change, the PF's netns is first marked as immutable.
This prevents race conditions where the netns could be changed after
the check is performed but before the mode transition is complete, and
it aligns the PF's behavior with that of the final uplink representor.

Signed-off-by: Jianbo Liu <jianbol@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
Link: https://patch.msgid.link/1759094723-843774-3-git-send-email-tariqt@nvidia.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

YES
**Why Backport**
- Rejects switchdev activation when the PF netdev sits in a different
  netns than the devlink instance, avoiding the broken state where OVS
  loses control of the split representors (`drivers/net/ethernet/mellano
  x/mlx5/core/eswitch_offloads.c:3842-3847`).
- New helper grabs the uplink netdev safely via the existing ref-counted
  accessor and sets `netns_immutable` under RTNL so the PF behaves like
  the eventual uplink representor, while immediately detecting namespace
  divergence (`drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.
  c:3777-3797`;
  `drivers/net/ethernet/mellanox/mlx5/core/lib/mlx5.h:48-64`).
- If the mode change later fails, the helper rolls the flag back to keep
  legacy behavior untouched; successful transitions keep the flag set,
  matching switchdev guidance to freeze port namespaces (`drivers/net/et
  hernet/mellanox/mlx5/core/eswitch_offloads.c:3867-3869`;
  `Documentation/networking/switchdev.rst:130-143`).
- Locking the namespace leverages the core check that rejects moves of
  immutable interfaces (`net/core/dev.c:12352-12355`), eliminating the
  race window the commit message highlights without touching data-path
  code.
- The change is tightly scoped to the mode-set path, has no dependencies
  on new infrastructure, and fixes a long-standing, user-visible bug
  with minimal regression risk—strong fit for stable kernels that ship
  mlx5 switchdev support.

 .../mellanox/mlx5/core/eswitch_offloads.c     | 33 +++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
index f358e8fe432cf..59a1a3a5fc8b5 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
@@ -3739,6 +3739,29 @@ void mlx5_eswitch_unblock_mode(struct mlx5_core_dev *dev)
 	up_write(&esw->mode_lock);
 }
 
+/* Returns false only when uplink netdev exists and its netns is different from
+ * devlink's netns. True for all others so entering switchdev mode is allowed.
+ */
+static bool mlx5_devlink_netdev_netns_immutable_set(struct devlink *devlink,
+						    bool immutable)
+{
+	struct mlx5_core_dev *mdev = devlink_priv(devlink);
+	struct net_device *netdev;
+	bool ret;
+
+	netdev = mlx5_uplink_netdev_get(mdev);
+	if (!netdev)
+		return true;
+
+	rtnl_lock();
+	netdev->netns_immutable = immutable;
+	ret = net_eq(dev_net(netdev), devlink_net(devlink));
+	rtnl_unlock();
+
+	mlx5_uplink_netdev_put(mdev, netdev);
+	return ret;
+}
+
 int mlx5_devlink_eswitch_mode_set(struct devlink *devlink, u16 mode,
 				  struct netlink_ext_ack *extack)
 {
@@ -3781,6 +3804,14 @@ int mlx5_devlink_eswitch_mode_set(struct devlink *devlink, u16 mode,
 	esw->eswitch_operation_in_progress = true;
 	up_write(&esw->mode_lock);
 
+	if (mode == DEVLINK_ESWITCH_MODE_SWITCHDEV &&
+	    !mlx5_devlink_netdev_netns_immutable_set(devlink, true)) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Can't change E-Switch mode to switchdev when netdev net namespace has diverged from the devlink's.");
+		err = -EINVAL;
+		goto skip;
+	}
+
 	if (mode == DEVLINK_ESWITCH_MODE_LEGACY)
 		esw->dev->priv.flags |= MLX5_PRIV_FLAGS_SWITCH_LEGACY;
 	mlx5_eswitch_disable_locked(esw);
@@ -3799,6 +3830,8 @@ int mlx5_devlink_eswitch_mode_set(struct devlink *devlink, u16 mode,
 	}
 
 skip:
+	if (mode == DEVLINK_ESWITCH_MODE_SWITCHDEV && err)
+		mlx5_devlink_netdev_netns_immutable_set(devlink, false);
 	down_write(&esw->mode_lock);
 	esw->eswitch_operation_in_progress = false;
 unlock:
-- 
2.51.0


