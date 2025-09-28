Return-Path: <linux-rdma+bounces-13712-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A6CCBA786A
	for <lists+linux-rdma@lfdr.de>; Sun, 28 Sep 2025 23:26:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5B903B87B9
	for <lists+linux-rdma@lfdr.de>; Sun, 28 Sep 2025 21:26:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18AD22BDC33;
	Sun, 28 Sep 2025 21:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RWVAIP/2"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010032.outbound.protection.outlook.com [40.93.198.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B7BE225D6;
	Sun, 28 Sep 2025 21:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759094759; cv=fail; b=ZrZJEEXkOu64/c2adbrx5GSdu27KUXVOh0Iwo2s0CBmTExyDmMD1SqVqhyHuf6ZrYGX8tbf852i6EnYmvYJhiAmyDXH7qJeXwvVFoI3cTwEG7nsTmXzoHpdlVBaNOVHMTExjgZ3WHdsLk7gRtedHrwZ3hX2zgknGKRIJrw10TeQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759094759; c=relaxed/simple;
	bh=4rBXAwojQWSdPayOra4M8+AD7RsQ1qmKEpp8mmFlG40=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fi+N6rkPwIHS1GAnr2l7KmaFONr408OETlRMvnSILk49tq2jKklWDwDSKWeS57Savg5/LQqi0KRad2wA49dsHoyhhdaMaaSGTdvHeIjs4qxZNRAy/ffTSyKv8widQnjjbsFeD+ijjHqt8nAIHZI+W82v38T80c3kSkfxt739/J4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RWVAIP/2; arc=fail smtp.client-ip=40.93.198.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VYWlBzFtF6gCpVGuCmqk+5cYd+ZC6NP0GbiOWSCBH/uEuVge5z/+Vjz5kD/xslULmE/ny3IWtJsGK9Vokmi0TZP6zOn0Dpnj2AZTYZN5wlgzquXzl3EYom7Vv+V+YV2fD+GFj7NRuTSlOh7aCoxvG2ZqLGjbF6d5+ocmSmjpgvFV7tkvqTh1MhIFRU8FOElYCegJOwT5dVoWaINRnobEYMwzQkPc0CFjmCiqwTboFPs6PQJoYmUurumbZgedU1DDoRdrsdtOPXLy12F8CWsPxTD45uj7+58ArGJLUQU0Ib6sskBmqZdOL+GxB2aphjm3Ckw2q9ayepQnp8tjh/uksQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=56E/0PV/KRAp0/+CoZY+48OttWybwwxxsgM/A+A9ppw=;
 b=guJtJCHEZbgVhojbusE6g/7LreJZ748OANDnC+cSPZA6ZJEcjiJGjwdtu6ByrZpspT+2lzXV6RL1LP6+W2/vFJclVaXLV196xbsH0g4UtZ97Kw4Ow38Pw0d/rK3V6ppq4eDe4TbgRv/0W+FeyB/oqmUP8hJKRLtYGfwbpXJ4k+D2nABXzgs477I7pggR+fjRtZW2UkA5IoJlyHbDg25I3qscsA6xp1GKEWjiyWIMKUgXaAcirAK8+UnfRAHmnqgWvMLWQKgcF7tFXRwqxyJUSi2/QbiuCrnWrh0MZDq1f44AhMcaPFSo7l4XkCjFTrp8VBT5iqFhKrJRUc3yhE1NKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=56E/0PV/KRAp0/+CoZY+48OttWybwwxxsgM/A+A9ppw=;
 b=RWVAIP/2pOL8yJzHzyfjyGO2Td2ec2tAkEPVsJuldzGu0krXnFejc5NFXje6zbroNTFuUSktmFI/1lK+Z/pAkqVPE53TLvd7LaPhDbCJSsIkT13v2lBbzqT/QbhgiBXZgF6NcYusc6XMT+RQ1oLuCH7rx81nMqwBJg5+NfwqIHkGzr8rtKap2DJOj8WlV5Y+L0xiAFl0Akgs7YW797rfvUSPdr5iZTZ/hYoPHHsey7xu+CNhsek+CzO/R/19ioTzfnSCkdcxRWH1ZqAEpDSbUDBRWjgJ5mhzU0xGXv7oLUPGoI1fdMUZ1JSeEWTo/6VK3MFYyj9cg4pEZcij6asWGA==
Received: from PH5P222CA0005.NAMP222.PROD.OUTLOOK.COM (2603:10b6:510:34b::16)
 by IA0PPFD7DCFAC03.namprd12.prod.outlook.com (2603:10b6:20f:fc04::be7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.18; Sun, 28 Sep
 2025 21:25:54 +0000
Received: from CY4PEPF0000EDD5.namprd03.prod.outlook.com
 (2603:10b6:510:34b:cafe::f5) by PH5P222CA0005.outlook.office365.com
 (2603:10b6:510:34b::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.21 via Frontend Transport; Sun,
 28 Sep 2025 21:25:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CY4PEPF0000EDD5.mail.protection.outlook.com (10.167.241.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Sun, 28 Sep 2025 21:25:53 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sun, 28 Sep
 2025 14:25:53 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Sun, 28 Sep 2025 14:25:52 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Sun, 28 Sep 2025 14:25:49 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Moshe Shemesh
	<moshe@nvidia.com>, Jianbo Liu <jianbol@nvidia.com>
Subject: [PATCH net-next V2 2/7] net/mlx5e: Prevent entering switchdev mode with inconsistent netns
Date: Mon, 29 Sep 2025 00:25:18 +0300
Message-ID: <1759094723-843774-3-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1759094723-843774-1-git-send-email-tariqt@nvidia.com>
References: <1759094723-843774-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD5:EE_|IA0PPFD7DCFAC03:EE_
X-MS-Office365-Filtering-Correlation-Id: a44fc861-cb52-4114-b72b-08ddfed59adf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BnA+DlWz3urKBBVuYO6mJ99Kxpy/N2zplvN3aRl3m3FDI9M2iYjwXn/DSgnO?=
 =?us-ascii?Q?jEpzllOIjpDz73WGXqezZrl0ywFg9sB1PIjDzmo/Fps8Ibt1d9uRn4nOCleU?=
 =?us-ascii?Q?tWZ5K/ynQ3avrlrEphhlKvcygBLulj87eB5PuTAHMPyAzkntdOy6Ruxc24JY?=
 =?us-ascii?Q?wvhWnqIW9s3q2UrEW0S68lARqkSFza161b1F/HWtK3FJR1rR2Ii2KSnj0Bqk?=
 =?us-ascii?Q?ygPHEQVJsdBL5+svFXhX3ok+rxu1rH5NbVPCcNc4HE3kpj/DPtORqL/0RyQk?=
 =?us-ascii?Q?V16vW6suGWtjhQ97qx1jP4RtPoD5BoruGPHou0FWTweER8oIHry0d99vTF6z?=
 =?us-ascii?Q?w7sbiLG/f/kJb2TG6ZLbsl0ux1LhID0GZ+QEc1Aq47nZULcgS59snDzd5nOW?=
 =?us-ascii?Q?iimP6oiT42TWPC3WKOxN7krFrnfxd3yrfJb5nCpqMuj9qRR/1DxBXVyNBoQT?=
 =?us-ascii?Q?VJa8gYlqzYOwMsL+Dt6cANz+Jgi9ZcJ6r1iK37yGilf3HUJe3P48TBCKv3rN?=
 =?us-ascii?Q?cwt22GFC09UMjRJZ0P5pwq8UubbgBLESPQ5xdSYoUs8MSvp5nYEx1TE3pQFF?=
 =?us-ascii?Q?3CkpEuGWQBPckm2RD7wo5mCXe+S3epMYkmnubNphx1omYbZMf3QFdT2qPq6U?=
 =?us-ascii?Q?ztir9yeAfVntoyb2bu9y/xFgkVFlCP+I1BSHlOyHuxzN4rA33y+eaS98/u78?=
 =?us-ascii?Q?WYic0pKCdWPhIfDpuF1UwXdH/e9Vr8W68HCC1ly7y43TVIFmYr5x8SqVjaCq?=
 =?us-ascii?Q?Dhgb6MgoZMv4IdkTB3xevDi6WIiN3wAK/wdQb4MxtJF9EnpddiSgiq4ICjWo?=
 =?us-ascii?Q?4xGRAw9t0N9ZigYOtXBqV0Ae5GJLwpi72HxBilNv+KUb3WxkkxufwDnSVaLG?=
 =?us-ascii?Q?WLX1hC8x3pwi0LZqL8Z8ViqBL1zzBot13puySLsF/4O/XlxLu0u1WSdFGsoK?=
 =?us-ascii?Q?VJKH50QGB7ExPr6hlTDyK3PpvwxyRcrASXJkEGaYKxPMICArHGVwmz1au9gT?=
 =?us-ascii?Q?O/bqaZ3KmwMLIJ3cpd6/ApZZaRxBpi5ZjqHmMWpquoz6R3rYGRUaSPAm9MD8?=
 =?us-ascii?Q?0tjn4wVKYIht4yevyIJfGollAen/zDbWGD3KAtfZEhDP+akLmcWPpRyYq5Oa?=
 =?us-ascii?Q?hDD4osBXbcUOvqH4RPOP7ANDNyUelfJs5hv9kwOKLQ4I+RPLfYo+Iy4EiN7L?=
 =?us-ascii?Q?JZE555L/rOc9Jrvlmtp7xJ1jgtl0COAMCfEi0HJOpkU4RIDqXNjsGnjIHhjv?=
 =?us-ascii?Q?+GTejxfR03Wf8x4CLQSxiJPgNVjTyCkHqe1LAC3zCAeADmYMDHBIO0KF6m4r?=
 =?us-ascii?Q?nURwbZHgxoROPVKXdAWnJ1EFQoB0zV7MDXQ2Wo0PDWsG375DGkQvE2kdLY/2?=
 =?us-ascii?Q?NauraAbXh5X45NKSbjpPrb487KeQezSdADQnByL0HhV162Ek36afCRM0gFd+?=
 =?us-ascii?Q?uQJ+u436/eWGDdGX1Oy1vZtmK92wSKS+BaY+ieLu7rOcE2u1wY7y1nNDLrfW?=
 =?us-ascii?Q?XrI7dcIZu2UJ29Iyg2Sodfp1jLCpERvvv4srb9bOdwpmQWFPn4j6k4KG+VPk?=
 =?us-ascii?Q?oLcPx7JAHk9xhd7+E9s=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2025 21:25:53.5185
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a44fc861-cb52-4114-b72b-08ddfed59adf
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPFD7DCFAC03

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

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
index b8ec55929ab1..52c3de24bea3 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
@@ -3774,6 +3774,29 @@ void mlx5_eswitch_unblock_mode(struct mlx5_core_dev *dev)
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
@@ -3816,6 +3839,14 @@ int mlx5_devlink_eswitch_mode_set(struct devlink *devlink, u16 mode,
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
@@ -3834,6 +3865,8 @@ int mlx5_devlink_eswitch_mode_set(struct devlink *devlink, u16 mode,
 	}
 
 skip:
+	if (mode == DEVLINK_ESWITCH_MODE_SWITCHDEV && err)
+		mlx5_devlink_netdev_netns_immutable_set(devlink, false);
 	down_write(&esw->mode_lock);
 	esw->eswitch_operation_in_progress = false;
 unlock:
-- 
2.31.1


