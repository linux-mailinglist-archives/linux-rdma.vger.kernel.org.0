Return-Path: <linux-rdma+bounces-5664-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0318E9B7BCB
	for <lists+linux-rdma@lfdr.de>; Thu, 31 Oct 2024 14:37:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7ADB71F2198E
	for <lists+linux-rdma@lfdr.de>; Thu, 31 Oct 2024 13:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6119719DF8D;
	Thu, 31 Oct 2024 13:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gJEZk603"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BE1619D89D;
	Thu, 31 Oct 2024 13:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730381828; cv=none; b=s7cPBdwTc9W0Y9GT33lpIwaJdEpPNHPr/VXgWVNSNihYjQlbaRjfaLof8y5qGRV5tuRTbqyXwWUB0gIoHubZBWFKxjkoMjpdkSXKTHbegKTE5ILfB9y+Xky1K7IjAbm5pmhSWcC5I7hWxg6DRMjBvSy75cWudoUbURixMzWitJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730381828; c=relaxed/simple;
	bh=d3l6x6GlVstePoqlh0W6O0rvKV+qLzRLN0Cu1vRZdTQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tBPQyHHzMjtwhsfqzEdrSzIRKoR+6CMr9jvskicaooiNLrePOxFvSIJe4dlo8+eDRXp6Gv7OdGp8nWs0v5LM3tUHjcipMXWUbfHOR79gbmPN9TFPy7m3CC4oxfu2Kmv8+bZ0PQ+/qg5yOiQ64l56SHKCSs4hTTKlHgDNNFBo3Zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gJEZk603; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24B0CC4E697;
	Thu, 31 Oct 2024 13:37:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730381827;
	bh=d3l6x6GlVstePoqlh0W6O0rvKV+qLzRLN0Cu1vRZdTQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gJEZk6036fb3tjMGeAC3ko4srrJMgHalT9n/gVY1QeXiyqQ5sK6TRlR3IPHb7SDtd
	 3Cm9AtlhbGwpfEERpE6UtZY4fCz1d5yYfiRUWJV/ukTKWL78beQxw4iD3DSvrEUL4+
	 e2ZXusinxiFBNrjuH2fHyxU/MO/fyzZUmpF6We5yp/RbB7qiPGY8QYkKbgXlzn9jRx
	 4OCcicpMZFQbsia1xuWZBfHofa0eWlFp9jk1HitiV64mgspomKymBXkQeIFB+J04sP
	 D+kdCU2gKorwmYCqMGX3Ke3GwIx7st6A4FIArWC+5zCdv69B6FpNfRp4dqhDuldPhf
	 ZpknZPiXtYB4A==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Chiara Meiohas <cmeiohas@nvidia.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-rdma@vger.kernel.org,
	Michael Guralnik <michaelgur@nvidia.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH mlx5-next 3/3] RDMA/mlx5: Ensure active slave attachment to the bond IB device
Date: Thu, 31 Oct 2024 15:36:52 +0200
Message-ID: <91fc2cb24f63add266a528c1c702668a80416d9f.1730381292.git.leon@kernel.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <cover.1730381292.git.leon@kernel.org>
References: <cover.1730381292.git.leon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chiara Meiohas <cmeiohas@nvidia.com>

Fix a race condition when creating a lag bond in active backup
mode where after the bond creation the backup slave was
attached to the IB device, instead of the active slave.
This caused stale entries in the GID table, as the gid updating
mechanism relies on ib_device_get_netdev(), which would return
the backup slave.

Send an MLX5_DRIVER_EVENT_ACTIVE_BACKUP_LAG_CHANGE_LOWERSTATE
event when activating the lag, additionally to when modifying
the lag. This ensures that eventually the active netdevice is
stored in the bond IB device.
When handling this event remove the GIDs of the previously
attached netdevice in this port and rescan the GIDs of the
newly attached netdevice.

This ensures that eventually the active slave netdevice is
correctly stored in the IB device port. While there might be
a brief moment where the backup slave GIDs appear in the GID
table, it will eventually stabilize with the correct GIDs
(of the bond and the active slave).

Fixes: 8d159eb2117b ("RDMA/mlx5: Use IB set_netdev and get_netdev functions")
Signed-off-by: Chiara Meiohas <cmeiohas@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/main.c             | 28 ++++++++++++-------
 .../net/ethernet/mellanox/mlx5/core/lag/lag.c | 11 ++++++++
 2 files changed, 29 insertions(+), 10 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index 5f7fe32b9051..5038c52b79aa 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -3219,12 +3219,14 @@ static int lag_event(struct notifier_block *nb, unsigned long event, void *data)
 	struct mlx5_ib_dev *dev = container_of(nb, struct mlx5_ib_dev,
 					       lag_events);
 	struct mlx5_core_dev *mdev = dev->mdev;
+	struct ib_device *ibdev = &dev->ib_dev;
+	struct net_device *old_ndev = NULL;
 	struct mlx5_ib_port *port;
 	struct net_device *ndev;
-	int  i, err;
-	int portnum;
+	u32 portnum = 0;
+	int ret = 0;
+	int i;
 
-	portnum = 0;
 	switch (event) {
 	case MLX5_DRIVER_EVENT_ACTIVE_BACKUP_LAG_CHANGE_LOWERSTATE:
 		ndev = data;
@@ -3240,18 +3242,24 @@ static int lag_event(struct notifier_block *nb, unsigned long event, void *data)
 					}
 				}
 			}
-			err = ib_device_set_netdev(&dev->ib_dev, ndev,
-						   portnum + 1);
-			if (err)
-				return err;
-			/* Rescan gids after new netdev assignment */
-			rdma_roce_rescan_device(&dev->ib_dev);
+			old_ndev = ib_device_get_netdev(ibdev, portnum + 1);
+			ret = ib_device_set_netdev(ibdev, ndev, portnum + 1);
+			if (ret)
+				goto out;
+
+			if (old_ndev)
+				roce_del_all_netdev_gids(ibdev, portnum + 1,
+							 old_ndev);
+			rdma_roce_rescan_port(ibdev, portnum + 1);
 		}
 		break;
 	default:
 		return NOTIFY_DONE;
 	}
-	return NOTIFY_OK;
+
+out:
+	dev_put(old_ndev);
+	return notifier_from_errno(ret);
 }
 
 static void mlx5e_lag_event_register(struct mlx5_ib_dev *dev)
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
index d661267d98ff..7f68468c2e75 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
@@ -919,6 +919,7 @@ static void mlx5_do_bond(struct mlx5_lag *ldev)
 {
 	struct mlx5_core_dev *dev0 = ldev->pf[MLX5_LAG_P1].dev;
 	struct lag_tracker tracker = { };
+	struct net_device *ndev;
 	bool do_bond, roce_lag;
 	int err;
 	int i;
@@ -982,6 +983,16 @@ static void mlx5_do_bond(struct mlx5_lag *ldev)
 				return;
 			}
 		}
+		if (tracker.tx_type == NETDEV_LAG_TX_TYPE_ACTIVEBACKUP) {
+			ndev = mlx5_lag_active_backup_get_netdev(dev0);
+			/** Only sriov and roce lag should have tracker->TX_type
+			 *  set so no need to check the mode
+			 */
+			blocking_notifier_call_chain(&dev0->priv.lag_nh,
+						     MLX5_DRIVER_EVENT_ACTIVE_BACKUP_LAG_CHANGE_LOWERSTATE,
+						     ndev);
+			dev_put(ndev);
+		}
 	} else if (mlx5_lag_should_modify_lag(ldev, do_bond)) {
 		mlx5_modify_lag(ldev, &tracker);
 	} else if (mlx5_lag_should_disable_lag(ldev, do_bond)) {
-- 
2.46.2


