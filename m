Return-Path: <linux-rdma+bounces-13555-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E9B8B8FAE2
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Sep 2025 11:03:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 019A716601E
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Sep 2025 09:02:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23C4028726E;
	Mon, 22 Sep 2025 09:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="c3+qRcYT"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010025.outbound.protection.outlook.com [40.93.198.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B3AF21B9DE;
	Mon, 22 Sep 2025 09:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758531726; cv=fail; b=sG+cNVG02mFSCfKlK+MJJff2CouB3ChtrVwlqOCIkEtAkbDjQyUkCKr0OYuph5voLfSEpufelpz5ryoi6V5PvbDiRHUiQnAJ3bxCpiuI8LYqCMytEbDwVqNwptnE7pggiAYJAhZEV2ZVwaonwOSr+oqTmlfk6yGRxgDj4JWhdaA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758531726; c=relaxed/simple;
	bh=qCJD0rkRizGfqfxPlH2aI3xcytlAm6Bv1PD1yu5ff8Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mbEYVkvJkMKaRcFPJ1v7SBmtY+khX9oIeTgxpfTc0nBJdcAdRndQ+W5vZv++t9x7ajrySMNfuR9QydqONt0Y0rVv2bCZumM3lCvdN1vXt2A48lfQgqMr/iaCCUh/gj3MER7XZNoVzY2LBWIjwUgwM3jduBPgUvROikvtqRtFviM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=c3+qRcYT; arc=fail smtp.client-ip=40.93.198.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fgHsKDypYfOLsTQo9RsINyQnX41kHbfNSjcBWCm5ynu8Q7gpiWupiS7a8FUy7Q+71U7OraQlemiTIm1srpFVbbZPulOa7YeNEyDBTFLbc78NvJkl5K/YGgEWY6sp8CU60g4d2fjx+WHeRgvV9ow5hkRLI2rtfebzpcmdw83qsu4iO+4FxTpfLgIe4IYoHktonUjvdJ0kZTRY9hJHtfxEvtLTxrL0x5r8TUvbUgu3gcNIjEHXDJ/9rNINh7+6CfMBMHQJ9IGUX02gHxAzMzp5hFCg32qXkL4gbIDPrljkceyk9ii13BnFupg6zudK2H2LApoR+ow+oT5de22fM6kjZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/PNdqsTD1+UEoSrDswJVR34H4C0KL1dcd/azXvDXsGQ=;
 b=NR+EmTjWEr3I4TUs9GoVKd/0/HA0RLWE98vUexeI1wLscYHk0vL+xK/VGsr9GS+P8xar3ewggp7qr83Qx/lQ/jbq656pvw5qPTaz19drSk9tDOKEaU7Q5gRDknC3hu7X1AaUlPrYVUSCRrNKXokl6zXAiurHU1gx5cO6coVC9m73PnOu/rUxXestMnB5T+w7B2Wopsr4bdWzu7wQnmcOFy1TxhZiqNzbZhl7+7TNMZ6FGjgbS89r1AQPiWdey05E9pzyJfBEIIFbcclZ6cgkQ2AhCjD/p2AqUvWn+PEaBMuhxzkJk/gL3gX/+eiZhnrXpDHgHRd0+eh94XEKOF3Z1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/PNdqsTD1+UEoSrDswJVR34H4C0KL1dcd/azXvDXsGQ=;
 b=c3+qRcYTpa2gQ4jQoLvXdIq0/ml7wT17ZezYDu7JDleShHog9P6vlVRTG5SZyXcdUXxO2vQqmgO/25Jj5aDvO1mRpAdcmWxFfY3ogw3ONIYVohux7X38jYbblxZl02ovX3n7v8IHxlSsw7X3MMAkMiDr7/s1dBXsSa78whYPt6anzqNOYoaxF1ZxMMT7V3/cl0Y7PBq6Q/5Rh1eyaJl4BW9OFXl2o804d9kmnJRKbDcAfVa4mG6tI9wDtkkx+JV6PbLMYggnT4PYyw2MhJtABNTTxn0GE2fpvYga08mC4xcsVRYdZ7RdF493wkDrpVfGbUj8tkK4lCSB1j4by5eZ/Q==
Received: from CH0PR03CA0448.namprd03.prod.outlook.com (2603:10b6:610:10e::11)
 by BN7PPF49208036B.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6cf) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.19; Mon, 22 Sep
 2025 09:02:02 +0000
Received: from CH2PEPF00000146.namprd02.prod.outlook.com
 (2603:10b6:610:10e:cafe::51) by CH0PR03CA0448.outlook.office365.com
 (2603:10b6:610:10e::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.19 via Frontend Transport; Mon,
 22 Sep 2025 09:02:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CH2PEPF00000146.mail.protection.outlook.com (10.167.244.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Mon, 22 Sep 2025 09:02:02 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 22 Sep
 2025 02:01:50 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 22 Sep 2025 02:01:49 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 22 Sep 2025 02:01:46 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Moshe Shemesh
	<moshe@nvidia.com>, Jianbo Liu <jianbol@nvidia.com>
Subject: [PATCH net-next 2/7] net/mlx5e: Prevent entering switchdev mode with inconsistent netns
Date: Mon, 22 Sep 2025 12:01:06 +0300
Message-ID: <1758531671-819655-3-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1758531671-819655-1-git-send-email-tariqt@nvidia.com>
References: <1758531671-819655-1-git-send-email-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000146:EE_|BN7PPF49208036B:EE_
X-MS-Office365-Filtering-Correlation-Id: ca40de6f-4d8e-4c40-3ac9-08ddf9b6b1fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?j1EkWjbhQuzRv3hgP5TLkhMVSQsMkQmcDWQBSZyZNbSpjH0P71rZoWbEkVG2?=
 =?us-ascii?Q?rNSpViQcnVfbmtRwZERpAdi8EMlkDdyHjApIJ1whNRysdqey5VyZVXm2c2vg?=
 =?us-ascii?Q?zlnha0F9D9XLEbXcuxkRt54qmkB3NZUNlhoqGGmDL3GtANildsiEqZRont52?=
 =?us-ascii?Q?2HQN+oFYgC+LVpDG8w8gGXuXyUYOb+mIyynzs0gAOeH9kmnM2CC+7i0juHmL?=
 =?us-ascii?Q?0/xD9qjekwJRFdQDvadW98aX5dXR6MJJTQAyvuHzsKFh2Q/70mcmxco0PPd1?=
 =?us-ascii?Q?nLMmaKzVE8YMw0xYjI+S2HB7DAeGN/bhXWYtMWp9qeVcSUaX1j9cNxD53Gts?=
 =?us-ascii?Q?+adJSYCpAw8NaOpyBSzPolOkJu6atAzNIz4thJ1q7SdTns1CBptmrCaenbdB?=
 =?us-ascii?Q?tvAGlHxIJuK2B0hOj645LmzbX9oG+4f8HxB0F4CquSLzHYgE3R8e92+3ORdp?=
 =?us-ascii?Q?4wzTwc4cTrs4yLQlWRWZS219zjHVw/ptznNQK64csGSbj3XLknPfzNizbkjk?=
 =?us-ascii?Q?fgvX1+6EwLr+BAkZaCve28N5io7L+ScrMJFDIWxszrtJIM7OMY7eIpKoU+3Z?=
 =?us-ascii?Q?c/rdlETBYj5jsuPvI0JATNWkasvKCuIjqEMAkqWsK77TfSkddcoT4Tld2bHw?=
 =?us-ascii?Q?GBKMVolWH8x/zJ8FKo41OKY8EpBOOs+/zKHR6V+eDGwy1QWJyM3DyPYxZ+wb?=
 =?us-ascii?Q?FRfnvsNqSPX/a9oFxBSSC+fhmFh7vOFsk8Jsc9/0uTmH7+hZJH+tDRrGSKkp?=
 =?us-ascii?Q?qSiKuAqketI+lKBObW7eS3FPCD2c+KzMu7RLXKhaX3DIEjvA3H4qHZ1Nf5fA?=
 =?us-ascii?Q?dm1WF4RmcwQafcFi4TH3p48MZDSUH34jyvONAXNqT+82txVTfv7DAwbUnyFD?=
 =?us-ascii?Q?pJBf3TdFIhvQazDVLVO2M3bHjTfijsd4/M3ApoPzas4ys2fkguhty1xkctFZ?=
 =?us-ascii?Q?F19kTJMFkc6XBOxy3dW+TACVk/O/mqsJO69cMZ9XtXgXnz4ayOypjzPHmYBj?=
 =?us-ascii?Q?VXEzqF4zea3teSWYRxYoazgAg82rNGCcNVpuumnPmO9sjFMp+1Y5BUQv/Fr8?=
 =?us-ascii?Q?f0YzMPth0t9r+p2d+DhSoskcxXa+jNCzk2RHtFGm2YKjYFxmuBOtxU2hh9DY?=
 =?us-ascii?Q?R9AIhDOwRf/bopnxQ9qolBVSoJ081OuJLpMyp8voHdMKFd+qg4yWytiknk1e?=
 =?us-ascii?Q?iMgmo03yFw/AbfKiI9I8M1nC9NcWnWJ3X1mby/+xpnoviE8TJCI9HMaHhI32?=
 =?us-ascii?Q?iyE4jSKCPTxomUUiScKtWalr3rNdhaiIRJjT4DKKfRPvE1kZAfTDvC9DmPkD?=
 =?us-ascii?Q?B2jveuTfJ7NcORRgjDxBN5gBn9dEeU5XBYAxeEaZhKbKwgbO2k5hZxgwaKOR?=
 =?us-ascii?Q?puweQGGWMYLvDQWB5YqxJ66ilIPBChAjrDfWw14Z7KbMjnWUmaz7PwulrUxX?=
 =?us-ascii?Q?jT4wD1+komgfUIjjzfWpWtnSCcr3UtZE6pFwsBKUjpr3XIoH4X3A3IxpwJkO?=
 =?us-ascii?Q?QJnjzYvJUfPzlBGsqqWt9b/lSJd36BIZRYSjxUO1XWfta1/+1JXA32spXA?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2025 09:02:02.0440
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ca40de6f-4d8e-4c40-3ac9-08ddf9b6b1fa
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000146.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF49208036B

From: Jianbo Liu <jianbol@nvidia.com>

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
---
 .../mellanox/mlx5/core/eswitch_offloads.c     | 33 +++++++++++++++++++
 1 file changed, 33 insertions(+)

Previously submitted to net:
https://lore.kernel.org/all/1757939074-617281-3-git-send-email-tariqt@nvidia.com/

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
index bc9838dc5bf8..ff6e0130de38 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
@@ -3772,6 +3772,29 @@ void mlx5_eswitch_unblock_mode(struct mlx5_core_dev *dev)
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
@@ -3814,6 +3837,14 @@ int mlx5_devlink_eswitch_mode_set(struct devlink *devlink, u16 mode,
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
@@ -3832,6 +3863,8 @@ int mlx5_devlink_eswitch_mode_set(struct devlink *devlink, u16 mode,
 	}
 
 skip:
+	if (mode == DEVLINK_ESWITCH_MODE_SWITCHDEV && err)
+		mlx5_devlink_netdev_netns_immutable_set(devlink, false);
 	down_write(&esw->mode_lock);
 	esw->eswitch_operation_in_progress = false;
 unlock:
-- 
2.31.1


